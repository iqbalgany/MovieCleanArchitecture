import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_clean_architecture/config/api.dart';
import 'package:movie_clean_architecture/core/server_exception.dart';
import 'package:movie_clean_architecture/features/data/models/movie_model.dart';

class MovieRemoteDatasource {
  final _dio = Dio();
  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      final response = await _dio.get(
        '$baseUrl/trending/all/day',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data['result'];

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
      final response = await _dio.get(
        '$baseUrl/movie/popular',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data['result'];

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
        '$baseUrl/search/movie',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'accept': 'application/json',
          },
        ),
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        final List data = response.data['result'];

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
