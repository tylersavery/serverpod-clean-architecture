import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/retrieve_movie.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final RetrieveMovieUseCase retrieveMovie;

  MovieDetailBloc({required this.retrieveMovie}) : super(MovieDetailStateInitial()) {
    on<MovieDetailEvent>((_, emit) => emit(MovieDetailStateLoading()));
    on<MovieDetailRetrieveEvent>(_onFetchMovie);
  }

  Future<void> _onFetchMovie(MovieDetailRetrieveEvent event, Emitter<MovieDetailState> emit) async {
    final result = await retrieveMovie(RetrieveMovieParams(id: event.id));

    result.fold(
      (failure) => emit(MovieDetailStateFailure(failure.message)),
      (movie) => emit(MovieDetailStateSuccess(movie)),
    );
  }
}
