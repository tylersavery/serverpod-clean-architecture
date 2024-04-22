import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/exceptions.dart';
import 'package:movieapp_flutter/features/auth/data/models/user_model.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

abstract interface class AuthDataSource {
  UserModel? currentUser();

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  });

  Future<UserModel> confirmRegistration({required String email, required String verificationCode});

  Future<void> logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  final Client client;
  final SessionManager sessionManager;

  const AuthDataSourceImpl(this.client, this.sessionManager);

  @override
  UserModel? currentUser() {
    final user = sessionManager.signedInUser;
    if (user != null && user.id != null && user.email != null) {
      return UserModel(id: user.id!, email: user.email!, username: user.userName);
    }

    return null;
  }

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await client.modules.auth.email.authenticate(email, password);

      if (!result.success) {
        throw ServerException(result.failReason?.toString() ?? "Could not login");
      }

      if (result.userInfo == null) {
        throw const ServerException("User not found");
      }

      if (result.userInfo!.email == null) {
        throw const ServerException("Email not found");
      }

      if (result.keyId == null || result.key == null) {
        throw const ServerException("Not key or keyid found");
      }

      await sessionManager.registerSignedInUser(
        result.userInfo!,
        result.keyId!,
        result.key!,
      );

      return UserModel(
        id: result.userInfo!.id!,
        email: result.userInfo!.email!,
        username: result.userInfo!.userName,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final result = await client.modules.auth.email.createAccountRequest(username, email, password);

      if (result == false) {
        throw const ServerException("Could not create account");
      }

      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> confirmRegistration({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final result = await client.modules.auth.email.createAccount(email, verificationCode);

      if (result == null) {
        throw const ServerException("User was null");
      }

      if (result.id == null || result.email == null) {
        throw const ServerException("Id or Email was null");
      }

      return UserModel(
        id: result.id!,
        email: result.email!,
        username: result.userName,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await sessionManager.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
