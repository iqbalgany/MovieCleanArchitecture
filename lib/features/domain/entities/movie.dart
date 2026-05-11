// ignore_for_file: public_member_api_docs, sort_constructors_first

class Movie {
  final bool adult;
  final String backdropPath;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final String mediaType;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final DateTime firstAirDate;
  final bool softcore;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.softcore,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });
}
