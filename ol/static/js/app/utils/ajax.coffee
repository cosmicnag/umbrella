define ['cs!app/core/settings','jquery','cs!app/core/mediator'],(settings,$,mediator) ->
  class AjaxUtil
   ajax: (route,data,type,success_closure,failure_closure=((_data)->console.log(_data)),routeoverride) ->
      mediator.events.trigger "ajaxstart"
      $.ajax
        type: type
        url: settings.getAPIEndPoint(route) #+ (
          #if type is "GET" and data.id?
          #  "/#{data.id}"
          #else if routeoverride?
          #  "/#{routeoverride}"
          #else
          #  ""
        #)
        dataType: "json"
        crossDomain: true
        data: data
        success: (_data) =>
          if _data.success?
            success_closure _data
          else
            failure_closure _data
          mediator.events.trigger "ajaxend"
        error: ()=>
          mediator.events.trigger "ajaxend"
  new AjaxUtil()
