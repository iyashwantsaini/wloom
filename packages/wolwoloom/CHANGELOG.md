# Changelog

## 0.3.3 — polish & branding

* **Catalog** — hero CTA row uses `Wrap` so the WIDGETBOOK ghost button no longer overflows on narrow viewports.
* **Apps** — both showcase apps re-branded: APK label `Wolwoloom` / `Wolwoloom WB`, web titles polished, branded `wlm` launcher icons across all Android density buckets.
* **Tooling** — `scripts/gen_icons.py` now also writes Android `mipmap-*/ic_launcher.png` so a single run covers web + Android for both apps.

## 0.3.2 — docs

* Native-resolution screenshots for catalog (19), demo screens (6) and widgetbook (16) stories.
* Gallery moved to `docs/README.md`; root README points at it.

## 0.3.1 — Timeline / MessageBubble / KpiCard / ActionSheet / Surface

* **Display** — `WlmTimeline`, `WlmMessageBubble`, `WlmKpiCard` (inline sparkline).
* **Layout** — `WlmSurface` modifier (border / radius / shadow / gradient / tap).
* **Overlays** — `WlmActionSheet.show()` (mono editorial bottom sheet).
* **Templates** — six demo screens shipped in the example app: Login, Onboarding, Dashboard, Profile, Settings, Chat. Reachable via `?screen=...` deep link.
* `WlmStat` value text now scales down (FittedBox) instead of overflowing in narrow grids.

## 0.3.0 — unified Wlm­Button + heavy lifters

* **Buttons** — unified `WlmButton(variant + size + loading)` underneath `WlmPrimaryButton` / `WlmSecondaryButton` / `WlmGhostButton`.
* **Overlays** — `WlmToaster` queue, `WlmPopover`, `WlmMenu`, `WlmCommandPalette` (⌘K).
* **Inputs** — `WlmCombobox`, `WlmPinInput`, `WlmToggle`, full `WlmForm` orchestration with validators.
* **Display** — `WlmDataTable`.
* **Navigation** — `WlmPagination`.

## 0.2.0 — components, components, components

* **Theme** — `WlmThemeExtension` registered on every `WlmTheme` for typed access to hairline / muted / accent / success / warning / danger / info colors.
* **Responsive** — `WlmBreakpoint` enum + `WlmResponsive` builder for adaptive layouts.
* **Inputs** — `WlmCheckbox`, `WlmRadio<T>`, `WlmSegmentedControl<T>`, `WlmDropdown<T>`, `WlmSlider`, `WlmStepper`, `WlmDateField`, `WlmRating`.
* **Display** — `WlmAvatar`, `WlmAvatarStack`, `WlmTag`, `WlmKbd`, `WlmStat`, `WlmCallout`, `WlmCodeBlock`, `WlmProgressBar`, `WlmProgressRing`, `WlmTooltip`.
* **Layout** — `WlmAppBar`, `WlmAppScaffold`, `WlmAccordion`, `WlmBreadcrumbs`, `WlmDrawer`.
* **Lists** — `WlmCheckboxTile`, `WlmRadioTile`.
* **Feedback** — `WlmBanner`, `WlmToast` (lightweight overlay), `WlmEmptyState`, `WlmErrorState`.
* **Navigation** — `WlmTabBar`, `WlmShell` (adaptive bottom-nav / NavigationRail).
* **Buttons** — `WlmFab`.
* Widgetbook gallery extended with use cases for every new component.
* Foundational widget tests added.

* **Theme** — `WlmThemeExtension` registered on every `WlmTheme` for typed access to hairline / muted / accent / success / warning / danger / info colors.
* **Responsive** — `WlmBreakpoint` enum + `WlmResponsive` builder for adaptive layouts.
* **Inputs** — `WlmCheckbox`, `WlmRadio<T>`, `WlmSegmentedControl<T>`, `WlmDropdown<T>`, `WlmSlider`, `WlmStepper`, `WlmDateField`, `WlmRating`.
* **Display** — `WlmAvatar`, `WlmAvatarStack`, `WlmTag`, `WlmKbd`, `WlmStat`, `WlmCallout`, `WlmCodeBlock`, `WlmProgressBar`, `WlmProgressRing`, `WlmTooltip`.
* **Layout** — `WlmAppBar`, `WlmAppScaffold`, `WlmAccordion`, `WlmBreadcrumbs`, `WlmDrawer`.
* **Lists** — `WlmCheckboxTile`, `WlmRadioTile`.
* **Feedback** — `WlmBanner`, `WlmToast` (lightweight overlay), `WlmEmptyState`, `WlmErrorState`.
* **Navigation** — `WlmTabBar`, `WlmShell` (adaptive bottom-nav / NavigationRail).
* **Buttons** — `WlmFab`.
* Widgetbook gallery extended with use cases for every new component.
* Foundational widget tests added.

## 0.1.0 — initial release

* Design tokens: spacing, radii, hairline, motion durations.
* Typography: JetBrains Mono helpers (display / h1 / h2 / h3 / body / label / meta / tiny).
* Themes: `WlmTheme.light()` and `WlmTheme.dark()` (Material 3, ink-on-paper palette).
* Buttons: primary, secondary, ghost, icon, header icon.
* Inputs: text field, search field, key field, switch, checkbox.
* Display: badge, chip, pill, spec row, hairline divider.
* Layout: card, elevated card, page header, section label.
* Lists: list tile, action row, switch tile.
* Feedback: square scanning loader, scan bar, skeleton block, grid skeleton, snackbar helper.
* Navigation: bottom nav, step dots.
* Overlays: bottom sheet helper, dialog.
* Media: network image with fallback, progressive image, masonry grid.
