import 'package:equatable/equatable.dart';

class UserModel {
  final int id;
  final String email;
  final String name;
  final String lastname;
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.lastname
  });

  @override
  List<Object?> get props => [id, email,name,lastname];

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    email: json['email'] as String,
    name: json['name'] as String,
    lastname: json['lastname'] as String,

  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name':name,
    'lastname':lastname,
  };
}
