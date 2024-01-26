import 'package:equatable/equatable.dart';

class PublicationEntity extends Equatable {
  final int id;
  final int personId;
  final String title;
  final String content;
  final int anonymous;
  final List<String> images;
  final String ownerName;
  final String ownerPhoto;
  final int numberComments;
  const PublicationEntity({
    required this.id,
    required this.personId,
    required this.title,
    required this.content,
    required this.anonymous,
    required this.images,
    required this.ownerName,
    required this.ownerPhoto,
    required this.numberComments
  });

  @override
  List<Object?> get props => [
        id,
        personId,
        title,
        content,
        anonymous,
        images,
        ownerName,
        ownerPhoto,
        numberComments
      ];
}
