import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => ' ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat("yyyy-MM-dd").format(date);
  static formatDummyDate(DateTime date) => DateFormat("yyMM").format(date);
  static formatYear(DateTime date) => DateFormat("yyyy").format(date);
  static formatMonth(DateTime date) => DateFormat("MM").format(date);
}