import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_flutter/core/utils/show_snackbar.dart';
import 'package:movieapp_flutter/core/widgets/loader.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_edit_page.dart';

class MovieDetailPage extends StatefulWidget {
  static String route([int? movieId]) => "/movies/${movieId ?? ':id'}";

  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(MovieDetailRetrieveEvent(id: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailBloc, MovieDetailState>(
      listener: (context, state) {
        if (state is MovieDetailStateFailure) {
          showSnackbar(context, state.message);

          context.pop();
        }
      },
      builder: (context, state) {
        switch (state) {
          case MovieDetailStateLoading():
            return const Scaffold(body: Loader());
          case MovieDetailStateFailure():
            return Scaffold(
                body: Center(
              child: Text(state.message),
            ));
          case MovieDetailStateInitial():
            return const Scaffold(body: SizedBox());
          case MovieDetailStateSuccess():
            final movie = state.movie;

            return Scaffold(
              appBar: AppBar(
                title: Text(movie.title),
                actions: [
                  IconButton(
                      onPressed: () {
                        context.push(MovieEditPage.route(movie.id));
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
              body: Center(
                child: Column(
                  children: [
                    Text("Released: ${movie.year}"),
                    Text("Director: ${movie.directorName}"),
                    Text("Logline: ${movie.logline}"),
                    if (movie.imageUrl.isNotEmpty)
                      Image.network(
                        movie.imageUrl,
                        width: double.infinity,
                      )
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
