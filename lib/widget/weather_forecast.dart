import '../providers/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../elements/date_fomatter.dart';
import '../elements/my_container.dart';
import '../elements/my_text.dart';
import '../providers/models/forecast_weather.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  List<ForecastWeather> forecasts = const [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    forecasts = context.watch<ApiHandler>().getForecast;

    return SizedBox(
      child: MyContainer(
        child: SizedBox(
          width: size.width * 0.14,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const MyText(label: "Weather Forecast"),
              const Divider(
                color: Colors.white54,
                thickness: 1.0,
              ),
              ...forecasts.map((f) {
                DateFormatter df = DateFormatter(dateTime: f.date);
                return SizedBox(
                  width: size.width * 0.14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  label: df.weekdayShort,
                                  fontSize: MyFontSize.small,
                                ),
                                MyText(
                                  label:
                                      f.date.hour < 12 ? " | Day" : " | Night",
                                  fontSize: MyFontSize.small,
                                )
                              ],
                            ),
                            Image.asset(
                              "images/weather/${f.iconLink}.png",
                              height: 10 * size.longestSide / 1000,
                              width: 10 * size.longestSide / 1000,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              label:
                                  "${(f.minTemp - 273.15).toStringAsFixed(1)}\u2103",
                              fontSize: MyFontSize.small,
                            ),
                            MyText(
                              label:
                                  "${(f.maxTemp - 273.15).toStringAsFixed(1)}\u2103",
                              fontSize: MyFontSize.small,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
