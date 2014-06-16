from books.models import *
from pymongo import MongoClient
import re
from bson.objectid import ObjectId

connection = MongoClient()
db = connection.ol
books = db.books
authors = db.authors

def processborrow(borrow):
    lenderemails = [l.email for l in borrow.lenders.all()]
    message = borrow.message
    oid = ObjectId(borrow.book.mongo_id)
    title = books.find_one(oid)['title']
    from books.tasks import sendmail
    sendmail.delay(borrow.user.username,borrow.user.email,lenderemails,message,title) 
    #TODO Check SQL

def get_authors(q):
    regex = re.compile(q, re.IGNORECASE)
    results = list(authors.find({'name': regex}))
    #results = list(authors.find())
    return map(lambda x: {'tokens': [x['name']], 'value': x['key'], 'name': x['name']}, results)

def get_genres(q):
    regex = re.compile(q, re.IGNORECASE)
    #results = list(books.distinct('subjects'))
    results = db.command({'distinct': 'books', 'key': 'subjects', 'query': {'subjects': regex}})['values']
    return map(lambda x: {'tokens': [x], 'value': x}, results)

    
