import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soywarmi_app/domain/entity/user_entity.dart';

class UserEntityAuth extends UserEntity {
  final String password;
  final String rol;

  const UserEntityAuth({
    id,
    email,
    name,
    lastname,
    required this.password,
    required this.rol,
  }):super(id: id,email: email,name: name,lastname: lastname);

  @override
  List<Object?> get props => [id, email, password, rol];

}
