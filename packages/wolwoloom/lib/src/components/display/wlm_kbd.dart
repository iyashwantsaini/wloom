import 'package:flutter/material.dart';

import '../../tokens/wlm_type.dart';

/// Keycap display — `[ Esc ]`, `[ ⌘ K ]` etc. Used in cheatsheets and
/// shortcut hints.
class WlmKbd extends StatelessWidget {
  const WlmKbd(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 2, 6, 3),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.outlineVariant.withValues(alpha: 0.6),
            offset: const Offset(0, 1),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        label,
        style: WlmType.tiny(scheme.onSurface).copyWith(
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
