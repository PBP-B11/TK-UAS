import 'package:flutter/material.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/app/qna/qna_model.dart';
import 'package:my_panel/app/qna/qna_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class QnaPage extends StatefulWidget {
  const QnaPage({super.key});

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QNA'),
      ),
      body: FutureBuilder(
          future: QnaModels.fetchQna(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "There is no Question!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 245, 72, 72),
                          fontSize: 20),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 69, 135, 233),
                                      blurRadius: 2.0)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.rate}",
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor:
                                          Color.fromARGB(255, 58, 158, 220),
                                      color:
                                          Color.fromARGB(255, 255, 239, 239)),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${snapshot.data![index].fields.username} | ${snapshot.data![index].fields.time}",
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "${snapshot.data![index].fields.discussion}",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ));
              }
            }
          }),
      drawer: MyDrawer(),
      floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: FloatingActionButton.extended(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QnaForm()),
                  ),
                  label: const Text('Add Question'),
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          )),
    );
  }
}