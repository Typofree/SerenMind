import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class MoodController extends ChangeNotifier {
  String? _currentMood;
  int _currentIndex = 0;
  Color _backgroundColor = Colors.white;
  bool _isLoading = true;

  final List<Map<String, dynamic>> _moods = [
    {
      'mood': 'Heureux',
      'key': 'happy',
      'image': 'assets/images/mood/happy.png',
      'color': Colors.yellow
    },
    {
      'mood': 'Surpris',
      'key': 'surprise',
      'image': 'assets/images/mood/shocked.png',
      'color': Colors.orange
    },
    {
      'mood': 'Énervé',
      'key': 'angry',
      'image': 'assets/images/mood/angry.png',
      'color': Colors.red
    },
    {
      'mood': 'Triste',
      'key': 'sad',
      'image': 'assets/images/mood/sad.png',
      'color': Colors.blue
    },
  ];

  String? get currentMood => _currentMood;
  int get currentIndex => _currentIndex;
  Color get backgroundColor => _backgroundColor;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get moods => _moods;

  // Set the current mood ONLY when the user selects it
  void setCurrentMood(String? mood) {
    _currentMood = mood;
    notifyListeners();
  }

  // Change the current index when the slide changes, but DO NOT save the mood
  void setCurrentIndex(int index) {
    _currentIndex = index;
    _backgroundColor = _moods[index]['color'];
    _currentMood = null; // Clear the mood when changing the slide
    notifyListeners();
  }

  Future<void> saveMood(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      String moodKey = _moods[index]['key'];

      Map<String, String> moodData = {
        'mood': moodKey,
        'date': currentDate,
      };

      await prefs.setString('moodData', jsonEncode(moodData));

      _currentMood = moodKey; // Save the mood after pressing the button
      notifyListeners();
    } catch (e) {
      print("Erreur lors de la sauvegarde de l'humeur : $e");
    }
  }

  Future<void> loadMood() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      String? moodDataString = prefs.getString('moodData');

      if (moodDataString != null) {
        Map<String, dynamic> moodData = jsonDecode(moodDataString);

        String lastSavedMoodKey = moodData['mood'];
        String lastSavedDate = moodData['date'];

        if (lastSavedDate == currentDate) {
          // Find the index of the mood with the saved key
          _currentIndex =
              _moods.indexWhere((m) => m['key'] == lastSavedMoodKey);

          if (_currentIndex != -1) {
            _currentMood = lastSavedMoodKey;
            _backgroundColor = _moods[_currentIndex]['color'];
          } else {
            _resetMood();
          }
        } else {
          _resetMood();
        }
      } else {
        _resetMood();
      }
    } catch (e) {
      _resetMood();
      print("Erreur lors du chargement de l'humeur : $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _resetMood() {
    _currentMood = null;
    _currentIndex = 0;
    _backgroundColor = Colors.white;
  }
}
