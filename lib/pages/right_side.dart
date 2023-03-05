import 'package:flutter/material.dart';
import '../widget/current_weather.dart';
import '../widget/weather_forecast.dart';

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const <Widget>[
          CurrentWeather(),
          SizedBox(
            height: 20.0,
            width: double.infinity,
          ),
          WeatherForecast(),
        ],
      ),
    );
  }
}
