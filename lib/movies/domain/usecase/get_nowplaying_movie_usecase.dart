import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

import '../../../core/error/failure.dart';

class GetNowPlayingUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  GetNowPlayingUseCase(this.baseMovieRepostery);
  Future<Either<Failure,List<Movie>>> execute()async{
    return await baseMovieRepostery.getNowPlayingMovies();
  }
}