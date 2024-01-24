import 'package:equatable/equatable.dart';

class PublicationEntity extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String description;
  final bool anonymous;
  final List<String> images;

  const PublicationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.anonymous,
    required this.images,
  });

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
