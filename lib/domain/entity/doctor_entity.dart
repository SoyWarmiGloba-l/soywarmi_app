import 'package:soywarmi_app/domain/entity/person_entity.dart';

class DoctorEntity extends PersonEntity {
  final String specialty;
  final String university;

  const DoctorEntity({
    required int id,
    required String name,
    required String lastName,
    required String motherLastname,
    required String birthday,
    required String gender,
    required String email,
    required String photo,
    required int phone,
    required String createdAt,
    required String updatedAt,
    required bool deletedAt,
    required this.specialty,
    required this.university,
  }) : super(
          id: id,
          name: name,
          lastName: lastName,
          motherLastname: motherLastname,
          birthday: birthday,
          gender: gender,
          phone: phone,
          email: email,
          photo: photo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );
}
