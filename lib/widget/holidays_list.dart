import '../providers/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../elements/date_fomatter.dart';
import '../elements/my_text.dart';
import '../providers/models/holiday.dart';

class HolidaysList extends StatefulWidget {
  const HolidaysList({super.key});

  @override
  State<HolidaysList> createState() => _HolidaysListState();
}

class _HolidaysListState extends State<HolidaysList> {
  List<Holiday> holidays = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    holidays = context.watch<ApiHandler>().getHolidays;
    return SizedBox(
      width: size.width * 0.14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MyText(label: "Indian Holidays"),
          const Divider(
            color: Colors.white54,
            thickness: 1.0,
          ),
          ...holidays.map((e) {
            DateFormatter df = DateFormatter(dateTime: e.date);
            return SizedBox(
              width: size.width * 0.14,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    label: "${df.dayText} ${df.monthShort}",
                    fontSize: MyFontSize.small,
                  ),
                  SizedBox(
                    width: size.width * 0.09,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 3,
                            child: MyText(
                              label: e.name,
                              fontSize: MyFontSize.small,
                            )),
                        Flexible(
                            child: MyText(
                          label: df.weekdayShort,
                          fontSize: MyFontSize.small,
                        ))
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
