import 'package:flutter/material.dart';

import '../elements/my_text.dart';

class WeatherTile extends StatelessWidget {
  const WeatherTile({
    Key? key,
    required this.iconLink,
    required this.label,
  }) : super(key: key);

  final String iconLink;
  final String label;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Image.asset(
            iconLink,
            height: size.height * 0.025,
            width: size.height * 0.025,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        MyText(
          label: label,
          fontSize: MyFontSize.small,
        ),
      ],
    );
  }
}
