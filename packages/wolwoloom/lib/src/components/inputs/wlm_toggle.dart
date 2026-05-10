import 'package:flutter/material.dart';

import '../../tokens/wlm_size.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Single binary toggle — like [Switch] but mono and inline. Use
/// [WlmToggleGroup] for the multi-option flavour.
class WlmToggle extends StatelessWidget {
  const WlmToggle({
    super.key,
    required this.selected,
    required this.onChanged,
    this.label,
    this.icon,
    this.size = WlmSize.md,
    this.tooltip,
  });

  final bool selected;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final IconData? icon;
  final WlmSize size;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final h = wlmBySize(size, sm: 28.0, md: 32.0, lg: 40.0);
    final padH = wlmBySize(size,
        sm: WlmTokens.spaceSm, md: WlmTokens.spaceMd, lg: WlmTokens.spaceLg,);
    final iconSize = wlmBySize(size, sm: 12.0, md: 14.0, lg: 16.0);
    final fg = selected ? scheme.surface : scheme.onSurface;
    final bg = selected ? scheme.onSurface : Colors.transparent;
    final disabled = onChanged == null;
    final core = Semantics(
      button: true,
      toggled: selected,
      enabled: !disabled,
      label: tooltip ?? label,
      child: GestureDetector(
        onTap: disabled ? null : () => onChanged!(!selected),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: h,
          padding: EdgeInsets.symmetric(horizontal: padH),
          decoration: BoxDecoration(
            color: disabled ? bg.withValues(alpha: 0.4) : bg,
            borderRadius: BorderRadius.circular(WlmTokens.radSm),
            border: selected
                ? null
                : WlmTokens.hairlineBorder(scheme, opacity: 0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon,
                    size: iconSize,
                    color: disabled ? fg.withValues(alpha: 0.4) : fg,),
                if (label != null) const SizedBox(width: WlmTokens.spaceSm),
              ],
              if (label != null)
                Text(
                  label!.toUpperCase(),
                  style: WlmType.label(disabled ? fg.withValues(alpha: 0.4) : fg)
                      .copyWith(letterSpacing: 1.2),
                ),
            ],
          ),
        ),
      ),
    );
    if (tooltip != null) return Tooltip(message: tooltip!, child: core);
    return core;
  }
}

/// Linked group of [WlmToggle]s. Single or multi-select via [allowMultiple].
class WlmToggleGroup<T> extends StatelessWidget {
  const WlmToggleGroup({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.allowMultiple = false,
    this.size = WlmSize.md,
  });

  final List<WlmToggleItem<T>> items;
  final Set<T> selected;
  final ValueChanged<Set<T>>? onChanged;
  final bool allowMultiple;
  final WlmSize size;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WlmTokens.spaceSm,
      runSpacing: WlmTokens.spaceSm,
      children: [
        for (final it in items)
          WlmToggle(
            label: it.label,
            icon: it.icon,
            selected: selected.contains(it.value),
            size: size,
            onChanged: onChanged == null
                ? null
                : (_) {
                    final next = Set<T>.from(selected);
                    if (allowMultiple) {
                      if (next.contains(it.value)) {
                        next.remove(it.value);
                      } else {
                        next.add(it.value);
                      }
                    } else {
                      next
                        ..clear()
                        ..add(it.value);
                    }
                    onChanged!(next);
                  },
          ),
      ],
    );
  }
}

/// wloom toggle item class.
class WlmToggleItem<T> {
  const WlmToggleItem({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final IconData? icon;
}
