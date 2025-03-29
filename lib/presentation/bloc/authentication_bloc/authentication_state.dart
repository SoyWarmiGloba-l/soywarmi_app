part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  const Authenticated(this.user);
  final dynamic user;

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

class MembershipState {
  const MembershipState(this.state);
  final bool state;
}
