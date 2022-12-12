import 'package:flutter/material.dart';
import 'package:my_panel/app/qna/qna_reply.dart';
import 'package:my_panel/app/qna/qna_model.dart';
import 'package:my_panel/app/qna/qna_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/app/qna/qna_fetch.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({Key? key}) : super(key: key);

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {
  final Future<List<QnaModels>> future = fetchQnaAll();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question and Answer'),
      ),
      body: FutureBuilder<List<QnaModels>>(
        future: fetchQnaAll(),
        builder: (context, AsyncSnapshot<List<QnaModels>> snapshot){
            if (snapshot.data == null){
                return const Center(child: CircularProgressIndicator());
            } else{
                if(!snapshot.hasData){
                    return Column(
                        children: const [
                            Text(
                                "There is no question!",
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
                        itemBuilder: (_, index) => InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReplyPage(qnaModel: snapshot.data![index])
                                ),
                            ),
                            child: Container(
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
                                            "${snapshot.data![index].fields.date} | ${snapshot.data![index].fields.customer}",
                                            style: const TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        )
                    );
                }
            }
        }
      ),
    floatingActionButton: Padding(padding: const EdgeInsets.fromLTRB(40,10,10,10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> QnaForm())), label: const Text("Ask Your Question!"),
              icon: const Icon(Icons.add),) ,
          )
        ],
      ),),
      
    );
  }
}
