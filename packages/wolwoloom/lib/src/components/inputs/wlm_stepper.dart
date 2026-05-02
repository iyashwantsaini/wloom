import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Numeric stepper. `[ - ]  value  [ + ]` with mono digits.
class WlmStepper extends StatelessWidget {
  const WlmStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 99,
    this.step = 1,
    this.label,
  });

  final int value;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final canDec = onChanged != null && value - step >= min;
    final canInc = onChanged != null && value + step <= max;
    final col = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!.toUpperCase(), style: WlmType.label(scheme.outline)),
          const SizedBox(height: WlmTokens.spaceSm),
        ],
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(WlmTokens.radMd),
            border: WlmTokens.hairlineBorder(scheme),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Btn(
                icon: Icons.remove_rounded,
                onTap: canDec ? () => onChanged!(value - step) : null,
              ),
              Container(
                width: 1,
                height: 32,
                color: scheme.outlineVariant.withValues(alpha: 0.30),
              ),
              SizedBox(
                width: 48,
                child: Center(
                  child: Text(
                    value.toString(),
                    style: WlmType.body(scheme.onSurface),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 32,
                color: scheme.outlineVariant.withValues(alpha: 0.30),
              ),
              _Btn(
                icon: Icons.add_rounded,
                onTap: canInc ? () => onChanged!(value + step) : null,
              ),
            ],
          ),
        ),
      ],
    );
    return col;
  }
}

class _Btn extends StatelessWidget {
  const _Btn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = onTap == null ? scheme.outline : scheme.onSurface;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: 32,
        child: Icon(icon, size: 16, color: fg),
      ),
    );
  }
}
