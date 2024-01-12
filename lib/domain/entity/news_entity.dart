import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
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
  final List<EventTypeEntity> eventTypes;
  final String image;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.areas,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.eventTypes,
    required this.eventTypeId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
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

class EventTypeEntity {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const EventTypeEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
}
