import 'package:flutter/material.dart';
import 'package:my_panel/app/product_list/models/product.dart';
import 'package:my_panel/app/product_list/page/appbar.dart';

import 'package:my_panel/util/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/app/product_list/api/fetch_product.dart';

import 'package:my_panel/util/providers/user_provider.dart';
import 'package:my_panel/app/cart/page/cart.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserManagement>();
    final request = context.watch<CookieRequest>();
    //final response = request.get('http://10.0.2.2:8000/product/get_product/');
    final response = request.get('https://mypanel.up.railway.app/product/get_product/');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children:  [
              const Text("Panel",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                  future: response,
                  builder: (context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        return Column(
                          children: const [
                            Text(
                              "Product tidak tersedia",
                              style: TextStyle(
                                  color: Color(0xff59A5D8),
                                  fontSize: 20),
                            ),
                            //SizedBox(height: 8),
                          ],
                        );
                      } else {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 275,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'lib/assets/images/placeholder.png',
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data[index]["fields"]["name"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),),
                                        Text("Rp${snapshot.data[index]["fields"]["price"]}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size.fromHeight(20),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: const Text("Tambah ke Keranjang",
                                      style: TextStyle(
                                          fontSize: 14
                                      ),),
                                    onPressed: () async {
                                      var response = await request.post(
                                          //"http://10.0.2.2:8000/product/add_to_cart/${snapshot.data[index]["pk"]}",
                                          "https://mypanel.up.railway.app/product/add_to_cart/${snapshot.data[index]["pk"]}",
                                          {});
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }
}
