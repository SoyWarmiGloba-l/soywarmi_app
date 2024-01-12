import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soywarmi_app/presentation/bloc/register/register_state.dart';
import 'package:soywarmi_app/presentation/widget/custom_button.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_field.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_password.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

import '../../data/remote/authenticator_firebase_remote_data_source.dart';
import '../../data/repository/authenticator_repository_implementation.dart';
import '../../domain/usescase/auth/register_usecase.dart';
import '../../utilities/screen_size_util.dart';
import '../bloc/authentication_bloc/authentication_bloc.dart';
import '../bloc/register/register_cubit.dart';
import '../bloc/sign_in_cubit/sign_in_cubit.dart';
import '../widget/custom_text_field_login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, AuthenticatorFirebaseRemoteDataSource> authenticators = {
      'email': EmailAuthenticatorFirebaseRemoteDataSourceImplementation(),
      'google': GoogleAuthenticatorFirebaseRemoteDataSourceImplementation(),
    };
    return BlocProvider(
      create: (context) => RegisterCubit(
        registerUsecase: RegisterUsecase(
          authenticatorRepository: AuthenticatorRepositoryImplementation(
              authenticators: authenticators,
              emailFirebaseAuthDataSource:
                  EmailAuthenticatorFirebaseRemoteDataSourceImplementation()),
        ),
      ),
      child: const _RegisterPage(),
    );
  }
}

class _RegisterPage extends StatefulWidget {
  const _RegisterPage();

  @override
  State<_RegisterPage> createState() => __RegisterPageState();
}

class __RegisterPageState extends State<_RegisterPage> {
  final _formRegisterKey = GlobalKey<FormState>();
  TextEditingController correo = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController contrasenia = TextEditingController();
  TextEditingController confirmar_contrasenia = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.init(context);
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
            print(
                "STATE----------------------------------------------------------------------------------------");
            print(state);
            if (state is RegisterSuccess) {
              context
                  .read<AuthenticationBloc>()
                  .add(const AuthenticationStatusChanged(true));
            }
          },
          builder: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.pop(context);
            }
            if (state is RegisterLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            return Center(
                child: Container(
              margin: EdgeInsets.only(right: 23, left: 23),
              child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        NBWarmiLogo,
                        height: 160,
                        width: 250,
                      ),
                      const Text(
                        'Crea tu cuenta',
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: NBPrimaryColor),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: _formRegisterKey,
                        child: Column(children: [
                          getTextFieldRegister(context, "Correo", correo),
                          getTextFieldRegister(context, "Nombre", nombre),
                          getTextFieldRegister(context, "Apellido", apellido),
                          getTextFieldPassowrdRegister(
                              context, "Contrasenia", contrasenia),
                          getTextFieldPassowrdRegister(
                              context, "Contrasenia", confirmar_contrasenia),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: CustomButton(
                          label: 'Crear cuenta',
                          onPressed: () {
                            if (_formRegisterKey.currentState!.validate()) {
                              _formRegisterKey.currentState!.save();
                              context.read<RegisterCubit>().signUp(
                                    nombre: nombre.text,
                                    apellido: apellido.text,
                                    email: correo.text,
                                    password: contrasenia.text,
                                  );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('¿Ya tienes cuenta?',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.5))),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              ' Inicia Sesión',
                              style: TextStyle(
                                color: NBSecondPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ));
          },
          // listener: (context,state){

          // },
          // builder: (context,state){
          //   return Text("data");
          // },
        ));
  }
}
