import 'package:flutter/material.dart';
import 'package:serenmind/services/firebase.dart';
import 'package:serenmind/constants/constants.dart';

class ActivityListView extends StatelessWidget {
  final FirebaseControler _firebaseController = FirebaseControler();

  @override
  Widget build(BuildContext context) {
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

          return ListView(
            children: activitiesByMoodAndDay.entries.map((moodEntry) {
              String mood = moodEntry.key;
              Map<String, List<Map<String, dynamic>>> daysActivities = moodEntry.value;

              List<Map<String, dynamic>> allActivities = daysActivities.values.expand((activities) => activities).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      translateMoodToFrench(mood),  // Utilise la fonction importée
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...allActivities.map((activity) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: getColorForMood(mood),  // Utilise la fonction importée
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
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
