import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:movies_app_clean_arch/core/error/server_exception.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/core/network/error_message_model.dart';
import 'package:movies_app_clean_arch/movies/data/models/movie_detail_model.dart';
import 'package:movies_app_clean_arch/movies/data/models/movie_model.dart';
import 'package:movies_app_clean_arch/movies/data/models/recommended_movie_model.dart';
import 'package:movies_app_clean_arch/movies/data/models/user_model.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:movies_app_clean_arch/movies/domain/entities/user.dart';
import '../../domain/entities/movie_details.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
abstract class BaseMovieRemoteDataSource {
  Future<List<Movie>> getNowPlayingMovie();
  Future<List<Movie>> getPopularMovie();
  Future<List<Movie>> getTopRatedMovie();
  Future<MovieDetails> getMovieDetails(int id);
  Future<List<RecommendedMovie>> getRecommendedMovie(int id);
  Future<List<Movie>> searchForMovie(String query);
  Future<String> loginUser(String email, String password);
  Future<String> register(UserModel user);
  Future<UserModel> getUser(String uid);
  Future<String> uploadFile(File file);
  Future<void> setWatchListIndex(List<int> index,String uid);
  Future<List<dynamic>> getWatchListId(String uid);
  Future<void> removeMovieFromWatchList(String uid,int value);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    final response = await Dio().get(ApiConstants.getNowPlayingUrl);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final response = await Dio().get(ApiConstants.getPopularUrl);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    final response = await Dio().get(ApiConstants.getTopRatedUrl);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int id) async {
    final response = await Dio().get(ApiConstants().movieDetailsPathMaker(id));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendedMovieModel>> getRecommendedMovie(int id) async {
    final response =
        await Dio().get(ApiConstants().movieRecemondationPathMaker(id));
    if (response.statusCode == 200) {
      return List<RecommendedMovieModel>.from((response.data['results'] as List)
          .map((e) => RecommendedMovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> searchForMovie(String query) async {
    final response =
        await Dio().get(ApiConstants().searchForQueryPathMaker(query));

    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<String> loginUser(String email, String password) async {
    final response=await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
       // ignore: unnecessary_null_comparison
       if(response.user!.uid!=null) {
         return response.user!.uid;
       } else {
         throw ServerException(
          errorMessageModel:
              ErrorMessageModel(message: '', statusCode: 400, success: false));
       }

  }

  @override
  Future<String> register(UserModel user)async {
    final response=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password);
   try
         {
         FirebaseFirestore.instance.collection('users').doc(response.user!.uid).set(user.toJson()).then((value) => null);
         return response.user!.uid;
    }on FirebaseAuthException{
      throw ServerException(errorMessageModel: ErrorMessageModel(message: 'error in Register',statusCode: 400,success: false));
    }

  }

  @override
  Future<UserModel> getUser(String uid)async {
   DocumentSnapshot<Map<String,dynamic>> snap= await FirebaseFirestore.instance.collection('users').doc(uid).get();
   if(snap.exists) {
     return UserModel.fromJson(snap.data());
   } else {
     return Future.error('User not exist');
   }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<String> uploadFile(File files) async{
   final response=  await  firebase_storage.FirebaseStorage.instance.ref().child('users_profile_image/${files.uri.pathSegments.last}')
        .putFile(files);
  final url = response.ref.getDownloadURL();
   // ignore: unnecessary_null_comparison
   if(url!=null) {
     return url;
   } else {
     return '';
   }
  }
  @override
  Future<void> setWatchListIndex(List<int> index,String uid)async{
    final doc = await FirebaseFirestore.instance.collection('watch_list').doc(uid).get();
    if(doc.exists)
    {
      await FirebaseFirestore.instance.
      collection('watch_list').doc(uid).update({
        'movie_index':FieldValue.arrayUnion(index),
      });
    }else{
      await FirebaseFirestore.instance.
      collection('watch_list').doc(uid).set({
        'movie_index':index,
      });
    }
  }

  @override
  Future<List<dynamic>> getWatchListId(String uid)async{
    DocumentSnapshot<Map<String,dynamic>> snap=await FirebaseFirestore.instance.collection('watch_list').doc(uid).get();
    if(snap.exists){
      final map=snap.data();
      List<dynamic> movieIndex= map!['movie_index'];
      return movieIndex;
    }else{
      return Future.error('no data');
    }
  }

  @override
  Future<void> removeMovieFromWatchList(String uid,int value)async{
    final snap=await FirebaseFirestore.instance.collection('watch_list').doc(uid).get();
    if(snap.exists){
      await FirebaseFirestore.instance.collection('watch_list').doc(uid).update({
        'movie_index':FieldValue.arrayRemove([value])
      });
    }else{
      Future.error('no list exists');
    }
  }

}
