import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/views/animated_splash/splash_screen.dart';
import 'package:jmmtask/views/login_contents/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jmmtask/views/myblogs_screen.dart';
import 'package:jmmtask/views/signup_contents/signup_screen.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      //settng font family for the app
      theme: ThemeData(
        fontFamily: 'SegoeUi',
        primaryColor: AppColors.mainColor,
      ),
      home: myApp()));
}
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //using screenUtil lib for responsiveness
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return SignupPage();
  }
}