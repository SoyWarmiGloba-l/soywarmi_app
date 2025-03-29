import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

import '../../data/model/notifications_model.dart';
import '../../data/remote/http_headers_global.dart';
import 'custom_alerts.dart';
import 'image_container.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState(title);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final String title;
  _CustomAppBarState(this.title);
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  String uuid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pusher = PusherClient(
      'app-key',
      PusherOptions(
        host: '${dotenv.env["SOCKET_ENDPOINT"]}',
        wssPort: 443,
        wsPort: 80, // port is 6001 by default
        encrypted: true, // true for use SSL
      ),
      autoConnect: false,
      enableLogging: true,
    );
    obtainNotificationsNotRead();
    obtainMyAccount().then((value) => {
          unsuscribeNotifications().then((value) => {connect()})
        });
  }

  Future<void> unsuscribeNotifications() async {
    var uuid = myAccount['id'];
    pusher.unsubscribe("notificacion" + uuid!.toString());
  }

  late PusherClient pusher;
  connect() async {
    var uuid = myAccount['id'];
    Channel channel3 = pusher.subscribe("notificacion" + uuid.toString());
    channel3.bind("registro-notificacion", (PusherEvent? event) {
      print(
          "-------------------------------------------------------------------------------------------------------------");
      obtainNotificationsNotRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: Image.asset(NbLogoAppBar,
            height: 50, width: 50, fit: BoxFit.contain),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: NBSecondPrimaryColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Stack(alignment: Alignment.center, children: [
          IconButton(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).primaryColor,
                  size: 42,
                ),
                Positioned(
                    top: 0,
                    right: 3,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 13,
                        minHeight: 13,
                      ),
                      child: Text(
                        listNotifications.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
            iconSize: 40,
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ]),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: (!myAccount.containsKey("photo") || myAccount["photo"] == null)
              ? const Padding(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(NbImageEmpty),
                  ),
                )
              : Container(
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: myAccount["photo"] == ''
                          ? NetworkImage(
                              '$_endPoint/storage/default_image.png')
                          : NetworkImage('$_endPoint${myAccount["photo"]}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Text(""),
                ),
        )
      ],
    );
  }

  final storage = const FlutterSecureStorage();
  Map<dynamic, dynamic> myAccount = {"name": ""};
  Future<void> obtainMyAccount() async {
    final myAccountJson = await storage.read(key: 'my_account');
    if (myAccountJson != null) {
      setState(() {
        print(
            "OBTAIN MY ACCOUNT-----------------------------------------------------------");
        myAccount = jsonDecode(myAccountJson);
        print(myAccount);
      });
    }
  }

  List<NotificationsModel> listNotifications = [];
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];
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
    });
  }
}
