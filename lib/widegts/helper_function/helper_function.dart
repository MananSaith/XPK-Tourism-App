import 'package:intl/intl.dart';
import 'package:xpk/utils/imports/app_imports.dart';

const int imageQualityCompress = 50;

class HelperFunctions {
  static String convertToLocalTime(String utcTimeString) {
    DateTime utcDateTime = DateTime.parse(utcTimeString);
    DateTime localDateTime = utcDateTime.toLocal();

    // Format local time
    String formattedLocalTime = DateFormat('hh:mm a').format(localDateTime);
    debugPrint("formattedLocalTime: $formattedLocalTime");
    return formattedLocalTime;
  }

  static String chatTime(String dateTime) {
    debugPrint("chatDateTime: $dateTime");
    // dateTime = dateTime.replaceAll(".000000Z", 'Z');
    DateTime now;
    if (!(dateTime.contains('T'))) {
      return DateFormat('hh:mm a').format(DateTime.parse(dateTime));
    } else {
      String utcString = dateTime;
      DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      now = format.parseUtc(utcString);
    }
    // return DateFormat('hh:mm a').format(now);
    return DateFormat('hh:mm a').format(now.toLocal());
  }

  static String chatDate(String dateTime) {
    //print("chatDate: $dateTime");
    DateTime now;
    if (!(dateTime.contains('T'))) {
      return DateFormat("MMM dd, yyyy").format(DateTime.parse(dateTime));
    } else {
      String utcString = dateTime;
      DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      now = format.parseUtc(utcString);
    }
    return DateFormat("MMM dd, yyyy").format(now.toLocal());
  }

  static String convertToAgoChat(String dateTime) {
    // print("convertToAgoChat: ${dateTime.toDate()}");
    DateTime input;
    if (!(dateTime.contains('T'))) {
      input = DateTime.parse(dateTime);
    } else {
      String utcString = dateTime;
      DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      input = format.parseUtc(utcString);
      // DateTime.fromMillisecondsSinceEpoch(
      // int.parse(dateTime));
    }
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }

  static bool isDateCurrent(dynamic dateInput) {
    if (dateInput == null) {
      // Handle null date if needed
      return false;
    }

    DateTime date;

    // Check if the input is a String, then parse it
    if (dateInput is String) {
      try {
        date = DateTime.parse(dateInput);
      } catch (e) {
        // Handle parsing error if the string is not a valid DateTime format
        
        return false;
      }
    } else if (dateInput is DateTime) {
      // If it's already a DateTime, use it directly
      date = dateInput;
    } else {
      // Invalid input type
      return false;
    }

    // Get the current date and time
    DateTime currentDate = DateTime.now();

    // Compare the given date with the current date
    return date.year == currentDate.year &&
        date.month == currentDate.month &&
        date.day == currentDate.day;
  }

  static String getGlobalTime() {
    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    var messageTime = format.format(DateTime.now().toUtc());
    return messageTime;
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String getImageUrl(String image) {
    return '${ApiConstant.imageBaseUrl}$image';
  }

 
}
