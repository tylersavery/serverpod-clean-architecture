import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/list_movies.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final ListMoviesUseCase listMovies;

  MovieListBloc({required this.listMovies}) : super(MovieListStateInitial()) {
    on<MovieListEvent>((_, emit) => emit(MovieListStateLoading()));
    on<FetchMoviesEvent>(_onFetchMovies);
  }

  Future<void> _onFetchMovies(MovieListEvent event, Emitter<MovieListState> emit) async {
    final result = await listMovies(NoParams());

    result.fold(
      (failure) => emit(MovieListStateFailure(failure.message)),
      (movies) => emit(MovieListStateSuccess(movies)),
    );
  }
}
