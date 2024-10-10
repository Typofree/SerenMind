import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:serenmind/services/firebase.dart';
import 'package:serenmind/constants/constants.dart';

class MusicListView extends StatefulWidget {
  @override
  _MusicListViewState createState() => _MusicListViewState();
}

class _MusicListViewState extends State<MusicListView> {
  final FirebaseControler _firebaseController = FirebaseControler();
  late Future<Map<String, Map<String, List<Map<String, dynamic>>>>> _musicFuture;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _currentMusicUrl;
  String? _currentMood;

  @override
  void initState() {
    super.initState();
    _loadCurrentMood();
    _musicFuture = _firebaseController.getAllMusic();
  }

  // Charger l'humeur actuelle depuis les préférences partagées
  Future<void> _loadCurrentMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? moodDataString = prefs.getString('moodData');

    if (moodDataString != null) {
      Map<String, dynamic> moodData = jsonDecode(moodDataString);
      String lastSavedMoodKey = moodData['mood'];
      setState(() {
        _currentMood = lastSavedMoodKey;
      });
    }
  }

  // Fonction pour jouer/mettre en pause la musique
  void _togglePlayPause(String musicUrl) async {
    if (_isPlaying && _currentMusicUrl == musicUrl) {
      await _audioPlayer.pause();
    } else {
      if (_currentMusicUrl != musicUrl) {
        await _audioPlayer.stop(); // Arrêter la musique précédente
        await _audioPlayer.play(UrlSource(musicUrl));
      } else {
        await _audioPlayer.resume();
      }
    }

    setState(() {
      _isPlaying = !_isPlaying;
      _currentMusicUrl = musicUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentMood == null) {
      return Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: FutureBuilder<Map<String, Map<String, List<Map<String, dynamic>>>>>(
        future: _musicFuture,
        builder: (BuildContext context, AsyncSnapshot<Map<String, Map<String, List<Map<String, dynamic>>>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune musique trouvée."));
          }

          Map<String, Map<String, List<Map<String, dynamic>>>> musicByMoodAndDay = snapshot.data!;

          // Filtrer les musiques en fonction de l'humeur actuelle
          Map<String, List<Map<String, dynamic>>>? filteredMusic = musicByMoodAndDay[_currentMood];

          if (filteredMusic == null || filteredMusic.isEmpty) {
            return Center(child: Text("Aucune musique disponible pour l'humeur sélectionnée."));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Affichage du titre avec l'humeur sélectionnée
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Une playlist ${translateMoodToFrench(_currentMood!)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: filteredMusic.entries.map((dayEntry) {
                    String day = dayEntry.key;
                    List<Map<String, dynamic>> musics = dayEntry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: musics.map((music) {
                            return InkWell(
                              onTap: () {
                                _togglePlayPause(music['url']);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                height: 200,
                                decoration: BoxDecoration(
                                  color: getColorForMood(_currentMood!),
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/music/music_$day.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              music['title'] ?? 'Musique',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Icon(
                                              _isPlaying && _currentMusicUrl == music['url']
                                                  ? Icons.pause_circle_filled
                                                  : Icons.play_circle_fill,
                                              color: Colors.white,
                                              size: 48,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
