import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_arch/core/error/failure.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class GetRecommendedMovieUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  GetRecommendedMovieUseCase(this.baseMovieRepostery);

  Future<Either<Failure,List<RecommendedMovie>>> execute(int id)async {
       return await baseMovieRepostery.getMovieRecommondation(id);
  }

}