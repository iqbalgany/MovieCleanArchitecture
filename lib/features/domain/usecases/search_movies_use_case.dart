import 'package:movie_clean_architecture/features/domain/entities/movie.dart';
import 'package:movie_clean_architecture/features/domain/repositories/movie_repository.dart';

class SearchMoviesUseCase {
  final MovieRepository movieRepository;

  SearchMoviesUseCase({required this.movieRepository});

  Future<List<Movie>> call(String query) async {
    return await movieRepository.searchMovies(query);
  }
}
