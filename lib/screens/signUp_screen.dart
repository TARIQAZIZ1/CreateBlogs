import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  var _email;
  var _password;
  var _Full_Name;
  bool _ischecked= false;
  bool _showpassword=false;
  final _firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var siz= MediaQuery.of(context).size;
    var space = SizedBox(
      height: siz.height*.03,
    );
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              children: [
                Container(
                  child: Row(
                     children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            height: siz.height*.028,
                            width: siz.width*.035,
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
                SizedBox(height: siz.height*.04),
                Text(
                  'Create Account',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: siz.width*.07,
                  ),
                ),
                Text(
                  'Enter your credentials to login ',
                ),
                space,
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Email',
                    textAlign: TextAlign.left,
                  ),
                ),
                Field(_Full_Name, 'John Doe'),
                space,
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Email',
                    textAlign: TextAlign.left,
                  ),
                ),
                Field(_email, 'xyz@gmail.com'),
                space,
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Password'),
                ),
                Field(_password, 'Enter Password',icon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this._showpassword ? Colors.blue : Colors.grey,
                  ),
                  onPressed: (){
                    setState(() {
                      this._showpassword=!this._showpassword;
                    });
                  },
                )),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomLeft,
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
                      flex: 4,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'I Agree to the ',
                          style: TextStyle(
                            fontSize: siz.width*.035,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Align(
                        alignment: Alignment.bottomLeft,
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
                space,
                InkWell(
                  child:Container(
                    height: siz.height*.05,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff0D638A),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Color(0xff0D638A)),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "sign up",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap:(){
                 Future: Firebase.initializeApp();
                    FirebaseAuth.instance.createUserWithEmailAndPassword
                      (email:_email,
                        password: _password)
                        .then((signedInUser)
                    {
                      _firestore.collection('users')
                          .add({
                        'email':_email,'pass':_password,
                      })
                          .then((value)
                      {
                        if(signedInUser!=null){
                          Navigator.pushNamed(context,'/homepage');
                        }
                      })
                          .catchError((e){
                        print(e);
                      });
                    });
                  },
                ),
                space,
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Allready have an account?',
                            style: TextStyle(
                              fontSize: siz.width*.04,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
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
                              Navigator.pushNamed(context, '/signUp');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
  Widget Field(purpose, labletext,{IconButton? icon}){
    return TextField(
      obscureText: !this._showpassword,
      decoration: InputDecoration(
        suffixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black,width: 3,style: BorderStyle.solid),
        ),
        hintText: labletext,
      ),
      onChanged: (value) {
        purpose = value;
      },
    );
  }
}