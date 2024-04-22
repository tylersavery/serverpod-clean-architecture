import 'package:fpdart/fpdart.dart';
import 'package:movieapp_flutter/core/entities/user.dart';
import 'package:movieapp_flutter/core/error/failure.dart';

abstract interface class AuthRepository {
  Either<Failure, User> currentUser();

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  });

  Future<Either<Failure, User>> confirmRegistration({
    required String email,
    required String verificationCode,
  });

  Future<Either<Failure, void>> logout();
}
