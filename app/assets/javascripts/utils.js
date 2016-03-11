amountFormat = function(amount) {
  return formatter.format(Number(amount));
}

dateFormat = function(d) {
  var parts = d.split('-');
  var date =  new Date(parts[0], parts[1]-1, parts[2]); // Note: months are 0-based
  return date.toLocaleDateString("pt-BR")
}

getDayFromDate = function(d) {
  var parts = d.split('-');
  return parts[2]
}

dateIsWeekend = function(d){
  var parts = d.split('-');
  var date =  new Date(parts[0], parts[1]-1, parts[2]); // Note: months are 0-based
  var day = date.getDay();
  return (day == 6) || (day == 0);    // 6 = Saturday, 0 = Sunday
}

var formatter = new Intl.NumberFormat('pt-BR', {
  style: 'currency',
  currency: 'BRL',
  minimumFractionDigits: 2,
});