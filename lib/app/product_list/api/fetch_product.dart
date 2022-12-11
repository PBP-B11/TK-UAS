import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/app/product_list/models/product.dart';

List<Product> listProduct = [];

Future<List<Product>> fetchProduct(BuildContext context) async {
  listProduct = [];

  final request = context.watch<CookieRequest>();
  final response = await request.get('https://mypanel.up.railway.app/product/get_product/');
  //final response = await request.get('http://10.0.2.2:8000/product/get_product/');

  print("======= response =========");
  print(response);

  for (var d in response) {
    if (d != null) {
      listProduct.add(Product.fromJson(d));
    }
  }
  print("======= list product =========");
  print(listProduct);

  return listProduct;
}

addToCart(BuildContext context, int pk) async {
  final request = context.read<CookieRequest>();
  //final request = Provider.of(context, listen: false);
  
  try {
    String url = 'https://mypanel.up.railway.app/product/add_to_cart/$pk';
    var response = await request.post(url, {});
  } catch (e) {
    print(e);
  }
}