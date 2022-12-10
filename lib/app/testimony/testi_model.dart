import 'dart:convert';
import 'package:http/http.dart' as http;

List<Testimoni> TestimoniFromJson(String str) => List<Testimoni>.from(json.decode(str).map((x) => Testimoni.fromJson(x)));

String TestimoniToJson(List<Testimoni> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
        //tanyain kalo mau get per-kategori gimana? masukin link-nya parameternya gimana
        //buat dropdown-nya
        //
        var url = Uri.parse('https://mypanel.up.railway.app/testimoni/flutter/json/'); 
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

        List<Testimoni> Testimoni = [];
            for (var d in data) {
                if (d != null) {
                    Testimoni.add(Testimoni.fromJson(d));
                }
            }
        return Testimoni;
    }
}

class Fields {
    Fields({
        required this.rate,
        required this.description,
        required this.date,
        required this.user,
        required this.username,
    });

    String rate;
    String description;
    DateTime date;
    int user;
    String username;
  

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        rate: json["rate"],
        description: json["description"],
        date: DateTime.parse(json["time"]),
        user: json["user"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "description": description,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "user": user,
        "username": username,
    };
}
