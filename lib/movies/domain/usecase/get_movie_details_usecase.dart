import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_arch/core/error/failure.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class GetMovieDetailsUseCase{

  final BaseMovieRepostery baseMovieRepostery;

  GetMovieDetailsUseCase(this.baseMovieRepostery);

  Future<Either<Failure,MovieDetails>> excute(int id)async{
    return await baseMovieRepostery.getMovieDetails(id);
  }
}