import 'package:flutter/material.dart';
import 'package:movieapp_client/movieapp_client.dart';

@immutable
sealed class MovieListState {
  const MovieListState();
}

final class MovieListStateInitial extends MovieListState {}

final class MovieListStateLoading extends MovieListState {}

final class MovieListStateSuccess extends MovieListState {
  final List<Movie> movies;

  const MovieListStateSuccess(this.movies);
}

final class MovieListStateFailure extends MovieListState {
  final String message;

  const MovieListStateFailure(this.message);
}
