import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class GetWatchListUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  GetWatchListUseCase(this.baseMovieRepostery);

Future<List<dynamic>>execute(String uid)async{
 return await baseMovieRepostery.getWatchListId(uid);
}
}