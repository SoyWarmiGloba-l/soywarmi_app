import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  final int id;
  final String name;
  final String lastName;
  final String motherLastname;
  final String email;
  final String photo;
  final String birthday;
  final String gender;
  final int phone;
  final String createdAt;
  final String updatedAt;
  final bool deletedAt;

  const PersonModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.motherLastname,
    required this.birthday,
    required this.gender,
    required this.email,
    required this.photo,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
        motherLastname,
        birthday,
        gender,
        email,
        photo,
        phone,
        createdAt,
        updatedAt,
        deletedAt
      ];
}
