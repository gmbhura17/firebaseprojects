import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ViewStudent extends StatefulWidget {
  @override
  State<ViewStudent> createState() => _ViewStudentState();
}
class _ViewStudentState extends State<ViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Student"),
      ),
      body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Students").snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              if(snapshot.data!.size<=0)
              {
                return Center(
                  child: Text("No Data To Show !!"),
                );
              }
              else{
                return ListView(
                  children: snapshot.data!.docs.map((document){
                    return Column(
                      children: [

                        Container(
                          color: Colors.white70,
                          child: ListTile(

                            title: Text(document["student"].toString(),style: TextStyle(fontSize: 24),),
                            subtitle: Text(document["roll no"].toString(),style: TextStyle(fontSize: 16),),
                            // tileColor: Colors.red,
                            trailing: Text(document["division"].toString(),style: TextStyle(fontSize: 20),),

                          ),

                        ),
                        GestureDetector(onTap: ()
                           async{
                          var docid = document.id.toString();
                          await FirebaseFirestore.instance.collection("Students").doc(docid).delete().then((value){ 
                            print("Record Delete Thiviya");
                          });
                           },
                             child: Container(
                                height: 30,
                                width: 100,
                                color: Colors.greenAccent,
                                  child: Center(child: Text("Delete Data",style: TextStyle(fontSize: 18),))),)
                        ],
                    );

                  }).toList(),
                );
              }

            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }
}
