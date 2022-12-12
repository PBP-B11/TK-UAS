import 'package:flutter/material.dart';
import 'package:my_panel/app/article/util/future.dart';
import 'package:my_panel/app/calculator/model/calculator_model.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_panel/app/calculator/page/view_history_calculator.dart';
class CalculatorForm extends StatefulWidget {
  const CalculatorForm({super.key});

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  @override
  final _formKey = GlobalKey<FormState>();
  var tagihan = 0;
  var offset = 0;
  var envfactor = 0;
  var luas_atap = 0;
  var solar_hours = 3.7;
  var doable = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Form'),
      ),
      body: Form(
      key: _formKey, //validasi input di form
      child: ListView(
        children: [
          Padding( padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child : TextFormField(
            keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Tagihan Listrik Selama 1 Tahun (KWH)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
          onChanged: (String? value){
            setState(() {
              tagihan = int.parse(value!);});},
          onSaved: (String? value){
            setState(() {
              tagihan =  int.parse(value!);});},
            validator: (String? value){ //int.tryParse(value) == null buat validator supaya input harus digit
              if (value ==null || value.isEmpty ||  int.tryParse(value) == null || int.parse(value) == 0){
                return "This field cannot be empty/zero/non-number";
              }
              return null;
            },
          ),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child:TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Persentase Tagihan Yang Dicover Solar Panel (%)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
            onChanged: (String? value){
              setState(() {
                offset = int.parse(value!)!;});},
            onSaved: (String? value){
              setState(() {
                offset = int.parse(value!)!;});},
            validator: (String? value){
              if (value ==null || value.isEmpty ||  int.tryParse(value) == null || int.parse(value) == 0){
                return "This field cannot be empty/zero/non-number";
              }
              if (int.parse(value) > 100){
                return "Please enter your wanted percentage between 0 - 100%";
              }
              return null;
            },
          ),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child:TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Faktor Pengaruh Cuaca (Umumnya 60% - 80%)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
            onChanged: (String? value){
              setState(() {
                envfactor = int.parse(value!)!;});},
            onSaved: (String? value){
              setState(() {
                envfactor = int.parse(value!)!;});},
            validator: (String? value){
              if (value ==null || value.isEmpty ||  int.tryParse(value) == null || int.parse(value) == 0){
                return "This field cannot be empty/zero/non-number";
              }
              if (int.parse(value) > 100){
                return "Please enter your wanted percentage between 0 - 100%";
              }

              return null;
            },
          ),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child:TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Luas Perkiraan Atap Rumah (M^2)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
            onChanged: (String? value){
              setState(() {
                luas_atap = int.parse(value!)!;});},
            onSaved: (String? value){
              setState(() {
                luas_atap = int.parse(value!)!;});},
            validator: (String? value){
              if (value ==null || value.isEmpty ||  int.tryParse(value) == null || int.parse(value) == 0  ){
                return "This field cannot be empty/zero/non-number";
              }
              return null;
            },
          ),),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(20.0),
              ),
            ),
            onPressed:()async{
              if (_formKey.currentState!.validate()){
                var user = context.read<UserManagement>();
                var solar_array_output = ((tagihan)/(365*solar_hours)).ceil();
                var solar_array_size = (solar_array_output * ((offset/100)/(envfactor/100))).ceil();
                var required_panel = ((solar_array_size*1000)/300).ceil();
                var required_area = ((required_panel*1.4).ceil()).ceil();
                if (required_area>luas_atap){
                  doable = false;
                }
                DateTime dateToday =new DateTime.now();
                String date = dateToday.toString().substring(0,10);
                if (doable == true ){
                  createCalculator(context,tagihan.toString(), offset.toString(), envfactor.toString(), solar_array_size.toString(), luas_atap.toString(), required_panel.toString(), required_area.toString(), doable.toString());
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 30,
                        child: Container(
                          child: ListView(
                            padding:
                            const EdgeInsets.only(top: 40, bottom: 40),
                            shrinkWrap: true,
                            children: <Widget>[
                              Center(
                                child: Column(children: [
                                  Text('Congratulations! ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                                  Text('Your Specification Meet Your Needs',style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Required Panel : $required_panel'),
                                  Text("Required Area For Panel : $required_area"),
                                  Text("Your Total Roof Area : $luas_atap"),
                                  Text("Is It Doable? : YES",style: TextStyle(fontWeight: FontWeight.bold))
                                ]),
                              ),
                              SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Back'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                if (doable == false){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 30,
                        child: Container(
                          child: ListView(
                            padding:
                            const EdgeInsets.only(top: 40, bottom: 40),
                            shrinkWrap: true,
                            children: <Widget>[
                              Center(
                                child: Column(children: [
                                  Text('Oops, We are sorry! ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                  Text('Your Specification Does Not Meet Your Needs',style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Required Panel : $required_panel pcs'),
                                  Text("Required Area For Panel : $required_area M^2"),
                                  Text("Your Total Roof Area : $luas_atap M^2" ),
                                  Text("Is It Doable? : NO",style: TextStyle(fontWeight: FontWeight.bold))
                                ]),
                              ),
                              SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Back'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                doable = true;
              }
            },
            child: const Text(
              "Cek Hasil Kalkulasi Anda",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ),
          TextButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalculatorHistory()),
              );},
              child: Text("Cek Rekam Jejak Kalkulasi Anda!",style:TextStyle(color: Colors.red)))
        ],
      ),
    ),
    );
  }
}
