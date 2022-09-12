part of 'search_for_movie_cubit.dart';

 class SearchForMovieState extends Equatable {
  final RequestState searchState;
  final String searchMessage;
  final List<Movie> searchList;

  const SearchForMovieState({ this.searchState = RequestState
      .isLoading, this.searchMessage = '', this.searchList = const []});


  SearchForMovieState copyWith({
    RequestState? searchState,
    String? searchMessage,
    List<Movie>? searchList,
  }) {
    return SearchForMovieState(
        searchState: searchState ?? this.searchState,
        searchMessage: searchMessage ?? this.searchMessage,
        searchList: searchList ?? this.searchList);
  }

  @override
  List<Object> get props => [searchState, searchMessage, searchList];
}
