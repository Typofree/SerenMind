import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseControler {
  var logger = Logger();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      logger.w("Erreur lors de la connexion: $e");
    }
  }

  Future setProfil(String name, double age) async {
    try {
      await firestore.collection('users').add({
        'name': name,
        'age': age,
      });
    } catch (e) {
      logger.e('Erreur lors de l\'ajout à Firestore : $e');
    }
  }
}
