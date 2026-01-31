import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';

// Global key for ScaffoldMessenger
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

  /// Loads save theme
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        // Default to dark mode if no preference is saved
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
        // Save the new theme preference
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
      title: 'Smart Task Manager',
      // Switch between dark and light theme based on user preference
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      /// Light theme
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        cardColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.blueAccent,
          error: Colors.redAccent,
        ),
        useMaterial3: true,
      ),

      // Dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          error: Colors.redAccent,
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}
