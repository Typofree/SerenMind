import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getRecipeByName(String recipeName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('recipes')
          .where('name', isEqualTo: recipeName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération de la recette : $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getMusicOfTheDay(String mood) async {

    try {
      String day = _getDayOfWeek();

      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('moods')
          .doc(mood)
          .collection('days')
          .doc(day)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération de la musique du jour: $e');
      return null;
    }
  }

  String _getDayOfWeek() {
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday:
        return 'lundi';
      case DateTime.tuesday:
        return 'mardi';
      case DateTime.wednesday:
        return 'mercredi';
      case DateTime.thursday:
        return 'jeudi';
      case DateTime.friday:
        return 'vendredi';
      case DateTime.saturday:
        return 'samedi';
      case DateTime.sunday:
        return 'dimanche';
      default:
        return 'lundi';
    }
  }
}
