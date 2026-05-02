import 'package:flutter/material.dart';

import 'wlm_avatar.dart';

/// Overlapping avatar stack with an optional `+N` overflow tile.
class WlmAvatarStack extends StatelessWidget {
  const WlmAvatarStack({
    super.key,
    required this.avatars,
    this.size = 28,
    this.overlap = 8,
    this.max = 4,
  });

  final List<WlmAvatar> avatars;
  final double size;
  final double overlap;
  final int max;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visible = avatars.take(max).toList();
    final hidden = avatars.length - visible.length;
    return SizedBox(
      height: size,
      width: visible.length * (size - overlap) + overlap + (hidden > 0 ? size : 0),
      child: Stack(
        children: [
          for (var i = 0; i < visible.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(size / 2),
                ),
                padding: const EdgeInsets.all(1.5),
                child: SizedBox(
                  width: size - 3,
                  height: size - 3,
                  child: visible[i],
                ),
              ),
            ),
          if (hidden > 0)
            Positioned(
              left: visible.length * (size - overlap),
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(size / 2),
                  border: Border.all(color: scheme.surface, width: 2),
                ),
                child: Text(
                  '+$hidden',
                  style: TextStyle(
                    fontSize: size * 0.32,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
