import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_flutter/core/widgets/loader.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_detail_page.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void initState() {
    super.initState();

    context.read<MovieListBloc>().add(FetchMoviesEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        switch (state) {
          case MovieListStateInitial():
            return const SizedBox.shrink();
          case MovieListStateLoading():
            return const Loader();
          case MovieListStateSuccess():
            final movies = state.movies;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  child: ListTile(
                    title: Text(movie.title),
                    subtitle: Text("Released in ${movie.year}"),
                    onTap: () {
                      context.push(MovieDetailPage.route(movie.id));
                    },
                  ),
                );
              },
            );
          case MovieListStateFailure():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }
}
