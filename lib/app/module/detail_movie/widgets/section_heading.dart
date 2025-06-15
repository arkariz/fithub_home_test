import 'package:flutter/material.dart';
import 'package:fithub_home_test/app/common/theme/daycode_theme.dart';
import 'package:fithub_home_test/app/common/widgets/d_text.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    required this.runtime,
    required this.voteAverage,
  });

  final String title;
  final int runtime;
  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        const SizedBox(height: 6),
        DText(
          text: title,
          type: DTextType.titleLarge,
          textAlign: TextAlign.center,
        ),
        Row(
          spacing: 20,
          children: [
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color:
                      DaycodeTheme.instance.theme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                DText(
                  text: "$runtime minutes",
                  type: DTextType.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color:
                      DaycodeTheme.instance.theme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                DText(
                  text: "$voteAverage (IMDb)",
                  type: DTextType.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
