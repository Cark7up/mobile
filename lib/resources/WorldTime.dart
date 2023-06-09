import 'package:http/http.dart' as http;
import 'dart:convert';

const Map<String, String> headers = {
  'Content-type': 'application/json; charset=UTF-8'
};
const String urlCity = 'https://www.timeapi.io/api/Time/current/zone?timeZone=';
const String urlLocation =
    'https://www.timeapi.io/api/Time/current/coordinate?';
final defaultDateTime = DateTime(1990);
const List<String> monthsText = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> monthsShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec',
];

const List<String> weekday = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const List<String> weekdayShort = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];


class Worldtime {
  /// returns current time at a set city in a TZ format.
  /// Examples of TZ format:
  /// Europe/Amsterdam
  /// America/Santiago
  /// Asia/Istanbul
  ///
  /// list of all TZ formats:
  /// https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List

  Future<DateTime> timeByCity(String cityTZ) async {
    final String url = urlCity + cityTZ;
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final String data = utf8.decode(response.bodyBytes.toList());
      if (response.statusCode != 200) {
        return defaultDateTime;
      }
      final Map json = jsonDecode(data);
      return DateTime.tryParse(json['dateTime']) ?? defaultDateTime;
    } catch (e) {
      rethrow;
    }
  }

  /// Returns current time by given latitude, longitude.
  Future<DateTime> timeByLocation({
    required double latitude,
    required double longitude,
  }) async {
    final String url = '${urlLocation}latitude=$latitude&longitude=$longitude';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final String data = utf8.decode(response.bodyBytes.toList());
      if (response.statusCode != 200) {
        return defaultDateTime;
      }
      final Map json = jsonDecode(data);
      return DateTime.tryParse(json['dateTime']) ?? defaultDateTime;
    } catch (e) {
      rethrow;
    }
  }

  /// Returns a [String] representation of dateTime.
  /// The [formatter] parameter should look like this:
  /// ```dart
  /// formatter = '\\D \\M \\Y \\h \\m \\N \\O';
  /// ```
  /// where:
  /// [W] - weekday, [w] - weekday short
  /// [D] - day,
  /// [M] - month, [K] - month in String form, [L] - month in String form but shortened
  /// [Y] - year,
  /// [h] - hour,
  /// [m] - minute,      // Note that it is a small 'm' (not capital 'M' for month)
  /// [s] - second,
  /// [n] - millisecond,
  /// [o] - microsecond,
  /// Not all parameters must be present, only the ones you want to display.
  /// You can write anything in the formatter to personalize it.
  /// The double \\ is to inform the function
  /// that the character after is a functional one instead of a text.
  ///
  /// Examples:
  /// ```dart
  /// DateTime dateTime = DateTime(2022,12,25,14,30);
  /// ```
  ///
  /// Example 1)
  /// ```dart
  /// String formatter = 'today is \\Dth \\h : \\m';
  /// print(format(dateTime, formatter)); // prints -> Today is 25th 14 : 30
  ///```
  ///
  /// Example 2)
  /// ```dart
  /// String formatter = 'time - \\h:\\m, date - \\D/\\M/\\Y';
  /// print(format(dateTime, formatter)); // prints -> time - 14:30, date - 25/12/2022
  /// ```

  String format({
    required DateTime dateTime,
    required String formatter,
  }) {
    Map<String, String> keys = {
      '\\W': weekday[dateTime.weekday - 1],
      '\\w': weekdayShort[dateTime.weekday - 1],
      '\\D': dateTime.day >= 10 ? dateTime.day.toString() : '0${dateTime.day}',
      '\\M': dateTime.month >= 10
          ? dateTime.month.toString()
          : '0${dateTime.month}',
      '\\K': monthsText[dateTime.month],
      '\\L': monthsShort[dateTime.month],
      '\\Y': dateTime.year.toString(),
      '\\h':
      dateTime.hour >= 10 ? dateTime.hour.toString() : '0${dateTime.hour}',
      '\\m': dateTime.minute >= 10
          ? dateTime.minute.toString()
          : '0${dateTime.minute}',
      '\\s': dateTime.second >= 10
          ? dateTime.second.toString()
          : '0${dateTime.second}',
      '\\n': dateTime.millisecond >= 100
          ? dateTime.millisecond.toString()
          : dateTime.millisecond >= 10
          ? '0${dateTime.millisecond}'
          : '00${dateTime.millisecond}',
      '\\o': dateTime.microsecond >= 100
          ? dateTime.microsecond.toString()
          : dateTime.microsecond >= 10
          ? '0${dateTime.microsecond}'
          : '00${dateTime.microsecond}',
    };

    keys.forEach((key, value) {
      if (formatter.contains(key)) {
        formatter = formatter.replaceAll(key, value.toString());
      }
    });

    return formatter;
  }
}
