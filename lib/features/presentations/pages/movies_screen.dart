import 'package:flutter/material.dart';
import 'package:movie_clean_architecture/features/presentations/pages/movies_view.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MoviesView();
  }
}
