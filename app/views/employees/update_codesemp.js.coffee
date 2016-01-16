
$("#sf_taxprocent").empty().append("<%= escape_javascript(render(:partial => 'charts/chart', :collection => @partcharts)) %>")

