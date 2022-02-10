import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:jmmtask/Model/model.dart';
import 'package:jmmtask/screens/logIn_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  var email;
  var password;
  final _auth = FirebaseAuth.instance;
  final _formkey=GlobalKey<FormState>();
  final nameEditingController=new TextEditingController();
  final emailEditingController=new TextEditingController();
  final passEditingController=new TextEditingController();
  bool _ischecked= false;
  bool _showpassword=false;
  //final _firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final nameField= TextFormField(
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],
      validator: (value){
        print("after in validation $nameEditingController");
        RegExp regex= new RegExp(r'^.{4,}$');
        if(value!.isEmpty){
          return ("Enter Name");
        }
        if(!regex.hasMatch(value)){
          return ("Please enter name (Min. 4 character)");
        }
      },
      onSaved: (value){
        nameEditingController.text = value!;
        print("after edit $nameEditingController");
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
          hintText: 'Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),

    );
    final emailField= TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return ("Enter Email");
        }
        if(RegExp("'^[a-zA-Z0-9+.-]+.[a-z]").hasMatch(value)) {
          return ("Enter a valid email");
        }
        return null;
      },
      onSaved: (value){
        emailEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),

    );
    final passField= TextFormField(
      autofocus: false,
      controller: passEditingController,
      obscureText: true,
      validator: (value){
        RegExp regex= new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return ("Enter password");
        }
        if(!regex.hasMatch(value)){
          return ("Please enter password (min. 6 character)");
        }
      },
      onSaved: (value){
        passEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),

    );
    var siz= MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child:
                  Container(
                    height: siz.height*.9,
                    padding: EdgeInsets.all(21),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Align(
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 7),
                                          height: siz.height*.020,
                                          width: siz.width*.030,
                                          decoration: BoxDecoration(
                                            color: Color(0xff0D638A),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'blog',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: siz.width*.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Create Account',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: siz.width*.07,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Enter your credentials to login ',
                              ),
                            ),
                          ),
                          Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Name',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                          ),
                          Expanded(child: nameField),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('Email',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Expanded(child: emailField),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('Password')),
                          ),
                          Expanded(child: passField),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      checkColor: Colors.white,
                                      value: _ischecked,
                                      shape: RoundedRectangleBorder(),
                                      onChanged: (value) {
                                        setState(() {
                                          _ischecked = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'I Agree to the ',
                                      style: TextStyle(
                                        fontSize: siz.width*.035,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: (){
                                      },
                                      child: Text(
                                        'Terms and conditions',
                                        style: TextStyle(
                                          fontSize: siz.width*.035,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff0D638A),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Material(
                              elevation: 5,
                              color: Color(0xff0D638A),
                              borderRadius: BorderRadius.circular(15),
                              child: MaterialButton(
                                padding: EdgeInsets.only(
                                    top: 3, bottom: 3),
                                minWidth: siz.width,
                                onPressed: () {
                                  register(emailEditingController.text, passEditingController.text);
                                },
                                child: Text(
                                  "Create Account",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('Already have an account?',
                                        style: TextStyle(
                                          fontSize: siz.width*.04,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        child: Text(
                                          'Log in',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: siz.width*.045,
                                            color: Color(0xff0D638A),
                                          ),
                                        ),
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/logIn');
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            ),
          ),
      ),
    );
  }
  void register(String email, String password) async{
    if(_formkey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password,)
          .then((value) => {
        storeDetails(),
      }).catchError((e){
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
  storeDetails() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel usermodel=UserModel(email: '', uid: '', name: '', password: '');
    usermodel.uid=user!.uid;
    usermodel.email=user.email!;
    usermodel.name= nameEditingController.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>logIn()));
  }
}