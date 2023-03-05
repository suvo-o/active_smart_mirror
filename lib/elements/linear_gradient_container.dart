import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final double? height;
  final double? width;
  const GradientContainer({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.9),
          ],
        ),
      ),
    );
  }
}
