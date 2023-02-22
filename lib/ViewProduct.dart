import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseprojects/UpdateProduct.dart';
import 'package:flutter/material.dart';

class ViewStudentExtra extends StatefulWidget {

  @override
  State<ViewStudentExtra> createState() => _ViewStudentExtraState();
}

class _ViewStudentExtraState extends State<ViewStudentExtra> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Product (ImagePicker) :"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Products").snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              if(snapshot.data!.size<=0)
              {
                return Center(
                  child: Text("No Product aain (aavya naein)"),
                );
              }
              else{
                return ListView(
                  children: snapshot.data!.docs.map((document){
                    return Column(
                      children: [
                        Container(
                          color: Colors.yellow,
                          height: 400,
                          width: 600,
                          child: Column(
                            children: [
                              Column(
                                children:[
                                  Image.network(document["imageUrl"].toString(),height: 200,),
                                  Text(document["Product"].toString(),style: TextStyle(fontSize: 24),),
                                  Text(document["Price"].toString(),style: TextStyle(fontSize: 24),),
                                  Text(document["Cetegery"].toString(),style: TextStyle(fontSize: 24),),
                                ]
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(onTap: ()
                                  async{
                                    var docid = document.id.toString();
                                    await FirebaseStorage.instance.ref(document["imageName"].toString());
                                    await FirebaseFirestore.instance.collection("Products").doc(docid).delete().then((value){
                                      print("Record Delete Thiviya");
                                    });
                                  },
                                    child: Container(
                                        height: 30,
                                        width: 130,
                                        color: Colors.greenAccent,
                                        child: Center(child: Text("Delete Product",style: TextStyle(fontSize: 18),))),),


                                  //  ------------------------------ Update -----------------------------------------
                                  GestureDetector(onTap: ()
                                  async{
                                    var docid = document.id.toString();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateProduct( updateid: docid,)));
                                    },

                                    child: Container(
                                        height: 30,
                                        width: 130,
                                        color: Colors.redAccent,
                                        child: Center(child: Text("Update Product",style: TextStyle(fontSize: 18),))),),
                                ],
                              )
                            ],
                          ),


                        ),


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


// ListTile(
//   leading: Image.asset("img/flut1.jpg",width: 30,),
//   title: Text(document["Product"].toString(),style: TextStyle(fontSize: 24),),
//   subtitle: Text(document["Price"].toString(),style: TextStyle(fontSize: 16),),
//   tileColor: Colors.red,
//   trailing: Text(document["Cetegery"].toString(),style: TextStyle(fontSize: 20),),
//
// ),