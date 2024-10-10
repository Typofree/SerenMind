import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:serenmind/services/firebase.dart';
import 'package:serenmind/constants/constants.dart';

class RecipeListView extends StatefulWidget {
  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  final FirebaseControler _firebaseController = FirebaseControler();
  late Future<Map<String, Map<String, List<Map<String, dynamic>>>>> _recipeFuture;
  String? _currentMood;

  @override
  void initState() {
    super.initState();
    _loadCurrentMood();
    _recipeFuture = _firebaseController.getAllRecipes();
  }

  Future<void> _loadCurrentMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? moodDataString = prefs.getString('moodData');

    if (moodDataString != null) {
      Map<String, dynamic> moodData = jsonDecode(moodDataString);
      String lastSavedMoodKey = moodData['mood'];
      setState(() {
        _currentMood = lastSavedMoodKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentMood == null) {
      return Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: FutureBuilder<Map<String, Map<String, List<Map<String, dynamic>>>>>(
        future: _recipeFuture,
        builder: (BuildContext context, AsyncSnapshot<Map<String, Map<String, List<Map<String, dynamic>>>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune recette trouvée."));
          }

          Map<String, Map<String, List<Map<String, dynamic>>>> recipesByMoodAndDay = snapshot.data!;

          Map<String, List<Map<String, dynamic>>>? filteredRecipes = recipesByMoodAndDay[_currentMood];

          if (filteredRecipes == null) {
            return Center(child: Text("Aucune recette disponible pour l'humeur sélectionnée."));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Affichage du titre avec l'humeur sélectionnée
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Des recettes ${translateMoodToFrench(_currentMood!)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: filteredRecipes.entries.map((dayEntry) {
                    String day = dayEntry.key;
                    List<Map<String, dynamic>> recipes = dayEntry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: recipes.map((recipe) {
                            return InkWell(
                              onTap: () {
                                context.push('/recipe/$_currentMood/$day/${recipe['name']}');
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                height: 200,
                                decoration: BoxDecoration(
                                  color: getColorForMood(_currentMood!),
                                  borderRadius: BorderRadius.circular(16),
                                  image: recipe['imageUrl'] != null
                                      ? DecorationImage(
                                    image: NetworkImage(recipe['imageUrl']),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.darken,
                                    ),
                                  )
                                      : null,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          recipe['name'] ?? 'Recette',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
