require.config({
    baseUrl: "../",
    urlArgs: 'cb=' + Math.random(),
    paths: {
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
        typeahead: 'libs/typeahead.min',
        jasmine: 'libs/jasmine-1.3.1/jasmine',
        'jasmine-html': 'libs/jasmine-1.3.1/jasmine-html',
        'jasmine-require': 'libs/jasmine-1.3.1/jasmine-require',
        spec: 'tests/spec/'
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
        },
        'jasmine-html': {
            deps: ['jasmine'],
            exports: 'jasmine'
        }
        
    }
});

require(['underscore', 'jquery', 'jasmine-html'], function(_, $, jasmine){
 
    var jasmineEnv = jasmine.getEnv();
    jasmineEnv.updateInterval = 1000;

    var htmlReporter = new jasmine.HtmlReporter();

    jasmineEnv.addReporter(htmlReporter);

    jasmineEnv.specFilter = function(spec) {
        return htmlReporter.specFilter(spec);
    };

    var specs = [];
    specs.push('cs!spec/collections/BooksSpec');
//    specs.push('spec/models/TodoSpec');
//    specs.push('spec/views/ClearCompletedSpec');
//    specs.push('spec/views/CountViewSpec');
//    specs.push('spec/views/FooterViewSpec');
//    specs.push('spec/views/MarkAllSpec');
//    specs.push('spec/views/NewTaskSpec');
//    specs.push('spec/views/TaskListSpec');
//    specs.push('spec/views/TaskViewSpec');


    $(function(){
        require(specs, function(){
            jasmineEnv.execute();
        });
    });
 
});

