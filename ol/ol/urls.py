from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'ol.views.home', name='home'),
    # url(r'^ol/', include('ol.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    url(r'^secret_update_url$', 'books.views.update'),
    # Uncomment the next line to enable the admin:
    url(r'^adminx/', include(admin.site.urls)),
    url(r'^mail_contact$', 'books.views.mail'),
    url(r'^api/', include('ol.api_urls')),
    url(r'^$', 'books.views.index'),
)
