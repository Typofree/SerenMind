import 'package:flutter/material.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/screens/activity/activityView.dart';
import 'package:serenmind/screens/home/homeView.dart';
import 'package:serenmind/screens/mood/moodView.dart';
import 'package:serenmind/widgets/menu_list.dart'; // Importez la page "MenuList"
import 'package:serenmind/widgets/bottom_bar.dart';
import 'package:serenmind/widgets/app_bar.dart';
import 'package:go_router/go_router.dart'; // Pour la navigation

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
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeView(),
      ActivityView(),
      MoodView(),
      MenuList(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HeaderAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    Color(0xFFF2F8F9),
                    Color(0xFFA9CAED),
                    Color(0xFF69B1A2),
                  ],
                  stops: [0.2, 0.6, 1.0],
                ),
              ),
            ),
          ),
          pages[_selectedIndex],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/tips');
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.lightbulb_outline,
          size: 24,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
