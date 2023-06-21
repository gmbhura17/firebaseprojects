import 'package:flutter/material.dart';

class Hello extends StatefulWidget {

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Helo"),
    );
  }
}
