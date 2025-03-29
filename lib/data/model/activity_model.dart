import 'dart:convert';

import 'package:equatable/equatable.dart';

class ActivityModel extends Equatable {
  final int id;
  final int eventTypeId;
  final String name;
  final String description;
  final String endDate;
  final List<String> step;
  final List<String> area;
  final List<String> requirement;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final EventType eventType;
  final List<dynamic> images;

  const ActivityModel({
    required this.id,
    required this.eventTypeId,
    required this.name,
    required this.description,
    required this.endDate,
    required this.step,
    required this.area,
    required this.requirement,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.eventType,
    required this.images,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    final steps = jsonDecode(json['step']) ;
    final areas =jsonDecode(json['area']);
    final requirements = jsonDecode(json['requirement']) ;


    return ActivityModel(
      id: json['id'] as int,
      eventTypeId: json['event_type_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      endDate: json['end_date'] as String,
      step: [],
      area: [],
      requirement: const ['Cédula de ciudadanía', 'Certificado de residencia'],
      createdAt: json['created_at']!=null?DateTime.parse(json['created_at'] as String):DateTime.now(),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      eventType: EventType.fromJson(json['event_type'] as Map<String, dynamic>),
      images: json['images']??[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_type_id': eventTypeId,
      'name': name,
      'description': description,
      'end_date': endDate,
      'step': step,
      'area': area,
      'requirement': requirement,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'event_type': eventType.toJson(),
      'images': images,
    };
  }

  @override
  List<Object?> get props => [
        id,
        eventTypeId,
        name,
        description,
        endDate,
        step,
        area,
        requirement,
        createdAt,
        updatedAt,
        deletedAt,
        eventType,
        images,
      ];
}

class EventType {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  EventType({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
