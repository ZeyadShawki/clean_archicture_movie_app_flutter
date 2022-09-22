import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class SetWatchListUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  SetWatchListUseCase(this.baseMovieRepostery);
  Future<void> execute(List<int> index,String uid)async{
   await baseMovieRepostery.setWatchListIndex(index, uid);
  }
}