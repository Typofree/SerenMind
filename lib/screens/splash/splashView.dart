import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 1.0),
    ).animate(_animationController);

    Future.delayed(const Duration(seconds: 3), () async {
      await _checkMoodAndNavigate();
      _animationController.forward();
    });
  }

  Future<void> _checkMoodAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    String? moodDataString = prefs.getString('moodData');

    if (moodDataString != null) {
      Map<String, dynamic> moodData = jsonDecode(moodDataString);
      String moodDate = moodData['date'];
      String moodKey = moodData['mood'];

      if (moodDate == today && moodKey != null) {
        context.go('/');
        return;
      }
    }
    context.go('/mood');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          SlideTransition(
            position: _slideAnimation,
            child: SplashContent(),
          ),
        ],
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash/splash_background.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
