import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart'; // Import du CarouselController
import 'package:intl/intl.dart';

import 'package:serenmind/constants/styles.dart';

class MoodView extends StatefulWidget {
  @override
  _MoodViewState createState() => _MoodViewState();
}

class _MoodViewState extends State<MoodView>
    with SingleTickerProviderStateMixin {
  String? _currentMood;
  int _currentIndex = 0;
  Color _backgroundColor = AppColors.backgroundColor;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showMoodText = false;
  bool _isLoading = true;

  final List<Map<String, dynamic>> _moods = [
    {
      'mood': 'Heureux',
      'image': 'assets/images/mood/happy.png',
      'color': Colors.yellow
    },
    {
      'mood': 'Surpris',
      'image': 'assets/images/mood/shocked.png',
      'color': Colors.orange
    },
    {
      'mood': 'Énervé',
      'image': 'assets/images/mood/angry.png',
      'color': Colors.red
    },
    {
      'mood': 'Excité',
      'image': 'assets/images/mood/excited.png',
      'color': Colors.purple
    },
    {
      'mood': 'Calme',
      'image': 'assets/images/mood/calm.png',
      'color': Colors.blue
    },
  ];

  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _loadMood();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? lastSavedMood = prefs.getString('mood');
    String? lastSavedDate = prefs.getString('date');

    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (lastSavedDate != currentDate) {
      setState(() {
        _currentMood = "Pas d'humeur sélectionnée";
        _currentIndex = 0;
        _backgroundColor = AppColors.backgroundColor;
      });
    } else {
      setState(() {
        _currentMood = lastSavedMood ?? "Pas d'humeur sélectionnée";
        _currentIndex = _moods.indexWhere((m) => m['mood'] == _currentMood);
        if (_currentIndex == -1) _currentIndex = 0;
        _backgroundColor = _moods[_currentIndex]['color'];
      });
    }

    await Future.delayed(Duration(milliseconds: 300));

    if (buttonCarouselController.ready) {
      buttonCarouselController.jumpToPage(_currentIndex);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveMood(String mood) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    await prefs.setString('mood', mood);
    await prefs.setString('date', currentDate);

    setState(() {
      _currentMood = mood;
      _showMoodText = true;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color: _backgroundColor,
              child: SafeArea(
                child: ClipRRect(
                  clipBehavior: Clip.none,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          initialPage: _currentIndex,
                          height: MediaQuery.of(context).size.height,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                              _backgroundColor = _moods[_currentIndex]['color'];
                            });
                          },
                        ),
                        items: _moods.map((mood) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(mood['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      if (_currentMood != null &&
                          _currentMood != "Pas d'humeur sélectionnée")
                        Positioned(
                          top: 30,
                          left: 20,
                          right: 20,
                          child: Center(
                            child: Text(
                              "Aujourd'hui, je suis $_currentMood",
                              style: AppTextStyles.headline1.copyWith(
                                color: AppColors.whiteColor,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _saveMood(_moods[_currentIndex]['mood']!);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: AppColors.blackColor,
                                foregroundColor: AppColors.whiteColor,
                                side: const BorderSide(
                                  color: AppColors.blackColor,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                'Je suis ${_moods[_currentIndex]['mood']!}',
                                style: AppTextStyles.buttonText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
