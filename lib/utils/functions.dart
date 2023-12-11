import 'package:intl/intl.dart';

String formatTime(int timeStamp) {
  final timeInMiliS = timeStamp * 1000;

  final dateTime =
      DateTime.fromMillisecondsSinceEpoch(timeInMiliS, isUtc: true);
  final formattedTime =
      DateFormat('hh:mm \na').format(dateTime.toLocal()).toString();

  return formattedTime;
}

String formatDate(int timeStamp) {
  final timeInMillis = timeStamp * 1000;

  final dateTime =
      DateTime.fromMillisecondsSinceEpoch(timeInMillis, isUtc: true);
  final formattedDate =
      DateFormat('MM-dd-yyyy').format(dateTime.toLocal()).toString();

  return formattedDate;
}

String formatDay(int timeStamp) {
  final timeInMillis = timeStamp * 1000;

  final dateTime =
      DateTime.fromMillisecondsSinceEpoch(timeInMillis, isUtc: true);
  final formattedDate = DateFormat('E').format(dateTime.toLocal()).toString();

  return formattedDate;
}

String formatTimeHr(int timeStamp) {
  final timeInMillis = timeStamp * 1000;

  final dateTime =
      DateTime.fromMillisecondsSinceEpoch(timeInMillis, isUtc: true);
  final formattedDate = DateFormat('HH').format(dateTime.toLocal()).toString();
  return formattedDate;
}

String getGreetings() {
  final dateTime = DateTime.now();

  if (dateTime.hour > 4 && dateTime.hour < 12) {
    return 'Good Morning!';
  }

  if (dateTime.hour >= 12 && dateTime.hour <= 17) {
    return 'Good Afternoon!';
  } else {
    return 'Good Evening!';
  }
}

List<int> todayMiliSecEpoch() {
  final today = DateTime.now();
  final todayMidnight =
      DateTime(today.year, today.month, today.day); // Midnight of today
  final tomorrowMidnight = todayMidnight.add(const Duration(days: 1));

  return [
    todayMidnight.millisecondsSinceEpoch,
    tomorrowMidnight.millisecondsSinceEpoch
  ];
}
