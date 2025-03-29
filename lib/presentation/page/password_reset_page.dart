import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/data/repository/authentication_state_repositoy_implementation.dart';
import 'package:soywarmi_app/domain/usescase/auth/reset_password_usecase.dart';
import 'package:soywarmi_app/presentation/bloc/reset_password/reset_password_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:soywarmi_app/presentation/widget/custom_button.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_field.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/screen_size_util.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NBColorWhite,
        elevation: 0,
        centerTitle: false,
        title:  Text(LocaleData.atras.getString(context), style: const TextStyle(color: NBPrimaryColor)),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: BlocProvider(
        create: (context) => ResetPasswordCubit(
            resetPasswordUseCase: ResetPasswordUseCase(
                authenticatorRepository:
                    AuthenticationStateRepositoryImplementation())),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Se ha enviado un correo a $_email'),
                backgroundColor: NBPrimaryColor,
              ),
            );
          }

          if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: NBPrimaryColor,
              ),
            );
          }
        }, builder: (context, state) {
          return Center(
              child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/reset_password.json',
                      height: ScreenSizeUtil.scaleWidth(0.28),
                      width: ScreenSizeUtil.scaleHeight(0.8),
                    ),
                    Text(
                      '${LocaleData.olvidasteContrasena.getString(context)}?',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: NBPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, top: 10, bottom: 20),
                      child: Text(
                        'Ingresa tu direccion de correo electronico y te enviaremos un enlace a tu correo para restablecer tu contraseña espera unos minutos, busca en spam o vuelve a intentarlo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: NBPrimaryColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    CustomTextField(
                      label: LocaleData.correoElectronico.getString(context),
                      onSaved: (value) {
                        _email = value!;
                      },
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, introduce tu correo electronico';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: CustomButton(
                        label: LocaleData.restablecerContrasena.getString(context),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            context
                                .read<ResetPasswordCubit>()
                                .resetPassword(_email);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        }),
      ),
    );
  }
}
