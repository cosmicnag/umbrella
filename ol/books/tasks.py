from celery import task

@task()
def sendmail(borrowersname,borrowersemail,lendersemails,message,bookname):
    from django.core.mail import send_mail
    send_mail('%s wants to borrow %s' %(borrowersname,bookname), message, borrowersemail,
    lendersemails, fail_silently=False)
