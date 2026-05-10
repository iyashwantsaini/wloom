import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// wloom tab class.
class WlmTab {
  const WlmTab({required this.label, this.icon});
  final String label;
  final IconData? icon;
}

/// Hairline-bordered tab strip. Active tab gets an ink underline; mono
/// labels by default.
class WlmTabBar extends StatelessWidget {
  const WlmTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
    this.scrollable = false,
  });

  final List<WlmTab> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final children = <Widget>[
      for (var i = 0; i < tabs.length; i++)
        _TabCell(
          tab: tabs[i],
          selected: i == currentIndex,
          onTap: () => onTap(i),
        ),
    ];
    final row = scrollable
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: children),
          )
        : Row(
            children: [
              for (final c in children) Expanded(child: c),
            ],
          );
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.30),
            width: WlmTokens.hairline,
          ),
        ),
      ),
      child: row,
    );
  }
}

class _TabCell extends StatelessWidget {
  const _TabCell({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final WlmTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = selected ? scheme.onSurface : scheme.outline;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceLg,
          vertical: WlmTokens.spaceMd,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? scheme.onSurface : Colors.transparent,
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (tab.icon != null) ...[
              Icon(tab.icon, size: 14, color: fg),
              const SizedBox(width: WlmTokens.spaceSm),
            ],
            Text(
              tab.label.toUpperCase(),
              style: WlmType.label(fg).copyWith(letterSpacing: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
