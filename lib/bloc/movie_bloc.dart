import 'package:moviez/events/add_movie.dart';
import 'package:moviez/events/delete_movie.dart';
import 'package:moviez/events/movie_event.dart';
import 'package:moviez/events/set_movies.dart';
import 'package:moviez/events/update_movie.dart';
import 'package:moviez/model/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviez/model/movie_list.dart';

class MovieBloc extends Bloc<MovieEvent, List<Movie>> {
  @override
  List<Movie> get initialState => List<Movie>();

  @override
  Stream<List<Movie>> mapEventToState(MovieEvent event) async* {
    if (event is SetMovies) {
      yield event.movieList;
    } else if (event is AddMovie) {
      List<Movie> newState = List.from(state);
      if (event.newMovie != null) {
        newState.add(event.newMovie);
      }
      yield newState;
    } else if (event is DeleteMovie) {
      List<Movie> newState = List.from(state);
      newState.removeAt(event.movieIndex);
      yield newState;
    } else if (event is UpdateMovie) {
      List<Movie> newState = List.from(state);
      newState[event.movieIndex] = event.newMovie;
      yield newState;
    }
  }
}
