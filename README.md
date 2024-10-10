# Serenmind

Serenmind est une application mobile développée en Flutter (version 3.22.3) avec une base de données et un backend gérés par Firebase. Cette application permet de suivre l'humeur, écouter de la musique, découvrir des recettes, et bien plus encore.

## Table des matières

- [Aperçu](#aperçu)
- [Fonctionnalités](#fonctionnalités)
- [Installation](#installation)
- [Dépendances](#dépendances)
- [Utilisation de Firebase](#utilisation-de-firebase)

## Aperçu

Serenmind est conçu pour offrir à ses utilisateurs une expérience conviviale, axée sur le bien-être. Il propose plusieurs fonctionnalités comme le suivi d'activités, de recettes, d'humeur, et inclut également des fonctionnalités d'authentification, de gestion des notifications, et bien plus encore grâce à l'intégration de Firebase.

## Fonctionnalités

- Authentification Firebase (Email/Password)
- Notifications push via Firebase Messaging
- Stockage de fichiers via Firebase Storage
- Gestion des recettes et suivi de l'humeur
- Système de splash screen personnalisé
- Lecture de musique intégrée
- Support multilingue avec `intl_utils`

## Installation

### Prérequis

- [Flutter](https://flutter.dev/) version 3.22.3 ou supérieure
- [Dart](https://dart.dev/) SDK version 3.4.4 ou supérieure
- Un projet Firebase configuré avec les services suivants :
    - Firebase Auth
    - Firestore
    - Firebase Messaging
    - Firebase Storage

### Étapes d'installation

1. Clonez le dépôt :

   ```bash
   git clone https://github.com/votre-repo/serenmind.git
   cd serenmind
    ```
2. Installez les dépendances Flutter :

   ```bash
   flutter pub get
    ```
3. Configurez Firebase en ajoutant vos fichiers google-services.json pour Android et GoogleService-Info.plist pour iOS.
4. Génération des fichiers intl pour les localisations :
   ```bash
   flutter pub run intl_utils:generate
    ```
5. Lancez l'application sur un émulateur ou un appareil physique :
   ```bash
   flutter run
    ```

## Dépendances

Voici les principales dépendances utilisées dans l'application :

- **`firebase_core`** : Intégration de Firebase dans Flutter
- **`firebase_auth`** : Authentification Firebase
- **`cloud_firestore`** : Base de données Firestore
- **`firebase_messaging`** : Notifications push
- **`firebase_storage`** : Stockage des fichiers dans Firebase
- **`go_router`** : Navigation déclarative dans Flutter
- **`permission_handler`** : Gestion des permissions d'appareil
- **`shared_preferences`** : Stockage local de données simples
- **`audioplayers`** : Lecteur audio pour Flutter
- **`carousel_slider`** : Composant de carrousel pour les vues
- **`provider`** : Gestion d'état simplifiée pour Flutter

Pour une liste complète des dépendances, consultez le fichier `pubspec.yaml`.

## Utilisation de Firebase

L'application utilise Firebase pour les fonctionnalités suivantes :

- **Firebase Auth** : Authentification utilisateur (création de compte, connexion).
- **Cloud Firestore** : Base de données pour stocker les informations liées aux utilisateurs, aux activités, et autres données.
- **Firebase Messaging** : Notifications push pour alerter les utilisateurs sur des événements importants.
- **Firebase Storage** : Stockage d'images et de fichiers audio.

---

Développé avec ❤️ par l'équipe Serenmind.

