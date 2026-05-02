import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

/// Settings screen with grouped switch tiles, list rows, and an
/// action sheet for theme selection.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _push = true;
  bool _email = false;
  bool _haptics = true;
  bool _analytics = false;
  String _theme = 'Auto';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: WlmAppBar(title: 'settings'),
      body: ListView(
        padding: const EdgeInsets.all(WlmTokens.spaceLg),
        children: [
          // Account header
          WlmSurface(
            padding: const EdgeInsets.all(WlmTokens.spaceLg),
            child: Row(
              children: [
                WlmAvatar(initials: 'MK', size: 48),
                const SizedBox(width: WlmTokens.spaceLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Miko Kurosawa',
                        style: WlmType.h3(scheme.onSurface),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'miko@wolwoloom.dev',
                        style: WlmType.meta(scheme.outline),
                      ),
                    ],
                  ),
                ),
                WlmGhostButton(
                  label: 'EDIT',
                  onPressed: () {},
                  size: WlmSize.sm,
                ),
              ],
            ),
          ),
          const SizedBox(height: WlmTokens.spaceXl),
          _group(context, 'NOTIFICATIONS', [
            WlmSwitchTile(
              title: 'Push notifications',
              subtitle: 'Get notified about new activity.',
              value: _push,
              onChanged: (v) => setState(() => _push = v),
            ),
            WlmSwitchTile(
              title: 'Email digest',
              subtitle: 'Weekly summary every Monday.',
              value: _email,
              onChanged: (v) => setState(() => _email = v),
            ),
          ]),
          _group(context, 'PREFERENCES', [
            WlmSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  WlmListTile(
                    leading: const Icon(Icons.palette_outlined, size: 18),
                    title: 'Theme',
                    subtitle: _theme,
                    trailing: const Icon(
                        Icons.chevron_right_rounded,
                        size: 18),
                    onTap: () => _pickTheme(context),
                  ),
                  Container(
                    height: WlmTokens.hairline,
                    color: WlmThemeExtension.of(context).hairline,
                  ),
                  WlmListTile(
                    leading: const Icon(Icons.language_rounded, size: 18),
                    title: 'Language',
                    subtitle: 'English',
                    trailing: const Icon(
                        Icons.chevron_right_rounded,
                        size: 18),
                    onTap: () {},
                  ),
                  Container(
                    height: WlmTokens.hairline,
                    color: WlmThemeExtension.of(context).hairline,
                  ),
                  WlmListTile(
                    leading:
                        const Icon(Icons.text_fields_rounded, size: 18),
                    title: 'Text size',
                    subtitle: 'Default',
                    trailing: const Icon(
                        Icons.chevron_right_rounded,
                        size: 18),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ]),
          _group(context, 'PRIVACY', [
            WlmSwitchTile(
              title: 'Haptic feedback',
              value: _haptics,
              onChanged: (v) => setState(() => _haptics = v),
            ),
            WlmSwitchTile(
              title: 'Anonymous analytics',
              subtitle: 'Helps improve the experience.',
              value: _analytics,
              onChanged: (v) => setState(() => _analytics = v),
            ),
          ]),
          _group(context, 'ABOUT', [
            WlmSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  WlmListTile(
                    leading: const Icon(Icons.info_outline_rounded, size: 18),
                    title: 'Version',
                    trailing: Text(
                      '0.3.1',
                      style: WlmType.meta(scheme.outline),
                    ),
                  ),
                  Container(
                    height: WlmTokens.hairline,
                    color: WlmThemeExtension.of(context).hairline,
                  ),
                  WlmListTile(
                    leading: const Icon(Icons.code_rounded, size: 18),
                    title: 'Source',
                    subtitle: 'github.com/iyashwantsaini/WolwoLoom',
                    trailing: const Icon(
                        Icons.open_in_new_rounded,
                        size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: WlmTokens.spaceLg),
          WlmGhostButton(
            label: 'SIGN OUT',
            onPressed: () {},
            icon: Icons.logout_rounded,
            expand: true,
          ),
          const SizedBox(height: WlmTokens.spaceXl),
        ],
      ),
    );
  }

  Widget _group(BuildContext context, String label, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: WlmTokens.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: WlmTokens.spaceMd, left: 4),
            child: Text(
              label,
              style: WlmType.tiny(Theme.of(context).colorScheme.outline)
                  .copyWith(letterSpacing: 1.6),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  void _pickTheme(BuildContext context) {
    WlmActionSheet.show(
      context,
      title: 'Theme',
      message: 'Choose how the app should look.',
      items: [
        WlmActionSheetItem(
          label: 'Auto (system)',
          icon: Icons.brightness_auto_rounded,
          onTap: () => setState(() => _theme = 'Auto'),
        ),
        WlmActionSheetItem(
          label: 'Light',
          icon: Icons.light_mode_outlined,
          onTap: () => setState(() => _theme = 'Light'),
        ),
        WlmActionSheetItem(
          label: 'Dark',
          icon: Icons.dark_mode_outlined,
          onTap: () => setState(() => _theme = 'Dark'),
        ),
      ],
    );
  }
}
