import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DSnackbarType {
  success,
  error,
}

class DSnackbar {
  void show(String title, String message, {DSnackbarType type = DSnackbarType.success}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: type == DSnackbarType.success ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
    );
  }
}