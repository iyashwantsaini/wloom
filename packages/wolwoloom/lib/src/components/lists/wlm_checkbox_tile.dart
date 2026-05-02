import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../inputs/wlm_checkbox.dart';

/// Wolwo-style row built around a `WlmCheckbox`. Title + description +
/// checkbox, full-width tap target.
class WlmCheckboxTile extends StatelessWidget {
  const WlmCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceLg,
          vertical: WlmTokens.spaceMd,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: WlmCheckbox(value: value, onChanged: onChanged),
            ),
            const SizedBox(width: WlmTokens.spaceLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: WlmType.body(scheme.onSurface)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: WlmType.meta(scheme.outline)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
