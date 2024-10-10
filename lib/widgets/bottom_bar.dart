import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/generated/l10n.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textColor.withOpacity(0.6),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home,
                    color: currentIndex == 0
                        ? AppColors.primaryColor
                        : AppColors.textColor.withOpacity(0.6)),
                const SizedBox(height: 4),
                Text(
                  S.of(context).nav_home,
                  style: currentIndex == 0
                      ? AppTextStyles.bodyText1
                          .copyWith(color: AppColors.primaryColor)
                      : AppTextStyles.bodyText1.copyWith(
                          color: AppColors.textColor.withOpacity(0.6)),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fitness_center,
                    color: currentIndex == 1
                        ? AppColors.primaryColor
                        : AppColors.textColor.withOpacity(0.6)),
                const SizedBox(height: 4),
                Text(
                  S.of(context).nav_activity,
                  style: currentIndex == 1
                      ? AppTextStyles.bodyText1
                          .copyWith(color: AppColors.primaryColor)
                      : AppTextStyles.bodyText1.copyWith(
                          color: AppColors.textColor.withOpacity(0.6)),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.music_note,
                    color: currentIndex == 2
                        ? AppColors.primaryColor
                        : AppColors.textColor.withOpacity(0.6)),
                const SizedBox(height: 4),
                Text(
                  S.of(context).nav_music,
                  style: currentIndex == 2
                      ? AppTextStyles.bodyText1
                          .copyWith(color: AppColors.primaryColor)
                      : AppTextStyles.bodyText1.copyWith(
                          color: AppColors.textColor.withOpacity(0.6)),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant,
                    color: currentIndex == 3
                        ? AppColors.primaryColor
                        : AppColors.textColor.withOpacity(0.6)),
                const SizedBox(height: 4),
                Text(
                  S.of(context).nav_menu,
                  style: currentIndex == 3
                      ? AppTextStyles.bodyText1
                          .copyWith(color: AppColors.primaryColor)
                      : AppTextStyles.bodyText1.copyWith(
                          color: AppColors.textColor.withOpacity(0.6)),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
