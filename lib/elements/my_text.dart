import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'my_color.dart';

enum MyFontSize {
  normal,
  medium,
  large,
  small,
  xsmall,
  extraLarge,
  xxtraLarge,
  xxxtraLarge,
}

enum MyFontWeight {
  normal,
  light,
  bold,
}

class MyText extends StatelessWidget {
  const MyText({
    super.key,
    required this.label,
    this.fontSize = MyFontSize.normal,
    this.fontWeight = MyFontWeight.normal,
    this.isDisable = false,
    this.color = Colors.white,
    this.maxLines = 1,
    this.useShadow = false,
    this.isSuperscript = false,
  });
  final String label;
  final MyFontSize fontSize;
  final MyFontWeight fontWeight;
  final bool isDisable;
  final Color color;
  final int maxLines;
  final bool useShadow;
  final bool isSuperscript;

  double get size {
    switch (fontSize) {
      case MyFontSize.large:
        return 16.0;
      case MyFontSize.medium:
        return 14.0;
      case MyFontSize.small:
        return 9.0;
      case MyFontSize.xsmall:
        return 7.0;
      case MyFontSize.extraLarge:
        return 20.0;
      case MyFontSize.xxtraLarge:
        return 24.0;
      case MyFontSize.xxxtraLarge:
        return 30.0;
      case MyFontSize.normal:
      default:
        return 12.0;
    }
  }

  FontWeight get weight {
    switch (fontWeight) {
      case MyFontWeight.bold:
        return FontWeight.w600;
      case MyFontWeight.light:
        return FontWeight.w100;
      case MyFontWeight.normal:
      default:
        return FontWeight.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeFactor = max(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ) /
        1000;
    return Text(
      label,
      maxLines: maxLines,
      style: TextStyle(
          shadows: useShadow
              ? [
                  const Shadow(
                    color: Colors.black,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 2.0,
                  )
                ]
              : [],
          fontSize: size * sizeFactor,
          fontWeight: weight,
          color: isDisable ? MyColors.grey : color,
          fontFeatures:
              isSuperscript ? [const FontFeature.superscripts()] : []),
    );
  }
}
