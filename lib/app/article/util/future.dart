import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_panel/app/article/model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

Future<List<Article>> fetchArticle(BuildContext context, String urlJson) async {
  final request = context.watch<CookieRequest>();
  var url = Uri.parse(urlJson);
  var response = await http.get(
    url,
    headers: request.headers,
  );
  print("respons fetchArticle : " + response.statusCode.toString());

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

addArticle(BuildContext context, String title, String articleUrl,
    String imageUrl) async {
  final request = context.read<CookieRequest>();

  try {
    String url = 'https://mypanel.up.railway.app/article/add-article/';
    var respons = await http.post(
      Uri.parse(url),
      body: {
        "title": title,
        "url": articleUrl,
        "gambar": imageUrl,
      },
      headers: request.headers,
    );
    print("respons addArticle : " + respons.statusCode.toString());
  } catch (e) {
    print(e);
  }
}

addLike(int id) async {
  try {
    String url = 'https://mypanel.up.railway.app/article/add-like/${id}';
    var respons = await http.post(Uri.parse(url));
    print("respons addlike : " + respons.statusCode.toString());
  } catch (e) {
    print(e);
  }
}

approveArticle(int id) async {
  try {
    String url = 'https://mypanel.up.railway.app/article/approve-article/${id}';
    var respons = await http.post(Uri.parse(url));
    print("respons approveArticle: " + respons.statusCode.toString());
  } catch (e) {
    print(e);
  }
}

deleteArticle(int id) async {
  try {
    String url = 'https://mypanel.up.railway.app/article/delete-article/${id}';
    var respons = await http.post(Uri.parse(url));
    print("respons deleteArticle: " + respons.statusCode.toString());
  } catch (e) {
    print(e);
  }
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
