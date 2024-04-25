part of 'movie_manage_bloc.dart';

@immutable
sealed class MovieManageState {}

final class MovieManageStateInitial extends MovieManageState {}

final class MovieManageStateLoading extends MovieManageState {}

final class MovieManageStateRetrieveSuccess extends MovieManageState {
  final Movie movie;

  MovieManageStateRetrieveSuccess(this.movie);
}

final class MovieManageStateFailure extends MovieManageState {
  final String message;

  MovieManageStateFailure(this.message);
}

final class MovieManageStateSaveSuccess extends MovieManageState {
  final Movie movie;

  MovieManageStateSaveSuccess(this.movie);
}

final class MovieManageStateDeleteSuccess extends MovieManageState {}
