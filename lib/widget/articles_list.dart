import '../providers/api_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../elements/my_text.dart';
import '../providers/models/article.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({super.key});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    articles = context.watch<ApiHandler>().getArticles;
    return CarouselSlider(
        items: articles
            .map(
              (a) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyText(
                        label: a.title,
                        fontSize: MyFontSize.large,
                        maxLines: 2,
                        useShadow: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            label: a.author != "null" ? "${a.author}  -  " : "",
                            useShadow: true,
                          ),
                          MyText(
                            label: a.publishedAt.substring(0, 10),
                            useShadow: true,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
            scrollDirection: Axis.vertical,
            viewportFraction: 1.0,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10)));
  }
}
