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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: MyDrawer(),
        body:
          FutureBuilder<List<Calculator>>(
          future: futureCalculator,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Card(
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),

                    ),
                    child: InkWell(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tagihan Listrik Per Tahun (KWH) : ${snapshot.data![index].fields.electricity}",
                                style: const TextStyle(
                                  // fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text("Persentase Yang Mau Di Cover : ${snapshot.data![index].fields.offset} %",
                                style: const TextStyle(
                                  // fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text("Faktor Pengaruh Cuaca : ${snapshot.data![index].fields.envfactor} %",
                                style: const TextStyle(
                                  // fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text("Luas Atap : ${snapshot.data![index].fields.roofarea} M^2",
                                style: const TextStyle(
                                  // fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                            ],
                          )
                      ),
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }
        )


    );
  }
}