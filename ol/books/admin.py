
from django.contrib import admin
from models import *
#from sorl.thumbnail.admin.current import AdminImageWidget

class LenderAdmin(admin.ModelAdmin):
	pass

admin.site.register(Lender, LenderAdmin)
