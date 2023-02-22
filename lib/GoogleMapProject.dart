import 'package:flutter/material.dart';

class GoogleMapProject extends StatefulWidget {

  @override
  State<GoogleMapProject> createState() => _GoogleMapProjectState();
}

class _GoogleMapProjectState extends State<GoogleMapProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map Project"),
      ),
    );
  }
}
