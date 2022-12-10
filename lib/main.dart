import 'package:flutter/material.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'app/authentication/pages/login_page.dart';

import 'util/drawer.dart';

void main() {
  runApp(const MyPanel());
}

class MyPanel extends StatelessWidget {
  const MyPanel({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) {
            CookieRequest request = CookieRequest();
            return request;
          },
        ),
        ChangeNotifierProvider(create: (_) => UserManagement())
      ],
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const MyHomePage(),
        initialRoute: "/login",
        routes: {
          "/login": (BuildContext context) => const LoginPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
