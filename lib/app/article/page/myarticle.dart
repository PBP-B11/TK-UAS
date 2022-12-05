import 'package:flutter/material.dart';
import 'package:my_panel/app/article/page/add_article_form.dart';
import 'package:my_panel/app/article/page/article_widget.dart';
import 'package:my_panel/app/article/util/future.dart';
import 'package:my_panel/util/drawer.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:google_fonts/google_fonts.dart';

class MyArticlePage extends StatefulWidget {
  const MyArticlePage({super.key});

  @override
  State<MyArticlePage> createState() => _MyArticlePageState();
}

class _MyArticlePageState extends State<MyArticlePage> {
  String judulPage = "My Article";
  double fontJudul = 22;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judulPage),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.symmetric(horizontal: 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FutureArticleCard(jenis: "requestedArticle"),
          ]),
        ),
      ),
      backgroundColor: Color.fromRGBO(246, 248, 250, 1),
    );
  }
}
