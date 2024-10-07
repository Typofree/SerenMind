import 'package:flutter/material.dart';
import 'package:serenmind/screens/activity/activity_page.dart';
import 'package:serenmind/screens/home/home_page.dart';
import 'package:serenmind/screens/tips/tips_page.dart';
import '../services/router.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatefulWidget {
  final int pageIndex;

  const MainLayout({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Naviguer vers les pages correspondantes
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
      body: pages[_selectedIndex], // Afficher la page correspondante
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Activité',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Conseil',
          ),
        ],
      ),
    );
  }
}
