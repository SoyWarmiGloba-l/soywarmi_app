import 'package:equatable/equatable.dart';

class PublicationModel extends Equatable {
  final int id;
  final int personId;
  final String title;
  final String content;
  final String ownerName;
  final int anonymous;
  final List<String> images;
  final String ownerPhoto;
  final int numberComments;

  const PublicationModel({
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

  factory PublicationModel.fromJson(Map<String, dynamic> json) {
    List<String>images=[];
    if(json.containsKey('photo1') && json["photo1"]!="") images.add(json["photo1"]);
    if(json.containsKey('photo2') && json["photo2"]!="") images.add(json["photo2"]);
    if(json.containsKey('photo3') && json["photo3"]!="") images.add(json["photo3"]);

    return PublicationModel(
      id: json['id'] as int,
      ownerPhoto: json['person']['photo'] ?? "",
      ownerName: '${json['person']['name']} ${json['person']['lastname']} ${json['person']['mother_lastname']}',
      personId: json['person_id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      anonymous: json['anonymous'] as int,
      images: images,
        numberComments:json['comments'].length
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person_id': personId,
      'title': title,
      'content': content,
      'anonymous': anonymous,
      'images': images,
      'ownerName': ownerName,
      'ownerPhoto': ownerPhoto,
      'numberComments':numberComments
    };
  }

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
