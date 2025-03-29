import 'dart:convert';
import 'dart:ffi';

import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final int id;
  final int eventTypeId;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final List<String> areas;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<EventTypeModel> eventTypes;
  final List<dynamic> images;

  const NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.startDate,
    required this.endDate,
    required this.areas,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.eventTypes,
    required this.eventTypeId,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final areas = jsonDecode(json['areas'] as String) ;
  return NewsModel(
    id: json['id'] as int,
    eventTypeId: json['event_type_id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    images: json['images'] ?? [],
    startDate: json['start_date'] as String,
    endDate: json['end_date'] as String,
    areas: [],
    createdAt: (json['created_at']!=null)?DateTime.parse(json['created_at'] as String):DateTime.now(),
    updatedAt: DateTime.parse(json['updated_at'] as String),
    deletedAt: json['deleted_at'] != null
        ? DateTime.parse(json['deleted_at'] as String)
        : null,
    eventTypes: (json['event_types'] as List<dynamic>?)
        ?.map((e) => EventTypeModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
  );
}


  @override
  List<Object?> get props => [
        id,
        title,
        description,
        images,
        startDate,
        endDate,
        areas,
        createdAt,
        updatedAt,
        deletedAt,
        eventTypes,
        eventTypeId,
      ];
}

class EventTypeModel {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const EventTypeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }
}
