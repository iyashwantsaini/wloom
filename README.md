<p align="center"><img src="docs/screenshots/wlm-icon.png" alt="Wolwoloom" width="120" /></p>

# Wolwoloom

> An editorial / typewriter-flavored Flutter design system. Mono typography, hairline borders, ink-on-paper palette with a periwinkle accent. Extracted from the [`wolwo`](https://github.com/iyashwantsaini/wolwo) wallpaper app.

[![CI](https://github.com/iyashwantsaini/WolwoLoom/actions/workflows/ci.yml/badge.svg)](https://github.com/iyashwantsaini/WolwoLoom/actions/workflows/ci.yml)
[![Pages](https://github.com/iyashwantsaini/WolwoLoom/actions/workflows/pages.yml/badge.svg)](https://github.com/iyashwantsaini/WolwoLoom/actions/workflows/pages.yml)
[![Release](https://github.com/iyashwantsaini/WolwoLoom/actions/workflows/release.yml/badge.svg)](https://github.com/iyashwantsaini/WolwoLoom/actions/workflows/release.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

**Showcase** —

* Live web gallery → **<https://iyashwantsaini.github.io/WolwoLoom/>** (auto-deploys on every push to `main`).
* Android APKs (catalog app + widgetbook) → **[Releases](https://github.com/iyashwantsaini/WolwoLoom/releases/latest)** (built on every `v*` tag).

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
  wolwoloom: ^0.3.1
```

```sh
flutter pub add wolwoloom
```

## Showcase

Two apps live in this repo and are both built by CI on every push to `main`:

| Showcase | What it is | Where to find it |
| --- | --- | --- |
| **Catalog app** ([`packages/wolwoloom/example`](packages/wolwoloom/example)) | A Flutter app that opens straight into a categorised catalog of every component, with a theme toggle in the app bar. Built for Android / iOS / desktop / web. | APK on the latest [release](https://github.com/iyashwantsaini/WolwoLoom/releases/latest) — `wolwoloom-example-*.apk` |
| **Widgetbook gallery** ([`apps/widgetbook`](apps/widgetbook)) | Interactive component gallery with knobs, light/dark themes, and viewport switching. Same source ships as web *and* APK. | Web: <https://iyashwantsaini.github.io/WolwoLoom/> · APK: `wolwoloom-widgetbook-*.apk` on the latest release |

### Screenshots

#### Catalog app — home & component categories

<table>
  <tr>
    <td align="center"><img src="docs/screenshots/catalog-home-dark.png" width="280"/><br/><sub>Catalog · dark</sub></td>
    <td align="center"><img src="docs/screenshots/catalog-home-light.png" width="280"/><br/><sub>Catalog · light</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/page-foundations.png" width="280"/><br/><sub>Foundations</sub></td>
    <td align="center"><img src="docs/screenshots/page-buttons.png" width="280"/><br/><sub>Buttons</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/page-inputs.png" width="280"/><br/><sub>Inputs</sub></td>
    <td align="center"><img src="docs/screenshots/page-forms.png" width="280"/><br/><sub>Forms</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/page-display.png" width="280"/><br/><sub>Display</sub></td>
    <td align="center"><img src="docs/screenshots/page-layout.png" width="280"/><br/><sub>Layout</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/page-lists.png" width="280"/><br/><sub>Lists</sub></td>
    <td align="center"><img src="docs/screenshots/page-feedback.png" width="280"/><br/><sub>Feedback</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/page-navigation.png" width="280"/><br/><sub>Navigation</sub></td>
    <td align="center"><img src="docs/screenshots/page-overlays.png" width="280"/><br/><sub>Overlays</sub></td>
  </tr>
  <tr>
    <td align="center" colspan="2"><img src="docs/screenshots/page-media.png" width="280"/><br/><sub>Media</sub></td>
  </tr>
</table>

#### Demo screens — drop-in templates built from the kit

<table>
  <tr>
    <td align="center"><img src="docs/screenshots/screen-login.png" width="240"/><br/><sub>Login</sub></td>
    <td align="center"><img src="docs/screenshots/screen-onboarding.png" width="240"/><br/><sub>Onboarding</sub></td>
    <td align="center"><img src="docs/screenshots/screen-dashboard.png" width="240"/><br/><sub>Dashboard</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/screen-profile.png" width="240"/><br/><sub>Profile</sub></td>
    <td align="center"><img src="docs/screenshots/screen-settings.png" width="240"/><br/><sub>Settings</sub></td>
    <td align="center"><img src="docs/screenshots/screen-chat.png" width="240"/><br/><sub>Chat</sub></td>
  </tr>
</table>

#### Widgetbook — interactive gallery with knobs, themes, and viewport switching

<table>
  <tr>
    <td align="center"><img src="docs/screenshots/wb-foundations-typography.png" width="280"/><br/><sub>Typography</sub></td>
    <td align="center"><img src="docs/screenshots/wb-foundations-palette.png" width="280"/><br/><sub>Palette</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/wb-buttons.png" width="280"/><br/><sub>Buttons</sub></td>
    <td align="center"><img src="docs/screenshots/wb-kpi-card.png" width="280"/><br/><sub>KPI card</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/wb-timeline.png" width="280"/><br/><sub>Timeline</sub></td>
    <td align="center"><img src="docs/screenshots/wb-message-bubble.png" width="280"/><br/><sub>Message bubble</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/wb-layout-surface.png" width="280"/><br/><sub>Surface</sub></td>
    <td align="center"><img src="docs/screenshots/wb-action-sheet.png" width="280"/><br/><sub>Action sheet</sub></td>
  </tr>
</table>

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
# Catalog app — runs the design system on Android / iOS / desktop / web
cd packages/wolwoloom/example
flutter run                      # Android / iOS / desktop
flutter run -d chrome            # Web

# Widgetbook — interactive component gallery (the showcase site)
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
| [`release.yml`](.github/workflows/release.yml) | Push of any `v*` tag · `workflow_dispatch` | Builds release APKs for both showcase apps (split-per-ABI + universal) and publishes them to a GitHub Release. Optionally signs with a keystore from repo secrets — see the comments at the top of the file. |

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
