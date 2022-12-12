import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_panel/app/cart/api/cart_api.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
