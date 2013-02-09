# vi:si:et:sw=4:sts=4:ts=4
from django.db import models
from django.contrib.auth.models import User
from django_hstore import hstore
import urllib2
import json
from pymongo import MongoClient

class Lender(models.Model):
	name = models.CharField(max_length=256)
	email = models.EmailField()
	users = models.ManyToManyField(User, blank=True)
	books = models.ManyToManyField('Book', through='LenderBook', blank=True)
	list_id = models.CharField(max_length=64)

	def __unicode__(self):
		return self.name

	def fetch_list_from_openlibrary(self):
		url = "http://openlibrary.org/people/umbrella_library/lists/%s/seeds.json" % self.list_id #OL25396L
		raw = urllib2.urlopen(url).read()
		data = json.loads(raw)
		list_of_books = []
		connection = MongoClient()
		db = connection.ol
		books = db.books
		for book in data['entries']:
			#ol_id = book['url'].replace("/books/", "").replace("/works/", "")
			#b = Book(ol_id=ol_id)
			book_data_url = "http://openlibrary.org%s.json" % book['url']
			#book_url = "http://openlibrary.org/api/books?bibkeys=OL:%s" % ol_id
			print book_data_url
			book_data = json.loads(urllib2.urlopen(book_data_url).read())
			mongo_book = books.find_one({"key":book_data['key']})
			print str(mongo_book)
			#mongo_id = mongo_book['_id'] if mongo_book else books.insert(book_data)
			mongo_id = mongo_book and mongo_book['_id'] or books.insert(book_data)
			book,created = Book.objects.get_or_create(mongo_id=mongo_id)
			#if not created:
			#	mongo_id = book.mongo_id
			#else:
			book.save()
			lb = LenderBook(lender=self,book=book,status=1)
			# TODO figure out status
			lb.save()
		
		

class Book(models.Model):
	ol_id = models.CharField(max_length=128, unique=True, db_index=True,blank=True,null=True)    
	mongo_id = models.CharField(max_length=128, unique=True, db_index=True)    
	
	def __unicode__(self):
		return self.ol_id


STATUS_CHOICES = (
	(0, 'avaialble to borrow'),
	(1, 'available to browse'),
	(2, 'available to take'),
)

class LenderBook(models.Model):
	lender = models.ForeignKey(Lender)
	book = models.ForeignKey('Book')
	status = models.CharField(max_length=128, choices=STATUS_CHOICES)


class BookFile(models.Model):
    fil = models.FileField(upload_to='ebooks')
    md5 = models.CharField(max_length=128)
    book = models.ForeignKey(Book)
