import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serenmind/screens/home/homeController.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:serenmind/screens/mood/moodController.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  late Future<Map<String, dynamic>?> _recipeFuture;
  late Future<Map<String, dynamic>?> _musicFuture;
  String? _currentMood;

  @override
  void initState() {
    super.initState();
    _recipeFuture = _controller.getRecipeByName('Poulet Rôti');
    _currentMood = Provider.of<MoodController>(context, listen: false).currentMood;
    _musicFuture = _controller.getMusicOfTheDay(_currentMood ?? 'happy');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause(String musicUrl) async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(musicUrl));
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Mes conseils',
                  style: AppTextStyles.headline2.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Divider(
                color: AppColors.textColor.withOpacity(0.3),
                thickness: 1.0,
              ),
              InkWell(
                onTap: () {
                  context.push('/tips');
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo/black_splash.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mes Conseils',
                      style: AppTextStyles.headline1.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Musique du Jour',
                  style: AppTextStyles.headline2.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Divider(
                color: AppColors.textColor.withOpacity(0.3),
                thickness: 1.0,
              ),
              FutureBuilder<Map<String, dynamic>?>(
                future: _musicFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Erreur : ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text("Musique non trouvée."));
                  }

                  var musicData = snapshot.data!;
                  String musicTitle = musicData['title'];
                  String musicUrl = musicData['url'];

                  return Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/music_player_background.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black54,
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            musicTitle,
                            style: AppTextStyles.headline3.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: AppColors.whiteColor,
                            size: 48,
                          ),
                          onPressed: () => _togglePlayPause(musicUrl),
                        ),
                        Text(
                          _isPlaying ? "Lecture en cours..." : "Appuyer pour jouer",
                          style: AppTextStyles.bodyText1.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Recette du Jour',
                  style: AppTextStyles.headline2.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Divider(
                color: AppColors.textColor.withOpacity(0.3),
                thickness: 1.0,
              ),
              FutureBuilder<Map<String, dynamic>?>(
                future: _recipeFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Erreur : ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text("Recette non trouvée."));
                  }

                  var data = snapshot.data!;
                  String recipeName = data['name'];
                  String imageUrl = data['imageUrl'];

                  return InkWell(
                    onTap: () {
                      context.push('/recipe/$recipeName');
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.thirdColor,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          recipeName,
                          style: AppTextStyles.headline1.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
    );
  }
}
