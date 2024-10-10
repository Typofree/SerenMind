import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenmind/constants/styles.dart';

class RecipeDetailView extends StatelessWidget {
  final String recipeName;

  RecipeDetailView({required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName, style: AppTextStyles.headline2),
        backgroundColor: AppColors.primaryColor,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('recipes')
            .where('name',
                isEqualTo:
                    recipeName)
            .limit(1)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Recette non trouvée."));
          }

          var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
          String imageUrl = data['imageUrl'];
          List<String> ingredients =
              List<String>.from(data['ingredients']);
          List<String> steps =
              List<String>.from(data['steps']);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 250,
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Ingrédients',
                    style: AppTextStyles.headline2
                        .copyWith(color: AppColors.textColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingredients.map((ingredient) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '- $ingredient',
                          style: AppTextStyles.bodyText1,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Étapes de la recette',
                    style: AppTextStyles.headline2
                        .copyWith(color: AppColors.textColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: steps.asMap().entries.map((entry) {
                      int stepNumber = entry.key + 1;
                      String stepText = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '$stepNumber. $stepText',
                          style: AppTextStyles.bodyText1,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
