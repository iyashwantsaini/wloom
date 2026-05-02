import 'package:flutter/material.dart';

import '../../tokens/wlm_motion.dart';
import '../../tokens/wlm_tokens.dart';
import '../../utils/wlm_a11y.dart';

/// Anchor-positioned overlay primitive — the building block under
/// [WlmMenu] and `WlmCombobox`. Tap the [child] to open [content]
/// directly below it; tap outside to close.
class WlmPopover extends StatefulWidget {
  const WlmPopover({
    super.key,
    required this.child,
    required this.content,
    this.alignment = WlmPopoverAlignment.below,
    this.gap = WlmTokens.spaceXs,
    this.maxWidth = 280,
    this.controller,
    this.onOpenChanged,
  });

  final Widget child;
  final WidgetBuilder content;
  final WlmPopoverAlignment alignment;
  final double gap;
  final double maxWidth;
  final WlmPopoverController? controller;
  final ValueChanged<bool>? onOpenChanged;

  @override
  State<WlmPopover> createState() => _WlmPopoverState();
}

enum WlmPopoverAlignment { below, above, belowEnd, aboveEnd }

class WlmPopoverController extends ChangeNotifier {
  bool _open = false;
  bool get isOpen => _open;
  void open() {
    if (!_open) {
      _open = true;
      notifyListeners();
    }
  }

  void close() {
    if (_open) {
      _open = false;
      notifyListeners();
    }
  }

  void toggle() => _open ? close() : open();
}

class _WlmPopoverState extends State<WlmPopover> {
  final _layerLink = LayerLink();
  OverlayEntry? _entry;
  late WlmPopoverController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = widget.controller ?? WlmPopoverController();
    _ctl.addListener(_sync);
  }

  @override
  void didUpdateWidget(covariant WlmPopover old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      _ctl.removeListener(_sync);
      if (old.controller == null) _ctl.dispose();
      _ctl = widget.controller ?? WlmPopoverController();
      _ctl.addListener(_sync);
    }
  }

  @override
  void dispose() {
    _ctl.removeListener(_sync);
    if (widget.controller == null) _ctl.dispose();
    _entry?.remove();
    super.dispose();
  }

  void _sync() {
    if (_ctl.isOpen) {
      _show();
    } else {
      _hide();
    }
    widget.onOpenChanged?.call(_ctl.isOpen);
  }

  void _show() {
    if (_entry != null) return;
    _entry = OverlayEntry(builder: (ctx) => _buildOverlay(ctx));
    Overlay.of(context).insert(_entry!);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }

  Offset _offset(Size childSize) {
    return switch (widget.alignment) {
      WlmPopoverAlignment.below =>
        Offset(0, childSize.height + widget.gap),
      WlmPopoverAlignment.above => Offset(0, -widget.gap),
      WlmPopoverAlignment.belowEnd =>
        Offset(0, childSize.height + widget.gap),
      WlmPopoverAlignment.aboveEnd => Offset(0, -widget.gap),
    };
  }

  Alignment _followerAnchor() => switch (widget.alignment) {
        WlmPopoverAlignment.below => Alignment.topLeft,
        WlmPopoverAlignment.above => Alignment.bottomLeft,
        WlmPopoverAlignment.belowEnd => Alignment.topRight,
        WlmPopoverAlignment.aboveEnd => Alignment.bottomRight,
      };

  Alignment _targetAnchor() => switch (widget.alignment) {
        WlmPopoverAlignment.below => Alignment.bottomLeft,
        WlmPopoverAlignment.above => Alignment.topLeft,
        WlmPopoverAlignment.belowEnd => Alignment.bottomRight,
        WlmPopoverAlignment.aboveEnd => Alignment.topRight,
      };

  Widget _buildOverlay(BuildContext ctx) {
    final scheme = Theme.of(ctx).colorScheme;
    final box = context.findRenderObject() as RenderBox?;
    final size = box?.size ?? Size.zero;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _ctl.close,
          ),
        ),
        CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          targetAnchor: _targetAnchor(),
          followerAnchor: _followerAnchor(),
          offset: _offset(size).translate(0, 0),
          child: TweenAnimationBuilder<double>(
            duration: WlmA11y.motion(ctx, WlmMotion.fast),
            curve: WlmMotion.standard,
            tween: Tween(begin: 0, end: 1),
            builder: (_, t, c) => Opacity(
              opacity: t,
              child: Transform.translate(
                offset: Offset(0, (1 - t) * 4),
                child: c,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: widget.maxWidth),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(WlmTokens.radMd),
                    border: WlmTokens.hairlineBorder(scheme, opacity: 0.6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(WlmTokens.radMd),
                    child: widget.content(ctx),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _ctl.toggle,
        child: widget.child,
      ),
    );
  }
}
