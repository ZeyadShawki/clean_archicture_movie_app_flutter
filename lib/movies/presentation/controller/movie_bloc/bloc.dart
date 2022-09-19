import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_nowplaying_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_bloc/bloc_state.dart';

import '../../../../core/network/app_prefreances.dart';
import '../../../domain/usecase/get_populer_movie_usecase.dart';
import '../../../domain/usecase/get_top_rated_movie_usecase.dart';
import '../../../domain/usecase/get_user_usecase.dart';

class MovieBloc extends Cubit<MovieState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularMovieUseCase getPopularMovieUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;
  final GetUserUseCase getUserUseCase;
  MovieBloc(
      this.getNowPlayingUseCase,
      this.getTopRatedUseCase,
      this.getPopularMovieUseCase,
      this.getUserUseCase,
      )
      : super(const MovieState());



  void getuserinfo()async{
    String uid=await AppPrefrenaces().getUid();

   final result= await getUserUseCase.execute(uid);
   emit(state.copywith(user: result));


  }

  void getNowPlaying() async {
    final result = await getNowPlayingUseCase.execute();

    result.fold((l) {
      emit(state.copywith(
        nowPlayingState: RequestState.isError,
        nowPlayingMessage: l.message,
      ));
    }, (r) {
      emit(state.copywith(
          nowPlayingState: RequestState.isLoaded, nowPlayingMovie: r));
    });
  }

  void getPopular() async {
    final result = await getPopularMovieUseCase.execute();
    result.fold((l) {
      emit(state.copywith(
        popularState: RequestState.isError,
        popularMessage: l.message,
      ));
    }, (r) {
      emit(
          state.copywith(popularMovie: r, popularState: RequestState.isLoaded));
    });
  }

  void getTopRated() async {
    final result = await getTopRatedUseCase.execute();
    result.fold((l) {
      emit(state.copywith(
        topRatedState: RequestState.isError,
        topRatedMessage: l.message,
      ));
    }, (r) {
      emit(state.copywith(
          topRatedMovie: r, topRatedState: RequestState.isLoaded));
    });
  }



}
