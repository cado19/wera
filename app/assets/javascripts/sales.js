function update_balance (){
  var amount = $('#sale_pay_amount').val();
  amount = parseFloat(amount);
  var total = $('#total').html();
  total = parseFloat(total);
  var balance = amount - total;
  isNaN(balance) ? $('#balance').html("Amount is not a number") : $('#balance').html(balance);
}

function bind1(){
  $('#sale_pay_amount').blur(update_balance);
}
