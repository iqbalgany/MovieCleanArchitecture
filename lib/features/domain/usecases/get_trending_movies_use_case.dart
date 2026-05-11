import 'package:movie_clean_architecture/features/domain/entities/movie.dart';
import 'package:movie_clean_architecture/features/domain/repositories/movie_repository.dart';

class GetTrendingMoviesUseCase {
  final MovieRepository movieRepository;

  GetTrendingMoviesUseCase({required this.movieRepository});

  Future<List<Movie>> call() async {
    return await movieRepository.getTrendingMovies();
  }
}
