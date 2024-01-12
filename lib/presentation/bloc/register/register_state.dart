import 'package:equatable/equatable.dart';
import 'package:soywarmi_app/core/failures.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}
class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {
  RegisterFailed(RegisterFailure failure) : message = failure.message;
  final String message;

  @override
  List<Object> get props => [message];
}