import 'dart:convert';
import 'package:active_smart_mirror/elements/date_fomatter.dart';
import 'package:http/http.dart';

import 'models/forecast_weather.dart';
import 'models/weather.dart';

enum Meridiem { am, pm }

class WeatherService {
  final String postsURL =
      "https://api.openweathermap.org/data/2.5/weather?lat=17.3850&lon=78.4867&appid=8596e5810510efc9fb7251b16c61ebb7";

  final String forecastUrl =
      "https://api.openweathermap.org/data/2.5/forecast?lat=17.3850&lon=78.4867&appid=8596e5810510efc9fb7251b16c61ebb7";

  Weather dummyWeather = Weather(
    lastUpdated: Time(
      hour: "00",
      minute: "00",
    ),
    temp: 0.0,
    tempMax: 0.0,
    tempMin: 0.0,
    text: "Server Error",
    iconLink: "",
    windKPH: 0.0,
    windDir: 90,
    humidity: 0,
    cloud: 0,
    feelslike: 0.0,
    country: '',
    location: '',
    sunRise: Time(hour: "00", minute: "00"),
    sunSet: Time(hour: "00", minute: "00"),
  );

  Future<Weather> getWeather() async {
    Response res;
    try {
      res = await get(Uri.parse(postsURL));
    } catch (e) {
      // ignore: avoid_print
      print("Weather Service Error");
      return dummyWeather;
    }

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      Weather weather = Weather(
        location: body["name"], //
        country: body["sys"]["country"], //
        lastUpdated: Time(
          hour: DateTime.fromMillisecondsSinceEpoch(body["dt"] * 1000)
              .hour
              .toString(),
          minute: DateTime.fromMillisecondsSinceEpoch(body["dt"] * 1000)
              .minute
              .toString(),
        ),
        temp: body["main"]["temp"], //
        text: body["weather"][0]["main"], //
        iconLink: body["weather"][0]["icon"], //
        windKPH: body["wind"]["speed"], //
        windDir: body["wind"]["deg"], //
        humidity: body["main"]["humidity"], //
        cloud: body["clouds"]["all"], //
        feelslike: body["main"]["feels_like"],
        sunRise: Time(
          hour:
              DateTime.fromMillisecondsSinceEpoch(body["sys"]["sunrise"] * 1000)
                  .hour
                  .toString(),
          minute:
              DateTime.fromMillisecondsSinceEpoch(body["sys"]["sunrise"] * 1000)
                  .minute
                  .toString(),
        ),
        sunSet: Time(
          hour:
              DateTime.fromMillisecondsSinceEpoch(body["sys"]["sunset"] * 1000)
                  .hour
                  .toString(),
          minute:
              DateTime.fromMillisecondsSinceEpoch(body["sys"]["sunset"] * 1000)
                  .minute
                  .toString(),
        ),
        tempMax: body["main"]["temp_max"],
        tempMin: body["main"]["temp_min"], //
      );
      return weather;
    } else {
      return dummyWeather;
    }
  }

  Future<List<ForecastWeather>> getForecastWeather() async {
    Response res;
    try {
      res = await get(Uri.parse(forecastUrl));
    } catch (e) {
      // ignore: avoid_print
      print("Weather Service Error");
      return [];
    }

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      // ignore: avoid_print
      //print(body);
      List<ForecastWeather> forecasts = [];
      body["list"].forEach((f) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
          f["dt"] * 1000,
        );
        //String temp = f["dt_txt"].toString().substring(11, 16);
        if ((date.hour == 08 || date.hour == 20) &&
            !DateFormatter(dateTime: date).compareTo(DateTime.now())) {
          forecasts.add(ForecastWeather(
            date: DateTime.fromMillisecondsSinceEpoch(
              f["dt"] * 1000,
            ),
            maxTemp: f["main"]["temp_max"],
            minTemp: f["main"]["temp_min"],
            text: f["weather"][0]["description"],
            iconLink: f["weather"][0]["icon"],
            maxWindKPH: double.parse(f["wind"]["speed"].toString()),
            avgHumidity: f["main"]["humidity"],
            cloud: f["clouds"]["all"],
            temp: f["main"]["temp"],
            feelslike: f["main"]["feels_like"].toDouble(),
            windDir: f["wind"]["deg"],
          ));
        }
      });
      for (var element in forecasts) {
        // ignore: avoid_print
        print(element.date);
      }
      return forecasts;
    } else {
      return [];
    }
  }
}
