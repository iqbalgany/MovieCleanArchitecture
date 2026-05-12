import 'package:get_it/get_it.dart';
import 'package:movie_clean_architecture/features/data/datasource/movie_remote_datasource.dart';
import 'package:movie_clean_architecture/features/data/repositories/movie_repository_impl.dart';
import 'package:movie_clean_architecture/features/domain/repositories/movie_repository.dart';
import 'package:movie_clean_architecture/features/domain/usecases/get_popular_movies_use_case.dart';
import 'package:movie_clean_architecture/features/domain/usecases/get_trending_movies_use_case.dart';
import 'package:movie_clean_architecture/features/domain/usecases/search_movies_use_case.dart';
import 'package:movie_clean_architecture/features/presentations/cubits/popular_movies/popular_movies_cubit.dart';
import 'package:movie_clean_architecture/features/presentations/cubits/search_movie/search_movies_cubit.dart';
import 'package:movie_clean_architecture/features/presentations/cubits/trending_movies/trending_movies_cubit.dart';

var getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton<MovieRemoteDatasource>(
    () => MovieRemoteDatasource(),
  );

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(movieRemoteDatasource: getIt()),
  );

  getIt.registerLazySingleton<GetPopularMoviesUseCase>(
    () => GetPopularMoviesUseCase(movieRepository: getIt()),
  );
  getIt.registerLazySingleton<GetTrendingMoviesUseCase>(
    () => GetTrendingMoviesUseCase(movieRepository: getIt()),
  );
  getIt.registerLazySingleton<SearchMoviesUseCase>(
    () => SearchMoviesUseCase(movieRepository: getIt()),
  );

  getIt.registerFactory<TrendingMoviesCubit>(
    () => TrendingMoviesCubit(getTrendingMoviesUseCase: getIt()),
  );
  getIt.registerFactory<PopularMoviesCubit>(
    () => PopularMoviesCubit(getPopularMoviesUseCase: getIt()),
  );
  getIt.registerFactory<SearchMoviesCubit>(
    () => SearchMoviesCubit(searchMoviesUseCase: getIt()),
  );
}
