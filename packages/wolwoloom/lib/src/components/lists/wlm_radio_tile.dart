import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../inputs/wlm_radio.dart';

/// Row built around `WlmRadio<T>`. Wrap a column of these in a
/// `Column`/`ListView` to build a single-select group.
class WlmRadioTile<T> extends StatelessWidget {
  const WlmRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(value),
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
              child: WlmRadio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
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
