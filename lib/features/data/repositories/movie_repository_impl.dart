import 'package:movie_clean_architecture/features/data/datasource/movie_remote_datasource.dart';
import 'package:movie_clean_architecture/features/domain/repositories/movie_repository.dart';

import '../../domain/entities/movie.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource movieRemoteDatasource;

  MovieRepositoryImpl({required this.movieRemoteDatasource});
  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final movies = await movieRemoteDatasource.getPopularMovies();
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Movie>> getTrendingMovies() async {
    try {
      final movies = await movieRemoteDatasource.getTrendingMovies();
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final movies = await movieRemoteDatasource.searchMovies(query);
      return movies;
    } catch (e) {
      rethrow;
    }
  }
}
