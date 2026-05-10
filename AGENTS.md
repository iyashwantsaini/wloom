# wloom — Agent / LLM Usage Guide

> Audience: AI coding assistants (Copilot, Claude, GPT, Cursor, etc.)
> generating Flutter code that uses the `wolwoloom` package (the **wloom** design system).
>
> This file is intentionally dense. Skim it once per task and you should
> never need to invent a wloom widget name or token value again.

---

## TL;DR — pick the right thing in 10 seconds

| You need… | Reach for | Don't use |
|---|---|---|
| Page background + safe-area + app bar | `WlmAppScaffold` + `WlmAppBar` | raw `Scaffold` |
| Primary CTA button | `WlmPrimaryButton(label, onPressed)` | `ElevatedButton` |
| Cancel / "second" button | `WlmGhostButton` | `TextButton` |
| Outlined / "alt" button | `WlmSecondaryButton` | `OutlinedButton` |
| Tappable icon | `WlmIconButton(icon, onPressed)` | `IconButton` |
| Icon glyph | `WlmIcons.<name>` | `Icons.<name>` (filled variants only) |
| Confirm dialog | `WlmDialog.confirm(context, title:..., body:...)` | `AlertDialog` |
| Bottom sheet | `showWlmBottomSheet(context: ..., builder: ...)` | `showModalBottomSheet` |
| Snackbar | `WlmSnack.show(context, 'Saved')` | `ScaffoldMessenger…showSnackBar` |
| Pull to refresh | `WlmRefresh(onRefresh:..., child:...)` | `RefreshIndicator` |
| Network image | `WlmNetworkImage(url:...)` | `Image.network` |
| Masonry / staggered grid | `WlmMasonryGrid` | `GridView` (when uneven heights) |
| Mono text input | `WlmTextField(label:..., hintText:...)` | `TextField` |
| Search field | `WlmSearchField(hintText:..., onChanged:...)` | `TextField` w/ search icon |
| All-caps small label | `Text('FOO', style: WlmType.label(c))` | `Text(style: TextStyle(...))` |
| Page title | `WlmType.h1(scheme.onSurface)` | `Theme.of(...).textTheme.headlineMedium` |
| Spacing | `WlmTokens.spaceXs/Sm/Md/Lg/Xl/Xxl` (4 / 8 / 12 / 16 / 24 / 32) | hard-coded `8`, `16`, etc. |
| Page gutter | `WlmTokens.gutter` (= `spaceLg` = 16) | `EdgeInsets.symmetric(horizontal: 16)` |
| Card inner padding | `WlmTokens.cardPadding` (= 16) | guess |
| Section vertical separation | `WlmTokens.section` (= 32) | guess |
| Radius | `WlmTokens.radXs/Sm/Md/Lg/Xl/Pill` | hard-coded `12`, etc. |
| Hairline border | `WlmTokens.hairlineBorder(scheme)` | `Border.all(width: 1)` |
| Animation duration | `WlmMotion.fast/medium/slow` | `Duration(milliseconds: 200)` |
| Animation curve | `WlmMotion.standard` / `WlmMotion.emphasized` | `Curves.easeOut` |
| Theme tokens (danger/warning/success/muted/accent) | `WlmTheme.of(context).<token>` | `scheme.error` etc. |
| Page transition | `Navigator.push(WlmPageRoute.sharedAxis(builder: ...))` | `MaterialPageRoute` |
| Custom focus ring | `WlmFocusable(child: ...)` | nothing — Material's blue ring will leak |
| Responsive layout | `WlmResponsive(compact: ..., expanded: ...)` or `WlmResponsiveValue<T>` | `LayoutBuilder` from scratch |

If the table doesn't list it, fall back to the **components index** below.

---

## Setup (always)

```dart
import 'package:wolwoloom/wolwoloom.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'My App',
        theme: WlmTheme.light(),
        darkTheme: WlmTheme.dark(),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      );
}
```

The single import gives you every public symbol. There is **no** wildcard
sub-import (no `package:wolwoloom/buttons.dart`); just the barrel file
and one optional extra:

```dart
import 'package:wolwoloom/gallery.dart'; // adds WlmGallery — drop into any route to browse components
```

---

## Naming rules (memorize)

1. Every public type starts with **`Wlm`**. If you're about to write `class WlmX`, check whether it already exists in [`lib/wolwoloom.dart`](packages/wolwoloom/lib/wolwoloom.dart) first.
2. Tokens live on **`WlmTokens`** (sizing) and **`WlmMotion`** (timing). Color tokens live on **`WlmColors`** (raw) and **`WlmTheme.of(context)`** (semantic).
3. Type styles live on **`WlmType`** as static methods that take a foreground `Color`: `WlmType.h1(scheme.onSurface)`.
4. Show-overlay helpers are top-level functions named `showWlm*` (`showWlmBottomSheet`). Confirm/alert dialogs are static methods on `WlmDialog` (`WlmDialog.confirm`, `WlmDialog.alert`, `WlmDialog.custom`).
5. Snackbars: `WlmSnack.show(context, 'Message')`.
6. Icons: `WlmIcons.<name>` (curated outlined set). If the glyph isn't there, use `Icons.<x>_outlined` — never `Icons.<x>` filled.

---

## Cross-platform behaviour (mobile / tablet / web)

wloom assumes one codebase ships to all three. The patterns below
are baked in — use them rather than reinventing per-platform logic.

### Breakpoints

```dart
final bp = WlmBreakpoint.of(context);
if (bp.isHandheld)  ...   // <840px (compact + medium)
if (bp.isDesktop)   ...   // ≥840px (expanded / large / extraLarge)
```

Thresholds match Material 3 window-size classes:

| Breakpoint | Width | Typical device |
|---|---|---|
| `compact` | <600 | phone portrait |
| `medium` | 600–840 | phone landscape, small tablet |
| `expanded` | 840–1200 | tablet, small laptop |
| `large` | 1200–1600 | desktop |
| `extraLarge` | ≥1600 | wide desktop |

### Switching whole layouts

```dart
WlmResponsive(
  compact: (_) => const _MobileShell(),
  expanded: (_) => const _TabletShell(),
  large: (_) => const _DesktopShell(),
);
```

### Switching values (columns, padding, font sizes)

```dart
final cols = const WlmResponsiveValue<int>(
  compact: 2, medium: 3, expanded: 4, large: 5,
).resolve(context);
```

### Capping width on wide screens (forms, prose)

```dart
WlmCenteredColumn(
  maxWidth: 720,
  child: ListView(...),
);
```

### Bottom nav on web/tablet

`WlmBottomNav` auto-collapses labels below 360px. Force it with
`compact: true` or disable auto behaviour with `compactBreakpoint: null`.
For tablet/desktop layouts, prefer a side rail you build with
`WlmResponsive` rather than a stretched bottom bar.

---

## Theming the whole app

```dart
MaterialApp(
  theme: WlmTheme.light(),
  darkTheme: WlmTheme.dark(),
);
```

Read semantic colors from the theme extension:

```dart
final wlm = WlmTheme.of(context);
container( color: wlm.muted );        // body copy / icon hint color
container( color: wlm.danger );       // destructive actions
container( color: wlm.success );      // confirmations
container( color: wlm.warning );      // soft warnings
container( color: wlm.info );         // informational accents
container( color: wlm.accent );       // brand periwinkle
container( color: wlm.hairline );     // 1px dividers
```

Read structural colors from `Theme.of(context).colorScheme`:

| Use for… | Read |
|---|---|
| Page bg | `scheme.surface` |
| Card bg / elevated surface | `scheme.surfaceContainerHighest` |
| Body text | `scheme.onSurface` |
| Disabled / hint text | `scheme.onSurfaceVariant` or `WlmTheme.of(context).muted` |
| Borders | `scheme.outlineVariant` (use `WlmTokens.hairlineBorder(scheme)`) |

**Never** hard-code hex values inside components; tokens > raw colors,
always.

---

## Spacing, radii, motion — quick reference

```dart
// Spacing scale
WlmTokens.spaceXs   //  4
WlmTokens.spaceSm   //  8
WlmTokens.spaceMd   // 12
WlmTokens.spaceLg   // 16
WlmTokens.spaceXl   // 24
WlmTokens.spaceXxl  // 32

// Semantic aliases
WlmTokens.gutter        // 16 — page horizontal padding
WlmTokens.section       // 32 — vertical separation between sections
WlmTokens.cardPadding   // 16 — inside cards
WlmTokens.inlineGap     // 12 — between inline form fields

// Radii
WlmTokens.radXs   //  4
WlmTokens.radSm   //  6
WlmTokens.radMd   // 12
WlmTokens.radLg   // 16
WlmTokens.radXl   // 20
WlmTokens.radPill // 999

// Borders
WlmTokens.hairlineBorder(scheme)   // BoxBorder for Container.decoration
WlmTokens.hairlineSide(scheme)     // BorderSide for OutlinedBorder

// Elevation (use sparingly — wloom is flat by default)
WlmTokens.shadowSm(scheme)
WlmTokens.shadowMd(scheme)
WlmTokens.shadowLg(scheme)

// Motion
WlmMotion.fast       // 120ms
WlmMotion.medium     // 220ms
WlmMotion.slow       // 320ms
WlmMotion.standard   // Curves.easeOutCubic
WlmMotion.emphasized // Curves.easeOutQuart
```

---

## Typography (everything is JetBrains Mono)

```dart
final c = Theme.of(context).colorScheme.onSurface;

Text('Hero number',     style: WlmType.display(c));
Text('Page title',      style: WlmType.h1(c));
Text('Section',         style: WlmType.h2(c));
Text('Subsection',      style: WlmType.h3(c));
Text('Body copy',       style: WlmType.body(c));
Text('Body small',      style: WlmType.bodySmall(c));
Text('LABEL',           style: WlmType.label(c));   // ALL-CAPS, sparse
Text('meta caption',    style: WlmType.meta(c));
Text('tiny',            style: WlmType.tiny(c));
```

---

## Components index (every public widget)

### Layout & shell
- `WlmAppScaffold` — page chrome + safe-area + optional bottom-nav slot
- `WlmAppBar` — transparent app bar, hairline divider on scroll
- `WlmPageHeader` — eyebrow + headline + optional supporting text
- `WlmSectionLabel` — ALL-CAPS section eyebrow used inside pages
- `WlmCard` / `WlmSurface` — hairline-bordered container
- `WlmDrawer`, `WlmAccordion`, `WlmBreadcrumbs`

### Buttons
- `WlmPrimaryButton(label, onPressed, {icon, expand, loading, size})`
- `WlmSecondaryButton(label, onPressed, ...)`
- `WlmGhostButton(label, onPressed, ...)`
- `WlmIconButton(icon, onPressed, {size, outlined, tooltip})`
- `WlmHeaderIconButton(icon, onPressed, {badge})` — use inside `WlmAppBar`
- `WlmFab(icon, onPressed)` — floating action button
- `WlmButton(label, variant: WlmButtonVariant.{primary,secondary,ghost,destructive})` — generic builder

### Inputs
- `WlmTextField(label, hintText, helperText, errorText, prefixIcon, suffixIcon, clearable, ...)`
- `WlmSearchField(hintText, onChanged, ...)`
- `WlmKeyField(...)` — labelled API-key style input
- `WlmCheckbox(value, onChanged)` (`onChanged` takes a `bool`, not nullable)
- `WlmRadio<T>(value, groupValue, onChanged)`
- `WlmToggle(value, onChanged)` — same UX as a switch
- `WlmSegmentedControl<T>(segments, value, onChanged, expand, variant)`
  - `WlmSegmentedControl.text(segments: ['ALL','PHOTOS'], ...)` — text-only pill variant
- `WlmDropdown<T>`, `WlmCombobox<T>`
- `WlmSlider`, `WlmStepper`, `WlmDateField`, `WlmRating`, `WlmPinInput`
- `WlmForm(child, onSubmit)` — minimal form with validation slot

### Display
- `WlmBadge(label, {color})` — tinted ALL-CAPS pill ("BETA")
- `WlmChip(label, {selected, onTap, icon})`
- `WlmPill(label, {background, foreground})` — overlay pill (over images, etc.)
- `WlmTag(label, {onRemove, onTap})`
- `WlmAvatar(initials | imageUrl, {size, shape})`
- `WlmAvatarStack(avatars, max)`
- `WlmSpecRow(label, value)` — key/value list row
- `WlmDivider`, `WlmKbd`, `WlmStat`, `WlmCallout`, `WlmCodeBlock`
- `WlmProgressBar`, `WlmProgressRing`
- `WlmTooltip(message, child)`
- `WlmDataTable`, `WlmTimeline`, `WlmMessageBubble`, `WlmKpiCard`

### Lists
- `WlmListTile`, `WlmActionRow`, `WlmSwitchTile`, `WlmCheckboxTile`, `WlmRadioTile`

### Feedback
- `WlmLoader` — square perimeter scanning loader (signature)
- `WlmScanBar(label, width)` — thin scanning bar
- `WlmSkeleton`, `WlmGridSkeleton`
- `WlmSnack.show(context, message, {actionLabel, onAction})`
- `WlmBanner`, `WlmToaster` / `WlmToast`
- `WlmEmptyState(title, eyebrow, body, icon | illustration, action, secondaryAction)`
- `WlmErrorState(title, body, retry)`
- `WlmRefresh(onRefresh, child)` — typewriter pull-to-refresh

### Overlays
- `showWlmBottomSheet(context, builder, {isScrollControlled})`
- `WlmDialog.confirm(context, title, body, {confirmLabel, cancelLabel, destructive})`
- `WlmDialog.alert(context, title, body, {okLabel})`
- `WlmDialog.custom(context, title, child, {actions})`
- `WlmActionSheet`, `WlmMenu`, `WlmPopover`, `WlmCommandPalette`

### Navigation
- `WlmBottomNav(items, currentIndex, onTap, {compact, compactBreakpoint})`
- `WlmTabBar(tabs, currentIndex, onTap, {scrollable})`
- `WlmStepDots`, `WlmShell`, `WlmPagination`
- `WlmPageRoute.fade / sharedAxis / fadeThrough` — use with `Navigator.push`

### Media
- `WlmNetworkImage(url, {fit, placeholder, errorWidget})` — fade-in + fallback baked in
- `WlmProgressiveImage(thumbUrl, fullUrl)` — thumb → full reveal
- `WlmMasonryGrid(children, columns)` — staggered grid with built-in skeleton hooks

### Primitives
- `WlmFocusable(child, onTap, {ringColor, semanticLabel})` — wrap custom tappable widgets to get on-brand focus rings

### Optional
- `WlmGallery` (in `package:wolwoloom/gallery.dart`) — full live catalog you can drop into any app

---

## Common recipes

### A typical page

```dart
WlmAppScaffold(
  appBar: WlmAppBar(
    title: 'WALLPAPERS',
    actions: [
      WlmHeaderIconButton(icon: WlmIcons.search, onPressed: _openSearch),
    ],
  ),
  body: WlmRefresh(
    onRefresh: _reload,
    child: ListView(
      padding: const EdgeInsets.all(WlmTokens.gutter),
      children: [
        WlmPageHeader(
          eyebrow: 'TODAY',
          title: 'Latest drops',
        ),
        const SizedBox(height: WlmTokens.section),
        WlmMasonryGrid(
          columns: const WlmResponsiveValue<int>(
            compact: 2, medium: 3, expanded: 4, large: 5,
          ).resolve(context),
          children: [
            for (final w in wallpapers)
              WlmNetworkImage(url: w.thumb),
          ],
        ),
      ],
    ),
  ),
);
```

### Confirm before destructive action

```dart
final ok = await WlmDialog.confirm(
  context,
  title: 'DELETE FAVORITE',
  body: 'This cannot be undone.',
  confirmLabel: 'DELETE',
  destructive: true,
);
if (ok ?? false) await _delete();
```

### Snackbar with undo

```dart
WlmSnack.show(
  context,
  'Removed.',
  actionLabel: 'UNDO',
  onAction: _restore,
);
```

### Bottom sheet with handle + rounded top

```dart
showWlmBottomSheet(
  context: context,
  builder: (_) => Padding(
    padding: const EdgeInsets.all(WlmTokens.cardPadding),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WlmActionRow(label: 'SHARE', icon: WlmIcons.share, onTap: _share),
        WlmActionRow(label: 'COPY', icon: WlmIcons.copy, onTap: _copy),
      ],
    ),
  ),
);
```

### Push a detail page with on-brand transition

```dart
Navigator.of(context).push(
  WlmPageRoute.sharedAxis(builder: (_) => DetailPage(item: it)),
);
```

Wrap an image in `Hero(tag: it.id, child: WlmNetworkImage(...))` on
both the source and destination pages for shared-element animation.

### Wrap a custom tappable widget to get focus rings

```dart
WlmFocusable(
  onTap: _open,
  semanticLabel: 'Open settings',
  child: Padding(
    padding: const EdgeInsets.all(WlmTokens.spaceMd),
    child: Row(children: [
      Icon(WlmIcons.settings),
      const SizedBox(width: WlmTokens.spaceSm),
      Text('Settings', style: WlmType.body(scheme.onSurface)),
    ]),
  ),
);
```

---

## Anti-patterns (don't do this)

- ❌ `Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)))`
  → use `WlmTokens.radMd` and the existing surface widgets (`WlmCard`, `WlmSurface`).
- ❌ `EdgeInsets.symmetric(horizontal: 16)` → `EdgeInsets.symmetric(horizontal: WlmTokens.gutter)`.
- ❌ `Duration(milliseconds: 200)` → `WlmMotion.medium`.
- ❌ `Theme.of(context).colorScheme.error` for "danger" semantics → `WlmTheme.of(context).danger`.
- ❌ `Icons.search` filled glyph → `WlmIcons.search` (or `Icons.search_outlined`).
- ❌ Raw `ScaffoldMessenger…showSnackBar(SnackBar(...))` → `WlmSnack.show(context, '...')`.
- ❌ `MaterialPageRoute(builder: ...)` for in-app nav → `WlmPageRoute.sharedAxis(builder: ...)`.
- ❌ `if (MediaQuery.of(context).size.width > 800)` → `WlmBreakpoint.of(context).isDesktop`.
- ❌ Hard-coded `Color(0xFF...)` inside components → token or `colorScheme` lookup.
- ❌ Inventing your own snackbar / dialog wrapper — wloom already
  ships theme-correct ones; the Material defaults will visually leak.

---

## When wloom doesn't have the widget you need

1. Check the components index above twice — the catalog is wider than it looks.
2. If still missing, **build it from `WlmTokens` + `WlmType` + `WlmTheme.of(context)`** so it stays on-brand. Don't reach for raw colors or hex values.
3. Wrap any new tappable in `WlmFocusable` to keep focus rings consistent.
4. If it's reusable, file it as a feature request rather than vendoring per-app.

---

## File map (for quick code search)

```
packages/wolwoloom/lib/
  wolwoloom.dart            # barrel — every public symbol
  gallery.dart              # optional — exports WlmGallery
  src/
    tokens/                 # WlmTokens, WlmColors, WlmType, WlmMotion, WlmIcons, WlmSize, WlmDensity
    theme/                  # WlmTheme.light/.dark + WlmThemeExtension
    utils/                  # WlmBreakpoint, WlmResponsive, WlmResponsiveValue, WlmCenteredColumn, WlmA11y
    navigation/             # WlmPageRoute (factories: fade / sharedAxis / fadeThrough)
    components/
      buttons/              # primary / secondary / ghost / icon / header-icon / fab / generic
      inputs/               # text / search / key / checkbox / radio / segmented / slider / stepper / date / rating / pin / form / dropdown / combobox / toggle
      display/              # badge / chip / pill / tag / avatar(-stack) / divider / spec-row / kbd / stat / callout / code-block / progress(-ring) / tooltip / data-table / timeline / message-bubble / kpi-card
      layout/               # surface / card / page-header / section-label / app-bar / app-scaffold / accordion / breadcrumbs / drawer
      lists/                # list-tile / action-row / switch-tile / checkbox-tile / radio-tile
      feedback/             # loader / scan-bar / skeleton / grid-skeleton / snack-bar / banner / toaster / toast / empty-state / error-state / refresh
      navigation/           # bottom-nav / step-dots / tab-bar / shell / pagination
      overlays/             # bottom-sheet / dialog / popover / menu / command-palette / action-sheet
      media/                # network-image / progressive-image / masonry-grid
      primitives/           # focusable
```
