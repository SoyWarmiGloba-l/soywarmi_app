import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soywarmi_app/core/usecases.dart';
import 'package:soywarmi_app/domain/usescase/team/get_teams_usecase.dart';
import '../../../domain/usescase/users/get_users_usecase.dart';
import 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {

  GetUsersCubit({
    required GetUsersUseCase getUsersUseCase,
  })  : _getUsersUseCase = getUsersUseCase,
        super(GetUsersInitial());

  final GetUsersUseCase _getUsersUseCase;


  Future<void> getUsers() async {
    emit(GetUsersLoading());

    final result = await _getUsersUseCase(
      NoParams(),
    );
    result.fold(
          (failure) => emit(GetUsersError(message: failure.message)),
          (users) => emit(GetUsersLoaded(users: users)),
    );
  }


}
