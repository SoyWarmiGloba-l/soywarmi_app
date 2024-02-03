import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/presentation/page/chats_page.dart';
import 'package:soywarmi_app/presentation/page/home_page.dart';
import 'package:soywarmi_app/presentation/page/map_page.dart';
import 'package:soywarmi_app/presentation/page/posts_page.dart';
import 'package:soywarmi_app/presentation/page/specialists_page.dart';
import 'package:soywarmi_app/presentation/widget/custom_app_bar.dart';
import 'package:soywarmi_app/presentation/widget/custom_bottom_navigator_bar.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';

class MainPage extends StatefulWidget {
  final int selectedIndex;

  const MainPage({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState(selectedIndex);
}

class _MainPageState extends State<MainPage> {
  late FlutterLocalization _flutterLocalization;
  late String _selectedLanguage;
  int _selectedIndex = 0;
  _MainPageState(this._selectedIndex);

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _selectedLanguage = _flutterLocalization.currentLocale!.languageCode;
    connectSocketi();
  }
  late PusherClient pusher;

  connectSocketi() async {
    pusher = PusherClient(
      'app-key', //default is 'app-key', change to production!
      const PusherOptions(
        host: '53c3-2800-cd0-1604-f000-9b25-348a-cfd2-5f9.ngrok-free.app', //you soketi server ip
        wssPort: 443,
        wsPort: 80, // port is 6001 by default
        encrypted: true, // true for use SSL
      ),
      autoConnect: false,
      enableLogging: true,
    );
    pusher.connect();
    pusher.onConnectionStateChange((state) {
      print(
          "previousState: ${state?.previousState}, currentState: ${state?.currentState}");
      if (state?.currentState == 'CONNECTED') {
        print("CONNECTING TO PUSHER EVENT");
      }
    });
    pusher.onConnectionError((error) {
      print("error: ${error?.exception}  ${error?.code} ${error?.message}");
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> _titles = [
      LocaleData.inicio.getString(context),
      LocaleData.hospitales.getString(context),
      LocaleData.especialidades.getString(context),
      LocaleData.publicaciones.getString(context),
      'Chats',
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_selectedIndex],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          MapPage(),
          SpecialistsPage(),
          PostsPage(),
          ChatsPage(),
        ],
      ),
      floatingActionButton: _selectedIndex == 3
          ? FloatingActionButton(
              backgroundColor: NBSecondPrimaryColor,
              onPressed: () {
                Navigator.pushNamed(context, '/new_post');
              },
              child: const Icon(
                Icons.add,
                color: NBColorWhite,
              ),
            )
          : null,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
