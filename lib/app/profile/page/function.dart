import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_panel/app/profile/model/mainaddress.dart';
import 'package:my_panel/app/profile/model/CustomerData.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';  
  
  Future<List<MainAddress>> fetchAddress(BuildContext context) async {
      final request = context.watch<CookieRequest>();
      var url = Uri.parse('https://mypanel.up.railway.app/profile/json2/');
      var response = await http.get(
        url,
        headers: request.headers,
      );

      // melakukan decode response menjadi bentuk json
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object ToDo
      List<MainAddress> theAddress = [];
      for (var d in data) {
        if (d != null) {
            theAddress.add(MainAddress.fromJson(d));
        }
      }

      return theAddress;
  }

  Future<List<CustomerData>> fetchCustomer(BuildContext context) async {
      final request = context.watch<CookieRequest>();
      var url = Uri.parse('https://mypanel.up.railway.app/profile/json1/');
      var response = await http.get(
        url,
        headers: request.headers,
      );

      // melakukan decode response menjadi bentuk json
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object ToDo
      List<CustomerData> theCustomer = [];
      for (var d in data) {
        if (d != null) {
            theCustomer.add(CustomerData.fromJson(d));
        }
      }

      return theCustomer;
  }

  changeCustomerName(BuildContext context, String name) async {
    final request = context.read<CookieRequest>();

    try {
      String url = 'https://mypanel.up.railway.app/profile/change-name/';
      var respons = await http.post(
        Uri.parse(url),
        body: {
          "name": name,
        },
        headers: request.headers,
      );
    } catch (e) {
      print(e);
    }
  }

  changeCustomerContact(BuildContext context, String phone, String email) async {
    final request = context.read<CookieRequest>();

    try {
      String url = 'https://mypanel.up.railway.app/profile/change-cont/';
      var respons = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "phone": phone,
        },
        headers: request.headers,
      );
    } catch (e) {
      print(e);
    }
  }

  changeAddress(BuildContext context, String address, String kota, String kecamatan, String kelurahan, String postcode) async {
    final request = context.read<CookieRequest>();

    try {
      String url = 'https://mypanel.up.railway.app/profile/change-addr/';
      var respons = await http.post(
        Uri.parse(url),
        body: {
          "address": address,
          "kota": kota,
          "kecamatan": kecamatan,
          "kelurahan": kelurahan,
          "postcode": postcode,
        },
        headers: request.headers,
      );
    } catch (e) {
      print(e);
    }
  }