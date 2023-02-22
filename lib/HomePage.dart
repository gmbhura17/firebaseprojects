import 'package:firebaseprojects/AddStudent.dart';
import 'package:firebaseprojects/AddProduct.dart';
import 'package:firebaseprojects/AddTeacher.dart';
import 'package:firebaseprojects/ViewStudent.dart';
import 'package:firebaseprojects/ViewProduct.dart';
import 'package:firebaseprojects/ViewTeacher.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("HomePage"),

       ),
      drawer: Drawer(
          child: Column(
            children: [
              SizedBox(height: 130,),
              Container(
                color: Colors.lightGreen.shade700,
                  child: Text("Student Data List",style: TextStyle(color: Colors.white),)),
              Padding(
                padding: const EdgeInsets.only(top: 30.0,left: 80),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddStudent()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text("Add Student Data",)),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewStudent()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text("View Student Data")),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Container(
                  color: Colors.redAccent.shade700,
                  child: Text("Product Data List (Image Picker",style: TextStyle(color: Colors.white),)),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddStudentExtra()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text("Add Product (ImagePicker)")),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewStudentExtra()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text("View Product (ImagePicker)")),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Container(

                  color: Colors.lightBlueAccent.shade700,
                  child: Text("Teacher Data List",style: TextStyle(color: Colors.white),)),
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 80),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddTeacher()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text("Add Teacher Data")),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 50,left: 80),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewTeacher()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text("View Teacher Data")),
                  ],
                ),
              ),


            ],
          ),


      ),
    );
  }
}




// TextField(
//   decoration: InputDecoration(
//     border: OutlineInputBorder(),
//     hintText: 'Enter a search term',
//   ),
// ),