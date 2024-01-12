import 'package:equatable/equatable.dart';

class UserModel {
  final String id;
  final String email;

  const UserModel({
    required this.id,
    required this.email,
  });

  @override
  List<Object?> get props => [id, email];

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    email: json['email'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
  };
}
