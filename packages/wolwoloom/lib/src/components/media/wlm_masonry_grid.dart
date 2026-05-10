import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../tokens/wlm_tokens.dart';

/// Thin wrapper around `MasonryGridView.count` with wloom defaults
/// (10px gap, edge insets, 2 columns).
class WlmMasonryGrid extends StatelessWidget {
  const WlmMasonryGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.spacing = 10,
    this.padding = const EdgeInsets.fromLTRB(
      WlmTokens.spaceMd,
      WlmTokens.spaceMd,
      WlmTokens.spaceMd,
      WlmTokens.spaceLg,
    ),
    this.controller,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      controller: controller,
      padding: padding as EdgeInsets,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
