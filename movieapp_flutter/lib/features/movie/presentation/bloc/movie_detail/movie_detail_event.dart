import 'package:flutter/foundation.dart';

@immutable
sealed class MovieDetailEvent {}

final class MovieDetailRetrieveEvent extends MovieDetailEvent {
  final int id;
  MovieDetailRetrieveEvent({required this.id});
}
