// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Log in to continue`
  String get loginPrompt {
    return Intl.message(
      'Log in to continue',
      name: 'loginPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailHint {
    return Intl.message(
      'Email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHint {
    return Intl.message(
      'Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get loginButton {
    return Intl.message(
      'Log In',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don''t have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the information below`
  String get fillInfo {
    return Intl.message(
      'Fill in the information below',
      name: 'fillInfo',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get nav_home {
    return Intl.message(
      'Home',
      name: 'nav_home',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get nav_activity {
    return Intl.message(
      'Activity',
      name: 'nav_activity',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get nav_music {
    return Intl.message(
      'Music',
      name: 'nav_music',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get nav_menu {
    return Intl.message(
      'Menu',
      name: 'nav_menu',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Change Mood`
  String get mood {
    return Intl.message(
      'Change Mood',
      name: 'mood',
      desc: '',
      args: [],
    );
  }

  /// `Legal Mentions`
  String get legal {
    return Intl.message(
      'Legal Mentions',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `Accessibility`
  String get accessibility {
    return Intl.message(
      'Accessibility',
      name: 'accessibility',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the Email field`
  String get errorEmailEmpty {
    return Intl.message(
      'Please fill in the Email field',
      name: 'errorEmailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the Password field`
  String get errorPasswordEmpty {
    return Intl.message(
      'Please fill in the Password field',
      name: 'errorPasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No user found with this email.`
  String get errorUserNotFound {
    return Intl.message(
      'No user found with this email.',
      name: 'errorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect.`
  String get errorWrongPassword {
    return Intl.message(
      'The password is incorrect.',
      name: 'errorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the Confirm Password field`
  String get errorConfirmPasswordEmpty {
    return Intl.message(
      'Please fill in the Confirm Password field',
      name: 'errorConfirmPasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get errorPasswordsDontMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'errorPasswordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak.`
  String get errorWeakPassword {
    return Intl.message(
      'The password is too weak.',
      name: 'errorWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use.`
  String get errorEmailAlreadyInUse {
    return Intl.message(
      'This email is already in use.',
      name: 'errorEmailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Error during login: {error}`
  String errorGeneral(Object error) {
    return Intl.message(
      'Error during login: $error',
      name: 'errorGeneral',
      desc: '',
      args: [error],
    );
  }

  /// `An error occurred: {error}`
  String errorGeneric(Object error) {
    return Intl.message(
      'An error occurred: $error',
      name: 'errorGeneric',
      desc: '',
      args: [error],
    );
  }

  /// `Sent password reset email`
  String get passwordResetSent {
    return Intl.message(
      'Sent password reset email',
      name: 'passwordResetSent',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get profileTitle {
    return Intl.message(
      'Profil',
      name: 'profileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update your information below`
  String get profileSubtitle {
    return Intl.message(
      'Update your information below',
      name: 'profileSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Account Deletion`
  String get confirmDelete {
    return Intl.message(
      'Confirm Account Deletion',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get deleteAccountWarning {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully!`
  String get profileUpdated {
    return Intl.message(
      'Profile updated successfully!',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Déconnexion`
  String get logout {
    return Intl.message(
      'Déconnexion',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstNameHint {
    return Intl.message(
      'First Name',
      name: 'firstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastNameHint {
    return Intl.message(
      'Last Name',
      name: 'lastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get ageHint {
    return Intl.message(
      'Age',
      name: 'ageHint',
      desc: '',
      args: [],
    );
  }

  /// `First name cannot be empty`
  String get errorFirstNameEmpty {
    return Intl.message(
      'First name cannot be empty',
      name: 'errorFirstNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Last name cannot be empty`
  String get errorLastNameEmpty {
    return Intl.message(
      'Last name cannot be empty',
      name: 'errorLastNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid age`
  String get errorAgeInvalid {
    return Intl.message(
      'Please enter a valid age',
      name: 'errorAgeInvalid',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
