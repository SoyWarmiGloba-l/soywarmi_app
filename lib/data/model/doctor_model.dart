

import 'package:soywarmi_app/data/model/person_model.dart';

class DoctorModel extends PersonModel {
  final String specialty;
  final String university;

  const DoctorModel({
    required int id,
    required String name,
    required String lastName,
    required String motherLastname,
    required String birthday,
    required String gender,
    required int phoneNumber,
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
          phone: phoneNumber,
          email: email,
          photo: photo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,

        );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['person']['id'] as int,
      name: (json['person']['name'] ?? '') as String,
      lastName: (json['person']['lastname'] ?? '') as String,
      motherLastname: (json['person']['mother_lastname'] ?? '') as String,
      birthday: (json['person']['birthday'] ?? '' ) as String,
      gender: (json['person']['gender'] ?? '') as String,
      phoneNumber: (json['person']['phoneNumber'] ?? 00000000) as int,
      email: (json['person']['email'] ?? '') as String,
      photo: (json['person']['photo'] ?? '') as String,
      phone: (json['person']['phone'] ?? '') as int,
      createdAt: (json['person']['created_at'] ?? '') as String,
      updatedAt: (json['person']['update_at'] ?? '') as String,
      deletedAt: (json['person']['deleted_at'] ?? false) as bool,
      specialty: (json['speciality'] ?? '') as String,
      university: (json['university'] ?? '') as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
