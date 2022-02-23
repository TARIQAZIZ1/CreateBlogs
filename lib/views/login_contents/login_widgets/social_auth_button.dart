import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
//button used for social auth functionalitis
class SocailAuthButton extends StatelessWidget {
  String text;
  dynamic onPressed;
  //constructor
  SocailAuthButton(
  {required this.text, required this.onPressed}
      );

  //Function onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(left: 30, right: 30),
      height: 50.sp,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border:  Border.all(color: AppColors.mainColor),
      ),
      child: Center(
        child: InkWell(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.mainColor,
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}