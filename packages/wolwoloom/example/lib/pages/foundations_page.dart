import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class FoundationsPage extends StatelessWidget {
  const FoundationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CatalogScaffold(
      title: 'Foundations',
      intro: 'The constants every component is built on. Spacing, radii, '
          'mono typography and the ink-on-paper palette.',
      sections: [
        Section(
          label: 'Spacing',
          children: const [_Spacing()],
        ),
        Section(
          label: 'Radii',
          children: const [_Radii()],
        ),
        Section(
          label: 'Typography',
          children: [
            _Type(label: 'DISPLAY', style: WlmType.display(scheme.onSurface)),
            _Type(label: 'H1', style: WlmType.h1(scheme.onSurface)),
            _Type(label: 'H2', style: WlmType.h2(scheme.onSurface)),
            _Type(label: 'H3', style: WlmType.h3(scheme.onSurface)),
            _Type(label: 'BODY', style: WlmType.body(scheme.onSurface)),
            _Type(label: 'BODY SMALL', style: WlmType.bodySmall(scheme.onSurface)),
            _Type(label: 'LABEL', style: WlmType.label(scheme.outline)),
            _Type(label: 'META', style: WlmType.meta(scheme.outline)),
            _Type(label: 'TINY', style: WlmType.tiny(scheme.outline)),
          ],
        ),
        Section(
          label: 'Palette',
          children: const [_Swatches()],
        ),
      ],
    );
  }
}

class _Spacing extends StatelessWidget {
  const _Spacing();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const items = <(String, double)>[
      ('xs · 4', WlmTokens.spaceXs),
      ('sm · 8', WlmTokens.spaceSm),
      ('md · 12', WlmTokens.spaceMd),
      ('lg · 16', WlmTokens.spaceLg),
      ('xl · 24', WlmTokens.spaceXl),
      ('xxl · 32', WlmTokens.spaceXxl),
    ];
    return Column(
      children: [
        for (final (label, value) in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceXs),
            child: Row(
              children: [
                SizedBox(
                  width: 96,
                  child: Text(label, style: WlmType.label(scheme.outline)),
                ),
                Container(width: value, height: 14, color: scheme.onSurface),
              ],
            ),
          ),
      ],
    );
  }
}

class _Radii extends StatelessWidget {
  const _Radii();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const items = <(String, double)>[
      ('sm', WlmTokens.radSm),
      ('md', WlmTokens.radMd),
      ('lg', WlmTokens.radLg),
      ('xl', WlmTokens.radXl),
    ];
    return Wrap(
      spacing: WlmTokens.spaceLg,
      runSpacing: WlmTokens.spaceLg,
      children: [
        for (final (label, value) in items)
          Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(value),
                  border: WlmTokens.hairlineBorder(scheme),
                ),
              ),
              const SizedBox(height: WlmTokens.spaceSm),
              Text(label.toUpperCase(),
                  style: WlmType.label(scheme.outline)),
            ],
          ),
      ],
    );
  }
}

class _Type extends StatelessWidget {
  const _Type({required this.label, required this.style});
  final String label;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: WlmType.label(scheme.outline)),
          ),
          Expanded(child: Text('The quick mono fox', style: style)),
        ],
      ),
    );
  }
}

class _Swatches extends StatelessWidget {
  const _Swatches();
  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final swatches = <(String, Color)>[
      ('surface', s.surface),
      ('surfaceContainerHighest', s.surfaceContainerHighest),
      ('onSurface', s.onSurface),
      ('outline', s.outline),
      ('outlineVariant', s.outlineVariant),
      ('primary', s.primary),
      ('secondary', s.secondary),
      ('error', s.error),
    ];
    return Wrap(
      spacing: WlmTokens.spaceMd,
      runSpacing: WlmTokens.spaceMd,
      children: [
        for (final (name, color) in swatches)
          SizedBox(
            width: 96,
            child: Column(
              children: [
                Container(
                  width: 96,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(WlmTokens.radSm),
                    border: WlmTokens.hairlineBorder(s),
                  ),
                ),
                const SizedBox(height: WlmTokens.spaceXs),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: WlmType.tiny(s.outline),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
