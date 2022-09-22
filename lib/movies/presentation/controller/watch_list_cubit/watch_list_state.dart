part of 'watch_list_cubit.dart';

@immutable
abstract class WatchListState {}

class WatchListInitial extends WatchListState {}
class WatchListLoading extends WatchListState {}

class WatchListSuccess extends WatchListState {
  final List<MovieDetails> watchListMovie;

  WatchListSuccess(this.watchListMovie);
}
class WatchListError extends WatchListState {
  final String message;

  WatchListError(this.message);

}
