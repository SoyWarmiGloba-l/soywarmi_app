import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/usecases.dart';
import '../../repository/authenticator_repository.dart';

class RegisterUsecase extends FutureUsesCase<void, SignUpParams> {
  RegisterUsecase({
    required AuthenticatorRepository authenticatorRepository,
  }) : _authenticatorRepository = authenticatorRepository;

  final AuthenticatorRepository _authenticatorRepository;
  @override
  Future<Either<RegisterFailure, void>> call(SignUpParams params) {
    return _authenticatorRepository.signUp(
      nombre: params.nombre,
      apellido: params.apellido,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  const SignUpParams({this.nombre,this.apellido, this.email, this.password});
  final String? nombre;
  final String? apellido;
  final String? email;
  final String? password;
}