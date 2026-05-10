import 'package:flutter/material.dart';

import '../../tokens/wlm_size.dart';
import 'wlm_button.dart';

/// Hairline-bordered button — wloom's secondary action.
class WlmSecondaryButton extends StatelessWidget {
  const WlmSecondaryButton({
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
        variant: WlmButtonVariant.secondary,
        icon: icon,
        uppercase: uppercase,
        expand: expand,
        size: size,
        loading: loading,
        tooltip: tooltip,
      );
}
