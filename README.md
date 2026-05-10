# wloom · design system

> An editorial / typewriter-flavored Flutter design system. Mono typography, hairline borders, ink-on-paper palette with a periwinkle accent. Ships as the [`wolwoloom`](https://pub.dev/packages/wolwoloom) package on pub.dev. Extracted from the [`wolwo`](https://github.com/iyashwantsaini/wolwo) wallpaper app.

[![pub package](https://img.shields.io/pub/v/wolwoloom.svg)](https://pub.dev/packages/wolwoloom)
[![pub points](https://img.shields.io/pub/points/wolwoloom)](https://pub.dev/packages/wolwoloom/score)
[![pub likes](https://img.shields.io/pub/likes/wolwoloom)](https://pub.dev/packages/wolwoloom/score)
[![CI](https://github.com/iyashwantsaini/wloom/actions/workflows/ci.yml/badge.svg)](https://github.com/iyashwantsaini/wloom/actions/workflows/ci.yml)
[![Pages](https://github.com/iyashwantsaini/wloom/actions/workflows/pages.yml/badge.svg)](https://github.com/iyashwantsaini/wloom/actions/workflows/pages.yml)
[![Publish](https://github.com/iyashwantsaini/wloom/actions/workflows/publish.yml/badge.svg)](https://github.com/iyashwantsaini/wloom/actions/workflows/publish.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

**Showcase** —

* Package on pub.dev → **<https://pub.dev/packages/wolwoloom>**
* Live web gallery → **<https://iyashwantsaini.github.io/wloom/>** (auto-deploys on every push to `main`).
* Android APKs (catalog app + widgetbook) → **[Releases](https://github.com/iyashwantsaini/wloom/releases/latest)** (built on every `v*` tag).

```dart
import 'package:wolwoloom/wolwoloom.dart';

MaterialApp(
  theme: WlmTheme.light(),
  darkTheme: WlmTheme.dark(),
  home: const MyPage(),
);
```

## Install

```sh
flutter pub add wolwoloom
```

or pin in `pubspec.yaml`:

```yaml
dependencies:
  wolwoloom: ^0.3.4
```

## Showcase

Two apps live in this repo and are both built by CI on every push to `main`:

| Showcase | What it is | Where to find it |
| --- | --- | --- |
| **wloom** ([`packages/wolwoloom/example`](packages/wolwoloom/example)) | A Flutter app that opens straight into a categorised showcase of every component, with a theme toggle in the app bar. Built for Android / iOS / desktop / web. | APK on the latest [release](https://github.com/iyashwantsaini/wloom/releases/latest) — `wloom-showcase-*.apk` |
| **wloom wb** ([`apps/widgetbook`](apps/widgetbook)) | Interactive component gallery with knobs, light/dark themes, and viewport switching. Same source ships as web *and* APK. | Web: <https://iyashwantsaini.github.io/wloom/> · APK: `wloom-wb-*.apk` on the latest release |

### Screenshots

Full gallery (showcase screens, demo templates, widgetbook stories) lives in [docs/README.md](docs/README.md). The recipe an agent can follow to refresh every shot is in [docs/screenshots/SKILL.md](docs/screenshots/SKILL.md).

## Components

| Group        | Widgets                                                                                                                                                                                                |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Foundations  | `WlmTokens`, `WlmColors`, `WlmType`, `WlmMotion`, `WlmTheme`, `WlmThemeExtension`, `WlmBreakpoint`, `WlmResponsive`                                                                                    |
| Buttons      | `WlmPrimaryButton`, `WlmSecondaryButton`, `WlmGhostButton`, `WlmIconButton`, `WlmHeaderIconButton`, `WlmFab`                                                                                           |
| Inputs       | `WlmTextField`, `WlmSearchField`, `WlmKeyField`, `WlmCheckbox`, `WlmRadio`, `WlmSegmentedControl`, `WlmDropdown`, `WlmSlider`, `WlmStepper`, `WlmDateField`, `WlmRating`                               |
| Display      | `WlmBadge`, `WlmChip`, `WlmPill`, `WlmSpecRow`, `WlmDivider`, `WlmAvatar`, `WlmAvatarStack`, `WlmTag`, `WlmKbd`, `WlmStat`, `WlmCallout`, `WlmCodeBlock`, `WlmProgressBar`, `WlmProgressRing`, `WlmTooltip`, `WlmDataTable`, `WlmTimeline`, `WlmMessageBubble`, `WlmKpiCard` |
| Layout       | `WlmSurface`, `WlmCard`, `WlmPageHeader`, `WlmSectionLabel`, `WlmAppBar`, `WlmAppScaffold`, `WlmAccordion`, `WlmBreadcrumbs`, `WlmDrawer`                                                              |
| Lists        | `WlmListTile`, `WlmActionRow`, `WlmSwitchTile`, `WlmCheckboxTile`, `WlmRadioTile`                                                                                                                      |
| Feedback     | `WlmLoader`, `WlmScanBar`, `WlmSkeleton`, `WlmGridSkeleton`, `WlmSnack`, `WlmToast`, `WlmBanner`, `WlmEmptyState`, `WlmErrorState`                                                                     |
| Navigation   | `WlmBottomNav`, `WlmStepDots`, `WlmTabBar`, `WlmShell`                                                                                                                                                 |
| Overlays     | `showWlmBottomSheet`, `WlmDialog`, `WlmCommandPalette`, `WlmActionSheet`                                                                                                                              |
| Media        | `WlmNetworkImage`, `WlmProgressiveImage`, `WlmMasonryGrid`                                                                                                                                             |

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

## Run locally

```sh
# wloom — the showcase app (runs the design system on Android / iOS / desktop / web)
cd packages/wolwoloom/example
flutter run                      # Android / iOS / desktop
flutter run -d chrome            # Web

# wloom wb — interactive widgetbook gallery
cd apps/widgetbook
flutter run -d chrome            # browse every component with knobs
flutter build web                # ship the gallery as a static site
```

## CI / publishing

Three GitHub Actions workflows live under [`.github/workflows/`](.github/workflows):

| Workflow | Trigger | What it does |
| --- | --- | --- |
| [`ci.yml`](.github/workflows/ci.yml) | Push & PR to `main` | `flutter analyze` across the package, example and widgetbook · `flutter test` for the package. |
| [`pages.yml`](.github/workflows/pages.yml) | Push to `main` (paths: `apps/widgetbook/**`, `packages/wolwoloom/**`) · `workflow_dispatch` | Builds the widgetbook for web and deploys it to GitHub Pages. **One-time setup:** *Repo → Settings → Pages → Source: GitHub Actions.* |
| [`release.yml`](.github/workflows/release.yml) | Push of any `v*` tag · `workflow_dispatch` | Builds release APKs for both showcase apps (`wloom` and `wloom wb`, split-per-ABI + universal) and publishes them to a GitHub Release. Optionally signs with a keystore from repo secrets — see the comments at the top of the file. |

To cut a release:

```sh
git tag v0.2.0
git push origin v0.2.0
```

## Roadmap

* `WlmAutocomplete`, `WlmRangeSlider`, `WlmTimeField`
* Form orchestration (`WlmForm`, validators, error summary)
* `WlmDataTable`, sortable mono table for dense data
* Charts (mono sparkline, bar, ring)
* `go_router` glue for `WlmShell`
* Built-in onboarding / settings page templates
* Generated docs site (Dartdoc + the widgetbook web build)

## Reference

The [`reference/wolwo/`](reference/wolwo) folder is a shallow clone of the wolwo wallpaper app that this design system was distilled from. Treat it as living documentation: every component in `wolwoloom` has a counterpart there showing how it was originally consumed.

## License

[MIT](LICENSE) — do whatever you want, just keep the notice. The cloned `reference/wolwo/` retains its own license.
