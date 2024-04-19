import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/retrieve_movie.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_retrieve/movie_retrieve_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_retrieve/movie_retrieve_state.dart';

class MovieRetrieveBloc extends Bloc<MovieRetrieveEvent, MovieRetrieveState> {
  final RetrieveMovieUseCase retrieveMovie;

  MovieRetrieveBloc({required this.retrieveMovie}) : super(MovieRetrieveStateInitial()) {
    on<MovieRetrieveEvent>((_, emit) => emit(MovieRetrieveStateLoading()));
    on<FetchMovieEvent>(_onFetchMovie);
  }

  Future<void> _onFetchMovie(FetchMovieEvent event, Emitter<MovieRetrieveState> emit) async {
    final result = await retrieveMovie(RetrieveMovieParams(id: event.id));

    result.fold(
      (failure) => emit(MovieRetrieveStateFailure(failure.message)),
      (movie) => emit(MovieRetrieveStateSuccess(movie)),
    );
  }
}
