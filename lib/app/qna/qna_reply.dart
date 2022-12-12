import 'package:flutter/material.dart';
import 'package:my_panel/app/qna/qna_model.dart';
import 'package:my_panel/app/qna/qna_reply_form.dart';
import 'package:my_panel/app/qna/page/qna.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReplyPage extends StatefulWidget {
  const ReplyPage({Key? key, required this.qnaModel}) : super(key: key);
  final QnaModels qnaModel;

  @override
  State<ReplyPage> createState() => _ReplyPageState(qnaModel);
}

class _ReplyPageState extends State<ReplyPage> {
  QnaModels model;
  _ReplyPageState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reply'),
      ),
      drawer: const Drawer(),
      //judul
      //username | waktu
      //pesan
      //tombol reply di pojok kanan
      //https://api.flutter.dev/flutter/material/Card-class.html 
      body: FutureBuilder(
        future: QnaModels.fetchQna(),
        builder: (context, AsyncSnapshot snapshot){
          if (snapshot.data == null){
            return const Center(child: CircularProgressIndicator());
          } else{
              if(!snapshot.hasData){
                  return Column(
                      children: const [
                          Text(
                              "Tidak ada reply",
                              style: TextStyle(
                                  color: Color(0xff59A5D8),
                                  fontSize: 20
                              ),
                          ),
                          SizedBox(height: 10),
                      ],
                  );
              } else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical:15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17.0),
                          boxShadow: const[
                              BoxShadow(
                                  color: Colors.blue,
                                  blurRadius: 3.0
                              )
                          ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${snapshot.data![index].fields.description}",
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                              ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                              "${snapshot.data![index].fields.customer} | ${snapshot.data![index].fields.date}",
                              style: const TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey,
                              ),
                          ),
                          const SizedBox(height: 10),   
                        ]
                      ),
                    ),
                  );
              }
          }
        },
      ),


      floatingActionButton: Padding(
        padding : const EdgeInsets.fromLTRB(40,10,10,10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              //alignment: Alignment.bottomLeft,
              //child: TextButton(
              //  onPressed: (){
              //    Navigator.pop(context);
              //  },
              //  child: Text(
              //    "Kembali",
              //  ),
              //  style: TextButton.styleFrom(
              //      backgroundColor: Colors.blue,
              //      primary: Colors.white,
              //  ),
              //),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReplyForm(qnaModel: model)
                  ),
                ),
                label: const Text('Reply'),
                icon: const Icon(Icons.message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}