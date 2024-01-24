import 'package:equatable/equatable.dart';

class PublicationModel extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String description;
  final bool anonymous;
  final List<String> images;

  const PublicationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.anonymous,
    required this.images,
  });

  factory PublicationModel.fromJson(Map<String, dynamic> json) {
    return PublicationModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      anonymous: json['anonymous'] as bool,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'anonymous': anonymous,
      'images': images,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        anonymous,
        images,
      ];
}
