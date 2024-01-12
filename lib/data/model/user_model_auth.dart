import 'package:equatable/equatable.dart';
import 'package:soywarmi_app/data/model/user_model.dart';

class UserModelAuth extends UserModel {
  final String password;
  final String rol;

  const UserModelAuth({
    id,
    email,
    required this.password,
    required this.rol,
  }) : super(id: id, email: email);

  @override
  List<Object?> get props => [id, email, password, rol];

  factory UserModelAuth.fromJson(Map<String, dynamic> json) => UserModelAuth(
        id: json['id'] as String,
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
