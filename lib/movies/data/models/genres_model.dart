import 'package:movies_app_clean_arch/movies/domain/entities/genre.dart';

class GenresModel extends Genre{
  const GenresModel({required super.name, required super.id});
  factory GenresModel.fromJson(Map<String,dynamic> json)=>
      GenresModel(
          name: json['name'],
          id: json['id']);
}