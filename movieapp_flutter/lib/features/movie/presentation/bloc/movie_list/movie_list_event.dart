import 'package:flutter/foundation.dart';

@immutable
sealed class MovieListEvent {}

final class FetchMoviesEvent extends MovieListEvent {}
