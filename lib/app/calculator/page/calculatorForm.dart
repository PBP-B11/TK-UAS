import 'package:flutter/material.dart';

import 'package:my_panel/util/drawer.dart';

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
      drawer: MyDrawer(),
      body: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
          decoration: InputDecoration(
              labelText: "Tagihan Listrik Selama 1 Tahun (KWH)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
          onChanged: (String? value){
            setState(() {
              tagihan = int.parse(value!)!;});},
          onSaved: (String? value){
            setState(() {
              tagihan =  int.parse(value!)!;});},
          validator: (String? value){
            if (value == null || value.isEmpty){
              return "This field cannot be empty";
            }
            return null;
          },
        ),
          TextFormField(
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
              if (value ==null || value==0){
                return "This field cannot be empty";
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Faktor Pengaruh Cuaca",
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
              if (value ==null || value.isEmpty){
                return "This field cannot be empty";
              }
              return null;
            },
          ),
          TextFormField(
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
              if (value ==null || value.isEmpty){
                return "This field cannot be empty";
              }
              return null;
            },
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(20.0),
              ),
            ),
            onPressed:()async{
              var solar_array_output = (tagihan)/(365*solar_hours);
              var solar_array_size = solar_array_output * ((offset/100)/(envfactor/100));
              var required_panel = (solar_array_size*1000)/300;
              var required_area = (required_panel*1.4).ceil();
              if (required_area>luas_atap){
                doable = false;
              }
              if (_formKey.currentState!.validate()){

              }

            },
            child: const Text(
              "Cek Hasil Kalkulasi Anda",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ),
    );
  }
}
