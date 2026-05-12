import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_clean_architecture/features/domain/usecases/search_movies_use_case.dart';

import '../../../domain/entities/movie.dart';

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final SearchMoviesUseCase searchMoviesUseCase;
  SearchMoviesCubit({required this.searchMoviesUseCase})
    : super(SearchMoviesInitial());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchMoviesInitial());
      return;
    }

    emit(SearchMoviesLoading());

    final result = await searchMoviesUseCase(query);

    result.fold(
      (l) => emit(SearchMoviesError(errorMessage: l.message)),
      (r) => emit(SearchMoviesSuccess(movies: r)),
    );
  }
}
