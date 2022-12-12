import 'package:flutter/material.dart';
import 'package:my_panel/app/authentication/pages/login_page.dart';
import 'package:my_panel/main.dart';
import 'package:my_panel/util/providers/user_provider.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:my_panel/app/authentication/models/customer.dart';

import 'package:http/http.dart' as http;

import '../../homepage/page/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String _username = "";
  String _password1 = "";
  String _password2 = "";
  bool _technician = false;
  final _usernameController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();

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
                    'lib/assets/images/register_model.png',
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
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        Form(
                          key: _registerFormKey,
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
                                          labelText: 'Username',
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
                                        controller: _passwordController1,
                                        obscureText: !isPasswordVisible,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
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
                              // Password 2 input
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
                                        controller: _passwordController2,
                                        obscureText: !isPasswordVisible,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          hintText: 'Enter the same password',
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue)),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
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
                                            _password2 = value!;
                                          });
                                        },
                                        onSaved: (String? value) {
                                          setState(() {
                                            _password2 = value!;
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
                              // Role
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
                                        Icons.key_outlined,
                                        size: 32,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      child: SwitchListTile(
                                        title: const Text('Technician'),
                                        value: _technician,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _technician = value;
                                          });
                                        },
                                        contentPadding: const EdgeInsets.only(right: 0),
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
                                    "Register",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () async {
                                    if (_registerFormKey.currentState!.validate()) {
                                      final response = await request.post(
                                        "https://mypanel.up.railway.app/auth/register/",
                                        // "http://localhost:8000/auth/register/",
                                        {
                                          'username': _username,
                                          'password1': _password1,
                                          'password2': _password2,
                                          'register_as': _technician
                                            ? "Technician"
                                            : "Customer",
                                        });
                                      if (response["status"] == true) {
                                        // Code here will run if the login succeeded.
                                        _registerFormKey.currentState!.reset();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginPage()),
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
                                                        Text(response["message"],
                                                          // response["message"],
                                                          textAlign: TextAlign.center,
                                                          style: const TextStyle(
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
                                padding: EdgeInsets.only(top: 25, bottom: 35),
                                child: Text(
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
                                    "Have join us before?",
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
                                              builder: (context) => const LoginPage()),
                                        );
                                      },
                                      child: const Text(
                                        "Login",
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
