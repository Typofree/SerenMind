import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenmind/generated/l10n.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validateFields({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    if (email.isEmpty) {
      return S.of(context).errorEmailEmpty;
    }
    if (password.isEmpty) {
      return S.of(context).errorPasswordEmpty;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return S.of(context).errorUserNotFound;
      } else if (e.code == 'wrong-password') {
        return S.of(context).errorWrongPassword;
      } else {
        return S.of(context).errorGeneral(e.message ?? 'Erreur inconnue');
      }
    } catch (e) {
      return S.of(context).errorGeneric(e.toString());
    }
  }

  Future<String?> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    if (email.isEmpty) {
      return S.of(context).errorEmailEmpty;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return S.of(context).errorUserNotFound;
      } else {
        return S.of(context).errorGeneral(e.message ?? 'Erreur inconnue');
      }
    } catch (e) {
      return S.of(context).errorGeneric(e.toString());
    }
  }
}
