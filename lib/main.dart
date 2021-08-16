import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviez/screens/home.dart';
import 'package:moviez/screens/login.dart';
import 'package:moviez/screens/reg.dart';
import 'package:moviez/model/movie_list.dart';
import 'package:moviez/model/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviez/bloc/movie_bloc.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => MovieBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "home",
        routes: {
          "home": (content) => MyHome(),
          "reg": (content) => MyReg(),
          "login": (content) => MyLogin(),
          "movie_list": (content) => MovieList(),
        },
      ),
    );
  }
}
