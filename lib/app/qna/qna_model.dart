import 'dart:convert';
import 'package:http/http.dart' as http;

List<QnaModels> QnaModelsFromJson(String str) => List<QnaModels>.from(json.decode(str).map((x) => QnaModels.fromJson(x)));
String QnaModelsToJson(List<QnaModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QnaModels {
  QnaModels({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  static List<QnaModels> listQna = [];

  factory QnaModels.fromJson(Map<String, dynamic> json) => QnaModels(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };


 static Future<List<QnaModels>> fetchQna() async {
    //tanyain kalo mau get per-kategori gimana? masukin link-nya parameternya gimana
    //buat dropdown-nya
    //
    var url =
        Uri.parse('https://mypanel.up.railway.app/qna/flutter/json/');
    var response = await http.get(
      url,
      headers: {
        //"Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    //print(jsonDecode(utf8.decode(response.bodyBytes)));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    print(data);

    List<QnaModels> listQna = [];
    for (var d in data) {
      if (d != null) {
        listQna.add(QnaModels.fromJson(d));
      }
    }
    return listQna;
  }
}

class Fields {
  Fields({
    required this.user,
    required this.question,
    required this.answer,
    required this.reply
  });

  int user;
  String question;
  String answer;
  String reply;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"] == null ? null : json["user"],
    question: json["question"],
    answer: json["answer"],
    reply: json["reply"]
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? null : user,
    "question": question,
    "answer": answer,
    "reply": reply,
  };
}