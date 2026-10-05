import 'package:flutter/material.dart';

import '../features/home/presentation/home_screen.dart';
import 'theme.dart';

class PitchPerfectApp extends StatelessWidget {
  const PitchPerfectApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'PitchPerfect',
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        home: const HomeScreen(),
      );
}
