class DateFormatter {
  late DateTime _dateTime;
  final List<String> _weeekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  final List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  DateFormatter({required DateTime dateTime}) {
    _dateTime = dateTime;
  }

  String _twoDigits(int n) => n.toString().padLeft(2, "0");

  String get month => _months[_dateTime.month - 1];

  String get weekday => _weeekDays[_dateTime.weekday % 7];

  String get monthShort => _months[_dateTime.month - 1].substring(0, 3);

  String get weekdayShort => _weeekDays[_dateTime.weekday % 7].substring(0, 3);

  String get day => _twoDigits(_dateTime.day);

  String get year => _dateTime.year.toString();
  String get yearShort => year.substring(2);

  String get dayText {
    if (_dateTime.day % 10 == 1 && _dateTime.day != 11) {
      return "${day}st";
    }
    if (_dateTime.day % 10 == 2 && _dateTime.day != 12) {
      return "${day}nd";
    }
    if (_dateTime.day % 10 == 3 && _dateTime.day != 13) {
      return "${day}rd";
    }
    return "${day}th";
  }

  bool compareTo(DateTime dateTime) =>
      (dateTime.day == _dateTime.day) &
      (dateTime.month == _dateTime.month) &
      (dateTime.year == _dateTime.year);
}
