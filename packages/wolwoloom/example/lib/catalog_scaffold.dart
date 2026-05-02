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
        title: title.toLowerCase(),
        leading: WlmHeaderIconButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        showDivider: true,
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 720;
            final maxW = c.maxWidth >= 1100 ? 1080.0 : c.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxW),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    wide ? WlmTokens.spaceLg : WlmTokens.spaceMd,
                    0,
                    WlmTokens.spaceXxl,
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        wide ? WlmTokens.spaceXxl : WlmTokens.spaceLg,
                        WlmTokens.spaceMd,
                        wide ? WlmTokens.spaceXxl : WlmTokens.spaceLg,
                        intro != null ? WlmTokens.spaceMd : WlmTokens.spaceLg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CATEGORY',
                            style: WlmType.label(scheme.outline)
                                .copyWith(letterSpacing: 1.6),
                          ),
                          const SizedBox(height: WlmTokens.spaceXs),
                          Text(
                            title,
                            style: WlmType.h1(scheme.onSurface).copyWith(
                              fontSize: wide ? 44 : 32,
                              letterSpacing: -0.6,
                              height: 1.1,
                            ),
                          ),
                          if (intro != null) ...[
                            const SizedBox(height: WlmTokens.spaceMd),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 620),
                              child: Text(
                                intro!,
                                style: WlmType.bodySmall(scheme.outline)
                                    .copyWith(height: 1.55),
                              ),
                            ),
                          ],
                          const SizedBox(height: WlmTokens.spaceMd),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: WlmTokens.spaceSm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: WlmThemeExtension.of(context).hairline,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(WlmTokens.radSm),
                                ),
                                child: Text(
                                  '${sections.length} SECTIONS',
                                  style: WlmType.tiny(scheme.outline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _SectionDivider(wide: wide),
                    for (var i = 0; i < sections.length; i++) ...[
                      sections[i],
                      if (i < sections.length - 1)
                        _SectionDivider(wide: wide),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.wide});
  final bool wide;
  @override
  Widget build(BuildContext context) {
    final wlm = WlmThemeExtension.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: wide ? WlmTokens.spaceXxl : WlmTokens.spaceLg,
      ),
      child: Container(height: WlmTokens.hairline, color: wlm.hairline),
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
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth >= 720;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            wide ? WlmTokens.spaceXxl : WlmTokens.spaceLg,
            WlmTokens.spaceXl,
            wide ? WlmTokens.spaceXxl : WlmTokens.spaceLg,
            WlmTokens.spaceXl,
          ),
          child: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: _SectionLabel(label: label, caption: caption),
                    ),
                    const SizedBox(width: WlmTokens.spaceXl),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < children.length; i++) ...[
                            if (i > 0)
                              const SizedBox(height: WlmTokens.spaceLg),
                            children[i],
                          ],
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionLabel(label: label, caption: caption),
                    const SizedBox(height: WlmTokens.spaceMd),
                    for (var i = 0; i < children.length; i++) ...[
                      if (i > 0) const SizedBox(height: WlmTokens.spaceMd),
                      children[i],
                    ],
                  ],
                ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, this.caption});
  final String label;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WlmSectionLabel(label),
        if (caption != null) ...[
          const SizedBox(height: WlmTokens.spaceXs),
          Text(caption!, style: WlmType.meta(scheme.outline)),
        ],
      ],
    );
  }
}
