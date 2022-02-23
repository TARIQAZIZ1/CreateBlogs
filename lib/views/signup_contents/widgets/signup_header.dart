import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SignUpHeader extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      margin: EdgeInsets.only(top: 50),
      height: 230.sp,
      decoration: BoxDecoration(
      ),
      child: Column(
        children: [
          Expanded(flex: 1,child: Align(alignment: Alignment.bottomCenter,child: Image.asset('assets/Login1.png',)),),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(flex: 1,child: Align(alignment: Alignment.topLeft,child: Text('Enter your credentials to login',)),),
        ],
      ),
    );
  }
}