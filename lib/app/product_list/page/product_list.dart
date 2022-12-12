import 'package:flutter/material.dart';
import 'package:my_panel/app/product_list/models/product.dart';
import 'package:my_panel/app/product_list/page/appbar.dart';
import 'package:my_panel/app/product_list/page/product_form.dart';

import 'package:my_panel/util/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:my_panel/util/providers/user_provider.dart';
import 'package:my_panel/app/cart/page/cart.dart';
import 'package:my_panel/app/product_list/api/product_api.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserManagement>();
    //final request = context.watch<CookieRequest>();
    //final response = request.get('http://10.0.2.2:8000/product/get_product/');
    //final response = request.get('https://mypanel.up.railway.app/product/get_product/');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children:  [
              const Text("All Product",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                  future: fetchProduct(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    print("==== future builder call ====");
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
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              margin: const EdgeInsets.all(8),
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
                                        Text(snapshot.data[index].fields.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),),
                                        Text("Rp${snapshot.data[index].fields.price}",
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
                                    child: Text("Tambah ke Keranjang ${snapshot.data[index].pk}",
                                      style: const TextStyle(
                                          fontSize: 14
                                      ),),
                                    onPressed: () async {
                                      await addToCart(
                                        context,
                                        snapshot.data[index].pk
                                      );
                                      final successBar = SnackBar(
                                        content: Text("${snapshot.data[index].fields.name} berhasil ditambahkan keranjang belanja"),
                                        action: SnackBarAction(
                                          label: 'Lihat',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const CartPage()),
                                            );
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(successBar);

                                      // await request.post(
                                      //   'https://mypanel.up.railway.app/product/add_to_cart/${snapshot.data[index].pk}',
                                      //   //'http://10.0.2.2:8000/product/add_to_cart/${snapshot.data[index].pk}',
                                      //   {});
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Visibility(
          visible: user.userLoggedIn?.isTechnician ?? false,
          child: Container(
            padding: EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text("Tambah Produk",
                style: TextStyle(
                    fontSize: 16
                ),),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductFormPage()
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
