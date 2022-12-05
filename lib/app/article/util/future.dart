import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_panel/app/article/model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

Future<List<Article>> fetchArticle(String urlJson) async {
  var url = Uri.parse(urlJson);
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

addArticle(String title, String articleUrl, String imageUrl) async {
  try {
    String url = 'http://localhost:8000/article/add-article/';
    var respons = await http.post(
      Uri.parse(url),
      body: {
        "title": title,
        "url": articleUrl,
        "gambar": imageUrl,
      },
    );
    print("respons : " + respons.statusCode.toString());
  } catch (e) {
    print(e);
  }
}

addLike(int id) async {
  try {
    String url = 'http://localhost:8000/article/add-like/${id}';
    var respons = await http.post(Uri.parse(url));
    print("respons : " + respons.statusCode.toString());
  } catch (e) {
    print(e);
  }
}

approveArticle(int id) async {
  try {
    String url = 'http://localhost:8000/article/approve-article/${id}';
    var respons = await http.post(Uri.parse(url));
    print("respons : " + respons.statusCode.toString());
  } catch (e) {
    print(e);
  }
}

deleteArticle(int id) async {
  try {
    String url = 'http://localhost:8000/article/delete-article/${id}';
    var respons = await http.post(Uri.parse(url));
    print("respons : " + respons.statusCode.toString());
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
