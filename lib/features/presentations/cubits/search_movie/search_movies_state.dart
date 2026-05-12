part of 'search_movies_cubit.dart';

sealed class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

final class SearchMoviesInitial extends SearchMoviesState {}

final class SearchMoviesLoading extends SearchMoviesState {}

final class SearchMoviesSuccess extends SearchMoviesState {
  final List<Movie> movies;

  const SearchMoviesSuccess({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class SearchMoviesError extends SearchMoviesState {
  final String errorMessage;

  const SearchMoviesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
