$ ->
  $(document).on 'change', '#sf_taxcodeird', (evt) ->
   

    $.ajax 'update_codesemp',
      type: 'GET'
      dataType: 'script'
      data: {
        chart_clones_id: $("#sf_taxcodeird 
        option:selected").val()
      }
      
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")
