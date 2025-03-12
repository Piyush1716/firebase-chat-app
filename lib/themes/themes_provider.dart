import 'package:flutter/material.dart';
import 'package:temp/themes/dark_theme.dart';
import 'package:temp/themes/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if(_themeData == lightTheme){
      setThemeData(darkTheme);
    }
    else{
      setThemeData(lightTheme);
    }
  }
}