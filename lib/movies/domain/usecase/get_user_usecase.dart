import 'package:movies_app_clean_arch/movies/data/models/user_model.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';

class GetUserUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  GetUserUseCase(this.baseMovieRepostery);

  Future<UserModel>execute(String uid)async{
    return await baseMovieRepostery.getUser(uid);
  }

}