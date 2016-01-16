$ ->
  $(document).on 'change', '#chart_clones_select', (evt) ->
   

    $.ajax 'update_codes',
      type: 'GET'
      dataType: 'script'
      data: {
        chart_clones_id: $("#chart_clones_select 
        option:selected").val()
      }
      
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")
