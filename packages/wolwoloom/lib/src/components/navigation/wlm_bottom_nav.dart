import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Wolwoloom nav item class.
class WlmNavItem {
  const WlmNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
  final IconData icon;
  final IconData? activeIcon;
  final String label;
}

/// Hairline-bordered bottom navigation. Five-or-fewer items, ALL-CAPS
/// mono labels, accent indicator dot under the active tab.
class WlmBottomNav extends StatelessWidget {
  const WlmBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<WlmNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.30),
            width: WlmTokens.hairline,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavCell(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavCell extends StatelessWidget {
  const _NavCell({
    required this.item,
    required this.selected,
    required this.onTap,
  });
  final WlmNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = selected ? scheme.onSurface : scheme.outline;
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? (item.activeIcon ?? item.icon) : item.icon,
                size: 20,
                color: fg,
              ),
              const SizedBox(height: 4),
              Text(
                item.label.toUpperCase(),
                style: WlmType.tiny(fg).copyWith(
                  fontSize: 9,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          if (selected)
            Positioned(
              top: 6,
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: scheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
