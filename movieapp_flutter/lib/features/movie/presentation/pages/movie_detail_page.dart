import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_flutter/core/utils/show_snackbar.dart';
import 'package:movieapp_flutter/core/widgets/loader.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_retrieve/movie_retrieve_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_retrieve/movie_retrieve_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_retrieve/movie_retrieve_state.dart';

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
    context.read<MovieRetrieveBloc>().add(FetchMovieEvent(id: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieRetrieveBloc, MovieRetrieveState>(
      listener: (context, state) {
        if (state is MovieRetrieveStateFailure) {
          showSnackbar(context, state.message);

          context.pop();
        }
      },
      builder: (context, state) {
        switch (state) {
          case MovieRetrieveStateLoading():
            return const Scaffold(body: Loader());
          case MovieRetrieveStateFailure():
            return Scaffold(
                body: Center(
              child: Text(state.message),
            ));
          case MovieRetrieveStateInitial():
            return const Scaffold(body: SizedBox());
          case MovieRetrieveStateSuccess():
            final movie = state.movie;

            return Scaffold(
              appBar: AppBar(
                title: Text(movie.title),
              ),
              body: Column(
                children: [
                  Text("Released: ${movie.year}"),
                  Text("Director: ${movie.directorName}"),
                  Text("Logine: ${movie.logline}"),
                ],
              ),
            );
        }
      },
    );
  }
}
