import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CatalogScaffold(
      title: 'Feedback',
      sections: [
        const Section(
          label: 'Loaders & skeletons',
          children: [
            Center(child: WlmLoader(label: 'Fetching wallpapers')),
            WlmScanBar(),
            WlmSkeleton(height: 16),
            SizedBox(height: WlmTokens.spaceMd),
            SizedBox(height: 240, child: WlmGridSkeleton()),
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
          caption: 'Sonner-style queue. Mounted once at the app root.',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'INFO',
                    onPressed: () => WlmToaster.info(ctx, 'New wallpapers indexed.'),
                  ),
                ),
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'SUCCESS',
                    onPressed: () => WlmToaster.success(ctx, 'Saved to favourites.'),
                  ),
                ),
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'WARNING',
                    onPressed: () => WlmToaster.warning(ctx, 'You are offline.'),
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
              message: 'Wolwoloom v0.2.0 is ready to install.',
              actionLabel: 'Update',
            ),
            WlmBanner(
              tone: WlmCalloutTone.warning,
              message: 'You are offline. Showing cached wallpapers.',
            ),
          ],
        ),
        const Section(
          label: 'Empty & error states',
          children: [
            WlmEmptyState(
              icon: Icons.bookmark_border_rounded,
              title: 'Nothing saved yet',
              body:
                  'Tap the bookmark icon on any wallpaper to save it for later.',
            ),
            WlmErrorState(
              title: "We couldn't load that.",
              body: 'Check your connection and try again.',
              details: 'SocketException: Failed host lookup',
            ),
          ],
        ),
      ],
    );
  }
}
