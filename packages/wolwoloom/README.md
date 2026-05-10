# wloom

[![pub package](https://img.shields.io/pub/v/wolwoloom.svg)](https://pub.dev/packages/wolwoloom)
[![pub points](https://img.shields.io/pub/points/wolwoloom)](https://pub.dev/packages/wolwoloom/score)
[![pub likes](https://img.shields.io/pub/likes/wolwoloom)](https://pub.dev/packages/wolwoloom/score)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](https://github.com/iyashwantsaini/wloom/blob/main/LICENSE)

**wloom** is an editorial / typewriter Flutter design system. Mono typography, hairline borders, ink-on-paper palette with a periwinkle accent. 100+ Material 3 widgets in one barrel import. Ships on pub.dev as the `wolwoloom` package.

* **Live web gallery** — <https://iyashwantsaini.github.io/wloom/>
* **Screenshots** — [docs/README.md](https://github.com/iyashwantsaini/wloom/blob/main/docs/README.md)
* **Source / issues** — <https://github.com/iyashwantsaini/wloom>

## Install

```sh
flutter pub add wolwoloom
```

## Usage

One import gives you everything:

```dart
import 'package:wolwoloom/wolwoloom.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: WlmTheme.light(),
        darkTheme: WlmTheme.dark(),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      );
}
```

A typical page:

```dart
WlmAppScaffold(
  appBar: WlmAppBar(title: 'WALLPAPERS'),
  body: ListView(
    padding: const EdgeInsets.all(WlmTokens.gutter),
    children: [
      WlmPageHeader(eyebrow: 'TODAY', title: 'Latest drops'),
      const SizedBox(height: WlmTokens.section),
      WlmPrimaryButton(label: 'DOWNLOAD', onPressed: () {}),
    ],
  ),
);
```

## Components

| Group        | Widgets                                                                                                                                                                                                |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Foundations  | `WlmTokens`, `WlmColors`, `WlmType`, `WlmMotion`, `WlmIcons`, `WlmTheme`, `WlmThemeExtension`, `WlmBreakpoint`, `WlmResponsive`, `WlmResponsiveValue`, `WlmCenteredColumn`                              |
| Buttons      | `WlmPrimaryButton`, `WlmSecondaryButton`, `WlmGhostButton`, `WlmIconButton`, `WlmHeaderIconButton`, `WlmFab`, `WlmButton`                                                                              |
| Inputs       | `WlmTextField`, `WlmSearchField`, `WlmKeyField`, `WlmCheckbox`, `WlmRadio`, `WlmToggle`, `WlmSegmentedControl`, `WlmDropdown`, `WlmCombobox`, `WlmSlider`, `WlmStepper`, `WlmDateField`, `WlmRating`, `WlmPinInput`, `WlmForm` |
| Display      | `WlmBadge`, `WlmChip`, `WlmPill`, `WlmSpecRow`, `WlmDivider`, `WlmAvatar`, `WlmAvatarStack`, `WlmTag`, `WlmKbd`, `WlmStat`, `WlmCallout`, `WlmCodeBlock`, `WlmProgressBar`, `WlmProgressRing`, `WlmTooltip`, `WlmDataTable`, `WlmTimeline`, `WlmMessageBubble`, `WlmKpiCard` |
| Layout       | `WlmSurface`, `WlmCard`, `WlmPageHeader`, `WlmSectionLabel`, `WlmAppBar`, `WlmAppScaffold`, `WlmAccordion`, `WlmBreadcrumbs`, `WlmDrawer`                                                              |
| Lists        | `WlmListTile`, `WlmActionRow`, `WlmSwitchTile`, `WlmCheckboxTile`, `WlmRadioTile`                                                                                                                      |
| Feedback     | `WlmLoader`, `WlmScanBar`, `WlmSkeleton`, `WlmGridSkeleton`, `WlmSnack`, `WlmToast`, `WlmToaster`, `WlmBanner`, `WlmEmptyState`, `WlmErrorState`, `WlmRefresh`                                          |
| Navigation   | `WlmBottomNav`, `WlmStepDots`, `WlmTabBar`, `WlmShell`, `WlmPagination`, `WlmPageRoute`                                                                                                                |
| Overlays     | `showWlmBottomSheet`, `WlmDialog`, `WlmCommandPalette`, `WlmActionSheet`, `WlmMenu`, `WlmPopover`                                                                                                      |
| Media        | `WlmNetworkImage`, `WlmProgressiveImage`, `WlmMasonryGrid`                                                                                                                                             |
| Primitives   | `WlmFocusable`                                                                                                                                                                                          |

`Switch`, `Checkbox`, `Radio`, `AppBar`, `SnackBar`, `BottomNavigationBar`, `Card` and `TextSelection` are restyled automatically by `WlmTheme` — drop in stock Material widgets and they'll match.

## Design language

* **Typography** — JetBrains Mono everywhere, light weights (200–400), tight negative letter-spacing on headings, wide positive on labels.
* **Spacing** — `4 / 8 / 12 / 16 / 24 / 32` (xs..xxl) via `WlmTokens.spaceXs..Xxl`.
* **Radii** — `4 / 6 / 12 / 16 / 20 / 999` via `WlmTokens.radXs..Pill`.
* **Borders** — 1px hairlines on `outlineVariant @ 0.30`. No shadows, no glassmorphism.
* **Palette** —
  * Dark: ink `#0A0A0A` · surface `#111114` · accent periwinkle `#8FA8FF`.
  * Light: paper `#F4F4F6` · ink `#0E0E14` · accent periwinkle `#4A5BD0`.
* **Motion** — short and quiet (`fast 120ms`, `medium 220ms`, `slow 320ms`).

## Optional gallery

A live in-app component browser is available as a separate import — drop it into any route to inspect every widget:

```dart
import 'package:wolwoloom/gallery.dart';

Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WlmGallery()));
```

## Run the example

```sh
git clone https://github.com/iyashwantsaini/wloom
cd wloom/packages/wolwoloom/example
flutter run
```

See the [project README](https://github.com/iyashwantsaini/wloom#readme) for the full repo layout, CI, and roadmap.

## License

[MIT](https://github.com/iyashwantsaini/wloom/blob/main/LICENSE)
