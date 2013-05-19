# Create your views here.
from models import *
from ox.django.shortcuts import render_to_json_response
from pymongo import MongoClient
from django.shortcuts import render_to_response,get_object_or_404
from django.contrib.auth.models import User
from django.contrib.auth import login, authenticate
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
import re
import math
from helpers.book import get_authors, get_genres
from django.core.mail import send_mail


def lenders(request):
    if request.method == 'GET':
        lenders = list(Lender.objects.all().values())
        return render_to_json_response(lenders,status=200)
    return render_to_json_response([],status=501)


@csrf_exempt
def signup(request):
    username = request.POST.get("username", None)
    password = request.POST.get("password", None)
    email = request.POST.get("email", None)
    first_name = request.POST.get("first_name", None)
    last_name = request.POST.get("last_name", None)
    if not username or not password: 
        return render_to_json_response({'error': 'insufficient data'})
    if User.objects.filter(username=username).count() > 0:
        return render_to_json_response({'error': 'Username exists'})
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
    user = authenticate(username=username, password=password)
    login(request, user)
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

@csrf_exempt
def borrow(request):
    id = request.POST.get("id", None)
    message = request.POST.get("message", "")
    lenders = request.POST.get("lenders", "")
    lender_ids = lenders.split(",")
    user = request.user
    if not user.is_authenticated():
        return render_to_json_response({'error':'Not logged in.'})
    book = get_object_or_404(Book,mongo_id=id)
    borrow = Borrow(user=user,book=book,message=message)
    borrow.save() 
    for lender_id in lender_ids:
        lender = Lender.objects.get(pk=int(lender_id))
        borrow.lenders.add(lender)
    borrow.save()
    from helpers.book import processborrow
    processborrow(borrow)
    return render_to_json_response({'success':'success'})
	
def books(request):
    if request.method == 'GET':
        sort = request.GET.get('sort','')
        if sort == '':
            sort = '-_id'
        by,what = (sort[0],sort[1:],)
        #limit = request.GET.get('limit',50)
        author = request.GET.get("author", None)
        genre = request.GET.get("genre", None)
        lender = request.GET.get("lender", None)
        page = int(request.GET.get("page", "1"))
        per_page = int(request.GET.get("per_page", "50"))
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
            book_model = Book.objects.get(mongo_id = book['_id'])
            book['lenders'] = book_model.lenders_json()
            book['author_names'] = []
            if book.has_key('authors'):
                for a in book['authors']:
                    if a.has_key('author'):
                        key = a['author']['key']
                    elif a.has_key('type') and a['type'].has_key('author'):
                        key = a['type']['author']['key']
                    else:
                        key = None
                    #import pdb; pdb.set_trace()
                    if key:
                        author = db.authors.find_one({'key': key})
                        book['author_names'].append(author['name'])

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

def authors(request, q):
    authors = get_authors(q)
    return render_to_json_response(authors)

def genres(request, q):
    genres = get_genres(q)
    return render_to_json_response(genres)

@csrf_exempt
def mail(request):
    message = request.POST.get("message")
    email = request.POST.get("email")
    send_mail("Contact on tiptiptip.org", message, email, ['info@camputer.org'])
    return render_to_json_response({'success': 'success'})
    

def index(request):
    return render_to_response('index.jade')

def update(request):
    from tasks import update_all
    update_all.delay()
    return HttpResponse("Updating in the background, refresh the books list in a couple minutes and you should see your updates.")
