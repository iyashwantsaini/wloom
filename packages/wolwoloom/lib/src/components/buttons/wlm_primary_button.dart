import 'package:flutter/material.dart';

import '../../tokens/wlm_size.dart';
import 'wlm_button.dart';

/// Filled ink button — wloom's primary call-to-action.
///
/// Thin wrapper over [WlmButton] preserved for source compatibility.
/// Prefer `WlmButton(variant: WlmButtonVariant.primary, ...)` in new code.
class WlmPrimaryButton extends StatelessWidget {
  const WlmPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.uppercase = true,
    this.expand = false,
    this.size = WlmSize.md,
    this.loading = false,
    this.tooltip,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool uppercase;
  final bool expand;
  final WlmSize size;
  final bool loading;
  final String? tooltip;

  @override
  Widget build(BuildContext context) => WlmButton(
        label: label,
        onPressed: onPressed,
        variant: WlmButtonVariant.primary,
        icon: icon,
        uppercase: uppercase,
        expand: expand,
        size: size,
        loading: loading,
        tooltip: tooltip,
      );
}
