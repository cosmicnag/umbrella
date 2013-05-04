# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Lender'
        db.create_table('books_lender', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=256)),
            ('email', self.gf('django.db.models.fields.EmailField')(max_length=75)),
            ('list_id', self.gf('django.db.models.fields.CharField')(max_length=64)),
        ))
        db.send_create_signal('books', ['Lender'])

        # Adding M2M table for field users on 'Lender'
        db.create_table('books_lender_users', (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('lender', models.ForeignKey(orm['books.lender'], null=False)),
            ('user', models.ForeignKey(orm['auth.user'], null=False))
        ))
        db.create_unique('books_lender_users', ['lender_id', 'user_id'])

        # Adding model 'Book'
        db.create_table('books_book', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('ol_id', self.gf('django.db.models.fields.CharField')(db_index=True, max_length=128, unique=True, null=True, blank=True)),
            ('mongo_id', self.gf('django.db.models.fields.CharField')(unique=True, max_length=128, db_index=True)),
        ))
        db.send_create_signal('books', ['Book'])

        # Adding model 'Borrow'
        db.create_table('books_borrow', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('changed', self.gf('django.db.models.fields.DateTimeField')(null=True)),
            ('created', self.gf('django.db.models.fields.DateTimeField')(null=True)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('book', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['books.Book'])),
            ('message', self.gf('django.db.models.fields.TextField')(blank=True)),
        ))
        db.send_create_signal('books', ['Borrow'])

        # Adding model 'LenderBook'
        db.create_table('books_lenderbook', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('lender', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['books.Lender'])),
            ('book', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['books.Book'])),
            ('status', self.gf('django.db.models.fields.CharField')(max_length=128)),
        ))
        db.send_create_signal('books', ['LenderBook'])

        # Adding model 'BookFile'
        db.create_table('books_bookfile', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('fil', self.gf('django.db.models.fields.files.FileField')(max_length=100)),
            ('md5', self.gf('django.db.models.fields.CharField')(max_length=128)),
            ('book', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['books.Book'])),
        ))
        db.send_create_signal('books', ['BookFile'])


    def backwards(self, orm):
        # Deleting model 'Lender'
        db.delete_table('books_lender')

        # Removing M2M table for field users on 'Lender'
        db.delete_table('books_lender_users')

        # Deleting model 'Book'
        db.delete_table('books_book')

        # Deleting model 'Borrow'
        db.delete_table('books_borrow')

        # Deleting model 'LenderBook'
        db.delete_table('books_lenderbook')

        # Deleting model 'BookFile'
        db.delete_table('books_bookfile')


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
            'message': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'books.lender': {
            'Meta': {'object_name': 'Lender'},
            'books': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['books.Book']", 'symmetrical': 'False', 'through': "orm['books.LenderBook']", 'blank': 'True'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'list_id': ('django.db.models.fields.CharField', [], {'max_length': '64'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '256'}),
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