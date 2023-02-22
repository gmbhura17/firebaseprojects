import 'package:firebaseprojects/Functions/containerFunction.dart';
import 'package:flutter/material.dart';

class RoughPage extends StatefulWidget {
  const RoughPage({Key? key}) : super(key: key);

  @override
  State<RoughPage> createState() => _RoughPageState();
}

class _RoughPageState extends State<RoughPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:myContainer()
    );
  }
}
