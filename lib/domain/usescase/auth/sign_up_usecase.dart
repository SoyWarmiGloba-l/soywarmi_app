import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/core/failures.dart';
import 'package:soywarmi_app/core/usecases.dart';
import 'package:soywarmi_app/domain/entity/user_entity.dart';
import 'package:soywarmi_app/domain/repository/authenticator_repository.dart';

class SignUpUseCase extends FutureUsesCase<void, SignUpParams> {
  SignUpUseCase({
    required AuthenticatorRepository authenticatorRepository,
  }) : _authenticatorRepository = authenticatorRepository;

  final AuthenticatorRepository _authenticatorRepository;
  @override
  Future<Either<Failure, void>> call(SignUpParams params) {
    return _authenticatorRepository.signUp(
      nombre: params.nombre,
      apellido: params.apellido,
      email:params.email,
      password:params.password
    );
  }
}

class SignUpParams {
  const SignUpParams({this.nombre,this.apellido,this.email, this.password});
  final String? nombre;
  final String? apellido;
  final String? password;
  final String? email;
}
