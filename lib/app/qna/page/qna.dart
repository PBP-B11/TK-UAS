import 'package:flutter/material.dart';

import 'package:my_panel/util/drawer.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({super.key});

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QNA'),
      ),
      body: Center(),
    );
  }
}
