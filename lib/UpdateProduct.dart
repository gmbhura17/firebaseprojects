import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UpdateProduct extends StatefulWidget {

  var updateid="";
  UpdateProduct({ required this.updateid});
  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  File? image2file;
  TextEditingController _product = TextEditingController();
  TextEditingController _price = TextEditingController();
  var grpvalue = "A";
  ImagePicker _picker2 = ImagePicker();
  bool isloading = false;

  var oldfilename="";
  var oldfileurl="";

   getdata()
   async{
     await FirebaseFirestore.instance.collection("Products").doc(widget.updateid).get().then((document){
       _product.text = document["Product"].toString();
       _price.text = document["Price"].toString();
       // _product.text = document["product"].toString();
       setState(() {
         oldfilename =   document["imageName"].toString();
         oldfileurl =    document["imageUrl"].toString();
         grpvalue = document["Cetegery"].toString();
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
        title: Text("Update Product (Image Picker) "),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
      ),
      body:  SingleChildScrollView(
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
                  (image2file!=null)?Image.file(image2file!, width: 130 ,):(oldfileurl=="")?
                  // Image.asset("img/flut1.jpg",width: 130,)
                  CircularProgressIndicator()
                      :Image.network(oldfileurl ,width: 130,),
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
                  XFile? photo = await _picker2.pickImage(source: ImageSource.camera);
                  setState(() {
                    image2file = File(photo!.path);
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
                  XFile? photo = await _picker2.pickImage(source: ImageSource.gallery);
                  setState(() {
                    image2file = File(photo!.path);
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
          Text("Product :"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
              BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: _product,
                keyboardType: TextInputType.text,
                // controller: _contact,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text("Price :"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
              BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: _price,
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
                "Cetegery :",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 30,
              ),
              Text("Shoes :"),
              Radio(
                  value: "Shoes",
                  groupValue: grpvalue,
                  onChanged: (val)
                  {
                    setState((){
                      grpvalue=val!;
                    });
                  }
              ),
              Text("Snikers :"),
              Radio(
                  value: "Snikers",
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
          // (isloading)?CircularProgressIndicator():
          (isloading)?CircularProgressIndicator(): ElevatedButton(
              onPressed: () async{
                setState((){
                  isloading = true;
                });

                var uuid = Uuid();
                var filename = uuid.v1();
                await FirebaseStorage.instance.ref(filename).putFile(image2file!).whenComplete(() => {}).then((filedata)
                async{
                  await filedata.ref.getDownloadURL().then((fileurl) async{
                    var pro = _product.text.toString();
                    var pr = _price.text.toString();
                    var  cet = grpvalue;
                    await FirebaseFirestore.instance.collection("Products").add({
                      "Product":pro,
                      "Price":pr,
                      "Cetegery":cet,
                      "imageName":filename,
                      "imageUrl":fileurl,
                    }).then((value) {
                      print("Product Record Done . ");
                      _product.text="";
                      _price.text="";
                      grpvalue="";
                      setState(() {
                        image2file=null;
                      });
                      setState(() {
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
