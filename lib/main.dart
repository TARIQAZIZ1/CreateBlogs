import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmmtask/screens/blogs.dart';
import 'package:jmmtask/screens/createBologs.dart';
import 'package:jmmtask/screens/homePage.dart';
import 'package:jmmtask/screens/logIn_screen.dart';
import 'package:jmmtask/screens/signUp_screen.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(myApp());
}
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: blogs(title: '', image: '', desc: '',),
      routes:{
        '/signUp':(_)=>signUp(),
        '/homepage':(_)=>homePage(),
        '/logIn':(_)=>logIn(),
        '/uploadImage':(_)=>uploadImage(),
      },
    );
  }
}
