# vi:si:et:sw=4:sts=4:ts=4
from django.db import models
from django.contrib.auth.models import User
from django_hstore import hstore
import urllib2
import datetime
import json
from pymongo import MongoClient

class BaseModel(models.Model):
    changed = models.DateTimeField(null=True, editable=False)
    created = models.DateTimeField(null=True, editable=False)

    def save(self, *args, **kwargs):
        if not self.id:
            self.created = datetime.datetime.today()
        self.changed = datetime.datetime.today()
        if self.created == None:
            self.created = self.changed
        super(BaseModel, self).save(*args, **kwargs)

    class Meta:
        abstract = True

class Lender(models.Model):
	name = models.CharField(max_length=256)
	email = models.EmailField()
	users = models.ManyToManyField(User, blank=True)
	books = models.ManyToManyField('Book', through='LenderBook', blank=True)
	list_id = models.CharField(max_length=64)

	def __unicode__(self):
		return self.name

    def get_json(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email
        }

	def fetch_list_from_openlibrary(self):
		url = "http://openlibrary.org/people/umbrella_library/lists/%s/seeds.json" % self.list_id #OL25396L
		raw = urllib2.urlopen(url).read()
		data = json.loads(raw)
		list_of_books = []
		connection = MongoClient()
		db = connection.ol
		books = db.books
		authors = db.authors
		for book in data['entries']:
			#ol_id = book['url'].replace("/books/", "").replace("/works/", "")
			#b = Book(ol_id=ol_id)
			book_data_url = "http://openlibrary.org%s.json" % book['url']
			#book_url = "http://openlibrary.org/api/books?bibkeys=OL:%s" % ol_id
			book_data = json.loads(urllib2.urlopen(book_data_url).read())
			if book_data.has_key('authors'):
				print book_data['authors']
				author_keys = [a['author']['key'] for a in book_data['authors'] if a.get('author',None)]	
				for author_key in author_keys:
					author_endpoint = "http://openlibrary.org" + author_key + ".json"
					print author_endpoint
					author_data = json.loads(urllib2.urlopen(author_endpoint).read())
					mongo_author = authors.find_one({"key":author_data['key']})
					author_id = mongo_author and mongo_author['_id'] or authors.insert(author_data)
					print author_id
			mongo_book = books.find_one({"key":book_data['key']})
			mongo_id = mongo_book and mongo_book['_id'] or books.insert(book_data)
			book,created = Book.objects.get_or_create(mongo_id=mongo_id)
			book.save()
			lb = LenderBook(lender=self,book=book,status=1)
			# TODO figure out status
			lb.save()
		
		

class Book(models.Model):
	ol_id = models.CharField(max_length=128, unique=True, db_index=True,blank=True,null=True)    
	mongo_id = models.CharField(max_length=128, unique=True, db_index=True)    
	
	def __unicode__(self):
		return self.ol_id

    def lenders_json(self):
        return [l.get_json() for l in self.lender_set.all().distinct()]        


STATUS_CHOICES = (
	(0, 'available to borrow'),
	(1, 'available to browse'),
	(2, 'available to take'),
)

class Borrow(BaseModel):
    user = models.ForeignKey(User)
    book = models.ForeignKey(Book)
    message = models.TextField(blank=True)

class LenderBook(models.Model):
	lender = models.ForeignKey(Lender)
	book = models.ForeignKey('Book')
	status = models.CharField(max_length=128, choices=STATUS_CHOICES)


class BookFile(models.Model):
    fil = models.FileField(upload_to='ebooks')
    md5 = models.CharField(max_length=128)
    book = models.ForeignKey(Book)
