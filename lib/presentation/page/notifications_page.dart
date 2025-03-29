import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:soywarmi_app/core/language/locales.dart';

import '../../data/model/notifications_model.dart';
import '../../data/remote/http_headers_global.dart';
import '../widget/custom_alerts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationsModel> listNotifications=[];
  GlobalKey<_NotificationsPageState> notificationPage=GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    obtainNotificationsNotRead();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: notificationPage,
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
      ),
      body: (notificationsLoaded)?Container(
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
                return Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListTile(
                        title: Text(listNotifications[index].title),
                        subtitle: Text(listNotifications[index].data),
                        // Otros atributos...
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                          onPressed: (){
                            deleteNotification(listNotifications[index].id);

                          },
                          icon: Icon(Icons.delete)
                      ),
                    )
                  ],
                );
              },
            )),
      ):const Center(child: CircularProgressIndicator()),
    );
  }
  final _endPoint = dotenv.env['API_ENDPOINT'];
  final _storage = const FlutterSecureStorage();
  Future<void> deleteNotification(notificationId) async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    CustomAlerts.showConfirmationDialog(notificationPage.currentContext!).then((value) async => {
      if(value){
        await HttpHeadersGlobal.headerDeleteHttpWithToken(userToken!, '$_endPoint/api/v1/delete_my_notification/$notificationId').then((res){
          if(res.statusCode==200){
            CustomAlerts.showSuccessDialog(notificationPage.currentContext!, "Notificacion eliminada","Notificacion eliminada exitosamente");
            obtainNotificationsNotRead();

          }else{
            CustomAlerts.showErrorDialog(notificationPage.currentContext!, "Error al eliminar notificacion");
          }
        })
      }
    });
  }
  bool notificationsLoaded=false;
  Future<void> obtainNotificationsNotRead() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    await HttpHeadersGlobal.headerGetHttpWithToken(userToken!,
        '$_endPoint/api/v1/notifications/my-notifications-not-read')
        .then((res) {
      if (res.statusCode == 200) {
        setState(() {
          List comments = jsonDecode(res.body)['data'];
          if (comments.isNotEmpty) {
            setState(() {
              listNotifications = comments
                  .map((e) => NotificationsModel.fromJson(e['notifications']))
                  .toList();
            });
          }
        });
      } else {
        CustomAlerts.showErrorDialog(
            context, "Error al obtener los comentarios");
      }
      setState(() {
        notificationsLoaded=true;
      });
    });
  }
}
