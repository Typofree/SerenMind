import 'package:flutter/material.dart';
import 'package:serenmind/services/firebase.dart';
import 'package:audioplayers/audioplayers.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialiser le Future une seule fois lors de l'initialisation
    _musicFuture = _firebaseController.getAllMusic();
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

            return ListView(
              children: musicByMoodAndDay.entries.map((moodEntry) {
                String mood = moodEntry.key;
                Map<String, List<Map<String, dynamic>>> daysMusic = moodEntry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        translateMoodToFrench(mood),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Parcourir chaque jour de l'humeur et afficher les musiques
                    ...daysMusic.entries.map((dayEntry) {
                      String day = dayEntry.key;
                      List<Map<String, dynamic>> musics = dayEntry.value;

                      return Column(
                        children: musics.map((music) {
                          return InkWell(
                            onTap: () {
                              _togglePlayPause(music['url']);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              height: 200, // Hauteur définie pour chaque conteneur de musique
                              decoration: BoxDecoration(
                                color: getColorForMood(mood), // Couleur de fond pour l'humeur (si pas d'image)
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/music/music_$day.png'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4), // Assombrir l'image pour le texte
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
                                              color: Colors.white, // Couleur du texte blanc
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
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
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
