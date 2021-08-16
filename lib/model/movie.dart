import 'package:moviez/db/database_provider.dart';

class Movie {
  int id;
  String moviename;
  String director;
  bool isVegan;

  Movie({this.id, this.moviename, this.director, this.isVegan});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_MOVIENAME: moviename,
      DatabaseProvider.COLUMN_DIRECTOR: director,
      DatabaseProvider.COLUMN_IMDB: isVegan ? 1 : 0
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Movie.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    moviename = map[DatabaseProvider.COLUMN_MOVIENAME];
    director = map[DatabaseProvider.COLUMN_DIRECTOR];
    isVegan = map[DatabaseProvider.COLUMN_IMDB] == 1;
  }
}
