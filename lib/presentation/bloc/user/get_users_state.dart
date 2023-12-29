import 'package:equatable/equatable.dart';
import 'package:soywarmi_app/domain/entity/member_entity.dart';
import 'package:soywarmi_app/domain/entity/user_entity.dart';

abstract class GetUsersState extends Equatable {
  const GetUsersState();
  List<UserEntity>? get users => [];

  @override
  List<Object> get props => [];
}

class GetUsersInitial extends GetUsersState {}

class GetUsersLoading extends GetUsersState {}

class GetUsersLoaded extends GetUsersState {
  @override
  final List<UserEntity> users;

  const GetUsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class GetUsersError extends GetUsersState {
  final String message;

  const GetUsersError({required this.message});

  @override
  List<Object> get props => [message];
}