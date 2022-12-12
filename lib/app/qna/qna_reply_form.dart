import 'package:flutter/material.dart';
import 'package:my_panel/app/qna/qna_model.dart';
import 'package:my_panel/app/qna/qna_reply.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReplyForm extends StatefulWidget {
    const ReplyForm({Key? key, required this.qnaModel}) : super(key: key);

    final QnaModels qnaModel;

    @override
    State<ReplyForm> createState() => _ReplyFormState(qnaModel);
}

class _ReplyFormState extends State<ReplyForm> {
    QnaModels model;
    _ReplyFormState(this.model);

    final _formKey = GlobalKey<FormState>();

    String answer = "";

    Future<void> submit(BuildContext context, String idUser) async{
        String id = idUser;
        final response = await http.post(
            //bisa ngga pass model forum lewat sini --> untuk foreignkey
            Uri.parse('https://mypanel.up.railway.app/qna/update_question/' + id),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
                'answer': answer,
                'id': int.parse(id), 
            })
        );
    }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reply'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      children: [
                          //Pesan
                          Padding(
                              // Menggunakan padding sebesar 8 pixels
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Tuliskan Jawaban Anda di sini",
                                      labelText: "Answer",
                                      //icon: const Icon(Icons.),
                                      // Menambahkan circular border agar lebih rapi
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  ),
                                  // Menambahkan behavior saat nama diketik 
                                  onChanged: (String? value) {
                                      setState(() {
                                          answer = value!;
                                      });
                                  },
                                  // Menambahkan behavior saat data disimpan
                                  onSaved: (String? value) {
                                      setState(() {
                                          answer = value!;
                                      });
                                  },
                                  // Validator sebagai validasi form
                                  validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                          return 'Jawaban tidak boleh kosong!';
                                      }
                                      return null;
                                  },
                              ),
                          ),
                          //https://api.flutter.dev/flutter/material/TextField-class.html
                          TextButton(
                              child: const Text(
                                  "Simpan",
                                  style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                              ),
                              onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    //masih dummy --> fix this
                                    //have to add alert dialog
                                      String id = '1';//widget.id;
                                      submit(context, id);
                                  }
                              },
                          ),
                          
                      ],
                  ),
              ),
          ),
      ),
    );
  }
}