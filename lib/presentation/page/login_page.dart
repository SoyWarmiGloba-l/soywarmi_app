import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/data/remote/authenticator_firebase_remote_data_source.dart';
import 'package:soywarmi_app/data/repository/authenticator_repository_implementation.dart';
import 'package:soywarmi_app/domain/usescase/auth/sign_in_usecase.dart';
import 'package:soywarmi_app/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:soywarmi_app/presentation/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:soywarmi_app/presentation/widget/custom_button.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_field.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_password.dart';
import 'package:soywarmi_app/presentation/widget/google_button.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import 'package:soywarmi_app/utilities/screen_size_util.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, AuthenticatorFirebaseRemoteDataSource> authenticators = {
      'email': EmailAuthenticatorFirebaseRemoteDataSourceImplementation(),
      'google': GoogleAuthenticatorFirebaseRemoteDataSourceImplementation(),
    };
    return BlocProvider(
      create: (context) => SignInCubit(
        signInUseCase: SignInUseCase(
          authenticatorRepository: AuthenticatorRepositoryImplementation(
              authenticators: authenticators,
              emailFirebaseAuthDataSource:
                  EmailAuthenticatorFirebaseRemoteDataSourceImplementation()),
        ),
      ),
      child: const _LoginPageView(),
    );
  }
}

class _LoginPageView extends StatefulWidget {
  const _LoginPageView();

  @override
  State<_LoginPageView> createState() => __LoginPageViewState();
}

class __LoginPageViewState extends State<_LoginPageView> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late FlutterLocalization _flutterLocalization;
  late String _selectedLanguage;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _selectedLanguage = _flutterLocalization.currentLocale!.languageCode;
    print(_selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }

          if (state is SignInSuccess) {
            context
                .read<AuthenticationBloc>()
                .add(const AuthenticationStatusChanged(true));
          }
        },
        builder: (context, state) {
          if (state is SignInLoading || state is SignInSuccess) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          return Stack(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Image.asset(
                          NBWarmiLogo,
                          width: ScreenSizeUtil.scaleWidth(0.8),
                          height: ScreenSizeUtil.scaleHeight(0.28),
                        ),
                        Text(
                          LocaleData.inicioSesion.getString(context),
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(height: ScreenSizeUtil.scaleHeight(0.05)),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(children: [
                              CustomTextField(
                                label: LocaleData.correoElectronico.getString(context),
                                onSaved: (value) {
                                  _email = value!;
                                },
                                validator: (values) {
                                  if (values!.isEmpty) {
                                    return 'Por favor, introduce tu correo electronico';
                                  }
                                  return null;
                                },
                                type: TextInputType.emailAddress,
                                controller: emailController,
                                colored: true,
                              ),
                              CustomTextPassword(
                                label: LocaleData.contrasena.getString(context),
                                type: TextInputType.visiblePassword,
                                onSaved: (value) {
                                  _password = value!;
                                },
                                validator: (values) {
                                  if (values!.isEmpty) {
                                    return 'Por favor, introduce tu contraseña';
                                  }
                                  return null;
                                },
                                controller: passwordController,
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/forgot_password');
                                    },
                                    child: Text(LocaleData.olvidasteContrasena.getString(context),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .primaryColorDark
                                                .withOpacity(0.5))),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: CustomButton(
                                  label: LocaleData.inicioSesion.getString(context)  ,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      context.read<SignInCubit>().signIn(
                                            'email',
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                    }
                                  },
                                ),
                              ),
                              const Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('O',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              /*GoogleButton(
                                title: LocaleData.iniciaSesionGoogle.getString(context),
                                onPressed: () {
                                  BlocProvider.of<SignInCubit>(context)
                                      .signIn('google');
                                },
                              ),*/
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(LocaleData.noTienesCuenta.getString(context),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(0.5))),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child:  Text(
                                      ' ${LocaleData.registrate.getString(context)}',
                                      style: const TextStyle(
                                        color: NBSecondPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ]),
                          ),
                        )
                      ])),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: DropdownButton<String>(
                iconSize: 42,
                value: _selectedLanguage,
                dropdownColor: Colors.white,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'ay',
                    child: Text('Aymara'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'es',
                    child: Text('Español'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'quechua',
                    child: Text('Quechua'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'guarani',
                    child: Text('Guarani'),
                  ),
                ],
                icon: Icon(Icons.language, color: Theme.of(context).primaryColor,
                    size: 30),
                underline: null,
                onChanged: (String? value) {
                  setLocale(value);
                },
                hint: const Text('Idioma'),
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
              ),
            ],
          );
        },
      ),
    );
  }

  void setLocale(String? value) {
    if (value == null) return;

    if (value == 'es') {
      _flutterLocalization.translate('es');
    } else if (value == 'ay') {
      _flutterLocalization.translate('ay');
    } else if (value == 'quechua') {
      _flutterLocalization.translate('quechua');
    } else if (value == 'guarani') {
      _flutterLocalization.translate('guarani');
    }

    setState(() {
      _selectedLanguage = value;
    });
  }
}
