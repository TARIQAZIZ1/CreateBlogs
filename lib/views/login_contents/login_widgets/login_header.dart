import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';

class LogInHeader extends StatelessWidget {
  const LogInHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.sp,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child:
              Stack(
                children: [
                  Container(
                    height: 170.sp,
                  ),
                  Positioned(
                    top: -80,
                    left: 200,
                    right: -140.sp,
                    child: Container(
                      height: 220.sp,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset('assets/Login1.png'),
                )),
            Expanded(
              flex: 2,
              child:
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Login',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Align(alignment: Alignment.topLeft,child: Text('Enter your credentials to login')),
            ),),
          ],
        ),
      );
  }
}