import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_clean_architecture/features/domain/usecases/get_trending_movies_use_case.dart';

import '../../../domain/entities/movie.dart';

part 'trending_movies_state.dart';

class TrendingMoviesCubit extends Cubit<TrendingMoviesState> {
  final GetTrendingMoviesUseCase getTrendingMoviesUseCase;
  TrendingMoviesCubit({required this.getTrendingMoviesUseCase})
    : super(TrendingMoviesInitial());

  Future<void> fetchTrendingMovies() async {
    emit(TrendingMoviesLoading());

    final result = await getTrendingMoviesUseCase();

    result.fold(
      (l) => emit(TrendingMoviesError(errorMessage: l.message)),
      (r) => emit(TrendingMoviesSuccess(movies: r)),
    );
  }
}
