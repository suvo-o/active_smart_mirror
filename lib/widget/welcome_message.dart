import 'dart:async';
import '../elements/my_text.dart';
import 'package:flutter/material.dart';

class WelcomeMessage extends StatefulWidget {
  final bool isActive;
  final String specialMessege;
  const WelcomeMessage({
    super.key,
    this.specialMessege = "",
    this.isActive = false,
  });

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}

class _WelcomeMessageState extends State<WelcomeMessage> {
  Timer? timer;
  bool _isVisible = true;
  int i = 0;
  int j = 0;
  List<String> tempComp = [];

  final Map<String, List<String>> complimentsMap = {
    "anytime": ["Welcome to Active Smart Hub", "Hello World!!!"],
    "morning": ["Good Morning!", "Have A Nice Day!", "Good To See You"],
    "afternoon": ["Good Afternoon!", "Its Awesome!", "Good To See You"],
    "evening": ["Good Evening!", "Its Really Nice!", "Good To See You"],
    "night": ["Good Night!", "Sweet Dream!", "Good To See You"],
  };

  List<String> get compliments {
    if (!widget.isActive) {
      if (widget.specialMessege.isNotEmpty) {
        complimentsMap["anytime"]!.add(widget.specialMessege);
      }
      return complimentsMap["anytime"] ?? [];
    }
    DateTime dt = DateTime.now();
    if ((dt.hour > 4) & (dt.hour < 12)) return complimentsMap["morning"] ?? [];
    if (dt.hour < 17) return complimentsMap["afternoon"] ?? [];
    if (dt.hour < 21) return complimentsMap["evening"] ?? [];
    return complimentsMap["night"] ?? [];
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _changeMessage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        if (widget.isActive) {
          j = 0;
          i = (i + 1) % compliments.length;
        } else {
          i = 0;
          j = (j + 1) % compliments.length;
        }
        _isVisible = true;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 0.9 : 0.0,
      duration: const Duration(seconds: 3),
      child: MyText(
        label: widget.isActive ? compliments[i] : compliments[j],
        fontSize: MyFontSize.xxxtraLarge,
        fontWeight: MyFontWeight.light,
      ),
    );
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
      _changeMessage();
    });
  }
}
