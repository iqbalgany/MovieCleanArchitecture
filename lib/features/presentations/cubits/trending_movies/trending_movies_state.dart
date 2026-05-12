part of 'trending_movies_cubit.dart';

sealed class TrendingMoviesState extends Equatable {
  const TrendingMoviesState();

  @override
  List<Object> get props => [];
}

final class TrendingMoviesInitial extends TrendingMoviesState {}

final class TrendingMoviesLoading extends TrendingMoviesState {}

final class TrendingMoviesSuccess extends TrendingMoviesState {
  final List<Movie> movies;

  const TrendingMoviesSuccess({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class TrendingMoviesError extends TrendingMoviesState {
  final String errorMessage;

  const TrendingMoviesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
