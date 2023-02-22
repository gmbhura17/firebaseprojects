import 'package:firebaseprojects/HomePage.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  start() async
  {
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder:(context)=>HomePage())
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed( Duration(milliseconds: 5000),(){
      start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange.shade400,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.bottomLeft,
        //       end: Alignment.bottomRight,
        //       colors: [Colors.purple.shade900,Colors.pink.shade100]
        //   ),
        // ),
        child: Center(
          child: Image.asset("img/flut3.jpg",width: 300,),
        ),
      ),
    );

  }
}
