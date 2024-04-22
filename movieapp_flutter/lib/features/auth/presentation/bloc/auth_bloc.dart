import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:movieapp_flutter/core/entities/user.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/current_user.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_confirm_registration.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_logout.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit appUserCubit;
  final CurrentUserUseCase currentUser;
  final UserLoginUseCase userLogin;
  final UserLogoutUseCase userLogout;
  final UserRegisterUseCase userRegister;
  final UserConfirmRegistrationUseCase userConfirmRegistration;

  AuthBloc({
    required this.appUserCubit,
    required this.currentUser,
    required this.userLogin,
    required this.userLogout,
    required this.userRegister,
    required this.userConfirmRegistration,
  }) : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthStateLoading());
    });
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedIn);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthRegisterEvent>(_onAuthRegister);
    on<AuthConfirmRegistrationEvent>(_onAuthConfirmRegistration);
    on<AuthLogoutEvent>(_onAuthLogout);
  }

  FutureOr<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final result = await userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> _onAuthIsUserLoggedIn(
    AuthIsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await currentUser(NoParams());
    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> _onAuthRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    final result = await userRegister(
      UserRegisterParams(
        email: event.email,
        password: event.password,
        username: event.username,
      ),
    );

    result.fold((failure) => emit(AuthStateFailure(failure.message)), (success) {
      if (success) {
        emit(AuthStateConfirmationRequired(email: event.email, password: event.password));
      } else {
        emit(const AuthStateFailure("Could not register"));
      }
    });
  }

  FutureOr<void> _onAuthConfirmRegistration(AuthConfirmRegistrationEvent event, Emitter<AuthState> emit) async {
    final result = await userConfirmRegistration(
      UserConfirmRegistrationParams(
        email: event.email,
        verificationCode: event.verificationCode,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    final result = await userLogout(NoParams());

    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (_) {
        appUserCubit.logout();
        emit(AuthStateInitial());
      },
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    appUserCubit.updateUser(user);
    emit(AuthStateSuccess(user));
  }
}
