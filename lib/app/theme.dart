import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness b) => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00796B), brightness: b),
      cardTheme: const CardThemeData(margin: EdgeInsets.zero),
    );
