import 'package:flutter/material.dart';
import 'package:cement_flutter/components/SideBar.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: const Sidebar(
        avatarUrl: 'assets/images/logo.png',
        cityName: 'Tunis',
        userName: 'Habib',
      ),
    );
  }
}
