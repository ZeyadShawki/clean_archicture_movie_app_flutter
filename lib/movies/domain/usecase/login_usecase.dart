import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_arch/core/error/failure.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class LoginUseCase{
  final BaseMovieRepostery _baseMovieRepostery;

  LoginUseCase(this._baseMovieRepostery);

  Future<String> execute(String email,String password)async{
    return await _baseMovieRepostery.loginUser(email, password);
  }

}