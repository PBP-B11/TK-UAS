import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_panel/app/cart/api/cart_api.dart';
import 'package:my_panel/app/cart/page/checkout.dart';

import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/util/utils.dart';
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
  int _totalPrice = 0;
  bool _disableCheckout = false;

  enableCheckout(){
    setState(() {
      _disableCheckout = false;
    });
  }

  disableCheckout(){
    setState(() {
      _disableCheckout = true;
    });
  }

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

  // Widget totalPriceWidget() async {
  //   await totalPrice =
  //   return Text("Rp${_totalPrice.toString()}",
  //     style: TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 18,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    List<int> totalPriceList = [];
    final user = context.watch<UserManagement>();
    final request = context.watch<CookieRequest>();
    //final response = request.get('http://10.0.2.2:8000/cart/get_cart/');
    final response = request.get('https://mypanel.up.railway.app/cart/get_cart/');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Keranjang",),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: response,
                builder: (context, AsyncSnapshot snapshot) {
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
                            //updatePrice(price.round() * quantity);
                            //_totalPrice += price.round() * quantity;
                            totalPriceList.add(price.round() * quantity);
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
                                              child: Text(convertToIdr(snapshot.data[index]["fields"]["product"]["price"], 0),
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          var response = await request.post(
                                            "https://mypanel.up.railway.app/cart/delete_api/${snapshot.data[index]["pk"]}/",
                                            {}
                                          );
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          decrementItem(context, snapshot.data[index]["pk"]);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 20,
                                        ),
                                      ),
                                      Text(snapshot.data[index]["fields"]["quantity"].toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),),
                                      IconButton(
                                        onPressed: () async {
                                          await incrementItem(context, snapshot.data[index]["pk"]);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      ),
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
                }
              ),
              SizedBox(height: 75,)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.all(8),
          child: Material(
            elevation: 15,
            color: Colors.transparent,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Total: ',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    sum(totalPriceList);
                                }
                              ),
                            ]
                          ),
                        ),
                        Text(convertToIdr(_totalPrice, 0),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size.square(50),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Checkout",
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ),
                          Icon(Icons.shopping_cart_checkout)
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CheckoutPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
