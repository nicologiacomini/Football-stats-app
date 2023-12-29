import 'package:flutter/material.dart';

const MaterialColor mycolor = MaterialColor(_mycolorPrimaryValue, <int, Color>{
  50: Color(0xFFF6FFEB),
  100: Color(0xFFEAFFCC),
  200: Color(0xFFDCFFAA),
  300: Color(0xFFCDFF88),
  400: Color(0xFFC3FF6F),
  500: Color(_mycolorPrimaryValue),
  600: Color(0xFFB1FF4E),
  700: Color(0xFFA8FF44),
  800: Color(0xFFA0FF3B),
  900: Color(0xFF91FF2A),
});
const int _mycolorPrimaryValue = 0xFFB8FF55;

const MaterialColor mycolorAccent =
    MaterialColor(_mycolorAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_mycolorAccentValue),
  400: Color(0xFFE9FFD7),
  700: Color(0xFFDCFFBE),
});
const int _mycolorAccentValue = 0xFFFFFFFF;
