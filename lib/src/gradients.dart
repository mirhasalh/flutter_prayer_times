import 'package:flutter/material.dart';
import 'package:prayer_times/src/palette.dart';

class Gradients {
  static const fajr = LinearGradient(
    colors: [
      Palette.middleRedPurple,
      Palette.oldMauve,
      Palette.englishViolet,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.65, 1.0],
  );

  static const dhuhr = LinearGradient(
    colors: [
      Palette.lightCyan,
      Palette.electricBlue,
      Palette.electricBlue,
      Palette.cyanProcess,
      Palette.frenchSkyBlue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.05, 0.35, 0.45, 0.85, 1.0],
  );

  static const asr = LinearGradient(
    colors: [
      Palette.lightCyan,
      Palette.electricBlue,
      Palette.turquoise,
      Palette.teaGreen,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.25, 0.6, 1.0],
  );

  static const maghrib = LinearGradient(
    colors: [
      Palette.palePink,
      Palette.pinkLavender,
      Palette.tickleMePink,
      Palette.salmonPink,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.3, 0.75, 1.0],
  );

  static const isha = LinearGradient(
    colors: [
      Palette.spaceCadet,
      Palette.darkPurple,
      Palette.mistyDarkPurple,
      Palette.richBlack,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.25, 0.45, 1.0],
  );
}
