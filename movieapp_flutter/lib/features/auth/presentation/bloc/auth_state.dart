part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthStateInitial extends AuthState {}

final class AuthStateLoading extends AuthState {}

final class AuthStateSuccess extends AuthState {
  final User user;
  const AuthStateSuccess(this.user);
}

final class AuthStateFailure extends AuthState {
  final String message;
  const AuthStateFailure(this.message);
}

final class AuthStateConfirmationRequired extends AuthState {
  final String email;
  final String password;
  const AuthStateConfirmationRequired({
    required this.email,
    required this.password,
  });
}
