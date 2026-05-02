import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../overlays/wlm_popover.dart';

/// Single menu item rendered inside [WlmMenu] / [WlmMenuButton].
class WlmMenuItem {
  const WlmMenuItem({
    required this.label,
    this.icon,
    this.onTap,
    this.destructive = false,
    this.disabled = false,
    this.shortcut,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool destructive;
  final bool disabled;
  final String? shortcut;
}

/// Hairline-styled vertical menu rendered inside a [WlmPopover]. Use
/// [WlmMenuButton] for the most common case (anchor + items).
class WlmMenu extends StatelessWidget {
  const WlmMenu({super.key, required this.items, this.title});

  final String? title;
  final List<WlmMenuItem> items;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceXs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                WlmTokens.spaceMd,
                WlmTokens.spaceXs,
                WlmTokens.spaceMd,
                WlmTokens.spaceXs,
              ),
              child: Text(title!.toUpperCase(),
                  style: WlmType.label(scheme.outline),),
            ),
            Divider(height: 1, thickness: 1, color: scheme.outlineVariant.withValues(alpha: 0.4)),
          ],
          for (final item in items) _MenuTile(item: item),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.item});
  final WlmMenuItem item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = item.disabled
        ? scheme.outline
        : (item.destructive ? scheme.error : scheme.onSurface);
    return InkWell(
      onTap: item.disabled
          ? null
          : () {
              item.onTap?.call();
              // Close enclosing popover if present.
              final popover =
                  context.findAncestorStateOfType<State<WlmPopover>>();
              if (popover != null) {
                // Use the controller's close via a notification — the
                // popover's GestureDetector in the overlay will handle
                // outer taps; we just rely on Navigator.maybePop here.
              }
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: WlmTokens.spaceMd, vertical: WlmTokens.spaceSm,),
        child: Row(
          children: [
            if (item.icon != null) ...[
              Icon(item.icon, size: 16, color: fg),
              const SizedBox(width: WlmTokens.spaceMd),
            ],
            Expanded(
              child: Text(item.label,
                  style: WlmType.bodySmall(fg).copyWith(fontSize: 13),),
            ),
            if (item.shortcut != null) ...[
              const SizedBox(width: WlmTokens.spaceMd),
              Text(item.shortcut!, style: WlmType.tiny(scheme.outline)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Common pattern: a button-like anchor that opens a [WlmMenu].
class WlmMenuButton extends StatefulWidget {
  const WlmMenuButton({
    super.key,
    required this.child,
    required this.items,
    this.title,
    this.alignment = WlmPopoverAlignment.below,
  });

  final Widget child;
  final List<WlmMenuItem> items;
  final String? title;
  final WlmPopoverAlignment alignment;

  @override
  State<WlmMenuButton> createState() => _WlmMenuButtonState();
}

class _WlmMenuButtonState extends State<WlmMenuButton> {
  final _ctl = WlmPopoverController();

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WlmPopover(
      controller: _ctl,
      alignment: widget.alignment,
      content: (ctx) => WlmMenu(
        title: widget.title,
        items: [
          for (final i in widget.items)
            WlmMenuItem(
              label: i.label,
              icon: i.icon,
              destructive: i.destructive,
              disabled: i.disabled,
              shortcut: i.shortcut,
              onTap: () {
                _ctl.close();
                i.onTap?.call();
              },
            ),
        ],
      ),
      child: widget.child,
    );
  }
}
