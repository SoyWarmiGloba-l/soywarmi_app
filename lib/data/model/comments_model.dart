import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CommentsModel extends Equatable {
  final int id;
  final int personId;
  final int publicationId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String ownerName;
  final String ownerPhoto;

  const CommentsModel({
    required this.id,
    required this.personId,
    required this.publicationId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.ownerName,
    required this.ownerPhoto,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    final endPoint = dotenv.env['API_ENDPOINT'];

    return CommentsModel(
      id: json['id'] as int,
      personId: json['person_id'] as int,
      publicationId: json['publication_id'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      ownerName: (json.containsKey("person") && json['person']!=null)?json["person"]["name"]:'Anonimo',
      ownerPhoto: (json.containsKey("photo") && json['photo']!='')?'$endPoint${json["person"]["photo"]}':'https://drive.google.com/file/d/12V8D0w45iG9NdaQxBPyssK2MQv7qpZ4M/view?usp=sharing',
    );
  }


  @override
  List<Object?> get props => [
    id,
    personId,
    publicationId,
    content,
    createdAt,
    updatedAt,
    deletedAt,
    ownerName,
    ownerPhoto,
  ];
}
