import 'package:flutter/material.dart';

ThemeData get theme {
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff017EB7),
    ),
    useMaterial3: true,
  );
}
