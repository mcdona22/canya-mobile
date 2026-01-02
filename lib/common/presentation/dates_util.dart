import 'package:intl/intl.dart';

final dateOnlyFormatString = 'dd MMM yy';
final timeOnlyFormatString = 'HH:mm';

final dateOnlyFormatter = DateFormat(dateOnlyFormatString);
final timeOnlyFormatter = DateFormat(timeOnlyFormatString);
final dateFormatter = DateFormat(
  '$dateOnlyFormatString '
  '$timeOnlyFormatString',
);
