import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/controllers/utils/singin_signup_button.dart';
import 'package:jmmtask/views/login_contents/login_widgets/social_auth_button.dart';
import 'package:jmmtask/views/signup_contents/signup_screen.dart';
import '../blogs_contents/myblogs_screen.dart';
import '../../controllers/utils/text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  final _auth = FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    //GoogleSignInAccount? user= _googleSignIn.currentUser;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffFFFFFFFF),
          body: Form(
            key: _formKey,
            child: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
            //Header Corner
            Stack(
              children: [
                Container(
                  height: 130.sp,
                ),
                Positioned(
                  top: -90,
                  left: 200,
                  right: -140.sp,
                  child: Container(
                    height: 220.sp,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            //Header Image
            Container(
              height: 100.sp,
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Image.asset('assets/Login1.png'),),),
            //header text
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                'Login',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text('Enter your credentials to login'),
            ),
            SizedBox(height: 10.sp,),
            //Form fields
            Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 5.0,left: 30, right: 30),
              child: Text('Email'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFields(
                textController: emailController,
                hintText: 'xyz@gamil.com',
                showPassIcon: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 5,left: 30,right: 30),
              child: Text('Password',),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFields(
                textController: passwordController,
                hintText: '************',
                showPassIcon: true,
              ),
            ),
            // Container(
            //   height: 190.sp,
            //   margin: const EdgeInsets.only(left: 30, right: 30),
            //   child: Form(
            //     key: _formKey,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(
            //           flex: 3,
            //           child: Align(
            //             alignment: Alignment.bottomLeft,
            //             child: Text('Email'),),),
            //         Expanded(
            //           flex: 4,
            //           child: Align(
            //             alignment: Alignment.bottomCenter,
            //             child: TextFields(
            //               textController: emailController,
            //               hintText: 'xyz@gamil.com',
            //               passIcon: false,
            //             ),
            //           ),),
            //         Expanded(
            //           flex: 3,
            //           child: Align(
            //             alignment: Alignment.bottomLeft,
            //             child: Text('Password',),),),
            //         Expanded(
            //           flex: 4,
            //           child: Align(
            //             alignment: Alignment.bottomCenter,
            //             child: TextFields(
            //               textController: passwordController,
            //               hintText: '************',
            //               passIcon: true,
            //             ),
            //           ),),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 10.sp,),
            //Forgot password Option
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Forgot password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                            fontSize: 15.sp,
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
            SizedBox(height: 25.sp,),
            // Log in button
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SingInSignUpButton(context, text: 'SignIn',
                onPressed: () =>
                    loginfun(context, email: emailController.text,
                        password: passwordController.text),
              ),
            ),
            SizedBox(height: 15.sp,),

            //divider between form and social auth buttons
            divider(),
            SizedBox(height: 15.sp,),

            //social auth button for google
            SocailAuthButton(text: 'Continue with google',onPressed: () => googleLogin(),),
            SizedBox(height: 15.sp,),

            //social auth button for facebook
            SocailAuthButton(text: 'Continue with facebook', onPressed: () => facebookLogin(),),
            SizedBox(height: 40.sp,),

            //RichText for user who don't have account will be redirected to SignUp page
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style:
                    TextStyle(color: Colors.black, fontSize: 14.sp,),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Create account',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainColor,
                          fontSize: 14.sp,),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignupPage(),),);
                          },),
                  ]),
            ),
            SizedBox(height: 30,),
        ],
      ),
          )),
    );
  }
  //divider funtion
  Row divider() {
    return Row(children: <Widget>[
          Expanded(
            flex: 3,
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          Expanded(
              child: Text(
                "OR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.dividerColor,
                ),
          ),),
          Expanded(
            flex: 3,
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
        ]);
  }
  facebookLogin() async{
    print('my name is tariq');
    await FacebookAuth.i.login(
        permissions: ["public_profile", "email"]
    ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBlogs())))
        .catchError((e)
    {
      Fluttertoast.showToast(msg: 'No user selected');
    }
    );
  }
  googleLogin()  async{
    await _googleSignIn.signIn().then((value) =>
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBlogs()))
    ).catchError((e){
      Fluttertoast.showToast(msg: 'No user selected');
    });
  }
  loginfun(context, {required String email, required String password}) async {
    if (_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyBlogs())
        )
      }).catchError((e) {
        Fluttertoast.showToast(
            msg: "Incorrect Password or Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
        );
      });
    }
  }

}

