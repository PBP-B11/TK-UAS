import 'package:flutter/material.dart';
import 'package:my_panel/app/profile/page/addressform.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/app/profile/page/function.dart';
import 'package:my_panel/app/profile/page/customerform.dart';
import 'package:my_panel/app/profile/page/contactform.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_panel/app/profile/model/mainaddress.dart';
import 'package:my_panel/app/authentication/models/customer.dart';
import 'package:my_panel/app/authentication/pages/login_page.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserManagement>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(child:
       Column(
        children: [
          SizedBox(height: 10),
          Image.asset('lib/assets/images/profile.png',
            height: MediaQuery.of(context).size.height / 6,),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: FutureBuilder(
              future: fetchCustomer(context),
              builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else { 
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index)=> Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                        padding: const EdgeInsets.all(1),
                        child: Container (

                          child: ListView(
                            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                            shrinkWrap: true,
                            children: <Widget>[
                              Center(
                                child: Text("${snapshot.data[index].fields.name}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ))
                              ),
                              SizedBox(height: 30),
                              Center(child: const Text("Kontak",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              )),
                              ),
                              SizedBox(height: 30,),
                              Center(child: Text.rich(
                                style: TextStyle(fontSize: 15),
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "Telepon: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "${snapshot.data[index].fields.phone}"),
                                  ],
                                ),
                              ),),
                              SizedBox(height: 10,),
                              Center(child: Text.rich(
                                style: TextStyle(fontSize: 15),
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Email: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "${snapshot.data[index].fields.email}"),
                                  ],
                                ),
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );                    
                  }
              }
            ), 
            ),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 250),
            child: FutureBuilder(
              future: fetchAddress(context),
              builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else { 
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index)=> Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                        padding: const EdgeInsets.all(1),
                        child: Container (

                          child: ListView(
                            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                            shrinkWrap: true,
                            children: <Widget>[
                              Center(child:const Text("Alamat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              )),),
                              SizedBox(height: 30,),
                              Center(child: Text.rich(
                                style: TextStyle(fontSize: 15),
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "Kota: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "${snapshot.data[index].fields.kota}"),
                                  ],
                                ),
                              ),),
                              SizedBox(height: 10,),
                              Center(child: Text.rich(
                                style: TextStyle(fontSize: 15),
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Kecamatan: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "${snapshot.data[index].fields.kecamatan}"),
                                  ],
                                ),
                              ),),
                              SizedBox(height: 10,),
                              Center(child: Text.rich(
                                style: TextStyle(fontSize: 15),
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Kelurahan: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "${snapshot.data[index].fields.kelurahan}"),
                                  ],
                                ),
                              ),),
                              SizedBox(height: 10,),
                              Center(child: Text.rich(
                                style: TextStyle(fontSize: 15),
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Postcode: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "${snapshot.data[index].fields.postcode}"),
                                  ],
                                ),
                              ),),
                              SizedBox(height: 10,),
                              Center(child: Text.rich(
                                style: TextStyle(fontSize: 15),
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Alamat Lengkap: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: "${snapshot.data[index].fields.address}"),
                                  ],
                                ),
                              ),),
                            ],
                          ),
                        ),
                      ),
                    );                    
                  }
              }
            ), 
            ),
            Row (     
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40.0,
                  width: 120.0,  
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerForm()),
                      );                 
                    },
                    child: const Text(
                      "Change Name",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  width: 120.0,  
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactForm()),
                      );                 
                    },
                    child: const Text(
                      "Change Contact",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  width: 120.0,  
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressForm()),
                      );                 
                    },
                    child: const Text(
                      "Change Address",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),  
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent,
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 1, bottom: 1, left: 10, right: 10),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Logout",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              onPressed: () async {
                user.removeUser();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const LoginPage())
                );
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}
