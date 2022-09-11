import 'package:dio/dio.dart';
import 'package:movies_app_clean_arch/core/error/server_exception.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/core/network/error_message_model.dart';
import 'package:movies_app_clean_arch/movies/data/models/movie_detail_model.dart';
import 'package:movies_app_clean_arch/movies/data/models/movie_model.dart';
import 'package:movies_app_clean_arch/movies/data/models/recommended_movie_model.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';

import '../../domain/entities/movie_details.dart';
abstract class BaseMovieRemoteDataSource{
  Future<List<Movie>> getNowPlayingMovie();
  Future<List<Movie>> getPopularMovie();
  Future<List<Movie>> getTopRatedMovie();
  Future<MovieDetails> getMovieDetails(int id);
  Future<List<RecommendedMovie>> getRecommendedMovie(int id);
  Future<List<Movie>> searchForMovie(String query);
}





class MovieRemoteDataSource extends BaseMovieRemoteDataSource{

   @override
  Future<List<MovieModel>> getNowPlayingMovie()async{
    final response=await Dio().get(ApiConstants.getNowPlayingUrl);
    if(response.statusCode==200)
    {
      return List<MovieModel>.from(
          (response.data['results'] as List).map((e) =>
              MovieModel.fromJson(e)));
    }else
     {
       throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
     }
      

  }

  @override
  Future<List<MovieModel>> getPopularMovie() async{
    final response=await Dio().get(ApiConstants.getPopularUrl);
    if(response.statusCode==200)
    {
      return List<MovieModel>.from(
          (response.data['results'] as List).map((e) =>
              MovieModel.fromJson(e)));
    }else
    {
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie()async {
    final response=await Dio().get(ApiConstants.getTopRatedUrl);
    if(response.statusCode==200)
    {
      return List<MovieModel>.from(
          (response.data['results'] as List).map((e) =>
              MovieModel.fromJson(e)));
    }else
    {
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int id)async {
    final response=await  Dio().get(ApiConstants().movieDetailsPathMaker(id));
    if(response.statusCode==200)
     {
       return MovieDetailsModel.fromJson(response.data);
     }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
    
  }

  @override
  Future<List<RecommendedMovieModel>> getRecommendedMovie(int id)async {
    final response=await Dio().get(ApiConstants().movieRecemondationPathMaker(id));
    if(response.statusCode==200)
      {
        return  List<RecommendedMovieModel>.from((response.data['results'] as List).map((e) => RecommendedMovieModel.fromJson(e)));
      }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }

  }

  @override
  Future<List<MovieModel>> searchForMovie(String query) async{
  final response=await Dio().get(ApiConstants().searchForQueryPathMaker(query));
   
  if(response.statusCode==200)
    return List<MovieModel>.from((response.data['results'] as List).map((e) => MovieModel.fromJson(e)));
  else
    throw ServerException(errorMessageModel:ErrorMessageModel.fromJson(response.data));
  
  }
  
  
}