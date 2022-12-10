import 'package:flutter/material.dart';
import 'package:my_panel/util/providers/user_provider.dart';

import '../app/calculator/page/calculator.dart';
import '../app/homepage/page/homepage.dart';
import '../app/product_list/page/product_list.dart';
import '../app/cart/page/cart.dart';
import '../app/testimony/page/testimony.dart';
import '../app/qna/page/qna.dart';
import '../app/article/page/article.dart';
import '../app/profile/page/profile.dart';
import '../main.dart';
import '../app/authentication/pages/login_page.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final user = context.watch<UserManagement>();
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
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              Uri url = Uri.parse("https://mypanel.up.railway.app/logout/");
              await http.get(url);
              user.removeUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

