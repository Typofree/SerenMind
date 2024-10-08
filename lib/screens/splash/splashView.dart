import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serenmind/mainlayout.dart';

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
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 1.0),
    ).animate(_animationController);

    Future.delayed(const Duration(seconds: 3), () {
      _animationController.forward();
    });
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
          MainLayout(pageIndex: 0),
          SlideTransition(
            position: _slideAnimation,
            child: SplashContent(),
          ),
        ],
      ),
    );
  }
}

// Widget pour le contenu du SplashScreen (vous pouvez le modifier)
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
