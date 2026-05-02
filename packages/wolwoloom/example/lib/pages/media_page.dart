import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CatalogScaffold(
      title: 'Media',
      intro: 'Network images use a shimmer placeholder; the masonry grid '
          'auto-staggers items based on their child sizes.',
      sections: [
        const Section(
          label: 'Network image',
          children: [
            SizedBox(
              height: 240,
              child: WlmNetworkImage(
                url: 'https://picsum.photos/seed/wlm/800/600',
              ),
            ),
          ],
        ),
        const Section(
          label: 'Progressive image',
          children: [
            SizedBox(
              height: 240,
              child: WlmProgressiveImage(
                thumbUrl: 'https://picsum.photos/seed/wlm/40/30',
                hiResUrl: 'https://picsum.photos/seed/wlm/800/600',
              ),
            ),
          ],
        ),
        Section(
          label: 'Masonry grid',
          children: [
            SizedBox(
              height: 360,
              child: WlmMasonryGrid(
                itemCount: 8,
                crossAxisCount: 2,
                itemBuilder: (ctx, i) => SizedBox(
                  height: 80.0 + (i % 3) * 50,
                  child: WlmNetworkImage(
                    url: 'https://picsum.photos/seed/m$i/400/${300 + i * 30}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
