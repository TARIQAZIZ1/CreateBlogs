import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmmtask/screens/homePage.dart';
import 'package:jmmtask/widgets/buttons.dart';
import 'package:jmmtask/widgets/fields.dart';

class logIn extends StatefulWidget {
  const logIn({Key? key}) : super(key: key);

  @override
  _logInState createState() => _logInState();
}

class _logInState extends State<logIn> {
  var email;
  var password;
  bool _showpassword= false;
  final _key=GlobalKey<FormState>();
  final TextEditingController eController=new TextEditingController();
  final TextEditingController pController= new TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final emailField= TextFormField(
      autofocus: false,
      controller: eController,
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
        eController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final passField= TextFormField(
      autofocus: false,
      controller: pController,
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
        pController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),

    );
    var siz=MediaQuery.of(context).size;
    var space=SizedBox(
      height: siz.height*.02,
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(21),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      margin: EdgeInsets.only(bottom: 7),
                                      height: siz.height*.03,
                                      width: siz.width*.04,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: siz.width*.15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: siz.width*.055,
                              fontWeight: FontWeight.bold,
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
                                'Email',
                                textAlign: TextAlign.left,
                              ),
                          ),
                      ),
                      Expanded(child: emailField),
                      Expanded(
                          child: Align(alignment: Alignment.bottomLeft,child: Text('Password')),
                      ),
                      Expanded(child: passField),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: (){},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: siz.width*.04,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff0D638A),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: login(context)),
                      Expanded(
                        child: Row(children: <Widget>[
                          Expanded(child: Divider(thickness: 1,)),
                          Expanded(child: Text("OR",textAlign: TextAlign.center,)),
                          Expanded(child: Divider(thickness: 1,)),
                        ]),
                      ),
                      Expanded(child: button('Continue with google', Colors.white,Color(0xff0D638A),siz),),
                      space,
                      Expanded(child: button('Continoe with facebook', Colors.white, Color(0xff0D638A),siz)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Don\'t have an account?',
                                    style: TextStyle(
                                      fontSize: siz.width*.035,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TextButton(
                                      onPressed: (){
                                        Navigator.pushNamed(context, '/signUp');
                                      },
                                      child: Text(
                                        'Create account',
                                        style: TextStyle(
                                          fontSize: siz.width*.04,
                                          color: Color(0xff0D638A),
                                        ),
                                      ),
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
              ),
          ),
        ),
      ),
    );
  }
  Widget login(context){
    Size size=MediaQuery.of(context).size;
    return Material(
      elevation: 5,
      color: Color(0xff0D638A),
      borderRadius: BorderRadius.circular(15),
      child: MaterialButton(
        padding: EdgeInsets.only(top: 15,left: 10,bottom:15,right: 10),
        minWidth: size.width,
        onPressed: (){
          loginfun(eController.text, pController.text);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>dashboard()));
        },
        child: Text(
          "SignIn",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
  void loginfun(String email, String password) async{
    if(_key.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homePage())
        )
      }).catchError((e)
      {
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
