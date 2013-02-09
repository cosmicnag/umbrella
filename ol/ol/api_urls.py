from django.conf.urls import patterns, include, url

urlpatterns = patterns('books.views',
    url(r'^lenders', 'lenders'),
)
