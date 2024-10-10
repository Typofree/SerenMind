// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(error) => "Error: ${error}";

  static String m1(error) => "Error during login: ${error}";

  static String m2(error) => "An error occurred: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accessibility": MessageLookupByLibrary.simpleMessage("Accessibility"),
        "ageHint": MessageLookupByLibrary.simpleMessage("Age"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirmDelete":
            MessageLookupByLibrary.simpleMessage("Confirm Account Deletion"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Create an account"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
        "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete your account? This action cannot be undone."),
        "emailHint": MessageLookupByLibrary.simpleMessage("Email"),
        "error": m0,
        "errorAgeInvalid":
            MessageLookupByLibrary.simpleMessage("Please enter a valid age"),
        "errorConfirmPasswordEmpty": MessageLookupByLibrary.simpleMessage(
            "Please fill in the Confirm Password field"),
        "errorEmailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "This email is already in use."),
        "errorEmailEmpty": MessageLookupByLibrary.simpleMessage(
            "Please fill in the Email field"),
        "errorFirstNameEmpty":
            MessageLookupByLibrary.simpleMessage("First name cannot be empty"),
        "errorGeneral": m1,
        "errorGeneric": m2,
        "errorLastNameEmpty":
            MessageLookupByLibrary.simpleMessage("Last name cannot be empty"),
        "errorPasswordEmpty": MessageLookupByLibrary.simpleMessage(
            "Please fill in the Password field"),
        "errorPasswordsDontMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "errorUserNotFound": MessageLookupByLibrary.simpleMessage(
            "No user found with this email."),
        "errorWeakPassword":
            MessageLookupByLibrary.simpleMessage("The password is too weak."),
        "errorWrongPassword":
            MessageLookupByLibrary.simpleMessage("The password is incorrect."),
        "fillInfo": MessageLookupByLibrary.simpleMessage(
            "Fill in the information below"),
        "firstNameHint": MessageLookupByLibrary.simpleMessage("First Name"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "lastNameHint": MessageLookupByLibrary.simpleMessage("Last Name"),
        "legal": MessageLookupByLibrary.simpleMessage("Legal Mentions"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Log In"),
        "loginPrompt":
            MessageLookupByLibrary.simpleMessage("Log in to continue"),
        "logout": MessageLookupByLibrary.simpleMessage("Déconnexion"),
        "mood": MessageLookupByLibrary.simpleMessage("Change Mood"),
        "music_not_found":
            MessageLookupByLibrary.simpleMessage("Music not found."),
        "music_of_the_day":
            MessageLookupByLibrary.simpleMessage("Music of the Day"),
        "my_relaxation_tips":
            MessageLookupByLibrary.simpleMessage("My Relaxation Tips"),
        "nav_activity": MessageLookupByLibrary.simpleMessage("Activity"),
        "nav_home": MessageLookupByLibrary.simpleMessage("Home"),
        "nav_menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "nav_music": MessageLookupByLibrary.simpleMessage("Music"),
        "noAccount":
            MessageLookupByLibrary.simpleMessage("Don\'\'t have an account?"),
        "now_playing": MessageLookupByLibrary.simpleMessage("Now Playing..."),
        "passwordHint": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordResetSent":
            MessageLookupByLibrary.simpleMessage("Sent password reset email"),
        "profileSubtitle": MessageLookupByLibrary.simpleMessage(
            "Update your information below"),
        "profileTitle": MessageLookupByLibrary.simpleMessage("Profil"),
        "profileUpdated": MessageLookupByLibrary.simpleMessage(
            "Profile updated successfully!"),
        "recipe_not_found":
            MessageLookupByLibrary.simpleMessage("Recipe not found."),
        "recipe_of_the_day":
            MessageLookupByLibrary.simpleMessage("Recipe of the Day"),
        "relaxation": MessageLookupByLibrary.simpleMessage("Relaxation"),
        "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "tap_to_play": MessageLookupByLibrary.simpleMessage("Tap to Play"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome")
      };
}
