import 'package:moviez/db/database_provider.dart';
import 'package:moviez/events/delete_movie.dart';
import 'package:moviez/events/set_movies.dart';
import 'package:moviez/model/movie_form.dart';
import 'package:moviez/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviez/bloc/movie_bloc.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key key}) : super(key: key);

  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getMovies().then(
          (movieList) => BlocProvider.of<MovieBloc>(context).add(
            SetMovies(movieList),
          ),
        );
  }

  showMovieDialog(BuildContext context, Movie movie, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(movie.moviename),
        content: Text("ID ${movie.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieForm(movie: movie, movieIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(movie.id).then((index) {
              BlocProvider.of<MovieBloc>(context).add(
                DeleteMovie(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire movie list scaffold");
    return Scaffold(
      appBar: AppBar(
        title: Text("Movielist"),
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey,
        child: BlocConsumer<MovieBloc, List<Movie>>(
          builder: (context, movieList) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print("movieList: $movieList");

                Movie movie = movieList[index];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title:
                        Text(movie.moviename, style: TextStyle(fontSize: 26)),
                    subtitle: Text(
                      "DIRECTOR: ${movie.director}\nIMDB TOP RATED: ${movie.isVegan}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => showMovieDialog(context, movie, index),
                  ),
                );
              },
              itemCount: movieList.length,
            );
          },
          listener: (BuildContext context, movieList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red[700],
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MovieForm()),
        ),
      ),
    );
  }
}
