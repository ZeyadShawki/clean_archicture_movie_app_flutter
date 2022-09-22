

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app_clean_arch/core/network/network_info.dart';
import 'package:movies_app_clean_arch/movies/data/remote_data_source/remote_data_source_movie.dart';
import 'package:movies_app_clean_arch/movies/data/repostery/movie_repostery.dart';
import 'package:movies_app_clean_arch/movies/domain/reposetry/base_movie_repostery.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_nowplaying_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_populer_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_recmonded_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_top_rated_movie_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_user_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_watch_list_use_case.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/login_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/remove_from_watch_list_use_case.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/search_for_movie_use_case.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/set_watch_list_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/signin_use_case.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/upload_file_use_case.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/login_cubit/login_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/profile_cubit/my_profile_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/register_cubit/register_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/search_cubit/search_for_movie_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/watch_list_cubit/watch_list_cubit.dart';

import '../../movies/presentation/controller/movie_bloc/bloc.dart';

final si = GetIt.instance;
class ServiceLocater{
  void init()async{

     si.registerFactory<MovieBloc>(() => MovieBloc(si(),si(),si(),si()));
     si.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit(si(),si(),si()));
     si.registerFactory<SearchForMovieCubit>(() => SearchForMovieCubit(si()));
     si.registerFactory<LoginCubit>(() => LoginCubit(si()));
     si.registerFactory<RegisterCubit>(() => RegisterCubit(si(),si()));
     si.registerFactory<MyProfileCubit>(() => MyProfileCubit(si()));



     si.registerFactory<WatchListCubit>(() => WatchListCubit(si(),si(),si()));

     si.registerLazySingleton<RemoveFromWatchListUseCase>(() => RemoveFromWatchListUseCase(si()));

     si.registerLazySingleton<GetWatchListUseCase>(() => GetWatchListUseCase(si()));


     si.registerLazySingleton<SetWatchListUseCase>(() => SetWatchListUseCase(si()));

     si.registerLazySingleton<UploadFileUseCase>(() => UploadFileUseCase(si()));

    si.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(si()));

    si.registerLazySingleton<SignInUseCase>(() => SignInUseCase(si()));

    si.registerLazySingleton<LoginUseCase>(() => LoginUseCase(si()));

    si.registerLazySingleton<SearchForMovieUseCase>(() => SearchForMovieUseCase(si()));

     si.registerLazySingleton<GetRecommendedMovieUseCase>(() => GetRecommendedMovieUseCase(si()));
    // instance get movie details use case
    si.registerLazySingleton<GetMovieDetailsUseCase>(() => GetMovieDetailsUseCase(si()));

    si.registerLazySingleton<GetPopularMovieUseCase>(() => GetPopularMovieUseCase(si()));

    si.registerLazySingleton<GetTopRatedUseCase>(() => GetTopRatedUseCase(si()));

    si.registerLazySingleton<GetNowPlayingUseCase>(() => GetNowPlayingUseCase(si()));

    si.registerLazySingleton<BaseMovieRepostery>(() => MovieRepostery(si(),si()));
     
    si.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));
    
    si.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());
  }
}