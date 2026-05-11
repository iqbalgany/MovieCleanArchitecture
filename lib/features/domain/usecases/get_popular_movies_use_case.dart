import 'package:movie_clean_architecture/features/domain/entities/movie.dart';
import 'package:movie_clean_architecture/features/domain/repositories/movie_repository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository movieRepository;

  GetPopularMoviesUseCase({required this.movieRepository});

  Future<List<Movie>> call() async {
    return await movieRepository.getPopularMovies();
  }
}
