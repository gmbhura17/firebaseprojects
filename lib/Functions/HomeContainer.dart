import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

homeScreenContainer(Color? myColor,String? myImage,String? productName){
  return
    Column(
      children: [
        GestureDetector(
          onTap: (){

          },
          child: Container(
            width: 29,
            height: 13,
            decoration:  BoxDecoration(
                color: myColor,
                borderRadius: const BorderRadius.all(Radius.circular(12))
            ),
            child: Image.asset("img/gro_intro_img3.png"),
          ),
        ),
        Text(productName!,style: const TextStyle(fontSize: 13,color: Colors.black),),
      ],
    );
}