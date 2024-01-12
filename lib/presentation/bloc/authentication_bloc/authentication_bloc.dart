import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soywarmi_app/core/usecases.dart';
import 'package:soywarmi_app/domain/entity/user_entity.dart';
import 'package:soywarmi_app/domain/usescase/auth/read_authentication_state_usecase.dart';
import 'package:soywarmi_app/domain/usescase/auth/sign_out_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    ReadUserAuthenticationStateUseCase? readUserAuthenticationStateUseCase,
    SignOutUseCase? signOutUseCase,
  })  : _readUserAuthenticationStateUseCase =
            readUserAuthenticationStateUseCase ??
                ReadUserAuthenticationStateUseCase(),
        _signOutUseCase = signOutUseCase ?? SignOutUseCase(),
        super(AuthenticationInitial()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<SignOutRequested>(_onSignOutRequested);

    _isAuthenticatedSubscription =
        _readUserAuthenticationStateUseCase.isAuthenticated.listen(
      (isAuthenticated) {
        add(AuthenticationStatusChanged(isAuthenticated));
      },
    );
  }

  final ReadUserAuthenticationStateUseCase _readUserAuthenticationStateUseCase;

  final SignOutUseCase _signOutUseCase;

  late final StreamSubscription<bool> _isAuthenticatedSubscription;

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    print("Evento on authentication status changed");
    print(event.isAuthenticated);
    if (event.isAuthenticated) {
      final getUserResult =
          await _readUserAuthenticationStateUseCase.call(NoParams());
      print(getUserResult);
      getUserResult.fold(
        (error) => emit(const Unauthenticated()),
        (user) {
          if (user != null) {
            emit(Authenticated(user));
          } else {
            emit(const Unauthenticated());
          }
        },
      );
    } else if (event.isAuthenticated && state is Unauthenticated) {
      emit(AuthenticationInitial());
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _signOutUseCase.call(NoParams());
    emit(const Unauthenticated());
  }

  @override
  Future<void> close() {
    _isAuthenticatedSubscription.cancel();
    return super.close();
  }
}
