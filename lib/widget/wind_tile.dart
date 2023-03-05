import 'weather_tile.dart';
import 'package:flutter/material.dart';

class WindTile extends StatelessWidget {
  final int deg;
  final double speed;
  const WindTile({super.key, required this.deg, required this.speed});

  String get _direction {
    if (deg > 22.5 && deg <= 67.5) return "NE";
    if (deg > 67.5 && deg <= 112.5) return "E";
    if (deg > 112.5 && deg <= 157.5) return "SE";
    if (deg > 157.5 && deg <= 202.5) return "S";
    if (deg > 202.5 && deg <= 247.5) return "SW";
    if (deg > 247.5 && deg <= 292.5) return "W";
    if (deg > 292.5 && deg <= 337.5) return "NW";
    return "N";
  }

  @override
  Widget build(BuildContext context) {
    return WeatherTile(
        iconLink: "images/icons/windspeed.png",
        label: "$_direction ${speed.toInt()} KMPH");
  }
}
