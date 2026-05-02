import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../layout/wlm_card.dart';
import 'wlm_text_field.dart';

/// Labelled credentials field shown inside a hairline card — the
/// onboarding "API key" pattern from wolwo.
///
/// Renders the [label] and an optional `GET KEY →` link in a header row,
/// then a [WlmTextField] with [hintText] underneath. Designed to host
/// secrets so [obscureText] defaults to `true`.
class WlmKeyField extends StatelessWidget {
  const WlmKeyField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.onChanged,
    this.getKeyUrl,
    this.onGetKey,
    this.obscureText = true,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? getKeyUrl;
  final VoidCallback? onGetKey;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WlmCard(
      padding: const EdgeInsets.fromLTRB(
        WlmTokens.spaceLg,
        WlmTokens.spaceMd,
        WlmTokens.spaceLg,
        WlmTokens.spaceMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: WlmType.h3(scheme.onSurface).copyWith(fontSize: 14),
                ),
              ),
              if (onGetKey != null || getKeyUrl != null)
                GestureDetector(
                  onTap: onGetKey,
                  child: Text(
                    'GET KEY →',
                    style: WlmType.label(scheme.onSurface),
                  ),
                ),
            ],
          ),
          const SizedBox(height: WlmTokens.spaceSm),
          WlmTextField(
            controller: controller,
            hintText: hintText,
            onChanged: onChanged,
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }
}
