import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/models/blogs_model.dart';
import 'package:jmmtask/controllers/utils/singin_signup_button.dart';
import 'package:jmmtask/views/blogs_contents/myblogs_screen.dart';
import 'package:jmmtask/controllers/utils/text_form_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final _auth = FirebaseAuth.instance;
  String firebaseImagePath = '';
  XFile? imagePick;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  final titleController = new TextEditingController();
  final blogController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var placeholderImage = Image.asset('assets/empty1.jpg');
    return Scaffold(
      backgroundColor: Color(0xffFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Text(
                        'New blog',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.highlight_remove_rounded),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyBlogs()));
                        },
                      ),
                    )
                  ],
                ),
              ),
              Text('Enter the information below to create your blog'),
              SizedBox(
                height: 25.sp,
              ),
              Container(
                height: 150.sp,
                width: 1.sw,
                child: buildDashedBorder(
                  child: Center(
                    child: InkWell(
                      child: Stack(
                        children: [
                          if (imagePick == null)
                            Positioned(
                              child: Container(
                                height: 160.sp,
                                width: 160.sp,
                                child: placeholderImage,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              left: 0,
                              right: 0,
                              bottom: 0,
                            )
                          else
                            Image.file(
                              File(
                                imagePick!.path,
                              ),
                              fit: BoxFit.cover,
                            ),
                          if (imagePick == null)
                            Positioned(
                                left: 100.sp,
                                top: 50.sp,
                                right: 100.sp,
                                bottom: 50.sp,
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 400.sp,
                                          width: 400.sp,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: AlertDialog(
                                              content: Text('Upload Image'),
                                              actions: [
                                                Center(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      takeImage(ImageSource
                                                          .gallery);
                                                    },
                                                    icon: Icon(Icons.photo),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Upload header Image',
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )),
                          Positioned(
                            top: 0,
                            bottom: 50,
                            left: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.upload_rounded,
                                color: AppColors.mainColor,
                                size: 30.sp,
                              ), onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 400,
                              width: 400,
                              child: Align(
                                alignment: Alignment.center,
                                child: AlertDialog(
                                  content: Text('Upload Image'),
                                  actions: [
                                    Center(
                                      child: IconButton(
                                        onPressed: () {
                                          takeImage(ImageSource.gallery);
                                        },
                                        icon: Icon(Icons.photo),
                                      ),
                                    ),
                                  ],
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
              SizedBox(
                height: 25.sp,
              ),
              Text(
                'Blog Titile',
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5.sp,
              ),
              TextFields(
                textController: titleController,
                hintText: 'Enter title',
                showPassIcon: false,
              ),
              SizedBox(
                height: 25.sp,
              ),
              Text(
                'Text Here',
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5.sp,
              ),
              TextFields(
                textController: blogController,
                hintText: 'Type here',
                showPassIcon: false,
              ),
              SizedBox(
                height: 25.sp,
              ),
              SingInSignUpButton(context, onPressed: onPressed, text: 'Create'),
              SizedBox(
                height: 25.sp,
              ),
              Container(
                height: 40.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.rectangle,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      'Cancle',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    print('create blog');
    if (_formKey.currentState!.validate()) {
      createBlog(
          titleEditingController: titleController,
          blogEditingController: blogController);
    }
  }

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
    print('creating blogs');
    await uploadImage(
      imageName: imagePick!.name,
      imagePath: imagePick!.path,
    );
    // print('block Image.....${blockImage}');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? blog = _auth.currentUser;
    blogModel model = blogModel(bid: '', title: '', desc: '', image: '');
    model.bid = blog!.uid;
    model.title = titleEditingController.text;
    model.desc = blogEditingController.text;
    model.image = firebaseImagePath;

    await firebaseFirestore
        .collection('blogs')
        .doc(blog.uid)
        .set(model.toMap())
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyBlogs())));
    Fluttertoast.showToast(msg: "Blog created successfully :)");
  }

  Future uploadImage(
      {required String imageName, required String imagePath}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final refrence = storage.ref().child('Images').child(imageName);

    UploadTask uploadTask = refrence.putFile(File(imagePath));
    final tasksnapshot = await uploadTask.whenComplete(() async {
      final imageurl =
          await storage.ref().child('Images').child(imageName).getDownloadURL();
      firebaseImagePath = imageurl;
    });
  }
}
