import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';

class RecommendedMovieModel extends RecommendedMovie {
  RecommendedMovieModel(
      {required super.overview,
      required super.title,
      required super.id,
      required super.backdropPath,
        required super.posterPath,
      });

  factory RecommendedMovieModel.fromJson(Map<String,dynamic>json)=>
      RecommendedMovieModel(
          overview: json['overview'],
          title: json['title'],
          id: json['id'],
          backdropPath: json['backdrop_path'],
          posterPath: json['poster_path'],
      );

}
