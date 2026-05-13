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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchAnchor(
                  isFullScreen: false,
                  viewConstraints: BoxConstraints(maxHeight: 500),
                  viewBackgroundColor: Colors.grey.shade100,
                  viewShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      onTap: () => controller.openView(),
                      onChanged: (_) => controller.openView(),
                      hintText: 'Search movies...',
                      leading: Icon(Icons.search),
                      elevation: WidgetStatePropertyAll(10),
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.grey.shade100,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },

                  suggestionsBuilder: (context, controller) async {
                    final query = controller.text;
                    if (query.isEmpty) {
                      return [
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text('Type to search movies'),
                        ),
                      ];
                    }

                    context.read<SearchMoviesCubit>().searchMovies(query);

                    await context.read<SearchMoviesCubit>().stream.firstWhere(
                      (state) =>
                          state is SearchMoviesSuccess ||
                          state is SearchMoviesError,
                    );

                    if (!context.mounted) return [];

                    final state = context.read<SearchMoviesCubit>().state;

                    if (state is SearchMoviesSuccess) {
                      return state.movies
                          .map(
                            (movie) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.all(5),
                                leading: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(movie.name),
                                onTap: () {
                                  controller.closeView(movie.name);
                                },
                              ),
                            ),
                          )
                          .toList();
                    }

                    if (state is SearchMoviesError) {
                      return [ListTile(title: Text(state.errorMessage))];
                    }

                    return [Center(child: CircularProgressIndicator())];
                  },
                ),
              ),

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
                            child: PopularMoviesItem(
                              movie: state.movies[index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
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
                      padding: EdgeInsets.symmetric(vertical: 10),
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
      ),
    );
  }
}
