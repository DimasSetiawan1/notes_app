String formatTime(DateTime dateTime) {
  String hour = (dateTime.hour % 12).toString().padLeft(2, '0'); 
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}


String formatDate(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  return '$day-$month-$year';
}