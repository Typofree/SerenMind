import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/screens/mood/moodController.dart';
import 'package:go_router/go_router.dart';

class MoodView extends StatefulWidget {
  @override
  _MoodViewState createState() => _MoodViewState();
}

class _MoodViewState extends State<MoodView> {
  CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MoodController>(context, listen: false).loadMood();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MoodController>(context);

    return Scaffold(
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color: controller.backgroundColor,
              child: SafeArea(
                child: Stack(
                  children: [
                    CarouselSlider(
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        initialPage: controller.currentIndex,
                        height: MediaQuery.of(context).size.height,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        autoPlay: false,
                        onPageChanged: (index, reason) {
                          // Met à jour l'index et réinitialise l'humeur si la slide change
                          controller.setCurrentIndex(index);
                          controller.setCurrentMood(null); // Réinitialise l'humeur actuelle
                        },
                      ),
                      items: controller.moods.map((mood) {
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
                    Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Utiliser la clé d'humeur (key) pour définir l'humeur actuelle
                              controller.setCurrentMood(controller.moods[controller.currentIndex]['key']);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: controller.currentMood ==
                                      controller.moods[controller.currentIndex]['key']
                                  ? Colors.green
                                  : Colors.transparent,
                              foregroundColor: AppColors.whiteColor,
                              side: const BorderSide(
                                color: AppColors.blackColor,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'Je suis ${controller.moods[controller.currentIndex]['mood']}',
                              style: AppTextStyles.buttonText,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Indicateurs de "dots"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.moods.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => buttonCarouselController
                                    .animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.currentIndex == entry.key
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: controller.currentMood != null,
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.currentMood != null) {
                                  int moodIndex = controller.currentIndex;
                                  controller.saveMood(moodIndex);
                                  context.go('/');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: Colors.greenAccent,
                                foregroundColor: AppColors.whiteColor,
                                side: const BorderSide(
                                  color: AppColors.blackColor,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                'Valider ma sélection',
                                style: AppTextStyles.buttonText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
