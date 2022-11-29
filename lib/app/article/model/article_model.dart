// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

List<Article> articleFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Article({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.title,
    required this.url,
    required this.gambar,
    required this.like,
    required this.status,
    required this.date,
  });

  int user;
  String title;
  String url;
  String gambar;
  int like;
  bool status;
  DateTime date;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        url: json["url"],
        gambar: json["gambar"],
        like: json["like"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "url": url,
        "gambar": gambar,
        "like": like,
        "status": status,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
