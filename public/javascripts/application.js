// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(document).ready(function(){
      
	  $("#st_dt, #end_dt").datepicker({
            dateFormat: 'yy/mm/dd', changeMonth: true, changeYear: true, showOtherMonths: true, selectOtherMonths: true
      });
})
