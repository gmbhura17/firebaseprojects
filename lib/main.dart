import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseprojects/GoogleMapProject.dart';
import 'package:firebaseprojects/HomePage.dart';
import 'package:firebaseprojects/RoughPage.dart';
import 'package:firebaseprojects/SplashScreen.dart';
import 'package:flutter/material.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      //home:  SplashScreen(),
      home: HomePage(),
    );
  }
}
