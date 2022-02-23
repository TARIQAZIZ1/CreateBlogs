import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/views/login_contents/login_screen.dart';
import 'package:jmmtask/controllers/utils/singin_signup_button.dart';

class SignUpForm extends StatefulWidget {

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController=TextEditingController();

  final emailController= TextEditingController();

  final passwordController=TextEditingController();


  final _auth = FirebaseAuth.instance;

  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.sp,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            //NameForm field
            Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft, child: Text('Full name')),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  validator: (value){
                    print("after in validation ${nameController.text.trim()}");
                    RegExp regex= new RegExp(r'^.{4,}$');
                    if(value!.isEmpty){
                      return ("Enter Name");
                    }
                    if(!regex.hasMatch(value)){
                      return ("Please enter name (Min. 4 character)");
                    }
                    return null;
                  },
                  onSaved: (value){
                    nameController.text = value!;
                    print("after edit $nameController");
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
                      hintText: 'John Doe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),

                ),
              ),
            ),

            //TextFormField for email
            Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft, child: Text('Email')),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: TextFormField(
                  autofocus: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Enter Email");
                    }
                    if (RegExp("'^[a-zA-Z0-9+.-]+.[a-z]").hasMatch(value)) {
                      return ("Enter a valid email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15, left: 10, bottom: 15, right: 10),
                      hintText: 'xyz@gmail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
            ),

            //TextFormField for password
            Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Password')),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: TextFormField(
                  autofocus: false,
                  controller: passwordController,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Enter password");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Please enter password (min. 6 character)");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: 15, left: 10, bottom: 15, right: 10),
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: AppColors.passIconColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(flex: 2,child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Checkbox(
                      checkColor: Colors.white,
                      value: false,
                      shape: RoundedRectangleBorder(),
                      onChanged: (value) {

                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'I Agree to the ',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: (){
                      },
                      child: Text(
                        'Terms and conditions',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),),


            //SignIn button
            Expanded(child: SingInSignUpButton(context, text: 'Create Account',
              onPressed: () => register(context, email: emailController.text, password: passwordController.text), ),),
          ],
        ),
      ),
    );
  }

   register(BuildContext context, {required String email, required String password}) async{
    print('signUp button');
    print('key ${_formkey.currentState}');
    if(_formkey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password,)
      .then((value) => {
        print('after signup'),
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInScreen())),
      })
          .catchError((e){
        Fluttertoast.showToast(
            msg: "Please fill all the required fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0
        );
      }
      );
    }
  }
}