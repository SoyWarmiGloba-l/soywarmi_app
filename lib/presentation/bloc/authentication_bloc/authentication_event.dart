part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final bool isAuthenticated;
  const AuthenticationStatusChanged(this.isAuthenticated);

  @override
  List<Object> get props => [isAuthenticated];
}

class SignOutRequested extends AuthenticationEvent {

}

class MembershipUpdatedEvent extends AuthenticationEvent {
  final bool state;
  const MembershipUpdatedEvent(this.state);
}
