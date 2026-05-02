import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

/// Convenience scaffold every catalog page uses — `WlmAppBar` + a
/// scrolling body that lays out [Section] groups separated by hairlines.
class CatalogScaffold extends StatelessWidget {
  const CatalogScaffold({
    super.key,
    required this.title,
    required this.sections,
    this.intro,
  });

  final String title;
  final String? intro;
  final List<Section> sections;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: WlmAppBar(
        title: title,
        leading: WlmHeaderIconButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        showDivider: true,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            0,
            WlmTokens.spaceMd,
            0,
            WlmTokens.spaceXxl,
          ),
          children: [
            if (intro != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  WlmTokens.spaceLg,
                  0,
                  WlmTokens.spaceLg,
                  WlmTokens.spaceMd,
                ),
                child: Text(
                  intro!,
                  style: WlmType.bodySmall(scheme.outline).copyWith(height: 1.5),
                ),
              ),
            ],
            for (final s in sections) s,
          ],
        ),
      ),
    );
  }
}

/// One catalog group — eyebrow label, optional caption, and a vertical
/// stack of demo widgets separated by `WlmTokens.spaceMd`.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.label,
    required this.children,
    this.caption,
  });

  final String label;
  final String? caption;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        WlmTokens.spaceLg,
        WlmTokens.spaceMd,
        WlmTokens.spaceLg,
        WlmTokens.spaceLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WlmSectionLabel(label),
          if (caption != null) ...[
            const SizedBox(height: WlmTokens.spaceXs),
            Text(caption!, style: WlmType.meta(scheme.outline)),
          ],
          const SizedBox(height: WlmTokens.spaceMd),
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: WlmTokens.spaceMd),
            children[i],
          ],
        ],
      ),
    );
  }
}
