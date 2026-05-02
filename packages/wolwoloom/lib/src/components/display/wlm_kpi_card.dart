import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// A bold metric card with a tiny inline sparkline.
///
/// Highly customizable — pass [color] to recolor the trend, [borderColor],
/// [radius], [padding] to override visual chrome, and [sparkline] to render
/// any list of doubles as a polyline at the bottom of the card.
class WlmKpiCard extends StatelessWidget {
  const WlmKpiCard({
    super.key,
    required this.label,
    required this.value,
    this.delta,
    this.deltaPositive = true,
    this.icon,
    this.sparkline,
    this.color,
    this.borderColor,
    this.backgroundColor,
    this.radius = WlmTokens.radLg,
    this.padding = const EdgeInsets.all(WlmTokens.spaceLg),
    this.onTap,
  });

  final String label;
  final String value;
  final String? delta;
  final bool deltaPositive;
  final IconData? icon;
  final List<double>? sparkline;
  final Color? color;
  final Color? borderColor;
  final Color? backgroundColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    final accent = color ?? (deltaPositive ? wlm.success : wlm.danger);

    final body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? scheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? wlm.hairline,
          width: WlmTokens.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  style:
                      WlmType.tiny(scheme.outline).copyWith(letterSpacing: 1.6),
                ),
              ),
              if (icon != null) Icon(icon, size: 14, color: scheme.outline),
            ],
          ),
          const SizedBox(height: WlmTokens.spaceMd),
          Text(
            value,
            style: WlmType.h1(scheme.onSurface).copyWith(
              fontSize: 32,
              height: 1.0,
              letterSpacing: -0.6,
            ),
          ),
          if (delta != null) ...[
            const SizedBox(height: WlmTokens.spaceSm),
            Row(
              children: [
                Icon(
                  deltaPositive
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  size: 12,
                  color: accent,
                ),
                const SizedBox(width: 2),
                Text(
                  delta!,
                  style: WlmType.meta(accent),
                ),
              ],
            ),
          ],
          if (sparkline != null && sparkline!.length >= 2) ...[
            const SizedBox(height: WlmTokens.spaceMd),
            SizedBox(
              height: 28,
              child: CustomPaint(
                size: const Size.fromHeight(28),
                painter: _SparklinePainter(
                  values: sparkline!,
                  color: accent,
                ),
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) return body;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: body,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final minV = values.reduce((a, b) => a < b ? a : b);
    final maxV = values.reduce((a, b) => a > b ? a : b);
    final range = (maxV - minV).abs() < 1e-9 ? 1.0 : (maxV - minV);
    final dx = size.width / (values.length - 1);

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = i * dx;
      final y = size.height - ((values[i] - minV) / range) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final stroke = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, stroke);

    // Endpoint marker
    final lastX = (values.length - 1) * dx;
    final lastY = size.height - ((values.last - minV) / range) * size.height;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(lastX, lastY), width: 4, height: 4),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter old) =>
      old.values != values || old.color != color;
}
