# Wolwoloom

> An editorial / typewriter-flavored Flutter design system. Mono typography, hairline borders, ink-on-paper palette with a periwinkle accent. Extracted from the [`wolwo`](https://github.com/iyashwantsaini/wolwo) wallpaper app.

[![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B?logo=flutter)](https://flutter.dev) [![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

```dart
import 'package:wolwoloom/wolwoloom.dart';

MaterialApp(
  theme: WlmTheme.light(),
  darkTheme: WlmTheme.dark(),
  home: const MyPage(),
);
```

## Install

```yaml
dependencies:
  wolwoloom: ^0.1.0
```

```sh
flutter pub add wolwoloom
```

## Components (v0.1)

| Group        | Widgets                                                                                              |
| ------------ | ---------------------------------------------------------------------------------------------------- |
| Foundations  | `WlmTokens`, `WlmColors`, `WlmType`, `WlmMotion`, `WlmTheme`                                         |
| Buttons      | `WlmPrimaryButton`, `WlmSecondaryButton`, `WlmGhostButton`, `WlmIconButton`, `WlmHeaderIconButton`   |
| Inputs       | `WlmTextField`, `WlmSearchField`, `WlmKeyField`                                                      |
| Display      | `WlmBadge`, `WlmChip`, `WlmPill`, `WlmSpecRow`, `WlmDivider`                                         |
| Layout       | `WlmCard`, `WlmPageHeader`, `WlmSectionLabel`                                                        |
| Lists        | `WlmListTile`, `WlmActionRow`, `WlmSwitchTile`                                                       |
| Feedback     | `WlmLoader`, `WlmScanBar`, `WlmSkeleton`, `WlmGridSkeleton`, `WlmSnack`                              |
| Navigation   | `WlmBottomNav`, `WlmStepDots`                                                                        |
| Overlays     | `showWlmBottomSheet`, `WlmDialog`                                                                    |
| Media        | `WlmNetworkImage`, `WlmProgressiveImage`, `WlmMasonryGrid`                                           |

`Switch`, `Checkbox`, `Radio`, `AppBar`, `SnackBar`, `BottomNavigationBar`, `Card` and `TextSelection` are restyled automatically by `WlmTheme` — use the stock Material widgets and they'll match.

## Design language

* **Typography** — JetBrains Mono everywhere, light weights (200–400), tight negative letter-spacing on headings, wide positive on labels.
* **Spacing scale** — `4 / 8 / 12 / 16 / 24 / 32` (xs..xxl).
* **Radii** — `6 / 12 / 16 / 20`.
* **Borders** — 1px hairlines on `outlineVariant @ 0.30`. No shadows, no glassmorphism.
* **Palette** —
  * Dark: ink `#0A0A0A` · surface `#111114` · accent periwinkle `#8FA8FF`.
  * Light: paper `#F4F4F6` · ink `#0E0E14` · accent periwinkle `#4A5BD0`.
* **Motion** — short and quiet (`fast 120ms`, `medium 220ms`, `slow 320ms`).

## Repository layout

```
WolwoLoom/
├── packages/wolwoloom/         # the publishable Flutter package
│   ├── lib/                    # source
│   ├── example/                # example app (Android / iOS / Web)
│   ├── pubspec.yaml
│   └── README.md
├── apps/widgetbook/            # interactive component gallery (web + mobile)
├── reference/wolwo/            # the cloned wolwo app this system was distilled from
├── README.md (this file)
└── LICENSE
```

## Run

```sh
# Example app — runs the design system on Android / iOS / Web
cd packages/wolwoloom/example
flutter run                      # Android / iOS / desktop
flutter run -d chrome            # Web

# Widgetbook — interactive component gallery (the showcase site)
cd apps/widgetbook
flutter run -d chrome            # browse every component with knobs
flutter build web                # ship the gallery as a static site
```

## Static showcase site

The widgetbook builds to a single `build/web/` folder you can drop on any static host (GitHub Pages, Netlify, Cloudflare Pages):

```sh
cd apps/widgetbook
flutter build web --release --base-href /WolwoLoom/
# upload build/web/  →  e.g. gh-pages branch
```

## Roadmap

* `WlmRadioTile`, `WlmCheckboxTile`, `WlmSegmentedControl`
* `WlmTabBar`, `WlmAppBar`, `WlmDrawer`, `WlmFab`
* `WlmDateField`, `WlmDropdown`, `WlmAutocomplete`
* `WlmToast` (lighter than snackbar), `WlmBanner`, `WlmEmptyState`, `WlmErrorState`
* `WlmShell` (bottom-nav + go_router glue)
* Built-in onboarding / settings page templates
* Generated docs site (Dartdoc + the widgetbook web build)

## Reference

The [`reference/wolwo/`](reference/wolwo) folder is a shallow clone of the wolwo wallpaper app that this design system was distilled from. Treat it as living documentation: every component in `wolwoloom` has a counterpart there showing how it was originally consumed.

## License

[MIT](LICENSE) — do whatever you want, just keep the notice. The cloned `reference/wolwo/` retains its own license.
