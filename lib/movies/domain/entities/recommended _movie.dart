import 'package:equatable/equatable.dart';

class RecommendedMovie extends Equatable {
  String? backdropPath;
  String title;
  int id;
  String overview;
  String posterPath;

  RecommendedMovie({
    required this.overview,
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
  });

  @override
  List<Object> get props => [title,id,override,posterPath];
}