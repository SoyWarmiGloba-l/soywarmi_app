import 'package:equatable/equatable.dart';

class NotificationsModel extends Equatable {
  final int id;
  final String data;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;


  const NotificationsModel({
    required this.id,
    required this.data,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
        id: json['id'] as int,
        data: json['data'] as String,
        title: json['title'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        deletedAt: json['deleted_at'] != null
            ? DateTime.parse(json['deleted_at'] as String)
            : null,
    );
  }
  @override
  List<Object?> get props => [
    id,
    data,
    title,
    createdAt,
    updatedAt,
    deletedAt
  ];
}
