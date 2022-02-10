import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmmtask/Model/blogsModel.dart';
import 'package:jmmtask/Model/model.dart';
import 'package:jmmtask/main.dart';
class blogs extends StatefulWidget {
  blogs({required this.title, required this.image, required this.desc});
  String title='';
  String desc='';
  String image='';
  @override
  _blogsState createState() => _blogsState();

}

class _blogsState extends State<blogs> {
  User? blog=FirebaseAuth.instance.currentUser;
  //UserModel loggedin=UserModel(name: '',email: '',uid: '',password: '');
  blogModel blogs=blogModel(bid:'',title: '', desc: '', image: '');
  List<blogModel> items=[];
  @override
  void initState() {
    super.initState();
    getData();
    // FirebaseFirestore.instance
    //     .collection('blogs')
    //     .get()
    //     .then((value) {
    //   //this.blogs = blogModel.fromMap(value.docs);
    //      // items.add(this.blogs = blogModel.fromMap(value.data()));
    // });
  }
  final _fireStore = FirebaseFirestore.instance;
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _fireStore.collection('collectionName').get();;

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //for a specific field
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();

    print(allData);
  }
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: height,

          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  height: height*.1,
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
              Expanded(flex: 15,
                child: Align(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
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
                                  ),
                                  child: Text('kjhkjhjkh'),
                                ),
                                Positioned(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width*.05,
                                    ),
                                  ),
                                  bottom: 20,
                                  left: 20,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
