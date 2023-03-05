import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class ExitButtons extends StatefulWidget {
  const ExitButtons({Key? key}) : super(key: key);

  @override
  State<ExitButtons> createState() => _ExitButtonsState();
}

class _ExitButtonsState extends State<ExitButtons> {
  final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Colors.black.withOpacity(0.0),
      iconMouseOver: Colors.white);
  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: CloseWindowButton(colors: closeButtonColors),
    );
  }
}
