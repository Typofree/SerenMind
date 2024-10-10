import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenmind/generated/l10n.dart';

class RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? validateFields({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String age,
    required BuildContext context,
  }) {
    if (email.isEmpty) {
      return S.of(context).errorEmailEmpty;
    }
    if (firstName.isEmpty) {
      return S.of(context).errorFirstNameEmpty;
    }
    if (lastName.isEmpty) {
      return S.of(context).errorLastNameEmpty;
    }
    if (age.isEmpty || int.tryParse(age) == null) {
      return S.of(context).errorAgeInvalid;
    }
    if (password.isEmpty) {
      return S.of(context).errorPasswordEmpty;
    }
    if (confirmPassword.isEmpty) {
      return S.of(context).errorConfirmPasswordEmpty;
    }
    if (password != confirmPassword) {
      return S.of(context).errorPasswordsDontMatch;
    }
    return null;
  }

  Future<String?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String age,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Enregistrer des informations supplémentaires dans Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'age': age,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return S.of(context).errorWeakPassword;
      } else if (e.code == 'email-already-in-use') {
        return S.of(context).errorEmailAlreadyInUse;
      } else {
        return S.of(context).errorGeneral(e.message ?? 'Erreur inconnue');
      }
    } catch (e) {
      return S.of(context).errorGeneric(e.toString());
    }
  }
}
