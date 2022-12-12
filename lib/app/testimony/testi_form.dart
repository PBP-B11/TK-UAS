import 'package:flutter/material.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/app/testimony/testi_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddTesti extends StatefulWidget {
  const AddTesti({super.key});
  @override
  State<AddTesti> createState() => _AddState();
}

class _AddState extends State<AddTesti> {
  final _formKey = GlobalKey<FormState>();
  final List<String> typeChoices = <String>['Very Good', 'Good', 'Mediocre', 'Bad', 'Very Bad'];

  
  String description = "";
  String rate = "Pilih Jenis";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testimoni Form"),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: <Widget>[
                      
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, right: 50, left: 50),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: "Choose One",
                          labelText: "Rate APP",
                          icon: const Icon(Icons.emoji_emotions),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        items: typeChoices
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            rate = value!;
                          });
                        },
                        validator: (String? value) {
                          if (!typeChoices.contains(value)) {
                            return "Pilih salah satu!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ex : Really love your idea",
                          labelText: "Description",
                          icon: const Icon(Icons.rate_review_rounded),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        
                        onChanged: (String? value) {
                           setState(() {
                            description = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            description = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          
                          onPressed: () async{
                            
                            if (_formKey.currentState!.validate()) {
                                print("debug");
                                print(rate);
                                print(description);
                                var data = convert.jsonEncode(
                                  <String, String>{
                                    'title':rate,
                                    'description': description,}
                                );
                                
                              
                               var response = await http.post(Uri.parse('https://mypanel.up.railway.app/testimoni/create_ajax/'),
                                body: data,headers: {"Content-Type": "application/json"});

                              print(response.statusCode);
          
                            }
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Thank you for your response!')));

                            Navigator.push(context, MaterialPageRoute( builder: (context) => TestimonyPage(),),);
                          },

                          child: const Text(
                            'Save',
                            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                          )),
                    ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}