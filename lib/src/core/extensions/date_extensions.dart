import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  // return Thu. 23 May 2024 19:25
  String toDayMonthTime() {
    return DateFormat('EEE. dd MMM yyyy HH:mm').format(this);
  }

  String toMonthDayYear() {
    return DateFormat('MMMM d, yyyy').format(this);
  }

  String toDayMonthYear() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String toDayMonth() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
