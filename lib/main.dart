import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';
import 'utils/theme.dart';
import 'utils/constants.dart';

// FIX: Snackbar was getting stuck because context changed
// Using global ScaffoldMessenger key instead
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const SmartTaskManager());
}

class SmartTaskManager extends StatefulWidget {
  const SmartTaskManager({super.key});

  @override
  State<SmartTaskManager> createState() => _SmartTaskManagerState();
}

class _SmartTaskManagerState extends State<SmartTaskManager> {
  bool _isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isDarkMode = prefs.getBool('isDarkMode') ?? true;
      });
    } catch (e) {
      setState(() {
        _isDarkMode = true;
      });
    }
  }

  /// Toggles theme
  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isDarkMode = !_isDarkMode;
        prefs.setBool('isDarkMode', _isDarkMode);
      });
    } catch (e) {
      setState(() {
        _isDarkMode = !_isDarkMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      home: SplashScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}
