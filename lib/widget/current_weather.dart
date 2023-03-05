import '../providers/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../elements/my_container.dart';
import '../elements/my_text.dart';
import '../providers/models/weather.dart';
import 'weather_tile.dart';
import 'wind_tile.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  late Weather weather;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    weather = context.watch<ApiHandler>().getCurrentWeather;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          child: MyContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  label: "${weather.location}, ${weather.country}",
                  fontSize: MyFontSize.xxtraLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    weather.iconLink == null
                        ? const SizedBox()
                        : Image.asset(
                            "images/weather/${weather.iconLink}.png",
                            height: size.height * 0.075,
                          ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "images/icons/sunrise.png",
                              color: Colors.white60,
                              height: size.height * 0.025,
                            ),
                            MyText(
                              label:
                                  "${weather.sunSet?.hour.toString().padLeft(2, "0")} : ${weather.sunSet?.minute.toString().padLeft(2, "0")} PM",
                              fontSize: MyFontSize.small,
                            ),
                          ],
                        ),
                        MyText(
                          label:
                              //"${weather.temp}\u2103 / ${weather.tempF}\u2109",
                              "${((weather.temp ?? 0) - 273.15).toStringAsFixed(1)}\u2103 / ${((((weather.temp ?? 0) - 273.15) * 9 / 5) + 32).toStringAsFixed(1)}\u2109",
                          fontSize: MyFontSize.extraLarge,
                          fontWeight: MyFontWeight.bold,
                        ),
                        MyText(
                          label:
                              "Feels like ${((weather.feelslike ?? 0) - 273.15).toInt()}\u2103",
                          fontSize: MyFontSize.small,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        MyContainer(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              WeatherTile(
                  iconLink: "images/icons/clouds.png",
                  label: "${weather.cloud} %"),
              const SizedBox(width: 20),
              WeatherTile(
                  iconLink: "images/icons/humidity.png",
                  label: "${weather.humidity} %"),
              const SizedBox(width: 20),
              WindTile(
                speed: weather.windKPH ?? 0.0,
                deg: weather.windDir ?? 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
