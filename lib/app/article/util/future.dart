import 'package:flutter/material.dart';
import 'package:my_panel/app/article/model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

Future<List<Article>> fetchArticle(String url) async {
  var url = Uri.parse('url');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Article
  List<Article> listArticle = [];
  for (var d in data) {
    if (d != null) {
      listArticle.add(Article.fromJson(d));
    }
  }
  return listArticle;
}

Future openUrlinApp({
  required String url,
}) async {
  Uri formattedUrl = Uri.parse(url);
  if (await canLaunchUrl(formattedUrl)) {
    await launchUrl(
      formattedUrl,
      mode: LaunchMode.inAppWebView,
    );
  }
}
