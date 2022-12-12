import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    var url =
        Uri.parse('https://mypanel.up.railway.app/qna/show_question_json/');
    var response = await http.get(
      url,
      headers: {
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
    required this.customer,
    required this.date,
    required this.description,
    required this.is_replied,
    required this.answer
  });

  String customer;
  DateTime date;
  String description;
  bool is_replied;
  String answer;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    customer: json["customer"] == null ? null : json["customer"],
    date: DateTime.parse(json["date"]),
    description: json["description"],
    is_replied: json["is_replied"],
    answer: json["answer"],
    
  );

  Map<String, dynamic> toJson() => {
    "customer": customer == null ? null : customer,
    "description": description,
    "date" : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "is_replied": is_replied,
    "answer": answer,
  };
}