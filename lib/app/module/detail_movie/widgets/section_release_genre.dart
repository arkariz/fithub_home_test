import 'package:fithub_home_test/app/common/theme/daycode_theme.dart';
import 'package:fithub_home_test/app/common/widgets/d_text.dart';
import 'package:fithub_home_test/data/api/model/movie_detail.dart';
import 'package:flutter/material.dart';

class SectionReleaseGenre extends StatelessWidget {
  const SectionReleaseGenre({
    super.key,
    required this.releaseDate,
    required this.genres,
  });

  final String releaseDate;
  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DText(
              text: "Release Date",
              type: DTextType.titleSmall,
              textAlign: TextAlign.center,
            ),
            DText(
              text: releaseDate,
              type: DTextType.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 4,
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DText(
                text: "Genre",
                type: DTextType.titleSmall,
                textAlign: TextAlign.center,
              ),
              Row(
                spacing: 5,
                children: genres.take(2).map(
                  (e) => Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: DaycodeTheme.instance.theme.colorScheme.secondary),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: DaycodeTheme.instance.theme.colorScheme.secondary.withValues(alpha: 0.1),
                          blurRadius: 1.6,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: DText(text: e.name, type: DTextType.bodySmall),
                  ),
                ).toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}