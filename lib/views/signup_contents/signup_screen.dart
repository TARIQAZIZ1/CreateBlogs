import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/controllers/utils/singin_signup_button.dart';
import 'package:jmmtask/views/login_contents/login_screen.dart';


import '../../controllers/utils/text_form_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFFFF),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                //SignUpHeader(),
                SizedBox(
                  height: 40.sp,
                ),
                Container(
                    height: 60.sp,
                    child: Image.asset(
                      'assets/Login1.png',
                    )),
                SizedBox(
                  height: 40.sp,
                ),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Enter your credentials to login',
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45,bottom: 5.0),
                  child: Text('Full name'),
                ),
                TextFields(
                  textController: nameController,
                  hintText: 'John Doe',
                  showPassIcon: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25,bottom: 5.0),
                  child: Text('Email'),
                ),
                TextFields(
                  textController: emailController,
                  hintText: 'xyz@gamil.com',
                  showPassIcon: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25,bottom: 5),
                  child: Text('Password',),
                ),
                TextFields(
                  textController: passwordController,
                  hintText: '************',
                  showPassIcon: true,
                ),
                SizedBox(height: 10.sp,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(

                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Checkbox(
                            checkColor: AppColors.fieldColor,
                            value: false,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 13,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                    text: 'I Agree to the ',
                                    style:
                                        TextStyle(color: Colors.black, fontSize: 15.sp),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Terms and conditions',
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                              color: AppColors.mainColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.sp,),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignupPage()));
                                            }),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.sp,),
                SingInSignUpButton(
                  context,
                  text: 'Create Account',
                  onPressed: () => register(context,
                      email: emailController.text,
                      password: passwordController.text),
                ),
                SizedBox(height: 40.sp,),
                //SignUpForm(),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Already have an accout?',
                        style: TextStyle(color: Colors.black, fontSize: 15.sp),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Log in',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogInScreen()));
                                }),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 80.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  register(BuildContext context,
      {required String email, required String password}) async {
    print('signUp button');
    print('key ${_formKey.currentState}');
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {
                print('after signup'),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: "Please fill all the required fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
      });
    }
  }
}
