import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../signup_contents/signup_screen.dart';

//splash screen before loading
AnimatedSplashScreen buildAnimatedSplashScreen() {
  return AnimatedSplashScreen(
    splash: Center(
      child: Image.asset('assets/BlogPicNormal.png'),
    ),
    splashTransition: SplashTransition.slideTransition,
    backgroundColor: Color(0xff0D638A),
    nextScreen: SignupPage(),
  );
}