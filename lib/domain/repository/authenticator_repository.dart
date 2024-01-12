import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/core/failures.dart';
import 'package:soywarmi_app/domain/entity/user_entity.dart';

abstract class AuthenticatorRepository {
  Future<Either<AuthenticationFailure, void>> signIn(
    String type, {
    String? email,
    String? password,
  });

  Future<Either<RegisterFailure, void>> signUp({
    String? nombre,
    String? apellido,
    String? email,
    String? password,
  });
}
