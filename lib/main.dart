import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_clean_architecture/core/di/get_it.dart';
import 'package:movie_clean_architecture/features/presentations/pages/movies_screen.dart';

import 'features/presentations/cubits/popular_movies/popular_movies_cubit.dart';
import 'features/presentations/cubits/search_movie/search_movies_cubit.dart';
import 'features/presentations/cubits/trending_movies/trending_movies_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
          ),
        ),
        home: MoviesScreen(),
      ),
    );
  }
}
