import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:soywarmi_app/core/language/locales.dart';

import '../../data/model/notifications_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationsModel> listNotifications=[];
  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)!.settings.arguments;
    if (args is List<NotificationsModel>) listNotifications=args;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            LocaleData.notificaciones.getString(context),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
            ),
          ]),
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: Center(
            child: (listNotifications.isEmpty)?ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
              Lottie.asset('assets/animations/no_notifications.json',
                  height: 250),
              Text(
                LocaleData.noTienesNotificaciones.getString(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                'Ya viste o eliminaste todas tus notificaciones. Cuanto tengas una nueva, aparecerá aquí.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor.withOpacity(0.5)),
              ),
            ]):ListView.builder(
              itemCount: listNotifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listNotifications[index].title),
                  subtitle: Text(listNotifications[index].data),
                  // Otros atributos...
                );
              },
            )),
      ),
    );
  }
}
