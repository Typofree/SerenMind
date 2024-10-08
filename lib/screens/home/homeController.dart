import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getRecipeByName(String recipeName) async {
    try {
      // Requête Firestore pour récupérer la recette par nom
      QuerySnapshot querySnapshot = await _firestore
          .collection('recipes')
          .where('name', isEqualTo: recipeName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Si un document est trouvé, retourner ses données
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null; // Si aucune recette n'est trouvée
      }
    } catch (e) {
      print("Erreur lors de la récupération de la recette : $e");
      return null;
    }
  }
}
