import 'package:flutter/material.dart';
import 'package:my_panel/app/calculator/model/calculator_model.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';

class CalculatorHistory extends StatefulWidget {
  const CalculatorHistory({super.key});
  final String title = 'My Watch List';

  @override
  State<CalculatorHistory> createState() => _CalculatorHistoryState();
}

class _CalculatorHistoryState extends State<CalculatorHistory> {
  late Future<List<Calculator>> futureCalculator;

  @override
  void initState() {
    super.initState();
    futureCalculator = fetchCalculator(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserManagement>();
    final penggunaLogin = user.userLoggedIn;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: MyDrawer(),
        body: Text("asu")
    );
  }
}