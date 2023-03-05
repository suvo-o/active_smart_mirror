class Time {
  final String hour;
  final String minute;

  String get meridiem => int.parse(hour) > 11 ? "PM" : "AM";

  Time({required this.hour, required this.minute});
}

class Weather {
  final String? location;
  final String? country;
  final Time? lastUpdated;
  final double? temp;
  final double? tempMax;
  final double? tempMin;
  final String? text;
  final String? iconLink;
  final double? windKPH;
  final int? windDir;
  final int? humidity;
  final int? cloud;
  final double? feelslike;
  final Time? sunRise;
  final Time? sunSet;

  const Weather({
    this.sunRise,
    this.sunSet,
    this.tempMax,
    this.tempMin,
    this.location,
    this.country,
    this.lastUpdated,
    this.temp,
    this.text,
    this.iconLink,
    this.windKPH,
    this.windDir,
    this.humidity,
    this.cloud,
    this.feelslike,
  });
}
