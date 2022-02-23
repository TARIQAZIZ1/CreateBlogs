import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
class SingInSignUpButton extends StatelessWidget {
  String text;
  dynamic onPressed;
  SingInSignUpButton(BuildContext context,  {required this.onPressed, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.sp,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(5),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: AppColors.passIconColor,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(1, 1),
          ),
        ],

      ),
      child: Center(
        child: InkWell(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}