import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_clean_architecture/features/domain/entities/movie.dart';
import 'package:movie_clean_architecture/features/domain/usecases/get_popular_movies_use_case.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  PopularMoviesCubit({required this.getPopularMoviesUseCase})
    : super(PopularMoviesInitial());

  Future<void> fetchPopularMovies() async {
    emit(PopularMoviesLoading());

    final result = await getPopularMoviesUseCase();

    result.fold(
      (l) => emit(PopularMoviesError(errorMessage: l.message)),
      (r) => emit(PopularMoviesSuccess(movies: r)),
    );
  }
}
