import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class QnaForm extends StatefulWidget {
  const QnaForm({super.key});
  @override
  State<QnaForm> createState() => _QnaFormState();
}

class _QnaFormState extends State<QnaForm> {
    final _formKey = GlobalKey<FormState>();

    String question = "";
    String answer = "";


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('QNA'),
            ),
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            children: [
                                Padding(
                                    // Menggunakan padding sebesar 8 pixels
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Contoh: Bagaimana cara penggunaan solar panel yang benar?",
                                            labelText: "Question",
                                            //icon: const Icon(Icons.),
                                            // Menambahkan circular border agar lebih rapi
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                            ),
                                        ),
                                        // Menambahkan behavior saat nama diketik 
                                        onChanged: (String? value) {
                                            setState(() {
                                                question = value!;
                                            });
                                        },
                                        // Menambahkan behavior saat data disimpan
                                        onSaved: (String? value) {
                                            setState(() {
                                                question = value!;
                                            });
                                        },
                                        // Validator sebagai validasi form
                                        validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                                return 'Pertanyaan tidak boleh kosong!';
                                            }
                                            return null;
                                        },
                                    ),
                                ),

                                TextButton(
                                    child: const Text(
                                        "submit",
                                        style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                                    ),
                                    onPressed: () async {
                                      
                                      if (_formKey.currentState!.validate()) {
                                          print("debug");
                                          print(question);
                                          print(answer);
                                          var data = convert.jsonEncode(
                                            <String, String>{
                                              'description': question,
                                              'answer': answer,}
                                        );
                              
                            
                                      var response = await http.post(Uri.parse('https://mypanel.up.railway.app/qna/create_question/'),
                                        body: data);

                              print(response.request);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Thank you for your Question!')));
                                    },
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }}