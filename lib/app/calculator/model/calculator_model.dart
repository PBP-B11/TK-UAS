// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

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
  String electricity;
  String offset;
  String envfactor;
  String sizeestimate;
  String roofarea;
  String panel;
  String requiredarea;
  bool isDoable;
  DateTime date;

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
    date: DateTime.parse(json["date"]),
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
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
