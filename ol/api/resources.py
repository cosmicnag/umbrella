from tastypie.resources import ModelResource
from books.models import *


class LenderResource(ModelResource):
    class Meta:
        queryset = Lender.objects.all()
        allowed_methods = ['get']
        resource_name = 'lender'
