import 'package:flutter/material.dart';
import 'package:serenmind/services/firebase.dart';
import 'package:serenmind/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ActivityListView extends StatefulWidget {
  @override
  _ActivityListViewState createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  final FirebaseControler _firebaseController = FirebaseControler();
  String? _currentMood;

  @override
  void initState() {
    super.initState();
    _loadCurrentMood();
  }

  // Charger l'humeur actuelle depuis les préférences partagées
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
        // Utilisation des fonctions depuis le fichier constants.dart
        future: _firebaseController.getAllActivities(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, Map<String, List<Map<String, dynamic>>>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune activité trouvée."));
          }

          Map<String, Map<String, List<Map<String, dynamic>>>> activitiesByMoodAndDay = snapshot.data!;

          // Filtrer les activités en fonction de l'humeur actuelle
          Map<String, List<Map<String, dynamic>>>? filteredActivities = activitiesByMoodAndDay[_currentMood];

          if (filteredActivities == null || filteredActivities.isEmpty) {
            return Center(child: Text("Aucune activité disponible pour l'humeur sélectionnée."));
          }

          // Extraire toutes les activités des jours pour l'humeur sélectionnée
          List<Map<String, dynamic>> allActivities = filteredActivities.values.expand((activities) => activities).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Affichage du titre avec l'humeur sélectionnée
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Des activités ${translateMoodToFrench(_currentMood!)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: allActivities.map((activity) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: getColorForMood(_currentMood!),  // Utilise la couleur en fonction de l'humeur
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity['name'] ?? 'Activité',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            activity['description'] ?? 'Pas de description disponible',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
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
