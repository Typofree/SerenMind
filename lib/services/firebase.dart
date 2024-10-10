import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

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

  /// Récupération de la recette du jour en fonction de l'humeur
  Future<Map<String, dynamic>?> getRecipeOfTheDay(String mood) async {
    try {
      String day = getDayOfWeek();

      // Accéder à la sous-collection 'recipes' dans 'days'
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('moods')
          .doc(mood)
          .collection('days')
          .doc(day)
          .collection('recipes')
          .limit(1) // Limite à une recette par jour
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      } else {
        return null;
      }
    } catch (e) {
      logger.w('Erreur lors de la récupération de la recette du jour: $e');
      return null;
    }
  }

  /// Récupération de la musique du jour en fonction de l'humeur
  Future<Map<String, dynamic>?> getMusicOfTheDay(String mood) async {
    try {
      String day = getDayOfWeek();

      // Accéder à la sous-collection 'music' dans 'days'
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('moods')
          .doc(mood)
          .collection('days')
          .doc(day)
          .collection('music')
          .limit(1) // Limite à une musique par jour
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      } else {
        return null;
      }
    } catch (e) {
      logger.w('Erreur lors de la récupération de la musique du jour: $e');
      return null;
    }
  }

  // Méthode pour récupérer toutes les activités de chaque humeur et jour
  Future<Map<String, Map<String, List<Map<String, dynamic>>>>> getAllActivities() async {
    Map<String, Map<String, List<Map<String, dynamic>>>> activitiesByMoodAndDay = {};

    try {
      QuerySnapshot moodsSnapshot = await _firestore.collection('moods').get();

      for (var moodDoc in moodsSnapshot.docs) {
        String mood = moodDoc.id;

        // Récupérer tous les jours pour chaque humeur
        QuerySnapshot daysSnapshot = await _firestore
            .collection('moods')
            .doc(mood)
            .collection('days')
            .get();

        activitiesByMoodAndDay[mood] = {};

        for (var dayDoc in daysSnapshot.docs) {
          String day = dayDoc.id;

          // Récupérer les activités pour chaque jour
          QuerySnapshot activitiesSnapshot = await _firestore
              .collection('moods')
              .doc(mood)
              .collection('days')
              .doc(day)
              .collection('activity')
              .get();

          List<Map<String, dynamic>> activities = activitiesSnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          activitiesByMoodAndDay[mood]![day] = activities;
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des activités : $e');
    }

    return activitiesByMoodAndDay;
  }

  // Méthode pour récupérer toutes les musiques de chaque humeur et jour
  Future<Map<String, Map<String, List<Map<String, dynamic>>>>> getAllMusic() async {
    Map<String, Map<String, List<Map<String, dynamic>>>> musicByMoodAndDay = {};

    try {
      QuerySnapshot moodsSnapshot = await _firestore.collection('moods').get();

      for (var moodDoc in moodsSnapshot.docs) {
        String mood = moodDoc.id;

        // Récupérer tous les jours pour chaque humeur
        QuerySnapshot daysSnapshot = await _firestore
            .collection('moods')
            .doc(mood)
            .collection('days')
            .get();

        musicByMoodAndDay[mood] = {};

        for (var dayDoc in daysSnapshot.docs) {
          String day = dayDoc.id;

          // Récupérer les musiques pour chaque jour
          QuerySnapshot musicSnapshot = await _firestore
              .collection('moods')
              .doc(mood)
              .collection('days')
              .doc(day)
              .collection('music')
              .get();

          List<Map<String, dynamic>> musics = musicSnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          musicByMoodAndDay[mood]![day] = musics;
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des musiques : $e');
    }

    return musicByMoodAndDay;
  }

  // Méthode pour récupérer toutes les recettes de chaque humeur et jour
  Future<Map<String, Map<String, List<Map<String, dynamic>>>>> getAllRecipes() async {
    Map<String, Map<String, List<Map<String, dynamic>>>> recipesByMoodAndDay = {};

    try {
      QuerySnapshot moodsSnapshot = await _firestore.collection('moods').get();

      for (var moodDoc in moodsSnapshot.docs) {
        String mood = moodDoc.id;

        // Récupérer tous les jours pour chaque humeur
        QuerySnapshot daysSnapshot = await _firestore
            .collection('moods')
            .doc(mood)
            .collection('days')
            .get();

        recipesByMoodAndDay[mood] = {};

        for (var dayDoc in daysSnapshot.docs) {
          String day = dayDoc.id;

          // Récupérer les recettes pour chaque jour
          QuerySnapshot recipesSnapshot = await _firestore
              .collection('moods')
              .doc(mood)
              .collection('days')
              .doc(day)
              .collection('recipes')
              .get();

          List<Map<String, dynamic>> recipes = recipesSnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          recipesByMoodAndDay[mood]![day] = recipes;
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des recettes : $e');
    }

    return recipesByMoodAndDay;
  }


  /// Méthode pour récupérer le jour de la semaine en français
  String getDayOfWeek() {
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
