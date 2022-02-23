import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/controllers/page_index_cubit.dart';

import 'package:jmmtask/controllers/utils/singin_signup_button.dart';
import 'package:jmmtask/views/signup_contents/signup_screen.dart';

import '../../myblogs_screen.dart';

class LogInForm extends StatefulWidget {

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print('rebuilding');
    return BlocProvider(
      create: (context) => PageIndexCubit(true),
      child: Container(
        height: 300.sp,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _key,
          child: Column(
            children: [
              //TextFormField for email
              Expanded(
                child: Align(
                    alignment: Alignment.bottomLeft, child: Text('Email')),
              ),
              Expanded(
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

              //TextFormField for password
              Expanded(
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('Password')),
              ),
              Expanded(
                child: BlocBuilder<PageIndexCubit, bool>(
                  builder: (context, state) {
                    return TextFormField(
                      obscureText: state,
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
                        suffix: InkWell(
                          onTap: (){
                            context.read<PageIndexCubit>().setBool(isHidden: true);
                          },
                          child: Icon(
                                state
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                                color: state ? AppColors.passIconColor: AppColors.mainColor,
                          ),
                        ),

                      ),
                    );
                  },
                ),
              ),

              //Textbutton for user who forgot password
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.mainColor),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox(height: 20,)),

              //SignIn button
              Expanded(child: SingInSignUpButton(context, text: 'SignIn',
                onPressed: () =>
                    loginfun(context, email: emailController.text,
                        password: passwordController.text),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginfun(context, {required String email, required String password}) async {
    if (_key.currentState!.validate()) {
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
            fontSize: 15.0
        );
      });
    }
  }
}