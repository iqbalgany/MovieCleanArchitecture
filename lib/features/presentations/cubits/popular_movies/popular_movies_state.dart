part of 'popular_movies_cubit.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

final class PopularMoviesInitial extends PopularMoviesState {}

final class PopularMoviesLoading extends PopularMoviesState {}

final class PopularMoviesSuccess extends PopularMoviesState {
  final List<Movie> movies;

  const PopularMoviesSuccess({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class PopularMoviesError extends PopularMoviesState {
  final String errorMessage;

  const PopularMoviesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
