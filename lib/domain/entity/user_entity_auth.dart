import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soywarmi_app/domain/entity/user_entity.dart';

class UserEntityAuth extends UserEntity {
  final String password;
  final String rol;

  const UserEntityAuth({
    id,
    email,
    required this.password,
    required this.rol,
  }):super(id: id,email: email);

  @override
  List<Object?> get props => [id, email, password, rol];

}
