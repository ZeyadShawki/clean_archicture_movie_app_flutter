// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecase/search_for_movie_use_case.dart';

part 'search_for_movie_state.dart';

class SearchForMovieCubit extends Cubit<SearchForMovieState> {
  final SearchForMovieUseCase searchForMovieUseCase;
  SearchForMovieCubit(this.searchForMovieUseCase) : super(const SearchForMovieState());



  void searchForMovie(String query)async
  {
    emit(const SearchForMovieState().copyWith(searchState: RequestState.isLoading));

    final result=await searchForMovieUseCase.execute(query);
    result.fold(
            (l) {
            emit(  const SearchForMovieState().copyWith(searchState: RequestState.isLoading));
            },
            (r) {
              emit(const SearchForMovieState().copyWith(searchList: r,searchState: RequestState.isLoaded));


            });
  }

}
