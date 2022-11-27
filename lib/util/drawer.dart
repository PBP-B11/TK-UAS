import 'package:flutter/material.dart';

import '../app/calculator/page/calculator.dart';

import '../app/product_list/page/product_list.dart';

import '../app/cart/page/cart.dart';

import '../app/testimony/page/testimony.dart';

import '../app/qna/page/qna.dart';

import '../app/article/page/article.dart';

import '../app/profile/page/profile.dart';

import '../main.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('Home Page'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Calculator'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Product List'),
            onTap: () {
              // Route menu ke halaman result
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductListPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Cart'),
            onTap: () {
              // Route menu ke halaman myWatchlist
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Testimony'),
            onTap: () {
              // Route menu ke halaman myWatchlist
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TestimonyPage()),
              );
            },
          ),
          ListTile(
            title: const Text('QNA'),
            onTap: () {
              // Route menu ke halaman myWatchlist
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => QnaPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Article'),
            onTap: () {
              // Route menu ke halaman myWatchlist
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ArticlePage()),
              );
            },
          )
        ],
      ),
    );
  }
}
