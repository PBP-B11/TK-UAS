import 'package:flutter/material.dart';
import 'package:my_panel/app/article/page/add_article_form.dart';
import 'package:my_panel/app/article/page/article_widget.dart';
import 'package:my_panel/app/article/util/future.dart';
import 'package:my_panel/util/drawer.dart';

import 'package:url_launcher/url_launcher.dart'; // Open url in app

import 'package:google_fonts/google_fonts.dart'; // font style

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/util/providers/user_provider.dart';

class MyArticlePage extends StatefulWidget {
  final Function refresh;
  const MyArticlePage({super.key, required this.refresh});

  @override
  State<MyArticlePage> createState() => _MyArticlePageState();
}

class _MyArticlePageState extends State<MyArticlePage> {
  double fontJudul = 22;
  @override
  Widget build(BuildContext context) {
    void refresh() {
      setState(() {});
      print("Berhasil refresh halaman myArticle");
    }

    final user = context.watch<UserManagement>();
    final penggunaLogin = user.userLoggedIn;
    bool teknisi;

    if (penggunaLogin != null) {
      teknisi = penggunaLogin.isTechnician;
    } else {
      teknisi = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(teknisi ? "Requested Article" : "My Article"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.symmetric(horizontal: 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            teknisi
                ? FutureArticleCard(
                    jenis: "requestedArticle", refresh: () => refresh())
                : FutureArticleCard(
                    jenis: "myArticle", refresh: () => refresh())
          ]),
        ),
      ),
      backgroundColor: Color.fromRGBO(246, 248, 250, 1),
    );
  }
}
