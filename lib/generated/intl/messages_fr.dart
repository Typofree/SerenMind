// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(error) => "Erreur lors de la connexion : ${error}";

  static String m1(error) => "Une erreur est survenue : ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Vous avez déjà un compte?"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirmer le mot de passe"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Créer un compte"),
        "emailHint": MessageLookupByLibrary.simpleMessage("E-mail"),
        "errorConfirmPasswordEmpty": MessageLookupByLibrary.simpleMessage(
            "Veuillez remplir le champ Confirmer le mot de passe"),
        "errorEmailAlreadyInUse":
            MessageLookupByLibrary.simpleMessage("Cet email est déjà utilisé."),
        "errorEmailEmpty": MessageLookupByLibrary.simpleMessage(
            "Veuillez remplir le champ Adresse e-mail"),
        "errorGeneral": m0,
        "errorGeneric": m1,
        "errorPasswordEmpty": MessageLookupByLibrary.simpleMessage(
            "Veuillez remplir le champ Mot de passe"),
        "errorPasswordsDontMatch": MessageLookupByLibrary.simpleMessage(
            "Les mots de passe ne correspondent pas"),
        "errorUserNotFound": MessageLookupByLibrary.simpleMessage(
            "Aucun utilisateur trouvé avec cet email."),
        "errorWeakPassword": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe est trop faible."),
        "errorWrongPassword": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe est incorrect."),
        "fillInfo": MessageLookupByLibrary.simpleMessage(
            "Remplissez les informations ci-dessous"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Mot de passe oublié?"),
        "fullName": MessageLookupByLibrary.simpleMessage("Nom complet"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Connexion"),
        "loginPrompt": MessageLookupByLibrary.simpleMessage(
            "Connectez-vous pour continuer"),
        "nav_activity": MessageLookupByLibrary.simpleMessage("Activité"),
        "nav_home": MessageLookupByLibrary.simpleMessage("Accueil"),
        "nav_menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "nav_mood": MessageLookupByLibrary.simpleMessage("Humeur"),
        "noAccount": MessageLookupByLibrary.simpleMessage(
            "Vous n\'\'avez pas de compte?"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "passwordResetSent": MessageLookupByLibrary.simpleMessage(
            "Email de réinitialisation envoyé."),
        "signUp": MessageLookupByLibrary.simpleMessage("S\'\'inscrire"),
        "welcome": MessageLookupByLibrary.simpleMessage("Bienvenue")
      };
}
