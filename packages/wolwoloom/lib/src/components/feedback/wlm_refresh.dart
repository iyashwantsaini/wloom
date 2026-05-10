import 'dart:async';

import 'package:flutter/material.dart';

import '../../tokens/wlm_motion.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import 'wlm_scan_bar.dart';

/// On-brand pull-to-refresh wrapper.
///
/// Replaces Material's circular spinner with a typewriter "RELOADING…"
/// label and a [WlmScanBar] head once the refresh is in flight.
///
/// ```dart
/// WlmRefresh(
///   onRefresh: _reload,
///   child: ListView(...),
/// );
/// ```
class WlmRefresh extends StatefulWidget {
  const WlmRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
    this.idleLabel = 'PULL TO REFRESH',
    this.armedLabel = 'RELEASE TO RELOAD',
    this.refreshingLabel = 'RELOADING',
    this.triggerExtent = 72.0,
  });

  /// Async callback invoked once the user pulls past [triggerExtent].
  final Future<void> Function() onRefresh;
  final Widget child;
  final String idleLabel;
  final String armedLabel;
  final String refreshingLabel;

  /// Pull distance (px) required to arm the refresh.
  final double triggerExtent;

  @override
  State<WlmRefresh> createState() => _WlmRefreshState();
}

enum _RefreshPhase { idle, armed, refreshing }

class _WlmRefreshState extends State<WlmRefresh> {
  double _drag = 0.0;
  _RefreshPhase _phase = _RefreshPhase.idle;

  bool _onNotification(ScrollNotification n) {
    if (_phase == _RefreshPhase.refreshing) return false;
    if (n is OverscrollNotification && n.overscroll < 0) {
      setState(() {
        _drag = (_drag - n.overscroll).clamp(0.0, widget.triggerExtent * 1.5);
        _phase = _drag >= widget.triggerExtent
            ? _RefreshPhase.armed
            : _RefreshPhase.idle;
      });
    } else if (n is ScrollUpdateNotification &&
        n.metrics.pixels < 0 &&
        n.scrollDelta != null) {
      setState(() {
        _drag = (-n.metrics.pixels).clamp(0.0, widget.triggerExtent * 1.5);
        _phase = _drag >= widget.triggerExtent
            ? _RefreshPhase.armed
            : _RefreshPhase.idle;
      });
    } else if (n is ScrollEndNotification) {
      if (_phase == _RefreshPhase.armed) {
        unawaited(_runRefresh());
      } else {
        setState(() => _drag = 0);
      }
    }
    return false;
  }

  Future<void> _runRefresh() async {
    setState(() => _phase = _RefreshPhase.refreshing);
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        setState(() {
          _phase = _RefreshPhase.idle;
          _drag = 0;
        });
      }
    }
  }

  String get _label => switch (_phase) {
        _RefreshPhase.idle => widget.idleLabel,
        _RefreshPhase.armed => widget.armedLabel,
        _RefreshPhase.refreshing => widget.refreshingLabel,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final showHeader =
        _phase == _RefreshPhase.refreshing || _drag > 4.0;
    final indicatorHeight = _phase == _RefreshPhase.refreshing
        ? widget.triggerExtent
        : _drag.clamp(0.0, widget.triggerExtent * 1.2);

    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _onNotification,
          child: widget.child,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: WlmMotion.fast,
              curve: WlmMotion.standard,
              height: indicatorHeight,
              alignment: Alignment.center,
              child: showHeader
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _label.toUpperCase(),
                          style: WlmType.label(scheme.outline)
                              .copyWith(letterSpacing: 1.6),
                        ),
                        if (_phase == _RefreshPhase.refreshing) ...[
                          const SizedBox(height: WlmTokens.spaceSm),
                          const WlmScanBar(label: ''),
                        ] else ...[
                          const SizedBox(height: WlmTokens.spaceSm),
                          Container(
                            width: 24,
                            height: 2,
                            color: _phase == _RefreshPhase.armed
                                ? scheme.onSurface
                                : scheme.outlineVariant,
                          ),
                        ],
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}
