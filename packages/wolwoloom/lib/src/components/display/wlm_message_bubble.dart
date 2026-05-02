import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

enum WlmMessageSide { incoming, outgoing }

enum WlmMessageStatus { sending, sent, delivered, read, failed }

/// A chat message bubble with hairline borders and mono caption.
///
/// Fully customizable: [color], [textColor], [borderColor], [radius],
/// [padding], [maxWidthFraction] and per-instance [author] / [time].
class WlmMessageBubble extends StatelessWidget {
  const WlmMessageBubble({
    super.key,
    required this.text,
    this.side = WlmMessageSide.incoming,
    this.author,
    this.time,
    this.status,
    this.color,
    this.textColor,
    this.borderColor,
    this.radius = WlmTokens.radLg,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    this.maxWidthFraction = 0.78,
    this.tail = true,
  });

  final String text;
  final WlmMessageSide side;
  final String? author;
  final String? time;
  final WlmMessageStatus? status;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final double maxWidthFraction;
  final bool tail;

  IconData _statusIcon(WlmMessageStatus s) => switch (s) {
        WlmMessageStatus.sending => Icons.schedule_rounded,
        WlmMessageStatus.sent => Icons.check_rounded,
        WlmMessageStatus.delivered => Icons.done_all_rounded,
        WlmMessageStatus.read => Icons.done_all_rounded,
        WlmMessageStatus.failed => Icons.error_outline_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    final isOut = side == WlmMessageSide.outgoing;

    final bg =
        color ?? (isOut ? scheme.primary : scheme.surfaceContainerHighest);
    final fg = textColor ?? (isOut ? scheme.onPrimary : scheme.onSurface);
    final border = borderColor ?? (isOut ? Colors.transparent : wlm.hairline);

    return LayoutBuilder(
      builder: (ctx, c) {
        final maxW =
            c.maxWidth.isFinite ? c.maxWidth * maxWidthFraction : 260.0;
        final radii = BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft:
              Radius.circular(isOut || !tail ? radius : WlmTokens.radSm),
          bottomRight:
              Radius.circular(!isOut || !tail ? radius : WlmTokens.radSm),
        );
        return Align(
          alignment: isOut ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxW),
            child: Column(
              crossAxisAlignment:
                  isOut ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (author != null && !isOut)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      bottom: WlmTokens.spaceXs,
                    ),
                    child: Text(
                      author!,
                      style: WlmType.tiny(scheme.outline)
                          .copyWith(letterSpacing: 1.2),
                    ),
                  ),
                Container(
                  padding: padding,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: radii,
                    border: Border.all(
                      color: border,
                      width: WlmTokens.hairline,
                    ),
                  ),
                  child: Text(
                    text,
                    style: WlmType.body(fg).copyWith(height: 1.45),
                  ),
                ),
                if (time != null || status != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: WlmTokens.spaceXs,
                      left: 4,
                      right: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (time != null)
                          Text(
                            time!,
                            style: WlmType.tiny(scheme.outline),
                          ),
                        if (status != null && isOut) ...[
                          const SizedBox(width: 4),
                          Icon(
                            _statusIcon(status!),
                            size: 11,
                            color: status == WlmMessageStatus.read
                                ? scheme.primary
                                : scheme.outline,
                          ),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
