# Create your views here.
from models import *
from ox.django.shortcuts import render_to_json_response
from pymongo import MongoClient
from django.shortcuts import render_to_response

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
		connection = MongoClient()
		db = connection.ol
		books = db.books
		book_list = list(books.find().sort(what,direction=int(by+"1")).limit(8))
		for book in book_list:
			book['_id']=str(book['_id'])
		return render_to_json_response({'items':book_list})

def index(request):
	return render_to_response('index.jade')
