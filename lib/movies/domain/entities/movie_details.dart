import 'package:equatable/equatable.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/genre.dart';

class MovieDetails extends Equatable{

  final String backDropPath;
  final int id;
  final String title;
  final String overview;
  final num voteAverage;
  final String releaseDate;
  final List<Genre> genre;
  final int runtime;

const MovieDetails
      ({
    required this.backDropPath,
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.genre,
    required this.runtime,
  });

  List<Object> get props =>
      [runtime,backDropPath, id, title, overview, voteAverage, releaseDate, genre,];

}