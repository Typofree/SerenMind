import 'package:flutter/material.dart';
import 'package:serenmind/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilController extends ChangeNotifier {
  final FirebaseControler _firebaseController = FirebaseControler();

  User? _user;
  Map<String, dynamic>? _userData;

  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;

  ProfilController() {
    _user = _firebaseController.currentUser;
    if (_user != null) {
      loadUserProfile();
    }
  }

  /// Chargement du profil utilisateur
  Future<void> loadUserProfile() async {
    if (_user != null) {
      _userData = await _firebaseController.loadUserProfile(_user!.uid);
      notifyListeners();
    }
  }

  /// Mise à jour du profil utilisateur
  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required String age,
  }) async {
    if (_user != null) {
      await _firebaseController.updateUserProfile(
        userId: _user!.uid,
        firstName: firstName,
        lastName: lastName,
        age: age,
      );
      _userData = {
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'email': _user!.email,
      };
      notifyListeners();
    }
  }

  /// Suppression du compte utilisateur
  Future<void> deleteUserAccount(BuildContext context) async {
    if (_user != null) {
      await _firebaseController.deleteUserAccount();
      await _firebaseController.signOut();
      Navigator.of(context).pushReplacementNamed('/');
      notifyListeners();
    }
  }

  /// Déconnexion
  Future<void> signOut(BuildContext context) async {
    await _firebaseController.signOut();
    Navigator.of(context).pushReplacementNamed('/');
    notifyListeners();
  }
}
