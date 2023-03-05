import 'package:active_smart_mirror/elements/my_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../widget/articles_list.dart';
import '../elements/exit_button.dart';
import '../elements/linear_gradient_container.dart';
import 'left_side.dart';
import 'right_side.dart';
import '../widget/welcome_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> images = [
    "images/image01.jpg",
    "images/image02.jpg",
    "images/image03.jpg",
    "images/image04.jpg",
    "images/image05.jpg",
  ];
  bool _isActive = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: _isActive
              ? Container(
                  color: Colors.black,
                )
              : CarouselSlider(
                  items: images
                      .map(
                        (e) => SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.asset(
                            e,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 30),
                  ),
                ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          height: size.height * 0.75,
          width: size.width * 0.5,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.03,
              size.width * 0.03,
              size.width * 0.03,
              0.0,
            ),
            child: const LeftSide(),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          height: size.height * 0.75,
          width: size.width * 0.5,
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.03,
                size.width * 0.03,
                size.width * 0.03,
                0.0,
              ),
              child: const RightSide()),
        ),
        Positioned(
          bottom: size.height * 0.15,
          left: 0.0,
          height: size.height * 0.1,
          width: size.width,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
            ),
            height: double.infinity,
            width: double.infinity,
            child: WelcomeMessage(
              isActive: _isActive,
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          height: size.height * 0.15,
          width: size.width,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
            ),
            height: double.infinity,
            width: double.infinity,
            child: const ArticlesList(),
          ),
        ),
        if (_isActive)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            height: size.height * 0.15,
            width: size.width,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black,
                  ],
                ),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        if (_isActive)
          Positioned(
            top: 0.0,
            left: 0.0,
            height: size.height * 0.75,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientContainer(
                  width: size.width * 0.25,
                ),
                GradientContainer(
                  width: size.width * 0.25,
                ),
              ],
            ),
          ),
        Positioned(
          top: 0.0,
          right: 0.0,
          height: size.height * 0.025,
          width: size.width * 0.055,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0.0),
                iconSize: size.height * 0.02,
                onPressed: () => setState(() => _isActive = !_isActive),
                icon: Icon(
                  Icons.change_circle,
                  color: _isActive
                      ? MyColors.grey.withOpacity(0.1)
                      : MyColors.blue,
                ),
              ),
              const ExitButtons(),
            ],
          ),
        ),
      ],
    );
  }
}
