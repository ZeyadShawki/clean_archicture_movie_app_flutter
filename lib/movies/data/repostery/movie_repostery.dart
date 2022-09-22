import 'dart:io';

import 'package:movies_app_clean_arch/core/error/failure.dart';
import 'package:movies_app_clean_arch/core/error/server_exception.dart';
import 'package:movies_app_clean_arch/movies/data/models/user_model.dart';
import 'package:movies_app_clean_arch/movies/data/remote_data_source/remote_data_source_movie.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';
import 'package:dartz/dartz.dart';

import '../../../core/network/network_info.dart';
class MovieRepostery extends BaseMovieRepostery{
  final BaseMovieRemoteDataSource remoteDataSource;
  final NetworkInfo _networkInfo;
  MovieRepostery(this.remoteDataSource,this._networkInfo);

  @override
  Future<Either<Failure,List<Movie>>> getNowPlayingMovies()async {
    final result=await remoteDataSource.getNowPlayingMovie();
    if(await _networkInfo.isConnected) {
      try {
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(failure.errorMessageModel.message));
      }
    }else {
      return const Left(ServerFailure('No Internet connection'));
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

  @override
  Future<Either<Failure, String>> loginUser(String email, String password)async {
    final result= await remoteDataSource.loginUser(email, password);
    try
        {
          return Right(result);
        }on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, String>> signIn(UserModel user)async {
    final result = await remoteDataSource.register(user);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<UserModel> getUser(String uid)async {
    final result= await remoteDataSource.getUser(uid);
    try{
      return result;
    } catch(e){
      return Future.error(e.toString());
    }
  }

  @override
  Future<String> uploadFile(File file) async{
    final resualt=await remoteDataSource.uploadFile(file);
    try{
      return resualt;
    }catch (e){
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> setWatchListIndex(List<int> index, String uid)async {
    try{
      await remoteDataSource.setWatchListIndex(index, uid);
    }catch(e){
      return Future.error(e.toString());
    }
  }

  @override
  Future<List> getWatchListId(String uid) async{
   try{
   final response= await remoteDataSource.getWatchListId(uid);
   return response;
   }catch (e){
     return Future.error(e.toString());
   }

  }

  @override
  Future<void> removeMovieFromWatchList(String uid, int value)async {
   try{

   }catch (e){
     return Future.error(e.toString());
   }
  }

}