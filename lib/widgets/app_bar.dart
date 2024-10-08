import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serenmind/constants/styles.dart';

class HeaderAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _HeaderAppBarState createState() => _HeaderAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderAppBarState extends State<HeaderAppBar> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: InkWell(
          onTap: () {
            context.push('/login');
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
                color: Color.fromARGB(255, 64, 66, 66),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 28,
                color: _isPressed ? AppColors.whiteColor : Color.fromARGB(255, 64, 66, 66),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
