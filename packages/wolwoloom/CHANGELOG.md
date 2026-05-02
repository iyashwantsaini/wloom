# Changelog

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
