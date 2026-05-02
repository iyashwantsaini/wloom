import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

/// 3-step onboarding carousel using PageView + WlmStepDots.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _ctrl = PageController();
  int _index = 0;

  static const _pages = <_OnbPage>[
    _OnbPage(
      eyebrow: 'STEP ONE',
      title: 'Editorial\ncomponents.',
      body:
          'A monospaced design system tuned for content-heavy mobile apps. '
          'Hairline borders, all-caps labels, no glassmorphism.',
      icon: Icons.text_format_rounded,
    ),
    _OnbPage(
      eyebrow: 'STEP TWO',
      title: 'Built for\nmotion.',
      body:
          'Every component supports size, density, and accessibility tokens, '
          'with motion timings shared across the whole library.',
      icon: Icons.animation_rounded,
    ),
    _OnbPage(
      eyebrow: 'STEP THREE',
      title: 'Ready for\nproduction.',
      body:
          'Themed light + dark, analyzer-clean, and shipped on every commit. '
          'Drop it in and ship.',
      icon: Icons.rocket_launch_rounded,
    ),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_index < _pages.length - 1) {
      _ctrl.nextPage(
        duration: WlmMotion.medium,
        curve: WlmMotion.standard,
      );
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_index < _pages.length - 1)
            Padding(
              padding: const EdgeInsets.only(right: WlmTokens.spaceMd),
              child: WlmGhostButton(
                label: 'SKIP',
                onPressed: () => Navigator.of(context).maybePop(),
                size: WlmSize.sm,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => _OnbBody(page: _pages[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                WlmTokens.spaceXl,
                WlmTokens.spaceLg,
                WlmTokens.spaceXl,
                WlmTokens.spaceXl,
              ),
              child: Column(
                children: [
                  WlmStepDots(
                    total: _pages.length,
                    index: _index,
                  ),
                  const SizedBox(height: WlmTokens.spaceLg),
                  WlmPrimaryButton(
                    label: _index == _pages.length - 1
                        ? 'GET STARTED'
                        : 'CONTINUE',
                    onPressed: _next,
                    expand: true,
                    icon: Icons.arrow_forward_rounded,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnbPage {
  const _OnbPage({
    required this.eyebrow,
    required this.title,
    required this.body,
    required this.icon,
  });
  final String eyebrow;
  final String title;
  final String body;
  final IconData icon;
}

class _OnbBody extends StatelessWidget {
  const _OnbBody({required this.page});
  final _OnbPage page;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: WlmTokens.spaceXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: WlmTokens.spaceXl),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(WlmTokens.radMd),
              border: Border.all(
                color: wlm.hairline,
                width: WlmTokens.hairline,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(page.icon, size: 28, color: scheme.onSurface),
          ),
          const SizedBox(height: WlmTokens.spaceXl),
          Text(
            page.eyebrow,
            style: WlmType.tiny(scheme.outline).copyWith(letterSpacing: 1.8),
          ),
          const SizedBox(height: WlmTokens.spaceSm),
          Text(
            page.title,
            style: WlmType.h1(scheme.onSurface).copyWith(
              fontSize: 38,
              height: 1.05,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Text(
              page.body,
              style: WlmType.body(scheme.onSurfaceVariant)
                  .copyWith(height: 1.55),
            ),
          ),
        ],
      ),
    );
  }
}
