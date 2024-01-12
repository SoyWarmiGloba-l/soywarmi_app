import 'package:flutter/material.dart';
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

List<String> _titles = [
  'SoyWarmi',
  'Hospitales',
  'Especialistas',
  'Posts',
  'Chats',
];

class _MainPageState extends State<MainPage> {
  int _selectedIndex;
  _MainPageState(this._selectedIndex);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          PostPage(),
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