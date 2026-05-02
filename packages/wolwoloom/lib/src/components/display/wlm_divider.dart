import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';

/// 1px hairline divider in `outlineVariant @ opacity`. Use this instead
/// of `Divider`/`SizedBox` when you want the wolwo "rule between rows"
/// look without the surrounding default padding.
class WlmDivider extends StatelessWidget {
  const WlmDivider({
    super.key,
    this.opacity = 0.30,
    this.indent = 0,
    this.endIndent = 0,
  });

  final double opacity;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent),
      child: Container(
        height: WlmTokens.hairline,
        color: scheme.outlineVariant.withValues(alpha: opacity),
      ),
    );
  }
}
