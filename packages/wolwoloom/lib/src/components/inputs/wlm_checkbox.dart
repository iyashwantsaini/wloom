import 'package:flutter/material.dart';

/// Mono checkbox — square, hairline outline, ink fill when checked.
class WlmCheckbox extends StatelessWidget {
  const WlmCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 18,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onChanged != null;
    final fg = enabled ? scheme.onSurface : scheme.outline;
    return Semantics(
      checked: value,
      enabled: enabled,
      child: InkResponse(
        radius: size,
        onTap: enabled ? () => onChanged!(!value) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: value ? fg : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: fg, width: 1.5),
          ),
          child: value
              ? Icon(Icons.check_rounded, size: size - 4, color: scheme.surface)
              : null,
        ),
      ),
    );
  }
}
