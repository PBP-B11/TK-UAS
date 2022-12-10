import 'package:flutter/material.dart';

import 'package:my_panel/util/drawer.dart';
import 'package:my_panel/app/calculator/page/calculatorForm.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}


class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children :[ Image.asset('lib/assets/images/kalkulator1.png',
        height: MediaQuery.of(context).size.height / 2,),
        Text('According to the U.S. Energy Information Administration, the average household uses around 893 kilowatt-hours (kWh) per month. A residential solar setup produces anywhere from 350 to 850 kWh per month. Therefore, you can save as much as 95% off your utility bill.'),
          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CalculatorForm()),
            );
          }, child: Text("Lets Start!"))
    ]
      )
    );




  }
}
