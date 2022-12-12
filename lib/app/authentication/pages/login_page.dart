import 'package:flutter/material.dart';
import 'package:my_panel/app/authentication/pages/register_page.dart';
import 'package:my_panel/main.dart';
import 'package:my_panel/util/providers/user_provider.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:my_panel/app/authentication/models/customer.dart';

import 'package:http/http.dart' as http;

import '../../homepage/page/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String _username = "";
  String _password1 = "";
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final user = context.watch<UserManagement>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image logo
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: MediaQuery.of(context).size.width / 2.5,
                  ),
                ),
                // Image login model
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'lib/assets/images/login_model.PNG',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        // Login text
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              // Username Input
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: const Icon(
                                        Icons.person,
                                        size: 32,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _usernameController,
                                        decoration: const InputDecoration(
                                          hintText: 'Username',
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _username = value!;
                                          });
                                        },
                                        onSaved: (String? value) {
                                          setState(() {
                                            _username = value!;
                                          });
                                        },
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Username tidak boleh kosong!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Password input
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.lock_rounded,
                                        size: 32,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: !isPasswordVisible,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue)),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 4, 0),
                                            child: InkWell(
                                              onTap: togglePasswordView,
                                              child: Icon(
                                                isPasswordVisible
                                                    ? Icons.visibility_rounded
                                                    : Icons
                                                        .visibility_off_rounded,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _password1 = value!;
                                          });
                                        },
                                        onSaved: (String? value) {
                                          setState(() {
                                            _password1 = value!;
                                          });
                                        },
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Password tidak boleh kosong!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Button Login
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 25, top: 25),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size.fromHeight(45),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () async {
                                    if (_loginFormKey.currentState!.validate()) {
                                      // 'username' and 'password' should be the values of the user login form.
                                      final response = await request.login(
                                        "https://mypanel.up.railway.app/auth/login/",
                                        //"http://10.0.2.2:8000/auth/login/",
                                        {
                                          'username': _username,
                                          'password': _password1,
                                        });
                                      if (request.loggedIn) {
                                        // Code here will run if the login succeeded.
                                        _loginFormKey.currentState!.reset();
                                        var cust =
                                            Customer.fromJson(response["user"]);
                                        user.setUser(cust);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyHomePage()),
                                        );
                                      } else {
                                        // Code here will run if the login failed (wrong username/password).
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 15,
                                              child: Container(
                                                child: ListView(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    SizedBox(height: 20),
                                                    Center(
                                                      child: Column(children: [
                                                        Text(
                                                          response["message"],
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16)),
                                                      ]),
                                                    ),
                                                    SizedBox(height: 20),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'ok',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),

                              const Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: const Text(
                                  "OR",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "New to our Journey?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const RegisterPage()),
                                        );
                                      },
                                      child: const Text(
                                        "Register",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
