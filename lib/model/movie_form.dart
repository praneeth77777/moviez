import 'package:moviez/bloc/movie_bloc.dart';
import 'package:moviez/db/database_provider.dart';
import 'package:moviez/events/add_movie.dart';
import 'package:moviez/events/update_movie.dart';
import 'package:moviez/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieForm extends StatefulWidget {
  final Movie movie;
  final int movieIndex;

  MovieForm({this.movie, this.movieIndex});

  @override
  State<StatefulWidget> createState() {
    return MovieFormState();
  }
}

class MovieFormState extends State<MovieForm> {
  String _moviename;
  String _director;
  bool _isVegan = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _moviename,
      decoration: InputDecoration(labelText: 'MovieName'),
      maxLength: 30,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'MovieName is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _moviename = value;
      },
    );
  }

  Widget _builddirector() {
    return TextFormField(
      initialValue: _director,
      decoration: InputDecoration(labelText: 'Director'),
      maxLength: 30,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'DirectorName is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _director = value;
      },
    );
  }

  Widget _buildIsVegan() {
    return SwitchListTile(
      title: Text("IMDB TOP RATED?", style: TextStyle(fontSize: 20)),
      value: _isVegan,
      onChanged: (bool newValue) => setState(() {
        _isVegan = newValue;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      _moviename = widget.movie.moviename;
      _director = widget.movie.director;
      _isVegan = widget.movie.isVegan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Form"),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _builddirector(),
              SizedBox(height: 16),
              _buildIsVegan(),
              SizedBox(height: 20),
              widget.movie == null
                  ? RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();

                        Movie movie = Movie(
                          moviename: _moviename,
                          director: _director,
                          isVegan: _isVegan,
                        );

                        DatabaseProvider.db.insert(movie).then(
                              (storedMovie) =>
                                  BlocProvider.of<MovieBloc>(context).add(
                                AddMovie(storedMovie),
                              ),
                            );

                        Navigator.pop(context);
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              print("form");
                              return;
                            }

                            _formKey.currentState.save();

                            Movie movie = Movie(
                              moviename: _moviename,
                              director: _director,
                              isVegan: _isVegan,
                            );

                            DatabaseProvider.db.update(widget.movie).then(
                                  (storedMovie) =>
                                      BlocProvider.of<MovieBloc>(context).add(
                                    UpdateMovie(widget.movieIndex, movie),
                                  ),
                                );

                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
