import 'dart:async' show Timer;
import 'package:flutter/material.dart';

import '../elements/date_fomatter.dart';
import '../elements/my_text.dart';

class DisplayCurrentTime extends StatefulWidget {
  final Function(DateTime dateFromChild)? dateCallback;
  const DisplayCurrentTime(void Function(DateTime dateFromChild) getDate,
      {Key? key, this.dateCallback})
      : super(key: key);

  @override
  State<DisplayCurrentTime> createState() => _DisplayCurrentTimeState();
}

class _DisplayCurrentTimeState extends State<DisplayCurrentTime> {
  DateTime currentTime = DateTime.now();
  Timer? timer;
  DateTime dt = DateTime.now();
  DateFormatter df = DateFormatter(dateTime: DateTime.now());

  @override
  void initState() {
    _startTimer();
    dt = DateTime.now();
    super.initState();
  }

  void _changeDateTime() {
    if (mounted) {
      setState(() => dt = DateTime.now());
    }
    if (!DateFormatter(dateTime: currentTime).compareTo(dt)) {
      currentTime = dt;
      widget.dateCallback!(dt);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          label: df.weekday,
          fontSize: MyFontSize.xxtraLarge,
          //fontWeight: MyFontWeight.bold,
        ),
        MyText(
          label: "${df.dayText} of ${df.month}, ${dt.year}",
          fontSize: MyFontSize.large,
          //fontWeight: MyFontWeight.bold,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: customText(
                          time: dt.hour.remainder(12),
                          fontWeight: MyFontWeight.bold,
                          fontSize: MyFontSize.extraLarge))),
              const SizedBox(width: 5.0),
              const MyText(
                label: ":",
                fontSize: MyFontSize.extraLarge,
                fontWeight: MyFontWeight.bold,
              ),
              const SizedBox(width: 5.0),
              Expanded(
                  flex: 3,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: customText(
                          time: dt.minute.remainder(60),
                          fontSize: MyFontSize.extraLarge,
                          fontWeight: MyFontWeight.bold))),
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: customText(
                          time: dt.second.remainder(60),
                          fontSize: MyFontSize.medium,
                          fontWeight: MyFontWeight.light))),
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    fontSize: MyFontSize.extraLarge,
                    fontWeight: MyFontWeight.bold,
                    label: dt.hour > 11 ? " PM" : " AM",
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget customText({
    required int time,
    MyFontWeight fontWeight = MyFontWeight.normal,
    MyFontSize fontSize = MyFontSize.normal,
  }) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Center(
          child: MyText(
            label: twoDigits(time),
            fontSize: fontSize,
            fontWeight: fontWeight,
            //fontWeight: MyFontWeight.light,
          ),
        ));
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _changeDateTime();
    });
  }
}
