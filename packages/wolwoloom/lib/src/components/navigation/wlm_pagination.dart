import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Mono `pageN of M` pagination. Use either via [pageCount] for finite
/// page counts or [hasNext]/[hasPrevious] for cursor-style sources.
class WlmPagination extends StatelessWidget {
  const WlmPagination({
    super.key,
    required this.page,
    required this.onPageChanged,
    this.pageCount,
    this.hasPrevious,
    this.hasNext,
    this.compact = false,
  });

  final int page;
  final int? pageCount;
  final bool? hasPrevious;
  final bool? hasNext;
  final ValueChanged<int> onPageChanged;
  final bool compact;

  bool get _canPrev => hasPrevious ?? (page > 1);
  bool get _canNext =>
      hasNext ?? (pageCount == null ? true : page < pageCount!);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = pageCount != null ? '$page / $pageCount' : 'PAGE $page';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _navButton(
          context,
          icon: Icons.chevron_left_rounded,
          enabled: _canPrev,
          onTap: () => onPageChanged(page - 1),
        ),
        const SizedBox(width: WlmTokens.spaceMd),
        if (!compact && pageCount != null && pageCount! <= 7)
          ..._numberedPages(scheme)
        else
          Text(label, style: WlmType.label(scheme.onSurface)),
        const SizedBox(width: WlmTokens.spaceMd),
        _navButton(
          context,
          icon: Icons.chevron_right_rounded,
          enabled: _canNext,
          onTap: () => onPageChanged(page + 1),
        ),
      ],
    );
  }

  List<Widget> _numberedPages(ColorScheme scheme) {
    final pages = <Widget>[];
    for (var i = 1; i <= pageCount!; i++) {
      final selected = i == page;
      pages.add(
        InkWell(
          onTap: () => onPageChanged(i),
          borderRadius: BorderRadius.circular(WlmTokens.radSm),
          child: Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? scheme.onSurface : Colors.transparent,
              borderRadius: BorderRadius.circular(WlmTokens.radSm),
              border:
                  selected ? null : WlmTokens.hairlineBorder(scheme, opacity: 0.4),
            ),
            child: Text(
              '$i',
              style: WlmType.label(
                      selected ? scheme.surface : scheme.onSurface,)
                  .copyWith(letterSpacing: 0.5),
            ),
          ),
        ),
      );
    }
    return pages;
  }

  Widget _navButton(
    BuildContext context, {
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(WlmTokens.radSm),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WlmTokens.radSm),
          border: WlmTokens.hairlineBorder(scheme, opacity: 0.5),
        ),
        child: Icon(icon,
            size: 16,
            color: enabled
                ? scheme.onSurface
                : scheme.outline.withValues(alpha: 0.4),),
      ),
    );
  }
}
