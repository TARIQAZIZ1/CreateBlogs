import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class logIn extends StatefulWidget {
  const logIn({Key? key}) : super(key: key);

  @override
  _logInState createState() => _logInState();
}

class _logInState extends State<logIn> {
  var _email;
  var _password;
  bool _showpassword= false;
  @override
  Widget build(BuildContext context) {
    var siz=MediaQuery.of(context).size;
    var space=SizedBox(
      height: siz.height*.02,
    );
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 35),
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
            SizedBox(height: siz.height*.09),
            Text(
              'Login',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: siz.width*.055,
                fontWeight: FontWeight.bold,
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
            Field(_email, 'xyz@gmail.com'),
            space,
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Password'),
            ),
            Field(_password, 'Enter password',icon: IconButton(
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
            Align(
              alignment: Alignment.bottomRight,
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
            space,
          //  button('Sing In', Color(0xff0D638A), Colors.white,siz),
            FlatButton(
              minWidth: double.infinity,
              color: Color(0xff0D638A),
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((FirebaseUser) {
                  Navigator.pushNamed(context, '/homePage');
                }).catchError((e) {
                  print(e);
                });
              },
              child: Text(
                "sign in",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            space,
            Row(children: <Widget>[
              Expanded(child: Divider(thickness: 1,)),
              Expanded(child: Text("OR",textAlign: TextAlign.center,)),
              Expanded(child: Divider(thickness: 1,)),
            ]),
            space,
            button('Continue with google', Colors.white,Color(0xff0D638A),siz),
            space,
            button('Continoe with facebook', Colors.white, Color(0xff0D638A),siz),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
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
          ],
        ),
      )
      ),
    );
  }
  Widget button(String text, Color color, Color textColor, Size siz){
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 3),
        height: siz.height*.05,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Color(0xff0D638A),width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      onTap: (){},
    );
  }
  Widget Field(purpose, labletext,{IconButton? icon}){
    return TextField(
      obscureText: !this._showpassword,
      decoration: InputDecoration(
        suffixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Color(0xff0D638A),width: 3,style: BorderStyle.solid),
        ),
        hintText: labletext,
      ),
      onChanged: (value) {
        purpose = value;
      },
    );
  }
}
