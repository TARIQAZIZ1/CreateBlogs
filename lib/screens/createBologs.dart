import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmmtask/Model/blogsModel.dart';
import 'package:jmmtask/screens/homePage.dart';
import 'package:jmmtask/widgets/buttons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dotted_border/dotted_border.dart';

import 'blogs.dart';

class uploadImage extends StatefulWidget {
  @override
  _uploadImageState createState() => _uploadImageState();
}

class _uploadImageState extends State<uploadImage> {
  final _auth = FirebaseAuth.instance;
  String firebaseImagePath='';
  XFile? imagePick;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  final titleEditingController=new TextEditingController();
  final blogEditingController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var placeholderImage = Image.asset('assets/empty.jpg');
    final textField= TextFormField(
      maxLines: 15,
      controller: blogEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        print("after in validation $blogEditingController");
        if(value!.isEmpty){
          return ("Type here");
        }
      },
      onSaved: (value){
        blogEditingController.text = value!;
        print("after edit $blogEditingController");
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
          hintText: 'Type here',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),

    );
    final titleField= TextFormField(
      autofocus: false,
      controller: titleEditingController,
      keyboardType: TextInputType.text,
      validator: (value){
        if(value!.isEmpty){
          return ("Enter blog");
        }
      },
      onSaved: (value){
        titleEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
          hintText: 'Enter title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    Size siz=MediaQuery.of(context).size;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
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
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) =>
                            homePage()));
                      },
                    ),
                  )

                ],
              ),
              Text('Enter the information below to create your blog'),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Align(
                  alignment: Alignment.center,
                  child: buildDashedBorder(
                    child: Container(
                      height: height * .2,
                      width: double.infinity,
                      child: Center(
                        child: InkWell(
                          child: Stack(
                            children: [
                              if (imagePick == null) Container(width: width,child: placeholderImage) else Image.file(
                                File(
                                  imagePick!.path,
                                ),
                                fit: BoxFit.cover,
                              ),
                              if (imagePick == null) Column(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.upload_rounded,
                                              color: Color(0xff0D638A),),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    height: 400,
                                                    width: 400,
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Expanded(
                                                        child: AlertDialog(
                                                          content: Text('Upload Image'),
                                                          actions: [
                                                            Center(
                                                                child: IconButton(
                                                                  onPressed: (){
                                                                    takeImage(ImageSource.gallery);
                                                                  },
                                                                  icon: Icon(Icons.photo),
                                                                ),
                                                              ),
                                                          ],
                                                        ),

                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    height: 400,
                                                    width: 400,
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Expanded(
                                                        child: AlertDialog(
                                                          content: Text('Upload Image'),
                                                          actions: [
                                                            Center(
                                                                child: IconButton(
                                                                  onPressed: (){
                                                                    takeImage(ImageSource.gallery);
                                                                  },
                                                                  icon: Icon(Icons.photo),
                                                                ),
                                                              ),
                                                          ],
                                                        ),

                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              'Upload header Image',
                                              style: TextStyle(
                                                color: Color(0xff0D638A),
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ) else SizedBox(),
                            ],
                          ),
                          onTap: () {
                            // imagePick==null?
                            // showBottomSheet(context: context,
                            //     builder: ((builder) => bottomsheet())):
                            //     SizedBox();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 400,
                                  width: 400,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Expanded(
                                      child: AlertDialog(
                                        content: Text('Upload Image'),
                                        actions: [
                                          Center(
                                              child: IconButton(
                                                onPressed: (){
                                                  takeImage(ImageSource.gallery);
                                                },
                                                icon: Icon(Icons.photo),
                                              ),
                                            ),
                                        ],
                                      ),

                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(alignment: Alignment.bottomLeft,
                  child: Text('Blog Titile', textAlign: TextAlign.left,)),
              titleField,
              SizedBox(height: 2,),
              Align(alignment: Alignment.bottomLeft,
                  child: Text('Text Here', textAlign: TextAlign.left,)),
              textField,
              SizedBox(height: height*.02,),
              button('Create', Color(0xff0D638A), Colors.white, siz,
                  onPressed: () {
                    print('before blog title  ${blogEditingController}');
                    print('before blog title  ${titleEditingController}');
                    if (_formKey.currentState!.validate()) {
                      createBlog(titleEditingController: titleEditingController, blogEditingController: blogEditingController);
                      print('blog title  ${blogEditingController}');
                      print('blog title  ${titleEditingController}');
                    }
                  }),
              SizedBox(height: height*.02,),
              button('Cancle', Colors.white, Colors.black, siz,
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homePage()));
                  }
                  ),
            ],
          ),
        ),
      ),
    );
  }
  // uploadImage() async {
  //   final _storage = FirebaseStorage.instance;
  //   final _picker = ImagePicker();
  //   PickedFile image;
  //
  //
  //   //Check Permissions
  //   await Permission.photos.request();
  //
  //   var permissionStatus = await Permission.photos.status;
  //
  //   if (permissionStatus.isGranted) {
  //     //Select Image
  //     image = (await _picker.getImage(source: ImageSource.gallery))!;
  //     var file = File(image.path);
  //
  //     if (image != null) {
  //       //Upload to Firebase
  //       var snapshot = await _storage.ref()
  //           .child('folderName/imageName')
  //           .putFile(file);
  //
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //       setState(() {
  //         imageUrl = downloadUrl;
  //       });
  //     } else {
  //       print('No Path Received');
  //     }
  //   } else {
  //     print('Grant Permissions and try again');
  //   }
  // }
  Widget buildDashedBorder({required Widget child}) => DottedBorder(
        color: Color(0xff0D638A),
        strokeWidth: 1,
        child: child,
        borderType: BorderType.RRect,
        dashPattern: const [8, 8],
        radius: Radius.circular(10),
      );
  void takeImage(ImageSource source) async {
//    PickedFile? _imageFile;
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imagePick = pickedImage;
      });
    }
  }
  Future createBlog(
      {required TextEditingController titleEditingController,
        required TextEditingController blogEditingController}) async {
    //Reference to ocument
    await uploadImage(
      imageName: imagePick!.name,
      imagePath: imagePick!.path,
    );
    // print('block Image.....${blockImage}');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? blog = _auth.currentUser;
    blogModel model= blogModel(bid:'',title: '', desc: '', image: '');
    model.bid=blog!.uid;
    model.title=titleEditingController.text;
    model.desc=blogEditingController.text;
    model.image=firebaseImagePath;

    await firebaseFirestore
        .collection('blogs')
        .doc(blog.uid)
        .set(model.toMap());
    Fluttertoast.showToast(msg: "Blog created successfully :) ");
   // FirebaseFirestore.instance.collection('users').doc('blogs').set({
      // 'title': titleEditingController.text,
      // 'blogText': blogEditingController.text,
      // 'imageUrl': firebaseImagePath,
   // });
   // Fluttertoast.showToast(msg: "Blog created successfully :) ");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>blogs(title: titleEditingController.text, desc: blogEditingController.text, image: firebaseImagePath,)));
  }
  Future uploadImage(
      {required String imageName, required String imagePath}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final refrence = storage.ref().child('Images').child(imageName);

    UploadTask uploadTask = refrence.putFile(File(imagePath));

    // print('user image url ======== ${uploadTask.storage.bucket}');
    final tasksnapshot = await uploadTask.whenComplete(() async {
      final imageurl = await storage
          .ref()
          .child('Images')
          .child(imageName)
          .getDownloadURL();

      // print('image url...........$imageurl');

      // return imageurl;
      firebaseImagePath = imageurl;
    });
}
}