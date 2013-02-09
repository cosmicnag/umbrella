# vi:si:et:sw=4:sts=4:ts=4
from django.db import models
from django.contrib.auth.models import User
from django_hstore import hstore
import urllib2
import json

class Lender(models.Model):
	name = models.CharField(max_length=256)
	email = models.EmailField()
	users = models.ManyToManyField(User, blank=True)
	books = models.ManyToManyField('Book', through='LenderBook', blank=True)
	list_id = models.CharField(max_length=64)

	def __unicode__(self):
		return self.name

	def fetch_list(self):
		url = "http://openlibrary.org/people/umbrella_library/lists/%s/seeds.json" % self.list_id #OL25396L
		raw = urllib2.urlopen(url).read()
		data = json.loads(raw)
		for book in data['entries']:
			#ol_id = book['url'].replace("/books/", "").replace("/works/", "")
			#b = Book(ol_id=ol_id)
			book_data_url = "http://openlibrary.org%s.json" % book['url']
			#book_url = "http://openlibrary.org/api/books?bibkeys=OL:%s" % ol_id
			print book_data_url
			book_data = json.loads(urllib2.urlopen(book_data_url).read())
            b = Book()
            b.ol_id = book['url']
			b.data = book_data
			b.save()
			self.books.add(b)
			self.save()
				

class Book(models.Model):
	ol_id = models.CharField(max_length=128, unique=True, db_index=True)    
	data = hstore.DictionaryField()
    objects = hstore.HStoreManager()
	
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
