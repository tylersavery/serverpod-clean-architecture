import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/delete_movie.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/retrieve_movie.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/save_movie.dart';

part 'movie_manage_event.dart';
part 'movie_manage_state.dart';

class MovieManageBloc extends Bloc<MovieManageEvent, MovieManageState> {
  final RetrieveMovieUseCase retrieveMovie;
  final SaveMovieUseCase saveMovie;
  final DeleteMovieUseCase deleteMovie;

  MovieManageBloc({
    required this.retrieveMovie,
    required this.saveMovie,
    required this.deleteMovie,
  }) : super(MovieManageStateInitial()) {
    on<MovieManageEvent>((event, emit) => emit(MovieManageStateLoading()));
    on<MovieManageRetrieveEvent>(_onRetrieveMovie);
    on<MovieManageSaveEvent>(_onSaveMovie);
    on<MovieManageDeleteEvent>(_onDeleteMovie);
  }

  FutureOr<void> _onRetrieveMovie(MovieManageRetrieveEvent event, Emitter<MovieManageState> emit) async {
    final result = await retrieveMovie(RetrieveMovieParams(id: event.id));

    result.fold(
      (failure) => emit(MovieManageStateFailure(failure.message)),
      (movie) => emit(MovieManageStateRetrieveSuccess(movie)),
    );
  }

  FutureOr<void> _onSaveMovie(MovieManageSaveEvent event, Emitter<MovieManageState> emit) async {
    final result = await saveMovie(SaveMovieParams(movie: event.movie));
    result.fold(
      (failure) => emit(MovieManageStateFailure(failure.message)),
      (movie) => emit(MovieManageStateSaveSuccess(movie)),
    );
  }

  FutureOr<void> _onDeleteMovie(MovieManageDeleteEvent event, Emitter<MovieManageState> emit) async {
    final result = await deleteMovie(DeleteMovieParams(id: event.movieId));

    result.fold(
      (failure) => emit(MovieManageStateFailure(failure.message)),
      (_) => emit(MovieManageStateDeleteSuccess()),
    );
  }
}
