import 'package:flutter/material.dart';
import '../elements/date_fomatter.dart';
import '../elements/my_text.dart';

class WeekdayList extends StatelessWidget {
  final DateTime dateTime;
  const WeekdayList({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> days = [];

    for (int i = -3; i <= 3; i++) {
      days.add(DayColumn(
        date: dateTime.add(Duration(days: i)),
        isActive: i != 0 ? false : true,
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => days[index]),
            separatorBuilder: ((context, index) => const SizedBox(width: 12.0)),
            itemCount: days.length)
      ],
    );
  }
}

class DayColumn extends StatelessWidget {
  final DateTime date;
  final bool isActive;
  const DayColumn({super.key, required this.date, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    DateFormatter df = DateFormatter(dateTime: date);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          label: df.weekdayShort.toUpperCase(),
          fontSize: MyFontSize.xsmall,
          fontWeight: isActive ? MyFontWeight.bold : MyFontWeight.normal,
        ),
        MyText(
          label: df.day,
          fontSize: MyFontSize.medium,
          fontWeight: isActive ? MyFontWeight.bold : MyFontWeight.normal,
        ),
      ],
    );
  }
}
