import 'package:bloc/bloc.dart';
import 'package:soywarmi_app/domain/usescase/auth/register_usecase.dart';
import 'package:soywarmi_app/presentation/bloc/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required RegisterUsecase registerUsecase,
  })  : _registerUsecase = registerUsecase,
        super(RegisterInitial());

  final RegisterUsecase _registerUsecase;

  Future<void> signUp({String? nombre,String? apellido,String? email, String? password}) async {
    emit(RegisterLoading());

    final result = await _registerUsecase(
      SignUpParams(
        nombre: nombre,
        apellido:apellido,
        email: email,
        password: password,
      ),
    );

    result.fold(
          (failure) => emit(RegisterFailed(failure)),
          (success) => emit(RegisterSuccess()),
    );
  }
}
