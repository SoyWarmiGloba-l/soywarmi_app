import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
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
  final EventTypeEnity eventType;
  final List<String> images;

  const ActivityEntity({
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

class EventTypeEnity {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  EventTypeEnity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
}
