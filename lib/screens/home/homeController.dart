import 'package:serenmind/services/firebase.dart';

class HomeController {
  final FirebaseControler _firebaseController = FirebaseControler();

  /// Appel vers Firebase pour récupérer la recette par nom
  Future<Map<String, dynamic>?> getRecipeByName(String recipeName) async {
    return await _firebaseController.getRecipeByName(recipeName);
  }

  /// Appel vers Firebase pour récupérer la musique du jour selon l'humeur
  Future<Map<String, dynamic>?> getMusicOfTheDay(String mood) async {
    return await _firebaseController.getMusicOfTheDay(mood);
  }
}
