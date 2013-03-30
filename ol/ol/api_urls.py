from django.conf.urls import patterns, include, url

urlpatterns = patterns('books.views',
    url(r'^lenders', 'lenders'),
    url(r'^books', 'books'),
    url(r'^authors/(?P<q>.*?).json$', 'authors'),
    url(r'^genres/(?P<q>.*?).json$', 'genres'),
    url(r'^signin', 'signin'),
    url(r'^signup', 'signup'),
    url(r'^borrow', 'borrow'),
    url(r'^filters', 'get_filters_data'),
)
