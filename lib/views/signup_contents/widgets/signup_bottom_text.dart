import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/views/login_contents/login_screen.dart';
class SignUpBottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('Already have an account?',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}