import 'package:fithub_home_test/app/common/widgets/d_text.dart';
import 'package:flutter/material.dart';

class SectionOverview extends StatelessWidget {
  const SectionOverview({
    super.key,
    required this.overview,
  });

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DText(
          text: "Overview",
          type: DTextType.titleSmall,
          textAlign: TextAlign.left,
        ),
        DText(
          text: overview,
          type: DTextType.bodySmall,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}