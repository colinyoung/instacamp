// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  window.results = [];
  $("#new_search").bind('ajax:success', function(evt, xhr) {
    populateResults(xhr);
  });
});

function populateResults(json) {
  var results = $("#search_results");
  scroll(0,0); // scroll to top
  $.each(json, function(i,v) {
    var imageId = v.imageId.replace(/:/gi, '');
    var result_div = '<div onclick="resultClick(this)" class="result" id="img-' + imageId + '">' + 
      '<img src="' + v.tbUrl + '" />'
    '</div>';
    window.results[imageId] = v;
    results.prepend(result_div);
  });
}

function cls(v) {
  console.log(v)
  $("#search_results").empty().html(v);
  $("#search_results").css('opacity', '1.0');
  setTimeout('$("#search_results").empty(); $("#search_value").val("")', 3000);
}

function resultClick(t) {
  var object_id = $(t).attr('id').replace(/img\-/gi, '');
  var obj = window.results[object_id];
  $.ajax({
    type: "POST",
    url: '/chat/new',
    data: obj,
    success: cls,
    beforeSend: function() {
      $("#search_results").css('opacity', '0.3');
    }
    });
}

