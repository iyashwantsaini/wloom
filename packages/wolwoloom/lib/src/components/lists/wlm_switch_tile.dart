import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../layout/wlm_card.dart';

/// Card-wrapped switch row. Useful for settings/onboarding lists where
/// each option deserves visual weight.
class WlmSwitchTile extends StatelessWidget {
  const WlmSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.trailingBadge,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? trailingBadge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: WlmTokens.spaceSm),
      child: WlmCard(
        padding: EdgeInsets.zero,
        child: SwitchListTile.adaptive(
          contentPadding: const EdgeInsets.fromLTRB(
            WlmTokens.spaceLg,
            WlmTokens.spaceXs,
            WlmTokens.spaceSm,
            WlmTokens.spaceXs,
          ),
          value: value,
          onChanged: onChanged,
          title: Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  style: WlmType.h3(scheme.onSurface)
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              if (trailingBadge != null) ...[
                const SizedBox(width: WlmTokens.spaceSm),
                trailingBadge!,
              ],
            ],
          ),
          subtitle: subtitle == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    subtitle!,
                    style: WlmType.bodySmall(scheme.outline)
                        .copyWith(height: 1.4),
                  ),
                ),
        ),
      ),
    );
  }
}
