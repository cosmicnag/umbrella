# Create your views here.
from models import *
from ox.django.shortcuts import render_to_json_response

def lenders(request):
	if request.method == 'GET':
		lenders = list(Lender.objects.all().values())
		return render_to_json_response(lenders,status=200)
	return render_to_json_response([],status=501)
	
