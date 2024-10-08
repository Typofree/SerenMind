import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serenmind/screens/home/homeController.dart';
import 'package:serenmind/constants/styles.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Mes conseils',
                  style: AppTextStyles.headline2.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Divider(
                color: AppColors.textColor.withOpacity(0.3),
                thickness: 1.0,
              ),
              InkWell(
                onTap: () {
                  context.push('/tips');
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/tips_image.png'),
                      fit: BoxFit.cover,

                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mes Conseils',
                      style: AppTextStyles.headline1.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Musique du Jour',
                  style: AppTextStyles.headline2.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Divider(
                color: AppColors.textColor.withOpacity(0.3),
                thickness: 1.0,
              ),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.play_circle_fill,
                        color: AppColors.whiteColor,
                        size: 48,
                      ),
                      onPressed: () {
                        // Logique pour jouer la musique conseillée
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Recette du Jour',
                  style: AppTextStyles.headline2.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Divider(
                color: AppColors.textColor.withOpacity(0.3),
                thickness: 1.0,
              ),

              // FutureBuilder pour afficher la recette
              FutureBuilder<Map<String, dynamic>?>(
                future: _controller.getRecipeByName('Poulet Rôti'),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Erreur : ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text("Recette non trouvée."));
                  }

                  var data = snapshot.data!;
                  String recipeName = data['name'];
                  String imageUrl = data['imageUrl'];

                  return InkWell(
                    onTap: () {
                      // Navigate to the detailed recipe page with recipe name
                      context.push('/recipe/$recipeName');
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.thirdColor,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          recipeName,
                          style: AppTextStyles.headline1.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
