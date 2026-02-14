import 'package:flutter/material.dart';
import 'constants.dart';

class AppHelpers {
  static Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return AppColors.highPriority;
      case 'Medium':
        return AppColors.mediumPriority;
      default:
        return AppColors.lowPriority;
    }
  }

  static int getPriorityRank(String priority) {
    switch (priority) {
      case 'High':
        return 0;
      case 'Medium':
        return 1;
      default:
        return 2;
    }
  }

  static bool isToday(DateTime date) {
    return DateUtils.isSameDay(date, DateTime.now());
  }

  static bool isPastDate(DateTime date) {
    return date.isBefore(DateTime.now()) && !isToday(date);
  }

  /// snack bar message
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.blueAccent,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// error snack bar
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppColors.error,
      duration: duration,
    );
  }

  /// success snack bar
  static void showSuccess(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: AppColors.success);
  }

  /// info dialog
  static Future<void> showInfoDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
