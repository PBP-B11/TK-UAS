import 'package:flutter/material.dart';

import 'package:my_panel/util/drawer.dart';

class TestimonyPage extends StatefulWidget {
  const TestimonyPage({super.key});

  @override
  State<TestimonyPage> createState() => _TestimonyPageState();
}

class _TestimonyPageState extends State<TestimonyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testimony'),
      ),
      body: Center(),
      drawer: MyDrawer(),
    );
  }
}
