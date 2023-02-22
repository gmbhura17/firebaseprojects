import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class AddTeacher extends StatefulWidget {
  @override
  State<AddTeacher> createState() => _AddTeacherState();
}
class _AddTeacherState extends State<AddTeacher> {
  File? imagefieldfile;
  ImagePicker _pickerfield = ImagePicker();
  TextEditingController _name = TextEditingController();
  TextEditingController _exp = TextEditingController();
  var grpvalue = "Male";
  bool isloading=false; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addteacher"),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
      ),
      body: SingleChildScrollView(
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
                  (imagefieldfile!=null)?Image.file(imagefieldfile!,width: 130,):Image.asset("img/shoes1.jpg",width: 130,),
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
                    XFile? photo = await _pickerfield.pickImage(source: ImageSource.camera);
                    setState((){
                      imagefieldfile = File(photo!.path);
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
                    XFile? photo = await _pickerfield.pickImage(source: ImageSource.gallery);
                    setState((){
                      imagefieldfile = File(photo!.path);
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
            height: 50,
          ),
          Row(
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
          SizedBox(
            height: 30,
          ),
          (isloading)?CircularProgressIndicator():ElevatedButton(
              onPressed: () async{

                setState((){
                  isloading=true;
                });


                var uuid = Uuid();
                var filename = uuid.v1();


                await FirebaseStorage.instance.ref(filename).putFile(imagefieldfile!).whenComplete((){}).then((filedata) async{
                  await filedata.ref.getDownloadURL().then((fileurl) async{
                    var name = _name.text.toString();
                    var exp = _exp.text.toString();
                    var gender = grpvalue;
                    await FirebaseFirestore.instance.collection("Teachers").add ({
                      "name":name,
                      "experience":exp,
                      "gender":gender,
                      "imagename":filename,
                      "imageurl":fileurl
                    }).then((value){
                      print("Record Inserted");
                      _name.text="";
                      _exp.text="";
                      setState((){
                        imagefieldfile=null;
                      });

                      setState((){
                        isloading=false;
                      });

                    });
                  });
                });






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




// ElevatedButton(onPressed: (){
//   print(drp);
// }, child: Text("Submit"))