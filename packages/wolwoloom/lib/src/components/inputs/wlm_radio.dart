import 'package:flutter/material.dart';

/// Mono radio — small square dot inside hairline ring (not a circle, to
/// keep visual language consistent with the rest of the kit).
class WlmRadio<T> extends StatelessWidget {
  const WlmRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = 18,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selected = value == groupValue;
    final enabled = onChanged != null;
    final fg = enabled ? scheme.onSurface : scheme.outline;
    return Semantics(
      checked: selected,
      inMutuallyExclusiveGroup: true,
      enabled: enabled,
      child: InkResponse(
        radius: size,
        onTap: enabled ? () => onChanged!(value) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: fg, width: 1.5),
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: selected ? size - 8 : 0,
              height: selected ? size - 8 : 0,
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}
