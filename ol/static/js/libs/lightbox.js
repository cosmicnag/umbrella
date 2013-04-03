

(function($) {
    $.fn.rbox = function(options) {
        var that = this;

        $('.lightBoxBlock').click(function(e) {
            e.stopPropagation();
        });

        $('.closeLightBox').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            $('.overlay').unbind("click");
            var opts = $('.lightBox').data("rboxOpts");
            $('.overlay').fadeOut(opts.fade, function() {
                //alert("im your friend");
                $('.lightBoxContent').html(opts.loading);
                opts.onclose(opts);
            });
            //$('.lightBoxContent').data("rboxOpts", false);
        });

        $('.nextLightBox').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            var opts = $('.lightBox').data("rboxOpts");
            var $thisSeries = that.filter(opts.seriesSelector);
            var index = $thisSeries.index(opts.$anchor);
            $thisSeries.eq(index + 1).click();
        });

        $('.prevLightBox').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            var opts = $('.lightBox').data("rboxOpts");
            var $thisSeries = that.filter(opts.seriesSelector);
            var index = $thisSeries.index(opts.$anchor);
            $thisSeries.eq(index - 1).click();
        });
        
        //get options, giving preference, in order, to data- attributes defined on the html element, options passed when instantiatiing $(element).lightbox(options), defaults.
        var options = options || {},
            namespace = options.namespace || "rbox",
            
            optionTypes = {
                'strings': ['series', 'type', 'image', 'iframe', 'html', 'ajax', 'caption', 'loading', 'element'],
                'integers': ['width', 'height', 'fade'],
                'floats': [],
                'arrays':  [],
                'objects': [],
                'booleans': []
                //'functions': ['callback'] FIXME: lets not.
            };

     
        return this.each(function() {
            //alert("hi");                
            var $this = $(this),
                dataOptions = $.extend(options, $this.getDataOptions(optionTypes, namespace));

            var opts = $.extend({
                    'series': '', //string, series this lightbox is a part of
                    'type': 'image', //type of content - image, iframe, html or ajax
                    'image': '', //path to image, for type image
                    'iframe': '', //iframe URL
                    'html': '', //arbitrary html
                    'element': '', //selector for element on page whose innterHTML is the content
                    'ajax': '', //URL to fetch ajax content from
                    'caption': '', //optional caption
                    'fade': 300, //fade delay
                    'width': 0,
                    'height': 0,
                    'namespace': namespace,
                    'loading': 'Loading...',
                    'beforeopen': function(opts) { return opts; }, //called before open
                    'onopen': function() { $.noop(); }, //called onopen
                    'onclose': function() { $.noop(); } //called onclose

                }, dataOptions);

            if (opts.series) {
                opts.seriesSelector = '[data-' + opts.namespace + '-' + 'series=' + opts.series + ']';
            }

            $this.click(function(e) {
                e.preventDefault(); 
                //alert("hello");        
//                console.log(dataOptions);
                if (opts.series) {
                    var $thisSeries = that.filter(opts.seriesSelector);
                    var total = $thisSeries.length;
                    var thisIndex = $thisSeries.index($this) + 1;
                    //console.log($thisSeries, total, thisIndex);
                    if (thisIndex >= total) {
                        $('.nextLightBox').hide();
                    } else {
                        $('.nextLightBox').show();
                    }
                    if (thisIndex == 1) {
                        $('.prevLightBox').hide();
                    } else {
                        $('.prevLightBox').show();
                    }
                } else {
                    $('.nextLightBox, .prevLightBox').hide();
                }

                opts.$anchor = $this;
                opts = opts.beforeopen(opts);
                getLightBoxContent(opts, showLightbox);
            });

        });

    };

    function getLightBoxContent(opts, callback) {
        switch (opts.type) {
            case "image":
                var src = opts.image;
                var $content = $("<img />").attr("src", src);
                if (opts.width) {
                    $content.attr("width", opts.width);
                }
                if (opts.height) {
                    $content.attr("height", opts.height);
                }
                callback($content, opts);
                break;
            case "iframe":
                var $content = $('<iframe />').attr("src", opts.iframe);
                if (opts.width) {
                    $content.attr("width", opts.width);
                }
                if (opts.height) {
                    $content.attr("height", opts.height);
                }
                callback($content, opts);
                break;
            case "ajax":
                $('.lightBoxContent').html(opts.loading);
                $.get(opts.ajax, function(data) {
                    $content = $('<div />').html(data);
                    callback($content, opts);
                });
                break;
            case "html":
                var $content = $('<div />').html(opts.html);
                callback($content, opts);
                break;

            case "element":
                var $content = $(opts.element).html();
                callback($content, opts);
                break;
        }
    }

    function showLightbox(content, opts) {


        $('.lightBox').data("rboxOpts", opts);        
        $('.overlay').show(opts.fade, function(){
            $('.overlay').bind("click", function() {
                $('.closeLightBox').click();
            });
            opts.onopen();
            $('.lightBoxContent').empty().append(content);
            $(window).resize(function() {
                if ($(window).height() < $('.lightBox').height())
                {            
                    $('.overlay').css({'position':'absolute', 'height':'auto'});
                } else {
                    $('.overlay').css({'position':'', 'height':''});
                }            
            });
            $(window).resize();
        });            
    }


    /*
    Get options from data- attributes
        Parameters:                            
            optionTypes: <object>
                example: {
                    'strings': ['option1', 'option2', 'option3'],
                    'integers': ['fooint', 'barint'],
                    'arrays': ['list1', 'list2'],
                    'booleans': ['bool1']
                }

            namespace: <string>
                example: 'pandora'
                    namespace for data- attributes
                
            example html:
                <div id="blah" data-pandora-option1="foobar" data-pandora-fooint="23" data-pandora-list2="apples, oranges" data-pandora-bool1="true">

            usage:
                var dataOptions = $('#blah').getDataOptions(optionTypes, namespace);
    */
    $.fn.getDataOptions = function(optionTypes, namespace) {
        var $element = this;
        var prefix = "data-" + namespace + "-",
            options = {};        
        $.each(optionTypes['strings'], function(i,v) {
            var attr = prefix + v;
            options[v] = $element.hasAttr(attr) ? $element.attr(attr) : undefined;
        });
        $.each(optionTypes['integers'], function(i,v) {
            var attr = prefix + v;
            options[v] = $element.hasAttr(attr) ? parseInt($element.attr(attr)) : undefined;
        });
        $.each(optionTypes['floats'], function(i,v) {
            var attr = prefix + v;
            options[v] = $element.hasAttr(attr) ? parseFloat($element.attr(attr)) : undefined;
        });
        $.each(optionTypes['arrays'], function(i,v) {
            var attr = prefix + v;
            options[v] = $element.hasAttr(attr) ? $.map($element.attr(attr).split(","), $.trim) : undefined;
        }); 
        $.each(optionTypes['booleans'], function(i,v) {
            var attr = prefix + v;
            options[v] = $element.hasAttr(attr) ? $element.attr(attr) == 'true' : false;
        });  
        $.each(optionTypes['objects'], function(i,v) {
            var attr = prefix + v;
            options[v] = $element.hasAttr(attr) ? JSON.parse($element.attr(attr)) : undefined;
        });       
        return options;
    }

    /*
    FIXME: possibly improve - http://stackoverflow.com/questions/1318076/jquery-hasattr-checking-to-see-if-there-is-an-attribute-on-an-element#1318091
    */
    $.fn.hasAttr = function(attr) {
        return this.attr(attr) != undefined;
    };


})(jQuery);
