import 'package:equatable/equatable.dart';
import 'package:soywarmi_app/data/model/user_model.dart';

class UserModelAuth extends UserModel {
  final String password;
  final String rol;

  const UserModelAuth({
    id,
    email,
    name,
    lastname,
    required this.password,
    required this.rol,
  }) : super(id: id, email: email,name:name,lastname: lastname);

  @override
  List<Object?> get props => [id, email, password, rol];

  factory UserModelAuth.fromJson(Map<String, dynamic> json) => UserModelAuth(
        id: json['id'] as int,
        email: json['email'] as String,
        password: json['password'] as String,
        rol: json['rol'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'rol': rol,
      };
}
