import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviez/bloc/movie_bloc.dart';

class MyLogin extends StatefulWidget {
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var authc = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Center(
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
                    setState(() {
                      spinner = true;
                    });
                    try {
                      var userin = await authc.signInWithEmailAndPassword(
                          email: email, password: password);
                      print(userin);
                      if (userin != null) {
                        Navigator.pushNamed(context, "movie_list");
                        setState(() {
                          spinner = false;
                        });
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
      ),
    );
  }
}
