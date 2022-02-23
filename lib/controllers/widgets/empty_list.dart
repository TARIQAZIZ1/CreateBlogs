import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/views/blogs_contents/create_blogs.dart';
import 'package:jmmtask/views/signup_contents/signup_screen.dart';

//if the list is empty this widget will build
class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //Header of the empty list
        Container(
          height: 70.sp,
          child: Row(

            children: [
              Expanded(
                flex: 3,
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "My Blogs",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    height: .02.sh,
                    width: .02.sw,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff474747),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "blog",
                      style: TextStyle(
                        color: Color(0xff0D638A),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Text("Create the blog you want"),
        SizedBox(height: 220.sp,),
        //body of the empty users blogs
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'You don\'t have any blogs',
              style:
              TextStyle(color: Colors.black, fontSize: 14.sp),
              children: <TextSpan>[
                TextSpan(
                    text: '\n\nLets Create a Blog',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreateBlog()));
                      }),
              ]),
        ),
      ],
    );
  }
}