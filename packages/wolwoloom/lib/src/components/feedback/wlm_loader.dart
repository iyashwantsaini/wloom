import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Wolwo's signature loader — a square that traces its own perimeter
/// with a hairline border, accent tick and tiny ink dot at the head.
///
/// Use [compact] for inline strips (toolbars, list footers); the
/// non-compact version draws a label below.
class WlmLoader extends StatefulWidget {
  const WlmLoader({
    super.key,
    this.label = 'LOADING',
    this.size = 48,
    this.compact = false,
  });

  final String label;
  final double size;
  final bool compact;

  @override
  State<WlmLoader> createState() => _WlmLoaderState();
}

class _WlmLoaderState extends State<WlmLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => CustomPaint(
          painter: _SquareLoaderPainter(
            progress: _ctrl.value,
            ink: scheme.onSurface,
            hairline: scheme.outlineVariant.withValues(alpha: 0.40),
            accent: scheme.secondary,
          ),
        ),
      ),
    );

    if (widget.compact) return box;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        box,
        const SizedBox(height: WlmTokens.spaceMd),
        Text(
          widget.label.toUpperCase(),
          style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.6),
        ),
      ],
    );
  }
}

class _SquareLoaderPainter extends CustomPainter {
  _SquareLoaderPainter({
    required this.progress,
    required this.ink,
    required this.hairline,
    required this.accent,
  });
  final double progress;
  final Color ink;
  final Color hairline;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..color = hairline
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final p = progress % 1.0;
    final perimeter = (size.width + size.height) * 2;
    final dist = p * perimeter;
    final pos = _pointOnPerimeter(dist, size);
    final tailLen = math.max(8.0, size.width * 0.25);
    final tailEndDist = (dist - tailLen).clamp(0.0, perimeter);
    final endPos = _pointOnPerimeter(tailEndDist, size);
    canvas.drawLine(
      endPos,
      pos,
      Paint()
        ..color = accent
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.square,
    );
    canvas.drawRect(
      Rect.fromCenter(center: pos, width: 4, height: 4),
      Paint()..color = ink,
    );
  }

  Offset _pointOnPerimeter(double dist, Size size) {
    if (dist < size.width) return Offset(dist, 0);
    if (dist < size.width + size.height) {
      return Offset(size.width, dist - size.width);
    }
    if (dist < size.width * 2 + size.height) {
      return Offset(size.width * 2 + size.height - dist, size.height);
    }
    final perimeter = (size.width + size.height) * 2;
    return Offset(0, perimeter - dist);
  }

  @override
  bool shouldRepaint(covariant _SquareLoaderPainter old) =>
      old.progress != progress ||
      old.ink != ink ||
      old.hairline != hairline ||
      old.accent != accent;
}
