import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';
// import 'dart:ffi' as ffi;

class UpdateStudent extends StatefulWidget {

  var updateid="";
  UpdateStudent({required this.updateid});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  TextEditingController _student = TextEditingController();
  TextEditingController _roll = TextEditingController();
  var grpvalue = "A";
  getdata()async{
    await FirebaseFirestore.instance.collection("Students").doc(widget.updateid).get().then((document){
      _student.text = document["student"].toString();
      _roll.text = document["roll no"].toString();
      grpvalue=document["division"].toString();
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
              // child: Column(
              //   children: [
              //     (imagefieldfile2!=null)?Image.file(imagefieldfile2!,width: 130,):
              //     (oldfileurl=="")?CircularProgressIndicator():Image.network(oldfileurl,width: 130,),
              //   ],
              // ),
            ),
          ),
          SizedBox(height: 20,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     ElevatedButton(
          //       child: new Text('Camera',style: TextStyle(color: Colors.white),),
          //       onPressed: () async
          //       {
          //         XFile? photo = await _pickerfield2.pickImage(source: ImageSource.camera);
          //         setState((){
          //           imagefieldfile2= File(photo!.path);
          //         });
          //       },
          //       // color: Colors.black,
          //       // textColor: Colors.white,
          //       // splashColor: Colors.blue,
          //     ),
          //     ElevatedButton(
          //       child: new Text('Gallery',style: TextStyle(color: Colors.black),),
          //       onPressed: () async
          //       {
          //         XFile? photo = await _pickerfield2.pickImage(source: ImageSource.gallery);
          //         setState((){
          //           imagefieldfile2 = File(photo!.path);
          //         });
          //       },
          //       // color: Colors.white,
          //       // textColor: Colors.white,
          //       // splashColor: Colors.blue,
          //     ),
          //   ],
          // ),
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
                controller: _student,
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
                controller: _roll,
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
            child:  Row(
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
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async{
                var studuct = _student.text.toString();
                var roll = _roll.text.toString();
                var division = grpvalue.toString();

                
                FirebaseFirestore.instance.collection("Students").doc(widget.updateid).update({
                  "student":studuct,
                  "roll no":roll,
                  "division":division,
                }).then((value){
                  _student.text.toString();
                  _roll.text.toString();
                  grpvalue.toString();
                  Navigator.of(context).pop();
                });
                // setState((){
                //   isloading=true;
                // });

                // if(imagefieldfile2==null)
                // {
                //   var name = _student.text.toString();
                //   var exp = _roll.text.toString();
                //   var gender = grpvalue;
                //   await FirebaseFirestore.instance.collection("Teachers").doc(widget.updateid).update({
                //     "name":name,
                //     "experience":exp,
                //     "gender":gender,
                //   }).then((value){
                //     Navigator.of(context).pop();
                //   });
                // }
                // else
                // {
                //   await FirebaseStorage.instance.ref(oldfilename).delete().then((value) async{
                //     var uuid = Uuid();
                //     var filename = uuid.v1();
                //     await FirebaseStorage.instance.ref(filename).putFile(imagefieldfile2!).whenComplete((){}).then((filedata) async {
                //       await filedata.ref.getDownloadURL().then((
                //           fileurl) async {
                //         var name = _name.text.toString();
                //         var exp = _exp.text.toString();
                //         var gender = grpvalue;
                //         await FirebaseFirestore.instance.collection("Teachers").doc(widget.updateid).update({
                //           "name":name,
                //           "experience":exp,
                //           "gender":gender,
                //           "imagename":filename,
                //           "imageurl":fileurl
                //         }).then((value){
                //           Navigator.of(context).pop();
                //         });
                //       });
                //     });
                //   }
                //   );
                // }
                //
                //
                //
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
