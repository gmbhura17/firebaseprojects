import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseprojects/UpdateTeacher.dart';
import 'package:flutter/material.dart';
class ViewTeacher extends StatefulWidget {
  @override
  State<ViewTeacher> createState() => _ViewTeacherState();
}
class _ViewTeacherState extends State<ViewTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Teacher"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Teachers").snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(snapshot.hasData)
            {
              if(snapshot.data!.size<=0)
                {
                  return Center(
                    child: Text("No Teachers data Found"),
                  );
                }
              else
                {
                  return ListView(
                    children: snapshot.data!.docs.map((document){
                      return Container(
                        height: 350,
                          width: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 20,
                                color: Colors.blue,
                                 child: Container(
                                   child: Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(top: 30),
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             Image.network(document["imageurl"],height: 100,),
                                             Text(document["name"].toString(),style: TextStyle(fontSize: 20),),
                                             Text(document["gender"].toString(),style: TextStyle(fontSize: 20),),
                                           ],
                                         ),
                                       ),
                                       SizedBox(height: 40,),
                                       Row(
                                         children: [
                                           GestureDetector(
                                             onTap: () async{
                                               var docid = document.id.toString();

                                               await FirebaseStorage.instance.ref(document["imagename"].toString()).delete().then((value) async{
                                                 await FirebaseFirestore.instance.collection("Teachers").doc(docid).delete().then((value){
                                                   print("Record Deleted");
                                                 });
                                               });
                                             },
                                             child: Padding(
                                               padding: const EdgeInsets.only(left: 30,right: 30.0),
                                               child: Container(
                                                 height: 40,
                                                   color: Colors.black,
                                                   width: 70,
                                                   child: Center(child: Text("  Delete ",style: TextStyle(color: Colors.white),))),
                                             ),
                                           ),

                                       GestureDetector(
                                         onTap: () async{
                                           var docid = document.id.toString();
                                           Navigator.of(context).push(
                                           MaterialPageRoute(builder: (context)=>UpdateTeacher(
                                             updateid: docid,
                                           ))
                                           );

                                         },
                                         child: Padding(
                                           padding:  EdgeInsets.only(left: 100.0),
                                           child: Container(
                                               height: 40,
                                               color: Colors.white,
                                               width: 70,
                                               child: Center(child: Text("  Update ",style: TextStyle(color: Colors.black),))),
                                         ),
                                       ),
                                        // SizedBox(height: ,)
                                         ],
                                       ),
                                       SizedBox(height: 30),
                                     ],
                                   )
                                 ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}




// Container(
//   child: ListTile(
//     title: Text(document["name"].toString()),
//     subtitle: Text(document["gender"].toString()),
//   ),
// ),