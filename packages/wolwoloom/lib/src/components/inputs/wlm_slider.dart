import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Mono slider — square thumb, hairline track. Shows the current value
/// as a tiny ALL-CAPS label above the thumb when [showValueLabel] is on.
class WlmSlider extends StatelessWidget {
  const WlmSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.showValueLabel = true,
    this.formatLabel,
  });

  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final bool showValueLabel;
  final String Function(double)? formatLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = showValueLabel
        ? (formatLabel?.call(value) ??
            (max - min <= 1 ? value.toStringAsFixed(2) : value.toStringAsFixed(0)))
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label.toUpperCase(), style: WlmType.label(scheme.outline)),
          const SizedBox(height: WlmTokens.spaceXs),
        ],
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: scheme.onSurface,
            inactiveTrackColor: scheme.outlineVariant.withValues(alpha: 0.30),
            thumbColor: scheme.onSurface,
            overlayColor: scheme.onSurface.withValues(alpha: 0.06),
            trackHeight: 2,
            thumbShape: const _SquareThumb(size: 12),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
          ),
          child: Slider(
            value: value.clamp(min, max),
            onChanged: onChanged,
            min: min,
            max: max,
            divisions: divisions,
          ),
        ),
      ],
    );
  }
}

class _SquareThumb extends SliderComponentShape {
  const _SquareThumb({required this.size});
  final double size;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.square(size + 4);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final paint = Paint()..color = sliderTheme.thumbColor!;
    final rect = Rect.fromCenter(center: center, width: size, height: size);
    context.canvas.drawRect(rect, paint);
  }
}
