class ApiConstants{
  static const String baseurl='https://api.themoviedb.org/3/movie';
  static const String baseurl2='https://api.themoviedb.org/3';

  static const String apiKey='b722a9e4e2b6398f545030bcde9115a9';

  static const String getNowPlayingUrl='$baseurl/now_playing?api_key=$apiKey';
  static const String getPopularUrl='$baseurl/popular?api_key=$apiKey';
  static const String getTopRatedUrl='$baseurl/top_rated?api_key=$apiKey';
  static const String networkImagePath='https://image.tmdb.org/t/p/w500';

  String networkimagemaker(String? path){
    return '$networkImagePath$path';
  }

  static const String getMovieDetails='$baseurl/438148?api_key=$apiKey';

  String movieDetailsPathMaker(int id)
  {
    return '$baseurl/$id?api_key=$apiKey';
  }

  String movieRecemondationPathMaker(int id)
  {
    return '$baseurl/$id/recommendations?api_key=$apiKey';
  }

  String searchForQueryPathMaker(String query)
  {
    return '$baseurl2/search/movie?api_key=$apiKey&language=en-US&query=$query';
  }

}