import 'package:fithub_home_test/app/common/theme/daycode_theme.dart';
import 'package:fithub_home_test/app/common/widgets/d_text.dart';
import 'package:flutter/material.dart';

class SearchAppbar extends StatelessWidget {
  const SearchAppbar({
    super.key,
    this.onSearch,
  });

  final void Function(String)? onSearch;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          spacing: 20,
          children: [
            const DText(
              text: 'Find Movies, Tv series, and more..',
              type: DTextType.bodyMedium,
            ),
            TextField(
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 16,
                color: DaycodeTheme.instance.theme.colorScheme.onSurfaceVariant,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white, size: 25),
                hintText: 'Find your next favorite movie...',
              ),
              onChanged: onSearch,
            ),
          ],
        ),
      ),
    );
  }
}