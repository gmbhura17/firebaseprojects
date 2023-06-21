import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseprojects/AddStudent.dart';
import 'package:firebaseprojects/AddProduct.dart';
import 'package:firebaseprojects/AddTeacher.dart';
import 'package:firebaseprojects/ViewStudent.dart';
import 'package:firebaseprojects/ViewProduct.dart';
import 'package:firebaseprojects/ViewTeacher.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Center(child: Text("Firebase Project")),

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
      body: Column(
        children: [
          SizedBox(height: 300),
          Container(
            child: Center(
              child: GestureDetector(
                  onTap: () async {
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
                    if (googleSignInAccount != null) {
                      final GoogleSignInAuthentication googleSignInAuthentication =
                      await googleSignInAccount.authentication;
                      final AuthCredential authCredential = GoogleAuthProvider.credential(
                          idToken: googleSignInAuthentication.idToken,
                          accessToken: googleSignInAuthentication.accessToken);

                      // Getting users credential
                      UserCredential result = await auth.signInWithCredential(authCredential);
                      User? user = result.user;

                      var name = user?.displayName.toString();
                      var email = user?.email.toString();
                      var photo = user?.photoURL.toString();
                      var gid = user?.uid.toString();

                      print("user Name  "+ name!);
                      print("email Id  "+ email!);
                      print("google Id  "+ gid!);
                      print("photo  "+ photo!);

                    }
                  },
                  child: Container(
                      width: 240,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue,width: 4)
                      ),
                      child: Center(child: Text("Login With Google",style: TextStyle(fontSize: 25,color: Colors.blue.shade800),)))),
            ),

          ),
        ],
      ),

    );
  }
}

//
//
// import 'dart:ffi';
//
// class UpdateStudent extends StatefulWidget {
//
//   var updateid="";
//   UpdateStudent({required this.updateid});
//
//   @override
//   State<UpdateStudent> createState() => _UpdateStudentState();
// }
//
// class _UpdateStudentState extends State<UpdateStudent> {
//   TextEditingController _student = TextEditingController();
//   TextEditingController _roll = TextEditingController();
//   var grpvalue = "A";
//   getdata()async{
//     await FirebaseFirestore.instance.collection("Students").doc(widget.updateid).get().then((document){
//       _student.text = document["student"].toString();
//       _roll.text = document["roll no"].toString();
//       grpvalue=document["division"].toString();
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     getdata();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update Teacher"),
//         leading: GestureDetector(
//           child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
//           onTap: () {
//             Navigator.pop(context);
//           } ,
//         ) ,
//       ),
//       body:
//       SingleChildScrollView(
//         child: Column(children: [
//           SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey,width: 8),
//
//               ),
//             ),
//           ),
//           SizedBox(height: 20,),
//
//           SizedBox(
//             height: 30,
//           ),
//           Text("Employee :"),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration:
//               BoxDecoration(border: Border.all(color: Colors.black)),
//               child: TextField(
//                 controller: _student,
//                 keyboardType: TextInputType.text,
//                 // controller: _contact,
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//           Text("Experience :"),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration:
//               BoxDecoration(border: Border.all(color: Colors.black)),
//               child: TextField(
//                 controller: _roll,
//                 keyboardType: TextInputType.text,
//                 // controller: _contact,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left:50.0),
//             child:  Row(
//               children: [
//                 Text(
//                   "Division :",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 Text("A:"),
//                 Radio(
//                     value: "A",
//                     groupValue: grpvalue,
//                     onChanged: (val)
//                     {
//                       setState((){
//                         grpvalue=val!;
//                       });
//                     }
//                 ),
//                 Text("B:"),
//                 Radio(
//                     value: "B",
//                     groupValue: grpvalue,
//                     onChanged: (val)
//                     {
//                       setState((){
//                         grpvalue=val!;
//                       });
//                     }
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           ElevatedButton(
//               onPressed: () async{
//                 var studuct = _student.text.toString();
//                 var roll = _roll.text.toString();
//                 var division = grpvalue.toString();
//
//
//                 FirebaseFirestore.instance.collection("Students").doc(widget.updateid).update({
//                   "student":studuct,
//                   "roll no":roll,
//                   "division":division,
//                 }).then((value){
//                   _student.text.toString();
//                   _roll.text.toString();
//                   grpvalue.toString();
//                   Navigator.of(context).pop();
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(30.0),
//                 ),
//               ),
//               child: Text("Submit")),
//         ]),
//       ),
//
//     );
//   }
// }
