import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class RemoveFromWatchListUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  RemoveFromWatchListUseCase(this.baseMovieRepostery);

  Future<void> execute(String uid,int value)async{
    return await baseMovieRepostery.removeMovieFromWatchList(uid, value);
  }

}