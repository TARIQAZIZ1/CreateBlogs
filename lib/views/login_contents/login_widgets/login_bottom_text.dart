import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';

import 'package:jmmtask/views/signup_contents/signup_screen.dart';
class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text('Don\'t have an account?',
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
              },
              child: Text(
                'Create account',
                style: TextStyle(
                  fontSize: 17.sp,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}