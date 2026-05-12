import 'package:dartz/dartz.dart';
import 'package:movie_clean_architecture/core/server_failure.dart';
import 'package:movie_clean_architecture/features/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getTrendingMovies();
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, List<Movie>>> getPopularMovies();
}
