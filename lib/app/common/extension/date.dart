import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get formattedDate => DateFormat('MMMM d, y').format(this);
}