# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding field 'Lender.neighbourhood'
        db.add_column('books_lender', 'neighbourhood',
                      self.gf('django.db.models.fields.CharField')(default='', max_length=512, blank=True),
                      keep_default=False)

        # Adding field 'Lender.address'
        db.add_column('books_lender', 'address',
                      self.gf('django.db.models.fields.TextField')(default='', blank=True),
                      keep_default=False)

        # Adding field 'Lender.lending_policy'
        db.add_column('books_lender', 'lending_policy',
                      self.gf('django.db.models.fields.TextField')(default='', blank=True),
                      keep_default=False)

        # Adding field 'Lender.image'
        db.add_column('books_lender', 'image',
                      self.gf('django.db.models.fields.files.ImageField')(default='', max_length=100, blank=True),
                      keep_default=False)


    def backwards(self, orm):
        # Deleting field 'Lender.neighbourhood'
        db.delete_column('books_lender', 'neighbourhood')

        # Deleting field 'Lender.address'
        db.delete_column('books_lender', 'address')

        # Deleting field 'Lender.lending_policy'
        db.delete_column('books_lender', 'lending_policy')

        # Deleting field 'Lender.image'
        db.delete_column('books_lender', 'image')


    models = {
        'auth.group': {
            'Meta': {'object_name': 'Group'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        'auth.permission': {
            'Meta': {'ordering': "('content_type__app_label', 'content_type__model', 'codename')", 'unique_together': "(('content_type', 'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['contenttypes.ContentType']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Group']", 'symmetrical': 'False', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        'books.book': {
            'Meta': {'object_name': 'Book'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'mongo_id': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '128', 'db_index': 'True'}),
            'ol_id': ('django.db.models.fields.CharField', [], {'db_index': 'True', 'max_length': '128', 'unique': 'True', 'null': 'True', 'blank': 'True'})
        },
        'books.bookfile': {
            'Meta': {'object_name': 'BookFile'},
            'book': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['books.Book']"}),
            'fil': ('django.db.models.fields.files.FileField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'md5': ('django.db.models.fields.CharField', [], {'max_length': '128'})
        },
        'books.borrow': {
            'Meta': {'object_name': 'Borrow'},
            'book': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['books.Book']"}),
            'changed': ('django.db.models.fields.DateTimeField', [], {'null': 'True'}),
            'created': ('django.db.models.fields.DateTimeField', [], {'null': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'lenders': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['books.Lender']", 'symmetrical': 'False'}),
            'message': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'books.lender': {
            'Meta': {'object_name': 'Lender'},
            'address': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'books': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['books.Book']", 'symmetrical': 'False', 'through': "orm['books.LenderBook']", 'blank': 'True'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'image': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'blank': 'True'}),
            'lending_policy': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'list_id': ('django.db.models.fields.CharField', [], {'max_length': '64'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '256'}),
            'neighbourhood': ('django.db.models.fields.CharField', [], {'max_length': '512', 'blank': 'True'}),
            'users': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.User']", 'symmetrical': 'False', 'blank': 'True'})
        },
        'books.lenderbook': {
            'Meta': {'object_name': 'LenderBook'},
            'book': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['books.Book']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'lender': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['books.Lender']"}),
            'status': ('django.db.models.fields.CharField', [], {'max_length': '128'})
        },
        'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        }
    }

    complete_apps = ['books']