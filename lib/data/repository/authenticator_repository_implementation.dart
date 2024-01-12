import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soywarmi_app/core/failures.dart';
import 'package:soywarmi_app/data/remote/authenticator_firebase_remote_data_source.dart';
import 'package:soywarmi_app/domain/entity/user_entity.dart';
import 'package:soywarmi_app/domain/repository/authenticator_repository.dart';

import '../remote/user_public_general_remote_data_source.dart';

class AuthenticatorRepositoryImplementation extends AuthenticatorRepository {
  AuthenticatorRepositoryImplementation({
    required Map<String, AuthenticatorFirebaseRemoteDataSource> authenticators,
    required EmailAuthenticatorFirebaseRemoteDataSourceImplementation
        emailFirebaseAuthDataSource,
  })  : _authenticators = authenticators,
        _emailFirebaseAuthDataSource = emailFirebaseAuthDataSource;

  final Map<String, AuthenticatorFirebaseRemoteDataSource> _authenticators;

  final EmailAuthenticatorFirebaseRemoteDataSourceImplementation
      _emailFirebaseAuthDataSource;
  @override
  Future<Either<AuthenticationFailure, void>> signIn(String type,
      {String? email, String? password}) async {
    try {
      final authenticator = _authenticators[type];
      if (authenticator != null) {
        final result =
            await authenticator.signIn(email: email, password: password);

        return Right(result);
      } else {
        
        return Left(AuthenticationFailure('Invalid authenticator type'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure.fromSignInWithEmailCode(e.code));
    } on Exception catch (e) {
      return Left(AuthenticationFailure.fromSignInWithEmailCode(e.toString()));
    }
  }

  @override
  Future<Either<RegisterFailure, void>> signUp(
      {String? nombre,String? apellido,String? email, String? password}) async {
    try {
      final authenticator = _authenticators['email'];
      if (authenticator != null) {
        final result = await authenticator?.signUp(nombre:nombre,apellido:apellido,email: email, password: password);
        return Right(result);
      } else {
        return Left(RegisterFailure('Register Failure'));
      }
    } on Exception catch (e) {
      return Left(RegisterFailure(e.toString()));
    }
  }
}
