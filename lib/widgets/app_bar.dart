import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/generated/l10n.dart';

class HeaderAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _HeaderAppBarState createState() => _HeaderAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderAppBarState extends State<HeaderAppBar> {
  bool _isPressed = false;
  User? _user;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: InkWell(
          onTap: () {
            if (_user == null || _user!.isAnonymous) {
              context.push('/profil');
            } else {
              context.push('/profil');
            }
          },
          onHighlightChanged: (isHighlighted) {
            setState(() {
              _isPressed = isHighlighted;
            });
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isPressed ? AppColors.primaryColor : AppColors.backgroundColor,
              border: Border.all(
                color: _user != null && !_user!.isAnonymous
                    ? AppColors.primaryColor
                    : Color.fromARGB(255, 64, 66, 66),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 28,
                color: _user != null && !_user!.isAnonymous
                    ? AppColors.primaryColor
                    : Color.fromARGB(255, 64, 66, 66),
              ),
            ),
          ),
        ),
      ),
      title: Image.asset(
        'assets/images/logo/logo_simple.png',
        fit: BoxFit.contain,
        width: 120,
        height: 80,
      ),
      centerTitle: true,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'settings':
                context.go('/settings');
                break;
              case 'mood':
                context.go('/mood');
                break;
              case 'legal':
                context.go('/legal');
                break;
              case 'accessibility':
                context.go('/accessibility');
                break;
              default:
                break;
            }
          },
          icon: Icon(Icons.more_vert, color: AppColors.blackColor),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'settings',
              child: Text(S.of(context).settings),
            ),
            PopupMenuItem<String>(
              value: 'mood',
              child: Text(S.of(context).mood),
            ),
            PopupMenuItem<String>(
              value: 'legal',
              child: Text(S.of(context).legal),
            ),
            PopupMenuItem<String>(
              value: 'accessibility',
              child: Text(S.of(context).accessibility),
            ),
          ],
        ),
      ],
    );
  }
}
