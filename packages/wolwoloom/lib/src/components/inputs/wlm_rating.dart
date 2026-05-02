import 'package:flutter/material.dart';

/// Mono star rating. Five (or [count]) tappable squares — filled when
/// active. Reads as a typewriter rating, not a glossy app store widget.
class WlmRating extends StatelessWidget {
  const WlmRating({
    super.key,
    required this.value,
    this.onChanged,
    this.count = 5,
    this.size = 18,
    this.icon = Icons.star_rate_rounded,
    this.outlineIcon = Icons.star_outline_rounded,
  });

  final int value;
  final int count;
  final double size;
  final ValueChanged<int>? onChanged;
  final IconData icon;
  final IconData outlineIcon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: 'Rating $value of $count',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 1; i <= count; i++)
            InkResponse(
              radius: size,
              onTap: onChanged == null ? null : () => onChanged!(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Icon(
                  i <= value ? icon : outlineIcon,
                  size: size,
                  color: i <= value ? scheme.onSurface : scheme.outline,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
