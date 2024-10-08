import 'package:flutter/material.dart';
import 'package:serenmind/screens/activity/activity_page.dart';
import 'package:serenmind/screens/home/home_page.dart';
import 'package:serenmind/screens/tips/tips_page.dart';
import 'package:serenmind/widgets/bottom_bar.dart';

import 'package:go_router/go_router.dart';
import 'services/firebase.dart';

class MainLayout extends StatefulWidget {
  final int pageIndex;

  const MainLayout({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;
  FirebaseControler firebase = FirebaseControler();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/activity');
        break;
      case 2:
        context.go('/tips');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      ActivityPage(),
      TipsPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('SerenMind App')),
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex, // Envoi de l'index actuel
        onItemTapped:
            _onItemTapped, // La fonction appelée lorsqu'un onglet est tapé
      ),
    );
  }
}
