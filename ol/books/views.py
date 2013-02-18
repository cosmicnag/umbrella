# Create your views here.
from models import *
from ox.django.shortcuts import render_to_json_response
from pymongo import MongoClient
from django.shortcuts import render_to_response
import re
import math

def lenders(request):
    if request.method == 'GET':
        lenders = list(Lender.objects.all().values())
        return render_to_json_response(lenders,status=200)
    return render_to_json_response([],status=501)



	
def books(request):
    if request.method == 'GET':
        sort = request.GET.get('sort','-_id')
        by,what = (sort[0],sort[1:],)
        limit = request.GET.get('limit',8)
        publisher = request.GET.get("publisher", None)
        page = int(request.GET.get("page", "1"))
        per_page = int(request.GET.get("per_page", "8"))
        q = request.GET.get("q", None)
        connection = MongoClient()
        db = connection.ol
        books = db.books
        authors = db.authors
        find = {}
        if q:
            regex = re.compile(q, re.IGNORECASE)
            authors = [a['key'] for a in authors.find({'name': regex})]
            #import pdb;pdb.set_trace()
            find['$or'] = [
                {'title': regex},
                {'subtitle': regex},
                {'description.value': regex},
                {'subjects': regex},
                {'authors.author.key': { '$in': authors }} 
            ]
#        if publisher:
#            find['publishers'] = re.compile(publisher, re.IGNORECASE)
        count = books.find(find).count()
        pages = int(math.ceil(count / (per_page + .0)))
        if page > pages and pages != 0:
            page = pages        
        skip = (page - 1) * per_page
                
        book_list = books.find(find).sort(what,direction=int(by+"1")).skip(skip).limit(per_page)
        #total_count = book_list.count()
        book_list = list(book_list)                

#        book_list = list(books.find(find).sort(what,direction=int(by+"1")).limit(8))
        for book in book_list:
            book['_id']=str(book['_id'])

        return render_to_json_response({
            'items':list(book_list),
            'count': count,
            'pages': pages,
            'page': page
        })


def index(request):
    return render_to_response('index.jade')
