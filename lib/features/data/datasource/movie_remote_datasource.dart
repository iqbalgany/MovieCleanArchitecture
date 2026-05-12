import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_clean_architecture/config/api.dart';
import 'package:movie_clean_architecture/core/server_exception.dart';
import 'package:movie_clean_architecture/features/data/models/movie_model.dart';

class MovieRemoteDatasource {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'accept': 'application/json',
      },
    ),
  );
  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      final response = await _dio.get('/trending/all/day');

      if (response.statusCode == 200) {
        final List data = response.data['results'];

        return data.map((movie) => MovieModel.fromMap(movie)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error : $e');
      rethrow;
    }
  }

  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await _dio.get('/movie/popular');

      if (response.statusCode == 200) {
        final List data = response.data['results'];

        return data.map((movie) => MovieModel.fromMap(movie)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error : $e');
      rethrow;
    }
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        '/search/movie',

        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        final List data = response.data['results'];

        return data.map((movie) => MovieModel.fromMap(movie)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error : $e');
      rethrow;
    }
  }
}
