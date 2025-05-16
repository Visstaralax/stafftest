import 'package:flutter/material.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/help/help_page.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/profile/profile_page.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/shop_page.dart';

import '../commons/logout/logout_dialog.dart';

final int SHOP_PAGE_DEFAULT = 1;
class WrapperScreen extends StatefulWidget  {
  const WrapperScreen({super.key});

  @override
  State createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  int _selectedIndex = SHOP_PAGE_DEFAULT;

  final List<Widget> widgetOptions = [
    ProfileScreen(key: UniqueKey()),
    ShopScreen(key: UniqueKey()),
    HelpPage(key: UniqueKey()),
    DialogLogout()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Perfil',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shop),
      label: 'Tienda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info),
      label: 'Ayuda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.close),
      label: 'Cerrar',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.blue[50],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey,
        items: items,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      
    );
  }

}