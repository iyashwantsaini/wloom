import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Bottom-sheet action row — leading icon, mono body label, full-width
/// tap target. Wolwo's `_ActionRow` pattern.
class WlmActionRow extends StatelessWidget {
  const WlmActionRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = destructive ? scheme.error : scheme.onSurface;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceLg,
          vertical: WlmTokens.spaceMd,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: fg),
            const SizedBox(width: WlmTokens.spaceLg),
            Expanded(
              child: Text(label, style: WlmType.body(fg)),
            ),
          ],
        ),
      ),
    );
  }
}
