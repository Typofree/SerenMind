
import 'package:flutter/material.dart';

// obtiens une couleur en fonction du mood
Color getColorForMood(String mood) {
  switch (mood) {
    case 'happy':
      return Colors.yellow[300]!;
    case 'sad':
      return Colors.blue[300]!;
    case 'angry':
      return Colors.red[300]!;
    case 'surprised':
      return Colors.purple[300]!;
    default:
      return Colors.grey[300]!;
  }
}

// traduit les moods en français
String translateMoodToFrench(String mood) {
  switch (mood) {
    case 'happy':
      return 'Joyeux';
    case 'sad':
      return 'Triste';
    case 'angry':
      return 'Enervé';
    case 'surprised':
      return 'Surpris';
    default:
      return 'Inconnu';
  }
}
