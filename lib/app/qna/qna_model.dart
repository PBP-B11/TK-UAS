// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

// QnaModels qnaModelsFromJson(String str) => QnaModels.fromJson(json.decode(str));

// String qnaModelsToJson(QnaModels data) => json.encode(data.toJson());

// class QnaModels {
//     QnaModels({
//         required this.data,
//     });

//     List<Datum> data;

//     factory QnaModels.fromJson(Map<String, dynamic> json) => QnaModels(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );


//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     Datum({
//         required this.pk,
//         required this.fields,
//     });

//     int pk;
//     Fields fields;

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         pk: json["pk"],
//         fields: Fields.fromJson(json["fields"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "pk": pk,
//         "fields": fields.toJson(),
//     };
// }

// class Fields {
//     Fields({
//         required this.customer,
//         required this.isTechnician,
//         required this.date,
//         required this.description,
//         required this.isReplied,
//         required this.answer,
//     });

//     int customer;
//     bool isTechnician;
//     DateTime date;
//     String description;
//     bool isReplied;
//     String answer;

//     factory Fields.fromJson(Map<String, dynamic> json) => Fields(
//         customer: json["customer"],
//         isTechnician: json["is_technician"],
//         date: DateTime.parse(json["date"]),
//         description: json["description"],
//         isReplied: json["is_replied"],
//         answer: json["answer"] == null ? null : json["answer"],
//     );

//     Map<String, dynamic> toJson() => {
//         "customer": customer,
//         "is_technician": isTechnician,
//         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "description": description,
//         "is_replied": isReplied,
//         "answer": answer == null ? null : answer,
//     };
// }
// To parse this JSON data, do
//
//     final qnaModels = qnaModelsFromJson(jsonString);

import 'dart:convert';

List<QnaModels> qnaModelsFromJson(String str) => List<QnaModels>.from(json.decode(str).map((x) => QnaModels.fromJson(x)));

String qnaModelsToJson(List<QnaModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QnaModels {
    QnaModels({
        required this.pk,
        required this.fields,
    });

    int pk;
    Fields fields;

    factory QnaModels.fromJson(Map<String, dynamic> json) => QnaModels(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.customer,
        required this.isTechnician,
        required this.date,
        required this.description,
        required this.isReplied,
        required this.answer,
    });

    int customer;
    bool isTechnician;
    DateTime date;
    String description;
    bool isReplied;
    String answer;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        customer: json["customer"],
        isTechnician: json["is_technician"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        isReplied: json["is_replied"],
        answer: json["answer"] == null ? null : json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "customer": customer,
        "is_technician": isTechnician,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description,
        "is_replied": isReplied,
        "answer": answer == null ? null : answer,
    };
}
