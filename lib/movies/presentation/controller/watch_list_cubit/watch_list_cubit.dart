// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:movies_app_clean_arch/core/network/app_prefreances.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_watch_list_use_case.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/remove_from_watch_list_use_case.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit(this.getWatchListUseCase, this.getMovieDetailsUseCase, this.removeFromWatchListUseCase) : super(WatchListInitial());
  static WatchListCubit get(context) => BlocProvider.of(context);

  final GetWatchListUseCase getWatchListUseCase;
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final RemoveFromWatchListUseCase removeFromWatchListUseCase;
   List<MovieDetails> movieDetails=[];
  List<dynamic> moviesFromApi= [];

  Future<void> getWatchList()async{
    emit(WatchListLoading());
    String uid=await AppPrefrenaces().getUid();
    moviesFromApi= await getWatchListUseCase.execute(uid);

    movieDetails=[];
    if(moviesFromApi.isNotEmpty)
    {
    for(int i=0;i<moviesFromApi.length;i++)
    {
      final value = await getMovieDetailsUseCase.excute(moviesFromApi[i]);
      value.fold((l) => null, (r) => movieDetails.add(r));
    }
    emit(WatchListSuccess(movieDetails));
    }else{
      emit(WatchListError(''));
    }
  }

  Future<void> removeFromWatchList(int value)async{
    try{
      String uid=await AppPrefrenaces().getUid();

      await removeFromWatchListUseCase.execute(uid, value);
      getWatchList();
    }catch (e){
      emit(WatchListError(e.toString()));
    }
  }



}
