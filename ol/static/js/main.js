require.config({
    urlArgs: 'cb=' + Math.random(),
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
        jquery:'libs/jquery-1.8.3.min'
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
		}
    }
});

require(["cs!app/ol","domReady"],function(OL,domReady){
   domReady ( function(){
        OL.start();
    }); 
});
