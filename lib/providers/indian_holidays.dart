import 'dart:convert';
import 'package:http/http.dart';

import 'models/holiday.dart';

class MyDateTime {
  final String day;
  final String month;
  final String year;
  MyDateTime(this.day, this.month, this.year);
}

class HolidayService {
  final String postsURL =
      "https://calendarific.com/api/v2/holidays?api_key=0705db5f0d89abaf7184ffbac341b17f837192fc&country=IN&year=2023";

  Future<List<Holiday>> getHolidays() async {
    Response res;
    try {
      res = await get(Uri.parse(postsURL));
    } catch (e) {
      return [];
    }

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<Holiday> holidays = [];
      body["response"]["holidays"].forEach((item) {
        holidays.add(Holiday(
          name: item["name"].toString(),
          date: DateTime.utc(
            item["date"]["datetime"]["year"].toInt(),
            item["date"]["datetime"]["month"].toInt(),
            item["date"]["datetime"]["day"].toInt(),
          ),
        ));
      });
      holidays.sort((a, b) => a.date.compareTo(b.date));
      List<Holiday> hs = holidays
          .where((holiday) => holiday.date.compareTo(DateTime.now()) >= 0)
          .toList()
          .sublist(0, 10);
      return hs;
    } else {
      return [];
    }
  }
}
