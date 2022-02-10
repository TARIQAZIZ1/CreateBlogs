import 'package:flutter/material.dart';
Widget button(String text, Color color, Color textColor,Size size,{onPressed}){
  return InkWell(
    child: Container(
      width: double.infinity,
      height: size.height*.05,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Color(0xff0D638A),width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
            ),
          ),
      ),
      ),
    onTap: (){onPressed();},
  );
}