import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Tiny mono "scanning" bar — a thin track with a 24-px head bouncing
/// across it. Wolwo uses this as its pagination footer.
class WlmScanBar extends StatefulWidget {
  const WlmScanBar({
    super.key,
    this.label = 'LOADING MORE',
    this.width = 96,
  });

  final String label;
  final double width;

  @override
  State<WlmScanBar> createState() => _WlmScanBarState();
}

class _WlmScanBarState extends State<WlmScanBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label.toUpperCase(),
            style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.6),
          ),
          const SizedBox(height: WlmTokens.spaceSm + 2),
          SizedBox(
            width: widget.width,
            height: 2,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) => CustomPaint(
                painter: _ScanBarPainter(
                  progress: _ctrl.value,
                  track: scheme.outlineVariant.withValues(alpha: 0.30),
                  head: scheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanBarPainter extends CustomPainter {
  _ScanBarPainter({
    required this.progress,
    required this.track,
    required this.head,
  });
  final double progress;
  final Color track;
  final Color head;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      Paint()
        ..color = track
        ..strokeWidth = 1,
    );
    const headWidth = 24.0;
    final t = (math.sin(progress * 2 * math.pi) + 1) / 2;
    final x = (size.width - headWidth) * t;
    canvas.drawRect(
      Rect.fromLTWH(x, 0, headWidth, size.height),
      Paint()..color = head,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanBarPainter old) =>
      old.progress != progress;
}
