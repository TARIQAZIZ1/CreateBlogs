import 'package:flutter/material.dart';
Widget Field(purpose, labletext,{IconButton? icon}){
  bool _showpassword= false;
  return TextFormField(

    obscureText: _showpassword,
    decoration: InputDecoration(
      suffixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.black,width: 3,style: BorderStyle.solid),
      ),
      hintText: labletext,
    ),
    onChanged: (value) {
      purpose = value;
    },
  );
}