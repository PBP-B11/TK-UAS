// To parse this JSON data, do
//
//     final mainAddress = mainAddressFromJson(jsonString);

import 'dart:convert';

List<MainAddress> mainAddressFromJson(String str) => List<MainAddress>.from(json.decode(str).map((x) => MainAddress.fromJson(x)));

String mainAddressToJson(List<MainAddress> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainAddress {
    MainAddress({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory MainAddress.fromJson(Map<String, dynamic> json) => MainAddress(
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
        required this.address,
        required this.kota,
        required this.kecamatan,
        required this.kelurahan,
        required this.postcode,
    });

    int user;
    String address;
    String kota;
    String kecamatan;
    String kelurahan;
    String postcode;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        address: json["address"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        kelurahan: json["kelurahan"],
        postcode: json["postcode"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "address": address,
        "kota": kota,
        "kecamatan": kecamatan,
        "kelurahan": kelurahan,
        "postcode": postcode,
    };
}
