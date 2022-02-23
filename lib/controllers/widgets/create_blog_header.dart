import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/views/myblogs_screen.dart';
class CreateBlogHeader extends StatelessWidget {
  const CreateBlogHeader({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 21,right: 21),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Text(
              'New blog',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * .08,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.highlight_remove_rounded),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyBlogs()));
              },
            ),
          )
        ],
      ),
    );
  }
}