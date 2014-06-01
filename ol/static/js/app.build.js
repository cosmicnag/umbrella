({
    paths:{
        // RequireJS plugin
        text:'libs/text',
        // RequireJS plugin
        domReady:'libs/domReady',
        // underscore library
        underscore:'libs/underscore',
        // Backbone.js library
        backbone:'libs/backbone',
        'coffee-script':'libs/coffee-script',
		backbone_paginator: 'libs/backbone.paginator',
		marionette: 'libs/backbone.marionette.min',
		cs: 'libs/cs',
        tpl: 'libs/tpl',
        // jQuery
        jquery:'libs/jquery-1.8.3.min',
        typeahead: 'libs/typeahead.min'
    },
    shim:{
        backbone:{
            deps:['underscore', 'jquery'],
            exports:'Backbone'
        },
		backbone_paginator : {
			deps:['backbone']
		},
		marionette: {
            deps:['backbone'],
            exports: 'Marionette'	
		},
        underscore:{
            exports:'_'
        },
		cs: {
			deps:['coffee-script']
		},
		jquery : {
			exports:'$'
		},
        typeahead: {
            deps:['jquery'],
            exports: '$'
        }
    },
    name: "main",
    out: "build/main.js",
    baseUrl: ".",
    include: [
        "cs!app/init",
        "cs!app/utils/ajax",
        "cs!app/core/globals",
        "cs!app/core/settings",
        "cs!app/core/mediator",
        "cs!app/models/book",
        "cs!app/models/lender",
        "cs!app/views/filter",
        "cs!app/views/about",
        "cs!app/views/bookview",
        "cs!app/views/menu",
        "cs!app/views/layouts/content",
        "cs!app/views/booksview",
        "cs!app/views/lender",
        "cs!app/views/lenders",
        "cs!app/views/modals/signin",
        "cs!app/views/modals/borrow",
        "cs!app/views/modals/signup",
        "cs!app/views/modals/mail",
        "cs!app/views/modals/credits",
        "cs!app/collections/books",
        "cs!app/collections/lenders",
        "cs!app/helpers/user",
        "cs!app/helpers/modal",
        "cs!app/helpers/book",
        "tpl!app/views/about.tpl",
        "tpl!app/views/lender.tpl",
        "tpl!app/views/bookview.tpl",
    ]
})
