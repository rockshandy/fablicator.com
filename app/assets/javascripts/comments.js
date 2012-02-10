//= require tinymce-jquery

$(function(){
  $('#comment_body').tinymce({
    theme : "advanced",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    //theme_advanced_statusbar_location : "bottom",
    theme_advanced_buttons1: "bold,italic,|,link,unlink",
    theme_advanced_buttons2: "",
    theme_advanced_buttons3: "" 
  });
});
