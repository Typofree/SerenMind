import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirebaseControler {
  var logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  /// Connexion anonyme
  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
      logger.i("Connexion anonyme réussie");
    } catch (e) {
      logger.w("Erreur lors de la connexion: $e");
    }
  }

  /// Récupération du profil utilisateur
  Future<Map<String, dynamic>?> loadUserProfile(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      return snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      logger.w("Erreur lors de la récupération du profil utilisateur: $e");
      return null;
    }
  }

  /// Mise à jour du profil utilisateur
  Future<void> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String age,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
      });
      logger.i("Profil utilisateur mis à jour");
    } catch (e) {
      logger.w("Erreur lors de la mise à jour du profil utilisateur: $e");
    }
  }

  /// Suppression du compte utilisateur
  Future<void> deleteUserAccount() async {
    try {
      if (_auth.currentUser != null) {
        String userId = _auth.currentUser!.uid;

        // Supprimer les données de l'utilisateur dans Firestore
        await _firestore.collection('users').doc(userId).delete();
        logger.i("Données utilisateur supprimées de Firestore");

        // Supprimer l'utilisateur de Firebase Auth
        await _auth.currentUser!.delete();
        logger.i("Compte utilisateur supprimé");
      }
    } catch (e) {
      logger.w("Erreur lors de la suppression du compte utilisateur: $e");
    }
  }

  /// Déconnexion
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      logger.i("Déconnexion réussie");
    } catch (e) {
      logger.w("Erreur lors de la déconnexion: $e");
    }
  }

  /// Récupération de la recette par nom
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
      logger.w("Erreur lors de la récupération de la recette: $e");
      return null;
    }
  }

  /// Récupération de la musique du jour en fonction de l'humeur
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
      logger.w('Erreur lors de la récupération de la musique du jour: $e');
      return null;
    }
  }

  /// Méthode pour récupérer le jour de la semaine en français
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
