import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Mono code block with optional language eyebrow and copy button.
class WlmCodeBlock extends StatelessWidget {
  const WlmCodeBlock({
    super.key,
    required this.code,
    this.language,
    this.showCopy = true,
  });

  final String code;
  final String? language;
  final bool showCopy;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: WlmTokens.hairlineBorder(scheme),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (language != null || showCopy)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                WlmTokens.spaceMd,
                WlmTokens.spaceSm,
                WlmTokens.spaceXs,
                0,
              ),
              child: Row(
                children: [
                  if (language != null)
                    Text(
                      language!.toUpperCase(),
                      style: WlmType.label(scheme.outline)
                          .copyWith(letterSpacing: 1.4),
                    ),
                  const Spacer(),
                  if (showCopy)
                    IconButton(
                      tooltip: 'Copy',
                      iconSize: 14,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.copy_rounded, color: scheme.outline),
                      onPressed: () => Clipboard.setData(ClipboardData(text: code)),
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              WlmTokens.spaceMd,
              WlmTokens.spaceSm,
              WlmTokens.spaceMd,
              WlmTokens.spaceMd,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                code,
                style: WlmType.bodySmall(scheme.onSurface).copyWith(height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
