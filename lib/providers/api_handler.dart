import 'dart:async';
import 'package:flutter/material.dart';
import '../elements/date_fomatter.dart';
import 'indian_holidays.dart';
import 'models/article.dart';
import 'models/forecast_weather.dart';
import 'models/holiday.dart';
import 'models/weather.dart';
import 'news_boardcast.dart';
import 'weather_api.dart';

class ApiHandler extends ChangeNotifier {
  final WeatherService _ws = WeatherService();
  final HolidayService _hs = HolidayService();
  final ArticleService _as = ArticleService();
  late Timer _timer;
  List<Article> _articles = [];
  List<Holiday> _holidays = [];
  List<ForecastWeather> _forecastWeather = [];
  Weather _currentWeather = const Weather();
  late int _tempHour;
  late DateTime _tempDate;

  List<ForecastWeather> get getForecast => _forecastWeather;
  List<Article> get getArticles => _articles;
  List<Holiday> get getHolidays => _holidays;
  Weather get getCurrentWeather => _currentWeather;

  ApiHandler() {
    _startTimer();
    _tempDate = DateTime.now();
    _tempHour = _tempDate.hour;

    updateEveryDay();
    updateEveryHour();
  }

  void _updateData() {
    DateTime dt = DateTime.now();
    if (_tempHour < dt.hour) {
      _tempHour == dt.hour;
      updateEveryHour();
    }

    if (!DateFormatter(dateTime: dt).compareTo(_tempDate)) {
      _tempDate = DateTime.now();
    }
  }

  Future<void> updateEveryHour() async {
    _currentWeather = await _ws.getWeather();
    _articles = await _as.getArticles();
    notifyListeners();
  }

  Future<void> updateEveryDay() async {
    _holidays = await _hs.getHolidays();
    _forecastWeather = await _ws.getForecastWeather();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
      _updateData();
    });
  }
}
