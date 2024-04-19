import 'package:flutter/material.dart';
import 'package:movieapp_client/movieapp_client.dart';

@immutable
sealed class MovieRetrieveState {
  const MovieRetrieveState();
}

final class MovieRetrieveStateInitial extends MovieRetrieveState {}

final class MovieRetrieveStateLoading extends MovieRetrieveState {}

final class MovieRetrieveStateSuccess extends MovieRetrieveState {
  final Movie movie;

  const MovieRetrieveStateSuccess(this.movie);
}

final class MovieRetrieveStateFailure extends MovieRetrieveState {
  final String message;

  const MovieRetrieveStateFailure(this.message);
}
