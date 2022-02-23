import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/controllers/widgets/blogs_list.dart';
import 'package:jmmtask/controllers/widgets/empty_list.dart';
import 'package:jmmtask/views/blogs_contents/create_blogs.dart';

class MyBlogs extends StatefulWidget {
  @override
  _MyBlogsState createState() => _MyBlogsState();
}

class _MyBlogsState extends State<MyBlogs> {
  List items=[];
//getting data before building widgets through initState
  void initState() {
    super.initState();
    getData();
  }

  //Fetching data from database and storing in a list
  final List list = [];
  getData() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("blogs").get();
    final docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(int i=0;i<docData.length;i++){ list.add(docData);}

    print('${docData.length}');

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
          child:
            list.isNotEmpty?
            BlogsList(list: list):
            EmptyList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateBlog()));
          },
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(color: AppColors.mainColor, width: 3.sp)),
          child: Icon(
            Icons.add,
            color: Color(0xff0D638A),
            size: 40,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff0D638A),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: InkWell(
                  child: Icon(
                Icons.search,
                size: 30,
              )),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.person_rounded,
                size: 30,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}



