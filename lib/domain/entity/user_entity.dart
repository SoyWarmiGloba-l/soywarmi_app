import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String name;
  final String lastname;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.lastname
  });

  @override
  List<Object?> get props => [id, email,name,lastname];
}
