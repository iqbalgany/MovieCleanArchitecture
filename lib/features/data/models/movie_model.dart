import 'dart:developer';

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
    try {
      final dateString = map['release_date'] ?? map['first_air_date'] ?? '';

      return MovieModel(
        adult: map['adult'] as bool? ?? false,
        backdropPath: (map['backdrop_path'] ?? '').toString(),
        id: map['id']?.toInt() ?? 0,
        name: (map['title'] ?? map['name'] ?? '').toString(),
        originalName: (map['original_title'] ?? map['original_name'] ?? '')
            .toString(),
        overview: (map['overview'] ?? '').toString(),
        posterPath: (map['poster_path'] ?? '').toString(),
        mediaType: (map['media_type'] ?? '').toString(),
        originalLanguage: (map['original_language'] ?? '').toString(),
        genreIds: map['genre_ids'] != null
            ? List<int>.from(map['genre_ids'])
            : [],
        popularity: map['popularity']?.toDouble() ?? 0.0,
        firstAirDate: DateTime.tryParse(dateString) ?? DateTime.now(),
        softcore: map['softcore'] as bool? ?? false,
        voteAverage: map['vote_average']?.toDouble() ?? 0.0,
        voteCount: map['vote_count']?.toInt() ?? 0,
        originCountry: map['origin_country'] != null
            ? List<String>.from(map['origin_country'])
            : [],
      );
    } catch (e) {
      log("Gagal mapping data: $map");
      rethrow;
    }
  }
}
