import 'package:flutter/material.dart';
import 'package:movieapp_client/movieapp_client.dart';

@immutable
sealed class MovieDetailState {
  const MovieDetailState();
}

final class MovieDetailStateInitial extends MovieDetailState {}

final class MovieDetailStateLoading extends MovieDetailState {}

final class MovieDetailStateSuccess extends MovieDetailState {
  final Movie movie;

  const MovieDetailStateSuccess(this.movie);
}

final class MovieDetailStateFailure extends MovieDetailState {
  final String message;

  const MovieDetailStateFailure(this.message);
}
