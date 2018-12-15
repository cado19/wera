$(document).ready(function(){
  var aboutBtn = $('#aboutBtn');
  var showcase = $('#showcase');
  var aboutSection = $('#about');

  aboutBtn.click(function(){
    showcase.fadeOut(2000, function(){
      aboutSection.fadeIn("slow");
    });
  });
});
