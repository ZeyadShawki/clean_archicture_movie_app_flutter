// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:movies_app_clean_arch/core/network/app_prefreances.dart';
// ignore: depend_on_referenced_packages
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';

import '../../../domain/usecase/get_movie_details_usecase.dart';
import '../../../domain/usecase/get_recmonded_movie_usecase.dart';
import '../../../domain/usecase/set_watch_list_usecase.dart';
import 'movie_details_state.dart';


class MovieDetailsCubit extends Cubit<MovieDetailsInitial> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendedMovieUseCase getRecommendedMovieUseCase;
  final SetWatchListUseCase setWatchListUseCase;
  MovieDetailsCubit(this.getMovieDetailsUseCase, this.getRecommendedMovieUseCase, this.setWatchListUseCase) : super( const MovieDetailsInitial());

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

    final result=await getRecommendedMovieUseCase.execute(id);


    result.fold((l) {
      emit(state.copWith(recommendedstate: RequestState.isError,recommendedmovieMessage: l.message));
      
              },
            (r) {

            emit(state.copWith(recommendedmovieDetails: r,recommendedstate: RequestState.isLoaded));
            });
  }

  void setWatchList(List<int> index)async{
    String uid=await AppPrefrenaces().getUid();
try{
  await setWatchListUseCase.execute(index, uid);
  emit(state.copWith(addtoListMessage: 'Movie Added To Watch List Successfully'));
}catch(e){
  emit(state.copWith(addtoListMessage: 'Failed to Add Movie To Watch List'));

}

  }
  
}
