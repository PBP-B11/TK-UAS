// To parse this JSON data, do
//
//     final customerData = customerDataFromJson(jsonString);

import 'dart:convert';

List<CustomerData> customerDataFromJson(String str) => List<CustomerData>.from(json.decode(str).map((x) => CustomerData.fromJson(x)));

String customerDataToJson(List<CustomerData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerData {
    CustomerData({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
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
        required this.name,
        required this.email,
        required this.isTechnician,
        required this.phone,
    });

    int user;
    String name;
    String email;
    bool isTechnician;
    String phone;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        email: json["email"],
        isTechnician: json["is_technician"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "email": email,
        "is_technician": isTechnician,
        "phone": phone,
    };
}
