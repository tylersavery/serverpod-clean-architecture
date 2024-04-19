import 'package:flutter/foundation.dart';

@immutable
sealed class MovieRetrieveEvent {}

final class FetchMovieEvent extends MovieRetrieveEvent {
  final int id;
  FetchMovieEvent({required this.id});
}
