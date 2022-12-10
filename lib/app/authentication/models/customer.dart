// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.isTechnician,
    required this.phone,
  });

  int id;
  int userId;
  String name;
  String email;
  bool isTechnician;
  String phone;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    isTechnician: json["is_technician"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "email": email,
    "is_technician": isTechnician,
    "phone": phone,
  };
}
