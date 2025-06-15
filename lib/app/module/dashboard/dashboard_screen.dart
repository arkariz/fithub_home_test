import 'package:fithub_home_test/app/common/theme/daycode_color_scheme.dart';
import 'package:fithub_home_test/app/common/theme/daycode_theme.dart';
import 'package:fithub_home_test/app/common/widgets/d_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DScaffold(
      body: SizedBox(child: controller.widgetOptions[controller.selectedIndex.value],),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 1,
        unselectedFontSize: 1,
        iconSize: 45,
        items: <BottomNavigationBarItem>[
          navBarItem(Icons.play_arrow, Icons.play_circle_fill, controller.selectedIndex.value == 0),
          navBarItem(Icons.favorite, Icons.favorite, controller.selectedIndex.value == 1),
        ],
        currentIndex: controller.selectedIndex.value,
        onTap: controller.onItemTapped,
      ),
    ));
  }

  BottomNavigationBarItem navBarItem(IconData innerIcon, IconData outerIcon, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Icon(
            innerIcon, 
            color: isSelected 
              ? DaycodeTheme.instance.theme.colorScheme.onSurface 
              : DaycodeTheme.instance.theme.colorScheme.onSurfaceVariant,
          ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return isSelected 
                ? DaycodeGradient.primaryColorGradient.createShader(bounds) 
                : DaycodeGradient.onSurfaceGradient.createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
              child: Icon(
                outerIcon,
                color: isSelected
                  ? Colors.white
                  : DaycodeTheme.instance.theme.colorScheme.onSurfaceVariant,
              ),
          ),
        ],
      ),
      label: ""
    );
  }
}