import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Disclosure tile — title row toggles a body section open and closed.
/// Hairline-bordered, no shadow, animated chevron.
class WlmAccordion extends StatefulWidget {
  const WlmAccordion({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.initiallyOpen = false,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final bool initiallyOpen;
  final Widget? leading;

  @override
  State<WlmAccordion> createState() => _WlmAccordionState();
}

class _WlmAccordionState extends State<WlmAccordion>
    with SingleTickerProviderStateMixin {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: WlmTokens.hairlineBorder(scheme),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(WlmTokens.radMd),
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                WlmTokens.spaceLg,
                WlmTokens.spaceMd,
                WlmTokens.spaceMd,
                WlmTokens.spaceMd,
              ),
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: WlmTokens.spaceMd),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: WlmType.h3(scheme.onSurface)),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            widget.subtitle!,
                            style: WlmType.meta(scheme.outline),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: scheme.outline,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: _open
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(
                      WlmTokens.spaceLg,
                      0,
                      WlmTokens.spaceLg,
                      WlmTokens.spaceLg,
                    ),
                    child: widget.child,
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
