import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../favorite/favorite_screen.dart';
import '../now_playing/now_playing_screen.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> widgetOptions = [
    const NowPlayingScreen(),
    const FavoriteScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
