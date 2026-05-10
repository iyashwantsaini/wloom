import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _refreshCount = 0;

  Future<void> _onRefresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _refreshCount++);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CatalogScaffold(
      title: 'Feedback',
      intro:
          'Loaders, skeletons, snackbars, toasts, banners and empty/error states. '
          'Drop them in raw or via the convenience helpers (`WlmSnack.show`, `WlmToaster.*`).',
      sections: [
        Section(
          label: 'Loader',
          caption:
              'Square perimeter scanner. Use compact mode for inline strips.',
          children: [
            _DemoFrame(
              height: 140,
              child: const Center(child: WlmLoader(label: 'Loading')),
            ),
            const SizedBox(height: WlmTokens.spaceSm),
            _DemoFrame(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WlmLoader(label: 'SYNCING', compact: true, size: 18),
                  const SizedBox(width: WlmTokens.spaceMd),
                  Text(
                    'INLINE STRIP',
                    style: WlmType.label(scheme.outline)
                        .copyWith(letterSpacing: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Section(
          label: 'Scan bar',
          caption:
              'Thin scanning bar — pair with skeletons or use solo as a top progress hint.',
          children: [WlmScanBar()],
        ),
        const Section(
          label: 'Skeletons',
          caption: 'Shimmering placeholders for in-flight content.',
          children: [
            WlmSkeleton(height: 16, width: 220),
            SizedBox(height: WlmTokens.spaceSm),
            WlmSkeleton(height: 12),
            SizedBox(height: WlmTokens.spaceSm),
            WlmSkeleton(height: 12, width: 160),
          ],
        ),
        Section(
          label: 'Grid skeleton',
          caption:
              'Masonry skeleton mirroring WlmMasonryGrid while tiles load.',
          children: [
            _DemoFrame(
              height: 360,
              padded: false,
              child: const WlmGridSkeleton(crossAxisCount: 2, itemCount: 6),
            ),
          ],
        ),
        Section(
          label: 'Pull to refresh',
          caption:
              'Editorial typewriter pull-to-refresh. Drop-in for RefreshIndicator.',
          children: [
            _DemoFrame(
              height: 220,
              padded: false,
              child: WlmRefresh(
                onRefresh: _onRefresh,
                child: ListView.separated(
                  padding: const EdgeInsets.all(WlmTokens.spaceMd),
                  itemCount: 5,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: WlmTokens.spaceSm),
                  itemBuilder: (_, i) => Container(
                    padding: const EdgeInsets.all(WlmTokens.spaceMd),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(WlmTokens.radSm),
                      border: WlmTokens.hairlineBorder(scheme),
                    ),
                    child: Text(
                      'item ${i + 1}',
                      style: WlmType.body(scheme.onSurface),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: WlmTokens.spaceSm),
            Text(
              'refreshed $_refreshCount times',
              style: WlmType.meta(scheme.outline),
            ),
          ],
        ),
        Section(
          label: 'Snackbar & toast',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                Builder(
                  builder: (ctx) => WlmPrimaryButton(
                    label: 'Snackbar',
                    onPressed: () => WlmSnack.show(
                      ctx,
                      'Saved to favourites',
                      actionLabel: 'Undo',
                    ),
                  ),
                ),
                Builder(
                  builder: (ctx) => WlmSecondaryButton(
                    label: 'Toast',
                    onPressed: () => WlmToast.show(
                      ctx,
                      'Copied to clipboard',
                      tone: WlmCalloutTone.success,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Section(
          label: 'Toaster (stack)',
          caption:
              'Sonner-style queue. Mounted once at the app root via WlmToaster.',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'INFO',
                    onPressed: () =>
                        WlmToaster.info(ctx, 'New wallpapers indexed.'),
                  ),
                ),
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'SUCCESS',
                    onPressed: () =>
                        WlmToaster.success(ctx, 'Saved to favourites.'),
                  ),
                ),
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'WARNING',
                    onPressed: () =>
                        WlmToaster.warning(ctx, 'You are offline.'),
                  ),
                ),
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'DANGER',
                    onPressed: () => WlmToaster.danger(
                      ctx,
                      'Failed to fetch wallpapers.',
                      title: 'Network error',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Section(
          label: 'Banners',
          children: [
            WlmBanner(
              tone: WlmCalloutTone.info,
              title: 'Update available',
              message: 'wloom v0.3.4 is ready to install.',
              actionLabel: 'Update',
            ),
            SizedBox(height: WlmTokens.spaceSm),
            WlmBanner(
              tone: WlmCalloutTone.warning,
              message: 'You are offline. Showing cached wallpapers.',
            ),
            SizedBox(height: WlmTokens.spaceSm),
            WlmBanner(
              tone: WlmCalloutTone.success,
              title: 'All set',
              message: 'Profile saved.',
            ),
          ],
        ),
        Section(
          label: 'Empty state',
          children: [
            _DemoFrame(
              height: 280,
              child: const WlmEmptyState(
                icon: Icons.bookmark_border_rounded,
                eyebrow: 'NOTHING HERE',
                title: 'No favourites yet',
                body:
                    'Tap the bookmark icon on any wallpaper to save it for later.',
              ),
            ),
          ],
        ),
        Section(
          label: 'Error state',
          children: [
            _DemoFrame(
              height: 280,
              child: WlmErrorState(
                title: "We couldn't load that.",
                body: 'Check your connection and try again.',
                details: 'SocketException: Failed host lookup',
                onRetry: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Bordered preview frame so loaders / skeletons / refresh demos sit
/// inside an explicit, hairline-bound stage instead of stretching to
/// fill the page.
class _DemoFrame extends StatelessWidget {
  const _DemoFrame({
    required this.child,
    this.height = 200,
    this.padded = true,
  });

  final Widget child;
  final double height;
  final bool padded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: WlmTokens.hairlineBorder(scheme),
        color: scheme.surface,
      ),
      clipBehavior: Clip.antiAlias,
      padding: padded ? const EdgeInsets.all(WlmTokens.spaceMd) : null,
      child: child,
    );
  }
}
