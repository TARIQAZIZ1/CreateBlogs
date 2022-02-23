import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BlogsList extends StatefulWidget {
  BlogsList({required this.list});
  List list=[];

  @override
  _BlogsListState createState() => _BlogsListState();
}
class _BlogsListState extends State<BlogsList> {

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 2, right: 2,bottom: 2),
        height: height,

        child: Column(
          children: <Widget>[
            //header of the blogs list
            Expanded(
              flex: 2,
              child: Container(
                height: height*.12,
                child: Row(
                  children: [
                    Expanded(
                      flex:3,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "My Blogs",
                            style: TextStyle(
                              fontSize: width*.08,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: height*.02,
                          width: width*.02,
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
                              fontSize: width*.08,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Align( alignment: Alignment.topLeft,child: Text("Create the blog you "))),
            //list of users blogs
            Expanded(flex: 15,
              child: Align(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.list.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Stack(
                          children: [
                            Container(
                              height: height*.25,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.black,width: 1,style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage('${widget.list[index][index]['image']}'),
                                    fit: BoxFit.cover)),
                              ),
                            Positioned(
                              child: Text(
                                '${widget.list[index][index]['title']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width*.05,
                                ),
                              ),
                              bottom: 20,
                              left: 20,
                            ),
                            Positioned(
                              right: 15,
                              bottom: 15,
                              child: Icon(Icons.share, color: Colors.white,
                              )
                              ,)
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}