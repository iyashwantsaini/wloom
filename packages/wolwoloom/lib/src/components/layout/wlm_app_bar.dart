import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Wolwoloom-styled top app bar. Transparent background by default,
/// hairline divider at the bottom only when [showDivider] is true.
class WlmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WlmAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions = const [],
    this.showDivider = false,
    this.centerTitle = false,
  });

  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final bool showDivider;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.30),
                  width: WlmTokens.hairline,
                ),
              )
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: WlmTokens.spaceMd),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: WlmTokens.spaceSm),
                ],
                Expanded(
                  child: Align(
                    alignment: centerTitle
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: Text(
                      title,
                      style: WlmType.h2(scheme.onSurface),
                    ),
                  ),
                ),
                for (var i = 0; i < actions.length; i++) ...[
                  if (i > 0) const SizedBox(width: WlmTokens.spaceSm),
                  actions[i],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
