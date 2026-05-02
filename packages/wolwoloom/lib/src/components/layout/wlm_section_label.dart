import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Tiny ALL-CAPS section caption used above lists / groups.
class WlmSectionLabel extends StatelessWidget {
  const WlmSectionLabel(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.fromLTRB(
      WlmTokens.spaceLg,
      WlmTokens.spaceLg,
      WlmTokens.spaceLg,
      WlmTokens.spaceSm,
    ),
    this.trailing,
  });

  final String text;
  final EdgeInsetsGeometry padding;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              text.toUpperCase(),
              style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.4),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
