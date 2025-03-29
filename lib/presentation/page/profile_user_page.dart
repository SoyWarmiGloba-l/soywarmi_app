import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:soywarmi_app/presentation/page/login_page.dart';
import 'package:soywarmi_app/presentation/page/main_page.dart';
import 'package:soywarmi_app/presentation/widget/custom_button_menu.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import 'package:soywarmi_app/utilities/screen_size_util.dart';

import '../../main.dart';

class ProfileUserPage extends StatefulWidget {
  const ProfileUserPage({super.key});

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  late FlutterLocalization _flutterLocalization;
  late String _selectedLanguage;
  int _selectedIndex = 0;
  final endPoint = dotenv.env['API_ENDPOINT'];
   FlutterSecureStorage storage = const FlutterSecureStorage();


  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _selectedLanguage = _flutterLocalization.currentLocale!.languageCode;
    print(_selectedLanguage);
    obtainMyAccount();
  }
  Map<String,dynamic> myAccount={};
  Future<void> obtainMyAccount() async {
    final myAccountJson = await storage.read(key: 'my_account');
    if (myAccountJson != null) {
      setState(() {
        myAccount=jsonDecode(myAccountJson);
        print(myAccount);
      });
    }
  }
  void setLocale(String? value) {
    if (value == null) return;

    if (value == 'es') {
      _flutterLocalization.translate('es');
    } else if (value == 'ay') {
      _flutterLocalization.translate('ay');
    }

    setState(() {
      _selectedLanguage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel, color: Theme.of(context).primaryColor),
          ),
          actions: [
            //cambiar idioma
            Padding(
              padding: const EdgeInsets.only(right: 20),
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
                ],
                icon: Icon(Icons.language,
                    color: Theme.of(context).primaryColor, size: 30),
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
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      decoration: const BoxDecoration(
                        color: NbSecondSecondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage((myAccount.containsKey("photo") && myAccount["photo"]!=null && myAccount["photo"]!="")?'$endPoint${myAccount["photo"]}':"$endPoint/storage/default_image.png"),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (myAccount.containsKey("name") && myAccount["name"]!=null)?myAccount["name"]:"",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                (myAccount.containsKey("email") && myAccount["email"]!=null)?myAccount["email"]:"",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit_profile');
                                },
                                child:  Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    LocaleData.editarPerfil.getString(context),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(children: [
                        CustomButtonMenu(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          label: LocaleData.inicio.getString(context),
                          color: Theme.of(context).primaryColor,
                          icon: Icons.home,
                          size: 55,
                          withButton: ScreenSizeUtil.scaleWidth(0.9),
                        ),
                        CustomButtonMenu(
                          onPressed: () {
                            Navigator.pushNamed(context, '/news');
                          },
                          label: LocaleData.noticiasSoyWarmi.getString(context),
                          color: Theme.of(context).primaryColor,
                          icon: Icons.newspaper,
                          size: 55,
                          withButton: ScreenSizeUtil.scaleWidth(0.9),
                        ),
                        CustomButtonMenu(
                          onPressed: () {
                            Navigator.pushNamed(context, '/about_us');
                          },
                          label: LocaleData.quienesSomos.getString(context),
                          color: Theme.of(context).primaryColor,
                          icon: Icons.question_mark,
                          size: 55,
                          withButton: ScreenSizeUtil.scaleWidth(0.9),
                        ),
                        CustomButtonMenu(
                          onPressed: () {
                            Navigator.pushNamed(context, '/members');
                          },
                          label: LocaleData.miembros.getString(context),
                          color: Theme.of(context).primaryColor,
                          icon: Icons.people,
                          size: 55,
                          withButton: ScreenSizeUtil.scaleWidth(0.9),
                        ),
                        CustomButtonMenu(
                          onPressed: () {
                            Navigator.pushNamed(context, '/frequent_questions');
                          },
                          label: LocaleData.preguntasFrecuentes.getString(context),
                          color: Theme.of(context).primaryColor,
                          icon: Icons.question_answer,
                          size: 55,
                          withButton: ScreenSizeUtil.scaleWidth(0.9),
                        ),
                        CustomButtonMenu(
                          onPressed: () {
                            Navigator.pushNamed(context, '/complaint');
                          },
                          label: LocaleData.denunciar.getString(context),
                          color: Theme.of(context).primaryColor,
                          icon: Icons.warning,
                          size: 55,
                          withButton: ScreenSizeUtil.scaleWidth(0.9),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  NBSecondPrimaryColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () {
                              logOut().then((value){
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstPage()));
                              });
                              // context.read<AuthCubit>().logout();
                            },
                            child:  Text(
                              LocaleData.cerrarSesion.getString(context),
                              style: const TextStyle(fontSize: 15),
                            )),
                        const SizedBox(height: 10),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(children: [
                    Image.asset(
                      NBWarmiLogo,
                      width: ScreenSizeUtil.scaleWidth(0.3),
                      height: ScreenSizeUtil.scaleHeight(0.10),
                    ),
                    Text(
                      'Version 0.0.1',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      '@ 2023 SoyWarmi',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const Text(
                      'Politicas de privacidad - Terminos y condiciones',
                      style: TextStyle(
                        fontSize: 15,
                        color: NBSecondPrimaryColor,
                      ),
                    ),
                  ])
                ]),
          ),
        ));
  }

  Future<void> logOut() async {
    await storage.deleteAll();
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    firebaseAuth.signOut();
    storage.deleteAll();
    context
        .read<AuthenticationBloc>()
        .add(const AuthenticationStatusChanged(false));

  }
}
