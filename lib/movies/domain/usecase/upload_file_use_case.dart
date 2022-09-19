import 'dart:io';

import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class UploadFileUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  UploadFileUseCase(this.baseMovieRepostery);
  Future<String> execute(File file)async{
    return await baseMovieRepostery.uploadFile(file);
  }

}