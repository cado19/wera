$(document).ready(function(){
  var customerBtn = $('#customer-link');
  var customerForm = $('#hidden-form');
  var customerName = $('#customers_name');
  customerBtn.click(function(e){
    e.preventDefault();
    customerForm.fadeToggle();
    customerName.focus();
  });
});
