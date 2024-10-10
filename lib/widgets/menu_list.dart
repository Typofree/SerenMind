import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serenmind/constants/styles.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuItem(
            context,
            title: "Réduction du stress",
            imagePath: 'assets/images/menu/zen_menu.png',
            colorFilter: Colors.orange.withOpacity(0.3),
            onTap: () {
              context.push('/list/tips');
            },
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            context,
            title: "Écouter vos musique",
            imagePath: 'assets/images/menu/music_menu.png',
            colorFilter: Colors.blue.withOpacity(0.3),
            onTap: () {
              context.push('/list/music');
            },
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            context,
            title: "Trouvez votre sport",
            imagePath: 'assets/images/menu/activity_menu.png',
            colorFilter: Colors.orange.withOpacity(0.3),
            onTap: () {
              context.push('/list/activity');
            },
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            context,
            title: "Préparer vos recette",
            imagePath: 'assets/images/menu/recipe_menu.png',
            colorFilter: Colors.blue.withOpacity(0.3),
            onTap: () {
              context.push('/list/recipe');
            },
          ),
        ],
      ),
    );
  }

  // Fonction pour créer un élément de menu avec un filtre de couleur et le dernier mot en gras
  Widget _buildMenuItem(BuildContext context,
      {required String title,
      required String imagePath,
      required Color colorFilter,
      required VoidCallback onTap}) {
    return Material(
      // Ajout du widget Material
      color: Colors
          .transparent, // Rendre le fond du Material transparent pour voir l'image en dessous
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                colorFilter,
                BlendMode.srcATop,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: _buildRichText(
                  title), // Utilisation de RichText pour styliser le dernier mot
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichText(String title) {
    List<String> words = title.split(" ");
    String lastWord = words.removeLast();
    String firstWords = words.join(" ");

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$firstWords ".toUpperCase(),
            style: AppTextStyles.headline2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          TextSpan(
            text: lastWord.toUpperCase(),
            style: AppTextStyles.headline2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }
}
