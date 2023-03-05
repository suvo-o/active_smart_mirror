class ForecastWeather {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final double temp;
  final String text;
  final String iconLink;
  final double maxWindKPH;
  final int avgHumidity;
  final int cloud;
  final double feelslike;
  final int windDir;

  const ForecastWeather({
    required this.windDir,
    required this.feelslike,
    required this.cloud,
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.date,
    required this.text,
    required this.iconLink,
    required this.maxWindKPH,
    required this.avgHumidity,
  });
}
