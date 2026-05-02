import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// A single row in a [WlmActionSheet].
class WlmActionSheetItem {
  const WlmActionSheetItem({
    required this.label,
    this.icon,
    this.onTap,
    this.destructive = false,
    this.disabled = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool destructive;
  final bool disabled;
}

/// iOS-style action list shown from the bottom of the screen, but rendered
/// with our editorial chrome (hairline border, mono labels).
///
/// ```dart
/// WlmActionSheet.show(context, title: 'Photo', items: [...]);
/// ```
class WlmActionSheet extends StatelessWidget {
  const WlmActionSheet({
    super.key,
    required this.items,
    this.title,
    this.message,
    this.cancelLabel = 'CANCEL',
  });

  final List<WlmActionSheetItem> items;
  final String? title;
  final String? message;
  final String cancelLabel;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? message,
    required List<WlmActionSheetItem> items,
    String cancelLabel = 'CANCEL',
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      isScrollControlled: true,
      builder: (_) => WlmActionSheet(
        title: title,
        message: message,
        items: items,
        cancelLabel: cancelLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    final media = MediaQuery.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          WlmTokens.spaceMd,
          WlmTokens.spaceMd,
          WlmTokens.spaceMd,
          WlmTokens.spaceMd + media.viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main sheet
            Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(WlmTokens.radLg),
                border: Border.all(
                  color: wlm.hairline,
                  width: WlmTokens.hairline,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null || message != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        WlmTokens.spaceLg,
                        WlmTokens.spaceLg,
                        WlmTokens.spaceLg,
                        WlmTokens.spaceMd,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(
                              title!.toUpperCase(),
                              style: WlmType.label(scheme.onSurface)
                                  .copyWith(letterSpacing: 1.6),
                            ),
                          if (message != null) ...[
                            const SizedBox(height: WlmTokens.spaceXs),
                            Text(
                              message!,
                              style: WlmType.body(scheme.onSurfaceVariant),
                            ),
                          ],
                        ],
                      ),
                    ),
                  if (title != null || message != null)
                    Container(
                      height: WlmTokens.hairline,
                      color: wlm.hairline,
                    ),
                  for (var i = 0; i < items.length; i++) ...[
                    _Row(
                      item: items[i],
                      onTap: () {
                        Navigator.of(context).maybePop();
                        items[i].onTap?.call();
                      },
                    ),
                    if (i != items.length - 1)
                      Container(
                        height: WlmTokens.hairline,
                        color: wlm.hairline,
                      ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: WlmTokens.spaceSm),
            // Cancel
            Material(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(WlmTokens.radLg),
              child: InkWell(
                borderRadius: BorderRadius.circular(WlmTokens.radLg),
                onTap: () => Navigator.of(context).maybePop(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(WlmTokens.radLg),
                    border: Border.all(
                      color: wlm.hairline,
                      width: WlmTokens.hairline,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cancelLabel,
                    style: WlmType.label(scheme.onSurface)
                        .copyWith(letterSpacing: 1.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.item, required this.onTap});
  final WlmActionSheetItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    final color = item.disabled
        ? scheme.outline
        : item.destructive
            ? wlm.danger
            : scheme.onSurface;
    return InkWell(
      onTap: item.disabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceLg,
          vertical: 14,
        ),
        child: Row(
          children: [
            if (item.icon != null) ...[
              Icon(item.icon, size: 18, color: color),
              const SizedBox(width: WlmTokens.spaceMd),
            ],
            Expanded(
              child: Text(
                item.label,
                style: WlmType.body(color).copyWith(
                  fontWeight:
                      item.destructive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
