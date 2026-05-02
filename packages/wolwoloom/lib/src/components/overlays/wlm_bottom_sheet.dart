import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';

/// Show a Wolwoloom-styled modal bottom sheet — drag handle, surface
/// background, hairline outline along the top edge.
Future<T?> showWlmBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
}) {
  final scheme = Theme.of(context).colorScheme;
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: scheme.surface,
    showDragHandle: true,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(WlmTokens.radXl),
      ),
      side: WlmTokens.hairlineSide(scheme),
    ),
    builder: (ctx) => SafeArea(child: builder(ctx)),
  );
}
