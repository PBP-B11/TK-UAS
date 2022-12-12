import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/app/cart/model/order_item.dart';

List<OrderItem> listCart = [];

Future<List<OrderItem>> fetchCart(BuildContext context) async {
  listCart = [];

  final request = context.watch<CookieRequest>();
  final response = await request.get('https://mypanel.up.railway.app/cart/get_cart/');
  //final response = await request.get('http://10.0.2.2:8000/product/get_product/');

  for (var d in response) {
    print(d);
    if (d != null) {
      listCart.add(OrderItem.fromJson(d));
    }
  }
  return listCart;
}

incrementItem(BuildContext context, int pk) async {
  final request = context.read<CookieRequest>();
  String url = 'https://mypanel.up.railway.app/cart/inc_dec_item/1/$pk/';
  var response = await request.post(
      url,
      {}
  );
  return response;
}

decrementItem(BuildContext context, int pk) async {
  final request = context.read<CookieRequest>();
  String url = 'https://mypanel.up.railway.app/cart/inc_dec_item/2/$pk/';
  var response = await request.post(
      url,
      {}
  );
  return response;
}

processOrder(BuildContext context, int pk) async {
  final request = context.read<CookieRequest>();
  String url = 'https://mypanel.up.railway.app/cart/process_order/$pk';
  var response = await request.post(
      url,
      {}
  );
  return response;
}