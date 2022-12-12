import 'dart:convert';
import 'package:http/http.dart' as http;

List<Testimoni> TestimoniFromJson(String str) =>
    List<Testimoni>.from(json.decode(str).map((x) => Testimoni.fromJson(x)));

String TestimoniToJson(List<Testimoni> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Testimoni {
  Testimoni({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Testimoni.fromJson(Map<String, dynamic> json) => Testimoni(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };

  static Future<List<Testimoni>> fetchTestimoni() async {
    var url =
        Uri.parse('https://mypanel.up.railway.app/testimoni/json/');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(utf8.decode(response.bodyBytes));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    

    List<Testimoni> listTestimoni = [];
    for (var d in data) {
      if (d != null) {
        listTestimoni.add(Testimoni.fromJson(d));
      }
    }
    return listTestimoni;
  }
}
class Fields {
    Fields({
        required this.customer,
        required this.date,
        required this.title,
        required this.description,
    });

    Customer customer;
    DateTime date;
    String title;
    String description;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        customer: Customer.fromJson(json["customer"]),
        date: DateTime.parse(json["date"]),
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "title": title,
        "description": description,
    };
}

class Customer {
    Customer({
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

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
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
