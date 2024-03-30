import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late int _themeIndex;

  int get themeIndex => _themeIndex;

  ThemeProvider() {
    _loadThemeIndex();
  }

  Future<void> _loadThemeIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeIndex = prefs.getInt('themeIndex') ?? 1;
    notifyListeners();
  }

  Future<void> setTheme(int value) async {
    _themeIndex = value;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', value);
  }
}

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());
