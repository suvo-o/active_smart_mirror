import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double? height;
  final double? width;
  const MyContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    this.borderRadius = 30,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
          borderRadius: BorderRadius.all(
              Radius.circular(borderRadius * appWindow.scaleFactor / 2)),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                  color: Colors.black.withOpacity(0.2),
                  padding: padding,
                  child: child))),
    );
  }
}
