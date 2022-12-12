// // Rizka Nisrina Nabila
//
// import 'package:flutter/material.dart';
// import 'package:wisata_nusantara_mobile/apps/cerita_perjalanan/utils/fetch.dart';
// import 'package:wisata_nusantara_mobile/components/Drawer.dart';
// import 'package:wisata_nusantara_mobile/components/Drawer.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
//
// class CeritaPerjalanan extends StatefulWidget {
//   const CeritaPerjalanan({super.key, required this.title});
//   final String title;
//
//   @override
//   State<StatefulWidget> createState() => _CeritaPerjalananState();
// }
//
// class _CeritaPerjalananState extends State<CeritaPerjalanan> {
//   TextEditingController storyController = TextEditingController();
//   final _reviewFormKey = GlobalKey<FormState>();
//   String _review = "";
//
//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();
//     final response =
//         request.get('https://wisata-nusa.up.railway.app/story/json/');
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Cerita Perjalanan"),
//         ),
//         drawer: buildDrawer(context),
//         body: Container(
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                     colors: [Colors.greenAccent, Colors.blueGrey])),
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: const EdgeInsets.all(16.0),
//                       child: const Text(
//                         "Give us a review!",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//                 Expanded(
//                     flex: 2,
//                     child: Container(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0)),
//                           color: Colors.white,
//                           elevation: 4,
//                           child: Form(
//                               key: _reviewFormKey,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   TextFormField(
//                                     controller: storyController,
//                                     decoration: InputDecoration(
//                                       hintText: "Give us a review!",
//                                       labelText: "Review",
//                                       // Added a circular border to make it neater
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                       ),
//                                     ),
//                                     // Added behavior when name is typed
//                                     onChanged: (String? value) {
//                                       setState(() {
//                                         _review = value!;
//                                       });
//                                     },
//                                     // Added behavior when data is saved
//                                     onSaved: (String? value) {
//                                       setState(() {
//                                         _review = value!;
//                                       });
//                                     },
//                                     // Validator as form validation
//                                     validator: (String? value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Mohon isi review!';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   ElevatedButton(
//                                       onPressed: () async {
//                                         if (_reviewFormKey.currentState!.validate()) {
//                                           var response = await request.post(
//                                               "https://wisata-nusantara.up.railway.app/story/submit_json/",
//                                               {
//                                                 "review": _review
//                                               }
//                                           );
//                                           final successBar = SnackBar(
//                                             content: const Text("Review berhasil disimpan!"),
//                                             action: SnackBarAction(
//                                               label: 'Hide',
//                                               onPressed: () {
//
//                                               },
//                                             ),
//                                           );
//                                           ScaffoldMessenger.of(context).showSnackBar(successBar);
//                                         }
//                                       },
//                                       child: const Text("Send"))
//                                 ],
//                               )),
//                         ))),
//                 Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: const EdgeInsets.all(16.0),
//                       child: const Text(
//                         "Apa kata mereka?",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             fontStyle: FontStyle.italic),
//                       ),
//                     )),
//                 Expanded(
//                     flex: 2,
//                     child: FutureBuilder(
//                         future: response,
//                         builder: (context, AsyncSnapshot snapshot) {
//                           if (!snapshot.hasData) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           } else {
//                             if (snapshot.data.length < 1) {
//                               return Column(
//                                 children: const [
//                                   Text(
//                                     "Belum ada cerita :(",
//                                     style: TextStyle(
//                                         color: Color(0xff59A5D8), fontSize: 20),
//                                   ),
//                                   SizedBox(height: 8),
//                                 ],
//                               );
//                             } else {
//                               return GridView.builder(
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2),
//                                 itemBuilder: (_, index) => Column(
//                                   children: [
//                                     Text(
//                                         snapshot.data[index]["fields"]["name"]),
//                                     Text(snapshot.data[index]["fields"]
//                                         ["review"]),
//                                     TextButton(
//                                       onPressed: () async {
//                                         var response = await request.post(
//                                             "https://wisata-nusa.up.railway.app/story/delete_json/${snapshot.data[index]["pk"]}",
//                                             {});
//                                       },
//                                       // ini action kalau button ditekan;
//                                       child: Text(
//                                         "Delete",
//                                       ),
//                                       style: TextButton.styleFrom(
//                                         backgroundColor: Colors.green,
//                                         primary: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 itemCount: snapshot.data.length,
//                               );
//                             }
//                           }
//                         }))
//               ],
//             )));
//   }
// }
