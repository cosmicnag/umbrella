# Create your views here.
from models import *
from ox.django.shortcuts import render_to_json_response
from pymongo import MongoClient
from django.shortcuts import render_to_response
from django.contrib.auth.models import User
from django.contrib.auth import login, authenticate
from django.views.decorators.csrf import csrf_exempt
import re
import math


def lenders(request):
    if request.method == 'GET':
        lenders = list(Lender.objects.all().values())
        return render_to_json_response(lenders,status=200)
    return render_to_json_response([],status=501)


@csrf_exempt
def signup(request):
    username = request.POST.get("username", None)
    password = request.POST.get("password", None)
    password2 = request.POST.get("password2", None)
    email = request.POST.get("email", None)
    first_name = request.POST.get("first_name", None)
    last_name = request.POST.get("last_name", None)
    if not username or not password or not password2:
        return render_to_json_response({'error': 'insufficient data'})
    if User.objects.filter(username=username).count() > 0:
        return render_to_json_response({'error': 'Username exists'})
    if password != password2:
        return render_to_json_response({'error': 'Passwords do not match'})
    u = User()
    u.username = username
    u.set_password(password)
    if email:
        u.email = email
    if first_name:
        u.first_name = first_name
    if last_name:
        u.last_name = last_name
    u.save()
    login(request, u)
    return render_to_json_response({'success': 'User logged in'})


@csrf_exempt
def signin(request):
    username = request.POST.get("username", "")
    password = request.POST.get("password", "")
    user = authenticate(username=username, password=password)
    if user is not None:
        login(request, user)
        return render_to_json_response({'success': 'User logged in'})
    return render_to_json_response({'error': 'Username / password do not match'})

	
def books(request):
    if request.method == 'GET':
        sort = request.GET.get('sort','-_id')
        by,what = (sort[0],sort[1:],)
        limit = request.GET.get('limit',8)
        author = request.GET.get("author", None)
        genre = request.GET.get("genre", None)
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
        if author:
            find['authors.author.key'] = author
        if genre:
            find['subjects'] = genre
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

def get_filters_data(request):
    connection = MongoClient()
    db = connection.ol
    authors = {}
    lenders = {}
    for a in db.authors.find():
        authors[a['key']]=a['name']
    for l in Lender.objects.all():
        lenders[l.id]=l.name
    genres = []
    for book in db.books.find({}, {'subjects': 1}): #TODO: FIXME
        if book.has_key('subjects'):
            for subject in book['subjects']:
                genres.append(subject) 
    set = {}
    map(set.__setitem__, genres, [])
    unique_genres = set.keys()
    return render_to_json_response({'authors': authors, 'lenders': lenders, 'genres': unique_genres}) 

def index(request):
    return render_to_response('index.jade')
