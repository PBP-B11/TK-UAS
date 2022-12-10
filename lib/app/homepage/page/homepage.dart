import 'package:flutter/material.dart';
import 'package:my_panel/app/profile/page/profile.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:my_panel/app/authentication/pages/login_page.dart';
import 'package:my_panel/util/drawer.dart';

import 'package:my_panel/app/article/page/myarticle.dart';
import 'package:my_panel/app/calculator/page/calculator.dart';
import 'package:my_panel/app/cart/page/cart.dart';
import 'package:my_panel/app/product_list/page/product_list.dart';
import 'package:my_panel/app/qna/page/qna.dart';
import 'package:my_panel/app/testimony/page/testimony.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserManagement>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hello username, profile, and mycart
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, bottom: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Hello username
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hello, ",
                          style: TextStyle(
                            fontSize: 22,
                          ),),
                        Text(user.userLoggedIn!.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),),
                      ],
                    ),
                    // Cart and profile
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart,
                            size: 30,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CartPage()),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfilePage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Features
              Column(
                children: [
                  const Text("Features",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        SliverGrid.extent(
                          maxCrossAxisExtent: 150,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                          children: [
                            Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ProductListPage()),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.shopping_bag,
                                        size: 30,),
                                      Text("Produk",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CalculatorPage()),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.calculate_rounded,
                                        size: 30,),
                                      Text("Calculator",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TestimonyPage()),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.people_outline_rounded,
                                        size: 30,),
                                      Text("Testimoni",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const QnaPage()),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.question_mark_outlined,
                                        size: 30,),
                                      Text("QnA",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              
              //
            ],
          ),
        )
      ),
    );
  }
}