import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                height: height*.1,
                child: Row(
                children: [
                  Expanded(
                    flex:3,
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "My Blogs",
                          style: TextStyle(
                            fontSize: width*.08,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 4),
                        height: height*.02,
                        width: width*.02,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff474747),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "blog",
                        style: TextStyle(
                          color: Color(0xff0D638A),
                          fontWeight: FontWeight.bold,
                          fontSize: width*.08,
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
              Text("Create the blog you want"),
              Container(
                margin: EdgeInsets.only(
                  top: 180,
                ),
                height: height*.06,
                child: Column(
                  children: [
                    Expanded(child: Text('You don\'t have any blogs')),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          'Lets Create a Blog',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: (){},
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
                  color: Colors.indigo, width: 3)),

          child: Icon(
            Icons.add,
            color: Colors.indigo,
            size: 40,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.indigo,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
              size: 30,
              color: Colors.white,),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.search,size: 30,),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.person_rounded,
                size: 30,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
