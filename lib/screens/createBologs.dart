import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class uploadImage extends StatefulWidget {
  @override
  _uploadImageState createState() => _uploadImageState();
}

class _uploadImageState extends State<uploadImage> {
  String imageUrl='';
  String blogTitle='';
  String imgDscrptn='';
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff0D638A),style: BorderStyle.solid),

                    ),
                    child: IconButton(
                      icon: Icon(Icons.upload_rounded),
                      onPressed: (){
                        (imageUrl != null)
                            ? Image.network(imageUrl)
                            : Placeholder(fallbackHeight: 200.0,fallbackWidth: double.infinity);
                      },
                    ),
                  ),
                  onTap: (){
                    (imageUrl != null)
                        ? Image.network(imageUrl)
                        : Placeholder(fallbackHeight: 200.0,fallbackWidth: double.infinity);
                  },
                ),
              ),
              // Expanded(
              //   child: InkWell(
              //     onTap: () => uploadImage(),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Color(0xff0D638A),
              //       ),
              //       child: Text('Upload Image'),
              //     ),
              //   ),
              // ),
              SizedBox(height: 2,),
              Expanded(child: Align(alignment: Alignment.bottomLeft,child: Text('Blog Titile',textAlign: TextAlign.left,))),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Add your title',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black,width: 3,style: BorderStyle.solid),
                    ),
                  ),
                  onChanged: (value){
                    blogTitle=value;},
                ),
              ),
              SizedBox(height: 2,),
              Expanded(child: Align(alignment:Alignment.bottomLeft,child: Text('Text Here',textAlign: TextAlign.left,))),
              Expanded(
                child: Container(
                  height: height*2,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Type Here',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black,width: 3,style: BorderStyle.solid),
                      ),
                    ),
                    onChanged: (value){
                      imgDscrptn=value;
                    },
                  ),
                ),
              ),
              Expanded(
                child: button(
                  'Create',
                  Color(0xff0D638A),
                  Colors.white,
                  height,
                  onPressed: (){
                    return uploadImage();
                  }
                ),
              ),
              Expanded(child: button('Cancle', Colors.white, Colors.black, height)),
            ],
          ),
        ),
      ),
    );
  }
  Widget button(String text, Color color, Color textColor, double height, {onPressed}){
    return InkWell(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Color(0xff0D638A),width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
      onTap: (){onPressed();},
    );
  }
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = (await _picker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('folderName/imageName')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}