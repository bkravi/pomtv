/*
jQuery(document).ready(function($) {
	    $('a[rel*=facebox]').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.png',
      })
    })
$(document).ready(function() {
  $("#visitor_visitor_type").change(function(){
    value = $(this).val();
    if(value == 'bk'){
    $.post("/visitors/add_fields_1",
      function(data){$("#add_fields").html(data)}
    );
    }else{
      $("#add_fields").html('');
    }
  });

  $("#add_info").live('click', function(){
    if($("#add_info").attr("src").indexOf("add-Icon") > -1) 
		{
		$("#add_fields2").html('');
		$.post("/visitors/additional_info",
		  function(data){$("#additional_info").html(data)}
		);
		$("#additional_info").show("slow");
		$("#add_info").attr("src","/images/Minus.png");
	}
	else {
		$("#additional_info").hide("slow");
		$("#add_info").attr("src","/images/add-Icon.png");
	}
  });

  $("#add_info_checkin").click(function(){$("#additional_info_checkin").show("slow");});
  $("#is_driver_along_checkin_1").click(function(){$("#additional_info2_checkin").show("slow");});
  $("#is_driver_along_checkin_0").click(function(){$("#additional_info2_checkin").hide("slow");});

  $("#hide_additional_visitor").live('click', function(){
    $("#additional_info").hide("slow");
  });
  
  $("#visitor_is_driver_along_true").live('change', function(){
    $.post("/visitors/add_fields_2",
      function(data){$("#add_fields2").html(data)}
    );
  });
  $("#visitor_is_driver_along_false").live('change', function(){
    $("#add_fields2").html('');
  });
  
});
*/