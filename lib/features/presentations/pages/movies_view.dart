import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_clean_architecture/features/presentations/cubits/popular_movies/popular_movies_cubit.dart';
import 'package:movie_clean_architecture/features/presentations/cubits/trending_movies/trending_movies_cubit.dart';
import 'package:movie_clean_architecture/features/presentations/widgets/popular_movies_item.dart';
import 'package:movie_clean_architecture/features/presentations/widgets/trending_movies_item.dart';

import '../cubits/search_movie/search_movies_cubit.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchAnchor(
                builder: (context, controller) => SearchBar(
                  controller: controller,
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  leading: Icon(Icons.search),
                  hintText: 'Search movies...',
                  backgroundColor: WidgetStatePropertyAll(Colors.grey[200]),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (value) {
                    controller.openView();
                  },
                ),
                suggestionsBuilder: (context, controller) {
                  final query = controller.text;

                  if (query.isEmpty) {
                    return [];
                  }

                  context.read<SearchMoviesCubit>().searchMovies(query);

                  return [
                    BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
                      builder: (context, state) {
                        if (state is SearchMoviesLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is SearchMoviesSuccess) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = state.movies[index];
                              return ListTile(
                                leading: Image.network(
                                  'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                                  errorBuilder: (_, _, _) =>
                                      const Icon(Icons.movie),
                                ),
                                title: Text(movie.name),
                                onTap: () {
                                  controller.closeView(movie.name);
                                },
                              );
                            },
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ];
                },
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                'Popular Movies',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

            BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is PopularMoviesError) {
                  return Center(child: Text(state.errorMessage));
                }

                if (state is PopularMoviesSuccess) {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: state.movies.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            index == 0 ? 20 : 5,
                            0,
                            index == state.movies.length - 1 ? 20 : 5,
                            0,
                          ),
                          child: PopularMoviesItem(movie: state.movies[index]),
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                'Trending Movies',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

            BlocBuilder<TrendingMoviesCubit, TrendingMoviesState>(
              builder: (context, state) {
                if (state is TrendingMoviesLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is TrendingMoviesError) {
                  return Center(child: Text(state.errorMessage));
                }

                if (state is TrendingMoviesSuccess) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: TrendingMoviesItem(movie: state.movies[index]),
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
