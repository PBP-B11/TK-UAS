import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:my_panel/app/article/model/article_model.dart';
import 'package:my_panel/app/article/util/future.dart';
import 'package:my_panel/app/article/page/article.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/util/providers/user_provider.dart';

import 'package:blur/blur.dart';

class TombolLike extends StatefulWidget {
  const TombolLike({super.key, required this.id});

  final int id;
  @override
  State<TombolLike> createState() => _TombolLikeState();
}

class _TombolLikeState extends State<TombolLike> {
  Color iconColor = Colors.grey;
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          color: iconColor,
          icon: Icon(Icons.favorite),
          onPressed: () {
            if (clicked) {
              return;
            }
            setState(() {
              clicked = true;
              iconColor = Colors.red;
              addLike(widget.id);
            });
          },
        )
      ],
    );
    ;
  }
}

class FutureArticleCard extends StatefulWidget {
  final Function refresh;
  const FutureArticleCard(
      {super.key, required this.jenis, required this.refresh});

  final String jenis;
  @override
  State<FutureArticleCard> createState() => _FutureArticleCardState();
}

class _FutureArticleCardState extends State<FutureArticleCard> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserManagement>();
    final penggunaLogin = user.userLoggedIn;
    bool teknisi;

    if (penggunaLogin != null) {
      teknisi = penggunaLogin.isTechnician;
    } else {
      teknisi = false;
    }

    String url = "http";
    if (widget.jenis == "allArticle") {
      url = "https://mypanel.up.railway.app/article/artikel-json/";
    } else if (widget.jenis == "myArticle") {
      url = "https://mypanel.up.railway.app/article/artikel-user-json/";
    } else {
      url = "https://mypanel.up.railway.app/article/artikel-submitted-json/";
    }
    return FutureBuilder(
        future: fetchArticle(context, url),
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
                    Article article = listArticle[index];

                    try {
                      Color iconColor = Colors.grey;
                      bool clicked = false;
                      String formattedDate =
                          DateFormat('MMM d, yyyy').format(article.fields.date);
                      var gambar = ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          article.fields.gambar,
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
                              article.fields.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              formattedDate,
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
                              article.fields.title,
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
                                Text(
                                  article.fields.status
                                      ? "Approved"
                                      : "Submitted",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.0,
                                    color: article.fields.status
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
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
                              article.fields.title,
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
                                    await deleteArticle(article.pk);
                                    widget.refresh();
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
                                  onTap: () async {
                                    await approveArticle(article.pk);

                                    widget.refresh();
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      );

                      var tombolLike = TombolLike(id: article.pk);

                      var tombolDelete = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            color: iconColor,
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool delete = false;
                              delete = await showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 15,
                                    child: Container(
                                      child: ListView(
                                        padding: const EdgeInsets.all(20),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 100,
                                            child: Icon(
                                              Icons.warning_rounded,
                                              color: Colors.amber[400],
                                              size: 100,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Center(
                                            child: Column(children: [
                                              Text(
                                                'Are you sure you want to delete this article?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ]),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              if (delete) {
                                await deleteArticle(article.pk);
                                widget.refresh();
                              }
                              // addLike(article.pk);
                            },
                          )
                        ],
                      );

                      var teksDeskripsi;
                      var tombolArtikel;
                      if (widget.jenis == "allArticle") {
                        teksDeskripsi = teksDeskripsi1;
                        tombolArtikel = teknisi ? tombolDelete : tombolLike;
                      } else if (widget.jenis == "myArticle") {
                        teksDeskripsi = teksDeskripsi2;
                        tombolArtikel = SizedBox();
                      } else {
                        teksDeskripsi = teksDeskripsi3;
                        tombolArtikel = SizedBox();
                      }

                      return InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: 100,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gambar,
                              SizedBox(width: 10),
                              teksDeskripsi,
                              tombolArtikel,
                            ],
                          ),
                        ),
                        onTap: () async {
                          openUrlinApp(url: article.fields.url);
                        },
                      );
                    } catch (e) {
                      return Container();
                    }

                    // return ArticleCard(article: article, jenis: widget.jenis);
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
          (article) => InkWell(
            child: Container(
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
            onTap: () async {
              openUrlinApp(url: article.fields.url);
            },
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
        future: fetchArticle(context,
            "https://mypanel.up.railway.app/article/artikel-populer-json/"),
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

class FutureArticleThumbnail extends StatefulWidget {
  const FutureArticleThumbnail({super.key});

  @override
  State<FutureArticleThumbnail> createState() => _FutureArticleThumbnailState();
}

class _FutureArticleThumbnailState extends State<FutureArticleThumbnail> {
  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserManagement>();
    // final penggunaLogin = user.userLoggedIn;
    // bool teknisi;

    // if (penggunaLogin != null) {
    //   teknisi = penggunaLogin.isTechnician;
    // } else {
    //   teknisi = false;
    // }

    String url = "https://mypanel.up.railway.app/article/artikel-populer-json/";

    return FutureBuilder(
        future: fetchArticle(context, url),
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

              List<Material> listArticleThumbnail = [];
              for (int i = 0; i < listArticle.length; i++) {
                Article article = listArticle[i];
                String formattedDate =
                    DateFormat('MMM d, yyyy').format(article.fields.date);

                Material articleMaterial = Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () async {
                      openUrlinApp(url: article.fields.url);
                    },
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            article.fields.gambar,
                            fit: BoxFit.cover,
                            height: 105,
                          ),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    article.fields.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );

                listArticleThumbnail.add(articleMaterial);
              }

              Material routeToArticlePage = Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArticlePage()),
                    );
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'lib/assets/images/panel_surya.jpg',
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ).blurred(
                            blur: 2,
                            blurColor: Color.fromARGB(221, 127, 127, 127)),
                        // ), Image.network(
                        //         listArticle[listArticle.length - 1].fields.gambar,
                        //         fit: BoxFit.cover,
                        //       ).blurred(
                        //           blur: 3,
                        //           blurColor: Color.fromARGB(221, 49, 49, 49)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          Center(
                            child: Text(
                              "Lihat Selengkapnya",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );

              listArticleThumbnail.add(routeToArticlePage);

              try {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                      SliverGrid.extent(
                        maxCrossAxisExtent: 175,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                        childAspectRatio: 1.0,
                        children: listArticleThumbnail,
                      )
                    ],
                  ),
                );
              } catch (e) {
                return Container();
              }
            }
          }
        });
  }
}
