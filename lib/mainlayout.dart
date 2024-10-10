import 'package:flutter/material.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/screens/activity/activity_list_view.dart';
import 'package:serenmind/screens/home/homeView.dart';
import 'package:serenmind/screens/music/music_list_view.dart';
import 'package:serenmind/screens/recipe/recipeListView.dart';
import 'package:serenmind/widgets/menu_list.dart';
import 'package:serenmind/widgets/bottom_bar.dart';
import 'package:serenmind/widgets/app_bar.dart';

class MainLayout extends StatefulWidget {
  final int pageIndex;

  const MainLayout({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;
  bool _showMenu = false; // Variable pour afficher ou cacher la page de Menu

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showMenu = false; // Cacher le menu quand on sélectionne un autre index
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeView(),
      ActivityListView(),
      MusicListView(),
      RecipeListView(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HeaderAppBar(),
      body: Stack(
        children: [
          // Affichage des pages normales
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
              child: pages[_selectedIndex],
            ),
          ),
          // Affichage de la page Menu si _showMenu est vrai
          if (_showMenu)
            Positioned.fill(
              child: Container(
                color: Colors
                    .white, // Couleur de fond pour couvrir la page précédente
                child: MenuList(), // Affiche la page Menu
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showMenu = true; // Affiche la page Menu
          });
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
