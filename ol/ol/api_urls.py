from django.conf.urls import patterns, include, url

urlpatterns = patterns('books.views',
    url(r'^lenders', 'lenders'),
    url(r'^books', 'books'),
    url(r'^signin', 'signin'),
    url(r'^signup', 'signup'),
)
