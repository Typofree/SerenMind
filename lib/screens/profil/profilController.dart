import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userData;

  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;

  ProfilController() {
    _user = _auth.currentUser;
    if (_user != null) {
      _loadUserProfile();
    }
  }

  Future<void> _loadUserProfile() async {
    if (_user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(_user!.uid).get();
      _userData = snapshot.data() as Map<String, dynamic>?;
      notifyListeners();
    }
  }

  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required String age,
  }) async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
      });
      _userData = {
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'email': _user!.email,
      };
      notifyListeners();
    }
  }

  Future<void> loadUserProfile() async {
    if (_user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(_user!.uid).get();
      _userData = snapshot.data() as Map<String, dynamic>?;
      notifyListeners();
    }
  }

  Future<void> deleteUserAccount(context) async {
    if (_user != null) {
      // Supprimer les données dans Firestore
      await _firestore.collection('users').doc(_user!.uid).delete();
      // Supprimer l'utilisateur de Firebase Auth
      await _user!.delete();
      await _auth.signOut();
      await FirebaseAuth.instance.signOut();
      context.go('/');
      notifyListeners();
    }
  }
}
