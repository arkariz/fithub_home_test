import 'package:fithub_home_test/app/common/theme/daycode_color_scheme.dart';
import 'package:flutter/material.dart';

class DScaffold extends StatelessWidget {
  const DScaffold({super.key, required this.body, this.appBar, this.bottomNavigationBar});

  final Widget body;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: DaycodeGradient.backgroundGradient,
          ),
        ),
        Scaffold(
          appBar: appBar,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ],
    );
  }
}
