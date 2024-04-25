part of 'movie_manage_bloc.dart';

@immutable
sealed class MovieManageEvent {}

final class MovieManageRetrieveEvent extends MovieManageEvent {
  final int id;
  MovieManageRetrieveEvent(this.id);
}

final class MovieManageSaveEvent extends MovieManageEvent {
  final Movie movie;
  MovieManageSaveEvent(this.movie);
}

final class MovieManageDeleteEvent extends MovieManageEvent {
  final int movieId;
  MovieManageDeleteEvent(this.movieId);
}
