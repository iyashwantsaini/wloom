import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});
  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  bool _switch = true;
  bool _check1 = true;
  bool _check2 = false;
  String _radio = 'system';

  @override
  Widget build(BuildContext context) {
    return CatalogScaffold(
      title: 'Lists',
      sections: [
        Section(
          label: 'List tiles',
          children: [
            WlmListTile(
              title: 'Wallhaven',
              subtitle: 'Curated phone wallpapers',
              leading: const Icon(Icons.cloud_outlined),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            WlmListTile(
              title: 'NASA APOD',
              subtitle: 'A cosmic image, every day',
              leading: const Icon(Icons.public_outlined),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ],
        ),
        Section(
          label: 'Action rows',
          children: [
            WlmActionRow(
              icon: Icons.share_outlined,
              label: 'Share link',
              onTap: () {},
            ),
            WlmActionRow(
              icon: Icons.delete_outline,
              label: 'Remove from saved',
              destructive: true,
              onTap: () {},
            ),
          ],
        ),
        Section(
          label: 'Switch tile',
          children: [
            WlmSwitchTile(
              title: 'Daily wallpaper',
              subtitle: 'Rotate a new wallpaper each morning',
              value: _switch,
              onChanged: (v) => setState(() => _switch = v),
              trailingBadge: const WlmBadge(label: 'New'),
            ),
          ],
        ),
        Section(
          label: 'Checkbox tiles',
          children: [
            WlmCheckboxTile(
              title: 'Weekly digest',
              subtitle: 'Curated wallpapers, every Sunday morning.',
              value: _check1,
              onChanged: (v) => setState(() => _check1 = v),
            ),
            WlmCheckboxTile(
              title: 'Background sync',
              subtitle: 'Refresh sources while on Wi-Fi.',
              value: _check2,
              onChanged: (v) => setState(() => _check2 = v),
            ),
          ],
        ),
        Section(
          label: 'Radio tiles',
          children: [
            for (final entry in const [
              ('system', 'System', 'Match the device theme'),
              ('light', 'Light', 'Always use the light scheme'),
              ('dark', 'Dark', 'Always use the dark scheme'),
            ])
              WlmRadioTile<String>(
                value: entry.$1,
                groupValue: _radio,
                title: entry.$2,
                subtitle: entry.$3,
                onChanged: (v) => setState(() => _radio = v ?? _radio),
              ),
          ],
        ),
      ],
    );
  }
}
