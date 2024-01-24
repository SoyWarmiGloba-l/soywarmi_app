import 'package:soywarmi_app/data/model/person_model.dart';

class MemberModel extends PersonModel {
  final String description;
  final String rolEquipo;
  final SocialNetwoork socialNetworks;

  const MemberModel({
    required int id,
    required String name,
    required String lastName,
    required String motherLastname,
    required String birthday,
    required String gender,
    required String phoneNumber,
    required String email,
    required String photo,
    required int phone,
    required String createdAt,
    required String updatedAt,
    required bool deletedAt,
    required this.description,
    required this.rolEquipo,
    required this.socialNetworks,
  }) : super(
          id: id,
          name: name,
          lastName: lastName,
          motherLastname: motherLastname,
          birthday: birthday,
          gender: gender,
          email: email,
          photo: photo,
          phone: phone,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
        id: 0,
        name: (json['name'] ?? '') as String,
        lastName: (json['lastname'] ?? '') as String,
        motherLastname: (json['mother_lastname'] ?? '') as String,
        birthday: (json['birthday'] ?? '') as String,
        gender: (json['gender'] ?? '') as String,
        phoneNumber: (json['phoneNumber'] ?? '') as String,
        email: (json['email'] ?? '') as String,
        photo: (json['photo'] ?? '') as String,
        phone: (json['phone'] ?? 00000000) as int,
        createdAt: (json['created_at'] ?? '') as String,
        updatedAt: (json['update_at'] ?? '') as String,
        deletedAt: (json['deleted_at'] ?? false) as bool,
        description: (json['description'] ?? '') as String,
        rolEquipo: (json['rol_equipo'] ?? '') as String,
        socialNetworks: SocialNetwoork(
          twitter: (json['twitter'] ?? '') as String,
          facebook: (json['facebook'] ?? '') as String,
          instagram: (json['instagram'] ?? '') as String,
        )
        
        
        );
        
  }
}

class SocialNetwoork {
  final String twitter;
  final String facebook;
  final String instagram;

  const SocialNetwoork({
    required this.twitter,
    required this.facebook,
    required this.instagram,
  });

  
}
