import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Mono dropdown selector. Hairline-bordered button that opens a
/// themed menu with mono entries.
class WlmDropdown<T> extends StatelessWidget {
  const WlmDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.label,
    this.expand = false,
  });

  final T? value;
  final List<WlmDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? label;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WlmTokens.spaceMd,
        vertical: WlmTokens.spaceXs,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: WlmTokens.hairlineBorder(scheme),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: expand,
          isDense: true,
          icon: Icon(Icons.expand_more_rounded, size: 18, color: scheme.outline),
          dropdownColor: scheme.surface,
          borderRadius: BorderRadius.circular(WlmTokens.radMd),
          style: WlmType.body(scheme.onSurface),
          hint: hint == null
              ? null
              : Text(hint!, style: WlmType.body(scheme.outline)),
          onChanged: onChanged,
          items: [
            for (final i in items)
              DropdownMenuItem<T>(
                value: i.value,
                child: Text(i.label, style: WlmType.body(scheme.onSurface)),
              ),
          ],
        ),
      ),
    );

    if (label == null) return box;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label!.toUpperCase(), style: WlmType.label(scheme.outline)),
        const SizedBox(height: WlmTokens.spaceSm),
        box,
      ],
    );
  }
}

/// Wolwoloom dropdown item class.
class WlmDropdownItem<T> {
  const WlmDropdownItem({required this.value, required this.label});
  final T value;
  final String label;
}
