// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
List<Calculator> calculatorFromJson(String str) => List<Calculator>.from(json.decode(str).map((x) => Calculator.fromJson(x)));

String calculatorToJson(List<Calculator> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Calculator {
  Calculator({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Calculator.fromJson(Map<String, dynamic> json) => Calculator(
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
    required this.electricity,
    required this.offset,
    required this.envfactor,
    required this.sizeestimate,
    required this.roofarea,
    required this.panel,
    required this.requiredarea,
    required this.isDoable,
    required this.date,
  });

  int user;
  int electricity;
  int offset;
  int envfactor;
  int sizeestimate;
  int roofarea;
  int panel;
  int requiredarea;
  bool isDoable;
  String date;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    electricity: json["electricity"],
    offset: json["offset"],
    envfactor: json["envfactor"],
    sizeestimate: json["sizeestimate"],
    roofarea: json["roofarea"],
    panel: json["panel"],
    requiredarea: json["requiredarea"],
    isDoable: json["is_doable"],
    date: (json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "electricity": electricity,
    "offset": offset,
    "envfactor": envfactor,
    "sizeestimate": sizeestimate,
    "roofarea": roofarea,
    "panel": panel,
    "requiredarea": requiredarea,
    "is_doable": isDoable,
    "date": date,
  };
}
Future<List<Calculator>> fetchCalculator() async {
  var url = Uri.parse('https://mypanel.up.railway.app/calculator/show_json');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode != 200) {
    throw Exception("Failed to load list.");
  }
  // melakukan decode response menjadi bentuk json
  final data = jsonDecode(utf8.decode(response.bodyBytes));
  // melakukan konversi data json menjadi object Article
  List<Calculator> listCalculator = [];
  for (var d in data) {
    if (d != null) {
      listCalculator.add(Calculator.fromJson(d));
    }
  }
  return listCalculator;
}
Future<Calculator> createCalculator(
    dynamic electricity, dynamic offset,
    dynamic envfactor, dynamic sizeestimate,
    dynamic roofarea, dynamic panel,
    dynamic requiredarea, dynamic doable, dynamic date) async {
  try{
  final response = await http.post(
    Uri.parse('https://mypanel.up.railway.app/calculator/show_json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "electricity": electricity,
      "offset": offset,
      "envfactor": envfactor,
      "sizeestimate": sizeestimate,
      "roofarea": roofarea,
      "panel": panel,
      "requiredarea": requiredarea,
      "is_doable": doable,
      "date": date,
    }),
  );
  }catch(e){
    print(e);
  }


}