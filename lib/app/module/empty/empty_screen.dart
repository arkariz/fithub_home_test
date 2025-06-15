import 'package:fithub_home_test/app/common/widgets/d_text.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.title, required this.subtitle});
  
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(height: 80),
          const Column(
            spacing: 16,
            children: [
              _SlantedImage('assets/onboard1.jpeg', angle: -0.13, alignment: Alignment(1, -0.3)),
              _SlantedImage('assets/onboard2.jpeg', angle: -0.13, alignment: Alignment(1, -0.2)),
              _SlantedImage('assets/onboard3.jpeg', angle: -0.13, alignment: Alignment(1, -0.5)),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              spacing: 10,
              children: [
                DText(
                  text: title,
                  type: DTextType.titleLarge,
                  textAlign: TextAlign.center,
                ),
                DText(
                  text: subtitle,
                  type: DTextType.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      );
  }
}

class _SlantedImage extends StatelessWidget {
  final String assetPath;
  final double angle;
  final Alignment alignment;
  const _SlantedImage(this.assetPath, {this.angle = 0, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        return SizedBox(
          height: 180,
          child: Transform.rotate(
            angle: angle,
            child: OverflowBox(
              maxWidth: screenWidth * 1.3,
              child: Image.asset(
                assetPath,
                width: screenWidth * 1.2,
                fit: BoxFit.cover,
                alignment: alignment,
              ),
            ),
          ),
        );
      },
    );
  }
}