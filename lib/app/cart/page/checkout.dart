import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_panel/app/cart/api/cart_api.dart';
import 'package:my_panel/util/utils.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/util/providers/user_provider.dart';

import 'package:my_panel/app/cart/page/appbar.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CartPageState();
}

class _CartPageState extends State<CheckoutPage> {
  int _totalPrice = 0;

  int sum(List<int> list) {
    int sum = 0;
    for (var element in list) {
      sum += element;
    }
    setState(() {
      _totalPrice = sum;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    List<int> totalPriceList = [];
    final user = context.watch<UserManagement>();
    final request = context.watch<CookieRequest>();
    //final response = request.get('http://10.0.2.2:8000/cart/get_cart/');
    final response = request.get('https://mypanel.up.railway.app/cart/get_cart/');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Checkout"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
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
                            ), //SizedBox(height: 8),
                          ],
                        );
                      } else {
                        if (snapshot.data.length == 0){
                          return const Center(child:Text("Keranjangmu kosong :("));
                        } else {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var price = double.parse(snapshot.data[index]["fields"]["product"]["price"].toString());
                              var quantity = int.parse(snapshot.data[index]["fields"]["quantity"].toString());
                              totalPriceList.add(price.round() * quantity);
                              return Column(
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
                                              child: Text(convertToIdr(snapshot.data[index]["fields"]["product"]["price"],2),
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
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15, top: 5, left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Subtotal ",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),),
                                        Text(convertToIdr(price.round() * quantity, 2),
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                                    child: Divider(color: Colors.black,),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }
                    }
                  }
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Tagihan",
                          style: TextStyle(
                            fontSize: 16,
                          ),),
                        Text(convertToIdr(_totalPrice, 2),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text("Confirm Order",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const CheckoutPage()),
                        // );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
