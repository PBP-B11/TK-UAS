import 'package:flutter/material.dart';
import 'package:my_panel/app/cart/api/fetch_cart.dart';

import 'package:my_panel/util/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/util/providers/user_provider.dart';

import 'package:my_panel/app/cart/page/appbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserManagement>();
    final request = context.watch<CookieRequest>();
    //final response = request.get('http://10.0.2.2:8000/cart/get_cart/');
    final response = request.get('https://mypanel.up.railway.app/cart/get_cart/');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: response,
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
                          "Keranjangmu kosong :(",
                          style: TextStyle(
                              color: Color(0xff59A5D8),
                              fontSize: 20),
                        ),
                        //SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          elevation: 1,
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'lib/assets/images/placeholder.png',
                                        fit: BoxFit.fill,
                                        height: 75,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(snapshot.data[index]["fields"]["product"]["name"],
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("Rp${snapshot.data[index]["fields"]["product"]["price"]}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(snapshot.data[index]["fields"]["quantity"].toString()),
                                ],
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: Icon(Icons.accessibility),
        ),
      ),
    );
  }
}
