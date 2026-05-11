import 'package:movie_clean_architecture/features/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.adult,
    required super.backdropPath,
    required super.id,
    required super.name,
    required super.originalName,
    required super.overview,
    required super.posterPath,
    required super.mediaType,
    required super.originalLanguage,
    required super.genreIds,
    required super.popularity,
    required super.firstAirDate,
    required super.softcore,
    required super.voteAverage,
    required super.voteCount,
    required super.originCountry,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdropPath': backdropPath,
      'id': id,
      'name': name,
      'originalName': originalName,
      'overview': overview,
      'posterPath': posterPath,
      'mediaType': mediaType,
      'originalLanguage': originalLanguage,
      'genreIds': genreIds,
      'popularity': popularity,
      'firstAirDate': firstAirDate.millisecondsSinceEpoch,
      'softcore': softcore,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
      'originCountry': originCountry,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      adult: map['adult'] as bool,
      backdropPath: map['backdropPath'] as String,
      id: map['id'] as int,
      name: map['name'] as String,
      originalName: map['originalName'] as String,
      overview: map['overview'] as String,
      posterPath: map['posterPath'] as String,
      mediaType: map['mediaType'] as String,
      originalLanguage: map['originalLanguage'] as String,
      genreIds: List<int>.from((map['genreIds'] as List<int>)),
      popularity: map['popularity'] as double,
      firstAirDate: DateTime.fromMillisecondsSinceEpoch(
        map['firstAirDate'] as int,
      ),
      softcore: map['softcore'] as bool,
      voteAverage: map['voteAverage'] as double,
      voteCount: map['voteCount'] as int,
      originCountry: List<String>.from((map['originCountry'] as List<String>)),
    );
  }
}
