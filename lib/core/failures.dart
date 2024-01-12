import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class GenericFailure extends Failure {}

class DoctorFailure extends Failure {
  DoctorFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class TeamFailure extends Failure {
  TeamFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
class CreateChatConversationFailure extends Failure {
  CreateChatConversationFailure([String? message])
      : message =
      message ?? 'Ha ocurrido un error inesperado, inténtelo de nuevo.';
  final String message;

  @override
  List<Object> get props => [message];

}
class ActivityFailure extends Failure {
  ActivityFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
class UserFailure extends Failure {
  UserFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
class FaqsFailure extends Failure {
  FaqsFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class MedicalCenterFailure extends Failure {
  MedicalCenterFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
class NewsFailure extends Failure {
  NewsFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
class ChatConversationsFailure extends Failure {
  ChatConversationsFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

class PublicationsFailure extends Failure {
  PublicationsFailure(this.message);
  final String message;


  @override
  List<Object> get props => [message];
}
class AuthenticationFailure extends Failure {
  AuthenticationFailure([String? message])
      : message =
            message ?? 'Ha ocurrido un error inesperado, inténtelo de nuevo.';

  factory AuthenticationFailure.fromSignInWithEmailCode(String code) {
    switch (code) {
      case 'invalid-email':
        return AuthenticationFailure(
          'El correo es inválido o tiene un formato incorrecto.',
        );
      case 'user-disabled':
        return AuthenticationFailure(
          'Este correo ha sido deshabilitado. Contacte a soporte por ayuda.',
        );
      case 'user-not-found':
        return AuthenticationFailure(
          'Usuario no registrado, verifique que su correo sea el correcto.',
        );
      case 'wrong-password':
        return AuthenticationFailure(
          'La contraseña es incorrecta.',
        );
      case 'INVALID_LOGIN_CREDENTIALS':
        return AuthenticationFailure(
          'Credenciales inválidas.',
        );
      default:
        return AuthenticationFailure(code);
    }
  }

  factory AuthenticationFailure.fromSignUpWithEmailCode(String code) {
    switch (code) {
      case 'invalid-email':
        return AuthenticationFailure(
          'El correo es inválido o tiene un formato incorrecto.',
        );
      case 'user-disabled':
        return AuthenticationFailure(
          'Este correo ha sido deshabilitado. Contacta a soporte por ayuda.',
        );
      case 'email-already-in-use':
        return AuthenticationFailure(
          'El correo ya está en uso con otra cuenta.',
        );
      case 'operation-not-allowed':
        return AuthenticationFailure(
          'Operación no permitida. Por favor contacte a soporte.',
        );
      case 'weak-password':
        return AuthenticationFailure(
          'La contraseña ingresada es insegura.',
        );
      default:
        return AuthenticationFailure();
    }
  }
  final String message;

  @override
  List<Object> get props => [message];
}
