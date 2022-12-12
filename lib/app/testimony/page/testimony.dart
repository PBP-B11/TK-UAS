import 'package:flutter/material.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/app/testimony/testi_model.dart';
import 'package:my_panel/app/testimony/testi_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestimonyPage extends StatefulWidget {
  const TestimonyPage({Key? key}):super(key: key);

  @override
  State<TestimonyPage> createState() => _TestimonyPageState();
}

class _TestimonyPageState extends State<TestimonyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testimoni'),
      ),
    
        
      body: FutureBuilder(
        future: Testimoni.fetchTestimoni(),
        builder: (context, AsyncSnapshot snapshot){
            if (snapshot.data == null){
                return const Center(child: CircularProgressIndicator());
            } else{
                if(!snapshot.hasData){
                    return Column(
                        children: const [
                            Text(
                                "There is no Testimoni",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 245, 72, 72),
                                    fontSize: 20
                                ),
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
                                      color: Color.fromARGB(255, 174, 197, 230),
                                      blurRadius: 2.0)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      
                                      color:
                                          Color.fromARGB(255, 60, 126, 226)),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${snapshot.data![index].fields.customer.name} | ${snapshot.data![index].fields.date}",
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "${snapshot.data![index].fields.description}",
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
      floatingActionButton: Padding(padding: const EdgeInsets.fromLTRB(40,10,10,10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTesti())), label: const Text("Add your Testimoni"),
              icon: const Icon(Icons.add),) ,
          )
        ],
      ),),
      
    );
  }
}

