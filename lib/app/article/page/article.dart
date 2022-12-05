import 'package:flutter/material.dart';
import 'package:my_panel/app/article/page/add_article_form.dart';
import 'package:my_panel/app/article/page/article_widget.dart';
import 'package:my_panel/app/article/page/myarticle.dart';
import 'package:my_panel/app/article/util/future.dart';
import 'package:my_panel/util/drawer.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:google_fonts/google_fonts.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  String judulTombol = "My Article";
  double fontJudul = 22;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article'),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.symmetric(horizontal: 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 105,
                    height: 35,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: Text(
                        "Add Article",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddArticlePage()),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    height: 35,
                    child: TextButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: Colors.blue,
                          width: 0.6,
                        )),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(246, 248, 250, 1)),
                      ),
                      child: Text(
                        judulTombol,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyArticlePage()),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Text("Popular Article",
                style: GoogleFonts.plusJakartaSans(
                    fontSize: fontJudul,
                    fontWeight: FontWeight.w500,
                    height: 3)),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 2),
              color: Colors.white,
              child: FutureArticleCarousel(),
            ),
            Text("Latest Article",
                style: GoogleFonts.plusJakartaSans(
                    fontSize: fontJudul,
                    fontWeight: FontWeight.w500,
                    height: 3)),
            FutureArticleCard(jenis: "allArticle"),
          ]),
        ),
      ),
      backgroundColor: Color.fromRGBO(246, 248, 250, 1),
    );
  }
}
