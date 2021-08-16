import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyReg extends StatefulWidget {
  @override
  _MyRegState createState() => _MyRegState();
}

class _MyRegState extends State<MyReg> {
  var authc = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "register",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: Center(
          child: Container(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                  hintText: "Enter email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              elevation: 10,
              child: MaterialButton(
                minWidth: 200,
                height: 60,
                child: Text(
                  "submit",
                  style: TextStyle(color: Colors.red[700]),
                ),
                onPressed: () async {
                  try {
                    var user = await authc.createUserWithEmailAndPassword(
                        email: email, password: password);
                    //Navigator.pushNamed(context, "chat");
                    print(user);
                    if (user.additionalUserInfo.isNewUser == true) {
                      Navigator.pushNamed(context, 'movie_list');
                    } else {
                      Fluttertoast.showToast(
                          msg: "This is Center Short Toast",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
