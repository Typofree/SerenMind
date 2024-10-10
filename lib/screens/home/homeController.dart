import 'package:serenmind/services/firebase.dart';

class HomeController {
  final FirebaseControler _firebaseController = FirebaseControler();

  /// Appel vers Firebase pour récupérer la recette du jour en fonction de l'humeur
  Future<Map<String, dynamic>?> getRecipeOfTheDay(String mood) async {
    return await _firebaseController.getRecipeOfTheDay(mood);
  }

  /// Appel vers Firebase pour récupérer la musique du jour selon l'humeur
  Future<Map<String, dynamic>?> getMusicOfTheDay(String mood) async {
    return await _firebaseController.getMusicOfTheDay(mood);
  }
}
