class PopularModel {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  /*PopularModel(String override){
    this.overview = override;
  }*/

  PopularModel({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularModel.fromMap(Map<String,dynamic> movie) {
  return PopularModel(
    backdropPath: (movie['backdrop_path'] != null && movie['backdrop_path'] != '')
      ? 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}'
      : 'https://cdn-icons-png.flaticon.com/128/3980/3980131.png',
    id: movie['id'],
    originalLanguage: movie['original_language'],
    originalTitle: movie['original_title'],
    overview: movie['overview'],
    popularity: (movie['popularity'] as num).toDouble(),
    posterPath: movie['poster_path'] ?? '',
    releaseDate: movie['release_date'],
    title: movie['title'],
    voteAverage: (movie['vote_average'] as num).toDouble(),
    voteCount: movie['vote_count'],
  );
}


}