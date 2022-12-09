import 'package:flutter/material.dart';

import 'package:my_panel/util/drawer.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      drawer: MyDrawer(),
      body: Form(
      child: PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      children: <Widget>[
        Center(
          child: Text('According to the U.S. Energy Information Administration, the average household uses around 893 kilowatt-hours (kWh) per month. A residential solar setup produces anywhere from 350 to 850 kWh per month. Therefore, you can save as much as 95% off your utility bill.'),
        ),
        Center(
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Tagihan Listrik Selama 1 Tahun (KWH)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
        ),
          ),
        ),
      Center(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Persentase Tagihan Yang Dicover Solar Panel (%)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
          ),
        ),
      ),
        Center(
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Faktor Pengaruh Cuaca",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
        ),
        Center(
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Luas Perkiraan Atap Rumah (M^2)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
        ),
        Center(
          child:  TextButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(20.0),
            ),
          ),
            onPressed:null ,
            child: const Text(
              "Cek Hasil Kalkulasi Anda",
              style: TextStyle(color: Colors.white),
            ),
          )
        ),
      ],
      ),
      )
    );



  }
}
