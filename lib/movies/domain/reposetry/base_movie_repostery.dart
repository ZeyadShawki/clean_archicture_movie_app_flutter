import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_arch/movies/data/models/recommended_movie_model.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';

import '../../../core/error/failure.dart';

abstract class BaseMovieRepostery{
  Future<Either<Failure,List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure,List<Movie>>> getPopularMovies();
  Future<Either<Failure,List<Movie>>> getTopRatedMovies();
  Future<Either<Failure,MovieDetails>> getMovieDetails(int id);
  Future<Either<Failure,List<RecommendedMovie>>> getMovieRecommondation(int id);
  Future<Either<Failure,List<Movie>>> searchForMovie(String query);
}