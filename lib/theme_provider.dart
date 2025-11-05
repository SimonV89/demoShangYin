
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static final ThemeData _lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        // 对于浅色主题，我们希望状态栏图标是深色的
        statusBarIconBrightness: Brightness.dark,
        // 将状态栏背景设置为透明，以显示下方的Scaffold背景色
        statusBarColor: Colors.transparent,
      ),
    ),
  );

  static final ThemeData _darkTheme = ThemeData.dark();

  ThemeData _themeData;
  final SharedPreferences prefs;

  ThemeProvider({required this.prefs}) : _themeData = _loadThemeFromPrefs(prefs);

  static ThemeData _loadThemeFromPrefs(SharedPreferences prefs) {
    final isDark = prefs.getBool('isDark') ?? false;
    return isDark ? _darkTheme : _lightTheme;
  }

  ThemeData getTheme() => _themeData;

  bool isDarkMode() => _themeData == _darkTheme;

  void toggleTheme() {
    _themeData = isDarkMode() ? _lightTheme : _darkTheme;
    prefs.setBool('isDark', isDarkMode());
    notifyListeners();
  }
}
