import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serenmind/screens/home/homeController.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:serenmind/screens/mood/moodController.dart';
import 'package:serenmind/services/firebase.dart';
import 'package:serenmind/generated/l10n.dart';  // Import de la classe générée pour la localisation

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController();
  final FirebaseControler _firebaseController = FirebaseControler();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  late Future<Map<String, dynamic>?> _recipeFuture;
  late Future<Map<String, dynamic>?> _musicFuture;
  String? _currentMood;

  @override
  void initState() {
    super.initState();
    _currentMood = Provider.of<MoodController>(context, listen: false).currentMood;
    _recipeFuture = _controller.getRecipeOfTheDay(_currentMood ?? 'happy');
    _musicFuture = _controller.getMusicOfTheDay(_currentMood ?? 'happy');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String getDayOfWeek() {
    return _firebaseController.getDayOfWeek();
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
            Text(
              S.of(context).my_relaxation_tips, // "Mes conseils détentes" / "My Relaxation Tips"
              style: AppTextStyles.headline2.copyWith(
                color: AppColors.textColor,
              ),
            ),
            Divider(
              color: AppColors.textColor.withOpacity(0.3),
              thickness: 1.0,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity, // Takes full width of parent
                height: 140,            // Defined height
                margin: EdgeInsets.zero, // Remove any margin
                padding: EdgeInsets.zero, // Remove any padding
                decoration: BoxDecoration(
                  color: AppColors.thirdColor,  // Background color
                  borderRadius: BorderRadius.circular(16),  // Keep if you want rounded corners
                  image: const DecorationImage(
                    image: AssetImage('assets/images/menu/detente_home.png'),
                    fit: BoxFit.cover,  // Ensure image covers the entire container
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).relaxation, // "Détentes" / "Relaxation"
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
                S.of(context).music_of_the_day, // "Musique du Jour" / "Music of the Day"
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
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(S.of(context).error(snapshot.error.toString()))); // "Erreur : ${snapshot.error}" / "Error: ${snapshot.error}"
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text(S.of(context).music_not_found)); // "Musique non trouvée." / "Music not found"
                }

                var musicData = snapshot.data!;
                String musicTitle = musicData['title'];
                String musicUrl = musicData['url'];

                return Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/music_player_background.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        musicTitle,
                        style: AppTextStyles.headline3.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
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
                        _isPlaying
                            ? S.of(context).now_playing // "Lecture en cours..." / "Now Playing..."
                            : S.of(context).tap_to_play, // "Appuyer pour jouer" / "Tap to Play"
                        style: AppTextStyles.bodyText1.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold
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
                S.of(context).recipe_of_the_day, // "Recette du Jour" / "Recipe of the Day"
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
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(S.of(context).error(snapshot.error.toString()))); // "Erreur : ${snapshot.error}" / "Error: ${snapshot.error}"
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text(S.of(context).recipe_not_found)); // "Recette non trouvée." / "Recipe not found"
                }

                var data = snapshot.data!;
                String recipeName = data['name'];
                String imageUrl = data['imageUrl'];

                return InkWell(
                  onTap: () {
                    context.push('/recipe/${_currentMood ?? 'happy'}/${getDayOfWeek()}/$recipeName');
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
