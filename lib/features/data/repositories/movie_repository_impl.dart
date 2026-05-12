import 'package:dartz/dartz.dart';
import 'package:movie_clean_architecture/core/server_exception.dart';
import 'package:movie_clean_architecture/core/server_failure.dart';
import 'package:movie_clean_architecture/features/data/datasource/movie_remote_datasource.dart';
import 'package:movie_clean_architecture/features/domain/repositories/movie_repository.dart';

import '../../domain/entities/movie.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource movieRemoteDatasource;

  MovieRepositoryImpl({required this.movieRemoteDatasource});
  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final movies = await movieRemoteDatasource.getPopularMovies();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies() async {
    try {
      final movies = await movieRemoteDatasource.getTrendingMovies();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final movies = await movieRemoteDatasource.searchMovies(query);
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      rethrow;
    }
  }
}
