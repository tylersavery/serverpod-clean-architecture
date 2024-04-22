import 'package:fpdart/fpdart.dart';
import 'package:movieapp_flutter/core/entities/user.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/auth/domain/respositories/auth_repository.dart';

class UserConfirmRegistrationUseCase implements UseCase<User, UserConfirmRegistrationParams> {
  final AuthRepository authRepository;

  const UserConfirmRegistrationUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserConfirmRegistrationParams params) async {
    final confirmationResult = await authRepository.confirmRegistration(
      email: params.email,
      verificationCode: params.verificationCode,
    );

    return await confirmationResult.fold((failure) => left(failure), (r) async {
      return await authRepository.loginWithEmailPassword(
        email: params.email,
        password: params.password,
      );
    });
  }
}

class UserConfirmRegistrationParams {
  final String email;
  final String verificationCode;
  final String password;

  const UserConfirmRegistrationParams({
    required this.email,
    required this.verificationCode,
    required this.password,
  });
}
