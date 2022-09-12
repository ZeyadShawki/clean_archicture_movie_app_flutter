

import 'package:get_it/get_it.dart';
import 'package:movies_app_clean_arch/movies/data/remote_data_source/remote_data_source_movie.dart';
import 'package:movies_app_clean_arch/movies/data/repostery/movie_repostery.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_nowplaying_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_populer_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_recmonded_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_top_rated_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/search_for_movie_use_case.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/search_cubit/search_for_movie_cubit.dart';

import '../../movies/presentation/controller/movie_bloc/bloc.dart';

final si = GetIt.instance;
class ServiceLocater{
  void init(){
    si.registerFactory<MovieBloc>(() => MovieBloc(si(),si(),si()));
     si.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit(si(),si()));
     si.registerFactory<SearchForMovieCubit>(() => SearchForMovieCubit(si()));

      si.registerLazySingleton<SearchForMovieUseCase>(() => SearchForMovieUseCase(si()));

     si.registerLazySingleton<GetRecommendedMovieUseCase>(() => GetRecommendedMovieUseCase(si()));
    // instance get movie details use case
    si.registerLazySingleton<GetMovieDetailsUseCase>(() => GetMovieDetailsUseCase(si()));

    si.registerLazySingleton<GetPopularMovieUseCase>(() => GetPopularMovieUseCase(si()));

    si.registerLazySingleton<GetTopRatedUseCase>(() => GetTopRatedUseCase(si()));

    si.registerLazySingleton<GetNowPlayingUseCase>(() => GetNowPlayingUseCase(si()));

    si.registerLazySingleton<BaseMovieRepostery>(() => MovieRepostery(si()));

    si.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());
  }
}