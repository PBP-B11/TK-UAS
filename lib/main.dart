import 'package:flutter/material.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'app/authentication/pages/login_page.dart';

import 'util/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Panel'),
      ),
      drawer: MyDrawer(),
      body: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.7,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(48, 72, 171, 1)),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Image.asset('lib/assets/images/solar_panel.png',
                    height: MediaQuery.of(context).size.height * 0.7 * 0.6,
                    fit: BoxFit.contain),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            "Ayo gabung bersama kami menjadi salah satu warrior peduli lingkungan dengan menggunakan panel surya ",
                      ),
                      TextSpan(
                          text: 'MyPanel!',
                          style: TextStyle(
                              color: Color.fromRGBO(185, 243, 185, 1)))
                    ],
                  ),
                ),
              ]))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}