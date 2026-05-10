<p align="center"><img src="screenshots/wlm-icon.png" alt="wloom" width="120" /></p>

# wloom · screenshot gallery

Visual reference for the **wloom** showcase app, demo templates, and the **wloom wb** widgetbook gallery. Captured against the live builds — every shot is reproducible from `main` using [`SKILL.md`](screenshots/SKILL.md).

* Live web gallery (wloom wb) → <https://iyashwantsaini.github.io/wloom/>
* `wloom` APK + `wloom wb` APK → [latest release](https://github.com/iyashwantsaini/wloom/releases/latest)
* Source for screens → [packages/wolwoloom/example/lib/screens](../packages/wolwoloom/example/lib/screens)

---

## wloom — home & component categories

| | |
| :---: | :---: |
| <img src="screenshots/catalog-home-dark.png" width="360"/><br/><sub>wloom · dark</sub> | <img src="screenshots/catalog-home-light.png" width="360"/><br/><sub>wloom · light</sub> |
| <img src="screenshots/page-foundations.png" width="360"/><br/><sub>Foundations</sub> | <img src="screenshots/page-buttons.png" width="360"/><br/><sub>Buttons</sub> |
| <img src="screenshots/page-inputs.png" width="360"/><br/><sub>Inputs</sub> | <img src="screenshots/page-forms.png" width="360"/><br/><sub>Forms</sub> |
| <img src="screenshots/page-display.png" width="360"/><br/><sub>Display</sub> | <img src="screenshots/page-layout.png" width="360"/><br/><sub>Layout</sub> |
| <img src="screenshots/page-lists.png" width="360"/><br/><sub>Lists</sub> | <img src="screenshots/page-feedback.png" width="360"/><br/><sub>Feedback</sub> |
| <img src="screenshots/page-navigation.png" width="360"/><br/><sub>Navigation</sub> | <img src="screenshots/page-overlays.png" width="360"/><br/><sub>Overlays</sub> |
| <img src="screenshots/page-media.png" width="360"/><br/><sub>Media</sub> | |

## Demo screens — drop-in templates built from the kit

| | | |
| :---: | :---: | :---: |
| <img src="screenshots/screen-login.png" width="280"/><br/><sub>Login</sub> | <img src="screenshots/screen-onboarding.png" width="280"/><br/><sub>Onboarding</sub> | <img src="screenshots/screen-dashboard.png" width="280"/><br/><sub>Dashboard</sub> |
| <img src="screenshots/screen-profile.png" width="280"/><br/><sub>Profile</sub> | <img src="screenshots/screen-settings.png" width="280"/><br/><sub>Settings</sub> | <img src="screenshots/screen-chat.png" width="280"/><br/><sub>Chat</sub> |

Each screen is built **only** from public `Wlm*` widgets (`WlmAppScaffold`, `WlmTextField`, `WlmKpiCard`, `WlmTimeline`, `WlmMessageBubble`, `WlmActionSheet`, `WlmSurface`, …). Drop them into your app verbatim or pull pieces.

## wloom wb — interactive gallery with knobs, themes, and viewport switching

| | |
| :---: | :---: |
| <img src="screenshots/wb-foundations-typography.png" width="480"/><br/><sub>Typography</sub> | <img src="screenshots/wb-foundations-palette.png" width="480"/><br/><sub>Palette</sub> |
| <img src="screenshots/wb-foundations-spacing.png" width="480"/><br/><sub>Spacing tokens</sub> | <img src="screenshots/wb-foundations-radii.png" width="480"/><br/><sub>Radii tokens</sub> |
| <img src="screenshots/wb-buttons.png" width="480"/><br/><sub>Buttons</sub> | <img src="screenshots/wb-inputs.png" width="480"/><br/><sub>Inputs</sub> |
| <img src="screenshots/wb-kpi-card.png" width="480"/><br/><sub>KPI card</sub> | <img src="screenshots/wb-timeline.png" width="480"/><br/><sub>Timeline</sub> |
| <img src="screenshots/wb-message-bubble.png" width="480"/><br/><sub>Message bubble</sub> | <img src="screenshots/wb-data-table.png" width="480"/><br/><sub>Data table</sub> |
| <img src="screenshots/wb-layout-surface.png" width="480"/><br/><sub>Surface</sub> | <img src="screenshots/wb-layout-card.png" width="480"/><br/><sub>Card</sub> |
| <img src="screenshots/wb-lists.png" width="480"/><br/><sub>Lists</sub> | <img src="screenshots/wb-feedback.png" width="480"/><br/><sub>Feedback</sub> |
| <img src="screenshots/wb-navigation.png" width="480"/><br/><sub>Navigation</sub> | <img src="screenshots/wb-action-sheet.png" width="480"/><br/><sub>Action sheet</sub> |

---

### How these were captured

Full agent-runnable recipe: [`screenshots/SKILL.md`](screenshots/SKILL.md).

* **wloom** — `flutter build web --release` then served via `python -m http.server 8765`. Each route is reachable as `?screen=<demo>` or `?page=<category>`.
* **wloom wb** — `flutter build web --release --base-href /wloom/`, served on `:8766`. Stories addressed via `#/?path=<category>/<component>/<usecase>`.
* All shots taken at the live browser viewport (no fake mobile frames, no upscaling).
