// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/data/models/recommended_movie_model.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/recommended%20_movie.dart';

import '../../domain/usecase/get_movie_details_usecase.dart';
import '../../domain/usecase/get_recmonded_movie_usecase.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsInitial> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendedMovieUseCase getRecommendedMovieUseCase;
  MovieDetailsCubit(this.getMovieDetailsUseCase, this.getRecommendedMovieUseCase) : super( MovieDetailsInitial());

  void getMovieDetails(int id)async{
    final result=await getMovieDetailsUseCase.excute(id);
    result.fold((l) {
      emit(state.copWith(
        movieDetailsMessage: l.message,
        movieDetailstate: RequestState.isError,
      ));
    }, (r) {
      emit(state.copWith(
        movieDetails: r,
        movieDetailstate: RequestState.isLoaded
      ));
    });
  }
  
  void getRecomended(int id)async{
    print("//////////////");

    final result=await getRecommendedMovieUseCase.execute(id);


    result.fold((l) {
      emit(state.copWith(recommendedstate: RequestState.isError,recommendedmovieMessage: l.message));
      
              },
            (r) {

            emit(state.copWith(recommendedmovieDetails: r,recommendedstate: RequestState.isLoaded));
                     print(state.recommendedmovieDetails[0].backdropPath);
            });
  }
  
}
