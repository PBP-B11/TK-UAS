import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:my_panel/app/article/model/article_model.dart';
import 'package:my_panel/app/article/util/future.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({super.key, required this.article, required this.jenis});

  final Article article;
  final String jenis;
  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  Color iconColor = Colors.grey;
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('MMM d, yyyy').format(widget.article.fields.date);
    var gambar = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        widget.article.fields.gambar,
        width: MediaQuery.of(context).size.width * 0.275,
        height: MediaQuery.of(context).size.width * 0.25,
        fit: BoxFit.cover,
      ),
    );

    var teksDeskripsi1 = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            widget.article.fields.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Text(
            formattedDate +
                " Jumlah Like : " +
                widget.article.fields.like.toString(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );

    var teksDeskripsi2 = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            widget.article.fields.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Text(
                  "Submitted",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.0,
                    color: Colors.grey,
                  ),
                ),
                onTap: () async {},
              ),
            ],
          ),
        ],
      ),
    );

    var teksDeskripsi3 = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            widget.article.fields.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Text(
                  "Delete",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.0,
                    color: Colors.red[600],
                  ),
                ),
                onTap: () async {
                  deleteArticle(widget.article.pk);
                },
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                child: Text(
                  "Approve",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.0,
                    color: Colors.green[500],
                  ),
                ),
                onTap: () async {},
              )
            ],
          ),
        ],
      ),
    );

    var tombolLike = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          color: iconColor,
          icon: Icon(Icons.favorite),
          onPressed: () async {
            if (clicked) {
              return;
            }
            setState(() {
              iconColor = Colors.red;
              clicked = true;
            });
            addLike(widget.article.pk);
          },
        )
      ],
    );

    var teksDeskripsi;
    var iconLike;
    if (widget.jenis == "allArticle") {
      teksDeskripsi = teksDeskripsi1;
      iconLike = tombolLike;
    } else if (widget.jenis == "myArticle") {
      teksDeskripsi = teksDeskripsi2;
      iconLike = SizedBox();
    } else {
      teksDeskripsi = teksDeskripsi3;
      iconLike = SizedBox();
    }

    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gambar,
            SizedBox(width: 10),
            teksDeskripsi,
            iconLike,
          ],
        ),
      ),
      onTap: () async {
        openUrlinApp(url: widget.article.fields.url);
      },
    );
  }
}

class FutureArticleCard extends StatefulWidget {
  const FutureArticleCard({super.key, required this.jenis});

  final String jenis;
  @override
  State<FutureArticleCard> createState() => _FutureArticleCardState();
}

class _FutureArticleCardState extends State<FutureArticleCard> {
  @override
  Widget build(BuildContext context) {
    String url = "http";
    if (widget.jenis == "allArticle") {
      url = "http://localhost:8000/article/artikel-json/";
    } else if (widget.jenis == "myArticle") {
      url = "http://localhost:8000/article/artikel-json/";
      // url = "http://localhost:8000/article/artikel-user-json/";
    } else {
      url = "http://localhost:8000/article/artikel-json/";
      // url = "http://localhost:8000/article/artikel-submitted-json/";
    }
    return FutureBuilder(
        future: fetchArticle(url),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center();
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    "Tidak ada Artikel :(",
                    style: GoogleFonts.plusJakartaSans(
                        color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              List<Article> listArticle = snapshot.data!;

              return SingleChildScrollView(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listArticle.length,
                  itemBuilder: (context, index) {
                    Article article1 = listArticle[index];

                    return ArticleCard(article: article1, jenis: widget.jenis);
                  },
                ),
              );
            }
          }
        });
  }
}

class ArticleCarousel extends StatelessWidget {
  ArticleCarousel({super.key, required this.listArticle});
  final List<Article> listArticle;

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = listArticle
        .map(
          (article) => Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(article.fields.gambar,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 238, 86, 86)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          article.fields.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        height: MediaQuery.of(context).size.height * 0.3,
        autoPlay: true,
      ),
      items: imageSliders,
    );
  }
}

class FutureArticleCarousel extends StatelessWidget {
  const FutureArticleCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            fetchArticle("http://localhost:8000/article/artikel-populer-json/"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    "Tidak ada to Article :(",
                    style: GoogleFonts.plusJakartaSans(
                        color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              List<Article> listArticle = snapshot.data!;

              return ArticleCarousel(listArticle: listArticle);
            }
          }
        });
  }
}
