import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_panel/app/product_list/models/product.dart';

Future<List<Product>> fetchProduct() async {
  var url = Uri.parse('https://mypanel.up.railway.app/product/get_product/');
  //var url = Uri.parse('http://10.0.2.2:8000/product/get_product/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object MyWatchList
  List<Product> listProduct = [];
  for (var d in data) {
    if (d != null) {
      Product product = Product.fromJson(d);
      listProduct.add(product);
    }
  }

  return listProduct;
}