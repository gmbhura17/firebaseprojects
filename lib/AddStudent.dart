import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddStudent extends StatefulWidget {

  @override
  State<AddStudent> createState() => _AddStudentState();
}
class _AddStudentState extends State<AddStudent> {

  TextEditingController _student = TextEditingController();
  TextEditingController _roll = TextEditingController();
  var grpvalue = "A";
  bool isloading=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("addstudent"),
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
       child: Column(
         children: [
           SizedBox(
             height: 30,
           ),

           Row(
             children: [
               SizedBox(width: 150,),
               Padding(
                 padding: const EdgeInsets.only(top: 20.0),
                 child: Container(
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black,width: 8),

                   ),
                   child: Column(
                     children: [],
                   ),
                 ),
               ),
               SizedBox(width: 20,),
               Padding(
                 padding: const EdgeInsets.only(top: 20.0),
                 child: Container(
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey,width: 8),

                   ),
                   child: Column(
                     children: [],
                   ),
                 ),
               ),
               SizedBox(width: 20,),
               Padding(
                 padding: const EdgeInsets.only(top: 20.0),
                 child: Container(
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black,width: 8),

                   ),
                   child: Column(
                     children: [],
                   ),
                 ),
               ),
             ],
           ),
           SizedBox(height: 20,),

           SizedBox(
             height: 30,
           ),
           Text("Student :"),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               decoration:
               BoxDecoration(border: Border.all(color: Colors.black)),
               child: TextField(
                 controller: _student,
                 keyboardType: TextInputType.text,
                 // controller: _contact,
               ),
             ),
           ),
           SizedBox(height: 30),
           Text("Roll No. :"),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               decoration:
               BoxDecoration(border: Border.all(color: Colors.black)),
               child: TextField(
                 controller: _roll,
                 keyboardType: TextInputType.number,
                 // controller: _contact,
               ),
             ),
           ),
           SizedBox(
             height: 50,
           ),
           Row(
             children: [
               Text(
                 "Division :",
                 style: TextStyle(fontSize: 20),
               ),
               SizedBox(
                 width: 30,
               ),
               Text("A:"),
               Radio(
                   value: "A",
                   groupValue: grpvalue,
                   onChanged: (val)
                   {
                     setState((){
                       grpvalue=val!;
                     });
                   }
               ),
               Text("B:"),
               Radio(
                   value: "B",
                   groupValue: grpvalue,
                   onChanged: (val)
                   {
                     setState((){
                       grpvalue=val!;
                     });
                   }
               ),
             ],
           ),
           SizedBox(
             height: 30,
           ),
           ElevatedButton(onPressed: ()   async{
              var student = _student.text.toString();
              var roll = _roll.text.toString();
              var division = grpvalue;
              await FirebaseFirestore.instance.collection("Students").add({
                  "student":student,
                "roll no":roll,
                "division":division
              }).then((value) {
                print("STUDENT Record DalDIYA (Nakhdiya)");
                _student.text="";
                _roll.text="";

              });

           },
               style: ElevatedButton.styleFrom(
             shape: new RoundedRectangleBorder(
               borderRadius: new BorderRadius.circular(30.0),
             ),
           ),child: Text("Submit",
                 style: TextStyle(color: Colors.lightGreen),))
         ],
       ),
      )
    );
  }
}



// ElevatedButton(onPressed: (){
//   print(drp);
// }, child: Text("Submit"))