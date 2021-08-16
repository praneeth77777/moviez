import 'package:flutter/material.dart';
import 'package:moviez/screens/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviez/bloc/movie_bloc.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text(
          'Home ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Material(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                elevation: 15,
                child: MaterialButton(
                  child: Text(
                    'Registration',
                    style: TextStyle(fontSize: 20, color: Colors.red[700]),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "reg");
                  },
                  height: 60,
                  minWidth: 200,
                ),
              ),
            ),
            Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              elevation: 15,
              child: MaterialButton(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.red[700]),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "login");
                },
                height: 60,
                minWidth: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
