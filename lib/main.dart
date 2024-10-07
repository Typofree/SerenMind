import 'package:flutter/material.dart';
import 'services/router.dart';

void main() {
  runApp(SerenMindApp());
}

class SerenMindApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.router,
    );
  }
}
