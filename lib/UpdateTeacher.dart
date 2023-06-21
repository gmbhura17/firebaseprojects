import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseprojects/Helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UpdateTeacher extends StatefulWidget {

  var updateid="";
  UpdateTeacher({required this.updateid});

  @override
  State<UpdateTeacher> createState() => _UpdateTeacherState();
}

class _UpdateTeacherState extends State<UpdateTeacher> {
  File? imagefieldfile2;
  ImagePicker _pickerfield2 = ImagePicker();
  TextEditingController _name = TextEditingController();
  TextEditingController _exp = TextEditingController();
  var grpvalue = "Male";
  bool isloading=false;


  var oldfilename="";
  var oldfileurl="";

  getdata() async
  {
    await FirebaseFirestore.instance.collection(Helper.dataTeacher).doc(widget.updateid).get().then((document){
      _name.text = document["name"].toString();
      _exp.text = document["experience"].toString();
      setState((){
        oldfilename=document["imagename"].toString();
        oldfileurl=document["imageurl"].toString();
        grpvalue=document["gender"].toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Teacher"),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
      ),
      body:
      SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 8),

              ),
              child: Column(
                children: [
                  (imagefieldfile2!=null)?Image.file(imagefieldfile2!,width: 130,):
                  (oldfileurl=="")?CircularProgressIndicator():Image.network(oldfileurl,width: 130,),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: new Text('Camera',style: TextStyle(color: Colors.white),),
                onPressed: () async
                {
                  XFile? photo = await _pickerfield2.pickImage(source: ImageSource.camera);
                  setState((){
                    imagefieldfile2= File(photo!.path);
                  });
                },
                // color: Colors.black,
                // textColor: Colors.white,
                // splashColor: Colors.blue,
              ),
              ElevatedButton(
                child: new Text('Gallery',style: TextStyle(color: Colors.black),),
                onPressed: () async
                {
                  XFile? photo = await _pickerfield2.pickImage(source: ImageSource.gallery);
                  setState((){
                    imagefieldfile2 = File(photo!.path);
                  });
                },
                // color: Colors.white,
                // textColor: Colors.white,
                // splashColor: Colors.blue,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text("Employee :"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
              BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: _name,
                keyboardType: TextInputType.text,
                // controller: _contact,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text("Experience :"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
              BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: _exp,
                keyboardType: TextInputType.text,
                // controller: _contact,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left:50.0),
            child: Row(
              children: [
                Text(
                  "Gender :",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 30,
                ),
                Text("Male:"),
                Radio(
                    value: "Male",
                    groupValue: grpvalue,
                    onChanged: (val)
                    {
                      setState((){
                        grpvalue=val!;
                      });
                    }
                ),
                Text("Female:"),
                Radio(
                    value: "Female",
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
          ),
          SizedBox(
            height: 30,
          ),
          (isloading)?CircularProgressIndicator():ElevatedButton(
              onPressed: () async{

                setState((){
                  isloading=true;
                });

                if(imagefieldfile2==null)
                  {
                    var name = _name.text.toString();
                    var exp = _exp.text.toString();
                    var gender = grpvalue;
                    await FirebaseFirestore.instance.collection("Teachers").doc(widget.updateid).update({
                      "name":name,
                      "experience":exp,
                      "gender":gender,
                    }).then((value){
                      Navigator.of(context).pop();
                    });
                  }
                else
                  {
                    await FirebaseStorage.instance.ref(oldfilename).delete().then((value) async{
                      var uuid = Uuid();
                      var filename = uuid.v1();
                      await FirebaseStorage.instance.ref(filename).putFile(imagefieldfile2!).whenComplete((){}).then((filedata) async {
                        await filedata.ref.getDownloadURL().then((
                            fileurl) async {
                          var name = _name.text.toString();
                          var exp = _exp.text.toString();
                          var gender = grpvalue;
                          await FirebaseFirestore.instance.collection("Teachers").doc(widget.updateid).update({
                            "name":name,
                            "experience":exp,
                            "gender":gender,
                            "imagename":filename,
                            "imageurl":fileurl
                          }).then((value){
                            Navigator.of(context).pop();
                          });
                        });
                      });
                    });
                  }










              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              child: Text("Submit")),
        ]),
      ),
    );
  }
}
