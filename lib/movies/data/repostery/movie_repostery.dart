import 'package:movies_app_clean_arch/core/error/failure.dart';
import 'package:movies_app_clean_arch/core/error/server_exception.dart';
import 'package:movies_app_clean_arch/movies/data/remote_data_source/remote_data_source_movie.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';
import 'package:dartz/dartz.dart';
class MovieRepostery extends BaseMovieRepostery{
  final BaseMovieRemoteDataSource remoteDataSource;
  MovieRepostery(this.remoteDataSource);

  @override
  Future<Either<Failure,List<Movie>>> getNowPlayingMovies()async {
    final result=await remoteDataSource.getNowPlayingMovie();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getPopularMovies()async {
    final result=await remoteDataSource.getPopularMovie();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getTopRatedMovies()async {
    final result=await remoteDataSource.getTopRatedMovie();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int id)async {
    final result=await remoteDataSource.getMovieDetails(id);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }

  }

  @override
  Future<Either<Failure, List<RecommendedMovie>>> getMovieRecommondation(int id)async {
    final result=await remoteDataSource.getRecommendedMovie(id);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }

  }

  @override
  Future<Either<Failure, List<Movie>>> searchForMovie(String query)async {
   final result=await remoteDataSource.searchForMovie(query);
   try{
     return Right(result);
   }on ServerException catch(e){
     return Left(ServerFailure(e.errorMessageModel.message));
   }


  }

}