import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_clean_architecture/features/presentations/cubits/popular_movies/popular_movies_cubit.dart';
import 'package:movie_clean_architecture/features/presentations/pages/movies_view.dart';

import '../../../core/di/get_it.dart';
import '../cubits/search_movie/search_movies_cubit.dart';
import '../cubits/trending_movies/trending_movies_cubit.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<TrendingMoviesCubit>()..fetchTrendingMovies(),
        ),
        BlocProvider(
          create: (_) => getIt<PopularMoviesCubit>()..fetchPopularMovies(),
        ),
        BlocProvider(create: (_) => getIt<SearchMoviesCubit>()),
      ],
      child: MoviesView(),
    );
  }
}
