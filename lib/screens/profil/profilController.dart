import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Récupérer le profil utilisateur
  Future<Map<String, dynamic>?> getUserProfile() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firestore.collection('profiles').doc(user.uid).get();

        if (snapshot.exists) {
          return snapshot.data();
        }
      } catch (e) {
        print('Erreur lors de la récupération du profil: $e');
        throw Exception('Erreur lors de la récupération du profil.');
      }
    }

    return null;
  }

  // Mettre à jour le profil utilisateur
  Future<void> updateUserProfile(String fullName, String bio) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await _firestore.collection('profiles').doc(user.uid).set({
          'fullName': fullName,
          'bio': bio,
          'email': user.email,
        }, SetOptions(merge: true));
      } catch (e) {
        print('Erreur lors de la mise à jour du profil: $e');
        throw Exception('Erreur lors de la mise à jour du profil.');
      }
    }
  }
}
