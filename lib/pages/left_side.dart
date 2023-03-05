import 'package:flutter/material.dart';
import '../widget/display_date_time.dart';
import '../widget/holidays_list.dart';
import '../elements/my_container.dart';
import '../widget/weekday_list.dart';

class LeftSide extends StatefulWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  DateTime? dt;
  @override
  void initState() {
    super.initState();
  }

  void getDate(DateTime dateFromChild) {
    if (mounted) {
      setState(
        () => dt = dateFromChild,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyContainer(
          child: DisplayCurrentTime(getDate),
        ),
        const SizedBox(
          height: 20.0,
          width: double.infinity,
        ),
        MyContainer(
          height: size.height * 0.08,
          child: WeekdayList(dateTime: dt ?? DateTime.now()),
        ),
        const SizedBox(
          height: 20.0,
          width: double.infinity,
        ),
        const MyContainer(child: HolidaysList()),
      ],
    ));
  }
}
