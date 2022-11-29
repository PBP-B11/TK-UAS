import 'package:flutter/material.dart';
import 'package:my_panel/app/article/util/future.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_panel/util/drawer.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article'),
      ),
      drawer: MyDrawer(),
      body: Column(children: [
        ListTile(
          leading: Image.network(
            'https://www.esdm.go.id/assets/imagecache/bodyView/default-thumb-esdm.jpg',
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.cover,
          ),
          title: Text("Solar Cell, Sumber Energi Terbarukan Masa Depan"),
          trailing: Icon(Icons.favorite),
          visualDensity: VisualDensity(vertical: 4),
        ),
        ListTile(
            leading: Image.network(
              'https://img.inews.co.id/media/822/files/inews_new/2022/05/18/Panel_Surya_atau_Solar_Cell.jpg',
              width: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.cover,
            ),
            title: Text(
                "Panel Surya atau Solar Cell, Inilah Keuntungan untuk Penggunanya"),
            trailing: Icon(Icons.favorite),
            visualDensity: VisualDensity(vertical: 4),
            onTap: () async {
              openUrlinApp(
                  url:
                      'https://www.inews.id/techno/internet/panel-surya-atau-solar-cell-inilah-keuntungan-untuk-penggunanya');
            }),
      ]),
    );
  }
}
