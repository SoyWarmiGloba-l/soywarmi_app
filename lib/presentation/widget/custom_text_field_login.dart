import 'package:flutter/material.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';


Widget getTextFieldRegister(BuildContext context,String label,TextEditingController controller){
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      obscureText: false,
      validator: (values){
        if(values!.isEmpty){
          return 'Llena el campo';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor.withOpacity(0.6),
          fontSize: 15,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).cardColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
      ),
      enabled: true,
    ),
  );
}

Widget getTextFieldPassowrdRegister(BuildContext context,String label,TextEditingController controller){
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,

      decoration: InputDecoration(
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor.withOpacity(0.6),
          fontSize: 15,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).cardColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
      ),
      enabled: true,
    ),
  );
}