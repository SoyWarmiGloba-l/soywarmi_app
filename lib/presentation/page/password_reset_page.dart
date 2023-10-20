import 'package:flutter/material.dart';
import 'package:soywarmi_app/presentation/widget/custom_button.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import 'package:soywarmi_app/utilities/screen_size_util.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NBColorWhite,
        elevation: 0,
        title: const Text('Atras', style: TextStyle(color: NBPrimaryColor)),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            NBWarmiLogo,
            width: ScreenSizeUtil.scaleWidth(0.8),
            height: ScreenSizeUtil.scaleHeight(0.28),
          ),
          const Text(
            'Olvidaste tu contraseña?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: NBPrimaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
            child: Text(
              'Ingresa tu direccion de correo electronico y te enviaremos un enlace para restablecer tu contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: NBPrimaryColor.withOpacity(0.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: CustomButton(
              label: 'Restablecer contraseña',
              onPressed: () {},
            ),
          ),
        ],
      )),
    );
  }
}