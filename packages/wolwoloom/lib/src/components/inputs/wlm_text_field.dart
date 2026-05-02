import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Hairline-bordered text input. Filled `surfaceContainerHighest` background,
/// rounded `radMd` corners, accent cursor.
class WlmTextField extends StatelessWidget {
  const WlmTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasError = errorText != null;
    final borderColor = hasError ? scheme.error : scheme.outlineVariant;
    final focusColor = hasError ? scheme.error : scheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!.toUpperCase(), style: WlmType.label(scheme.outline)),
          const SizedBox(height: WlmTokens.spaceSm),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          enabled: enabled,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          cursorColor: scheme.secondary,
          style: WlmType.body(scheme.onSurface),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: WlmType.body(scheme.outline),
            filled: true,
            fillColor: scheme.surfaceContainerHighest,
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, size: 18, color: scheme.outline),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: WlmTokens.spaceMd,
              vertical: WlmTokens.spaceMd,
            ),
            border: _border(borderColor),
            enabledBorder: _border(borderColor),
            focusedBorder: _border(focusColor, width: WlmTokens.hairline),
            errorBorder: _border(scheme.error),
            disabledBorder: _border(scheme.outlineVariant.withValues(alpha: 0.5)),
          ),
        ),
        if (helperText != null && !hasError) ...[
          const SizedBox(height: WlmTokens.spaceSm),
          Text(helperText!, style: WlmType.meta(scheme.outline)),
        ],
        if (hasError) ...[
          const SizedBox(height: WlmTokens.spaceSm),
          Text(errorText!, style: WlmType.meta(scheme.error)),
        ],
      ],
    );
  }

  OutlineInputBorder _border(Color c, {double width = 1}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        borderSide: BorderSide(color: c, width: width),
      );
}
