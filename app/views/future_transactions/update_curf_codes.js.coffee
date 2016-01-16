
$("#charts_select").empty().append("<%= escape_javascript(render(:partial => 'charts/chart', :collection => @partcharts)) %>")

