import 'package:flutter/material.dart';
import 'package:my_panel/app/article/util/future.dart';
import 'package:my_panel/app/calculator/model/calculator_model.dart';
import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/util/providers/user_provider.dart';
import 'package:provider/provider.dart';
class CalculatorForm extends StatefulWidget {
  const CalculatorForm({super.key});

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  @override
  String? numberValidator(String? value) {
    if(value == null) {
      return "This field cannot be empty";
    }
    final n = num.tryParse(value);
    if(n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }
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
              if (value ==null || value.isEmpty){
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
                fetchCalculator(context);
                // createCalculator( context,user.userLoggedIn!.id,tagihan, offset, envfactor, solar_array_size, luas_atap, required_panel, required_area, doable, date);
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
