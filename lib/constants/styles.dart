import 'package:flutter/material.dart';

// Définitions des couleurs personnalisées
class AppColors {
  static const Color primaryColor = Color(0xFF579CAA);
  static const Color secondaryColor = Color(0xFF4D79AD);
  static const Color thirdColor = Color(0xFF03A9F4);
  static const Color fourthColor = Color(0xFFA9CAED);
  static const Color fifthColor = Color(0xFFA9CAED);
  static const Color backgroundColor = Color(0xFFF2F8F9);

  static const Color textColor = Color(0xFF333333);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
}

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontFamily:
        'Poppins',
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontFamily: 'Poppins',
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
    fontFamily: 'Montserrat',
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
    fontFamily: 'Montserrat',
  );

  static const TextStyle bodyText3 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
    fontFamily: 'Montserrat',
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
    fontFamily: 'Montserrat',
  );
}
