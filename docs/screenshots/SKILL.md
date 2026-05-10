# Skill: Refresh wloom screenshots

> **Source:** [github.com/iyashwantsaini/WolwoLoom](https://github.com/iyashwantsaini/WolwoLoom) — this skill lives at [`docs/screenshots/SKILL.md`](./SKILL.md).

A repeatable, agent-runnable recipe for capturing the screenshot grid in [`docs/screenshots/`](.) for **both apps** in this repo, in **both themes**:

| App | Where it lives | Display name | Screenshots prefix |
| --- | --- | --- | --- |
| **wloom** (showcase) | [`packages/wolwoloom/example`](../../packages/wolwoloom/example) | `wloom` | `catalog-*`, `page-*`, `screen-*` |
| **wloom wb** (widgetbook) | [`apps/widgetbook`](../../apps/widgetbook) | `wloom wb` | `wb-*` |

Use this whenever the UI changes meaningfully (new pages, restyled components, theme tweaks, design-system bumps, etc.).

---

## Outputs

```
docs/screenshots/
├── catalog-home-{dark,light}.png            # wloom homepage
├── page-{foundations,buttons,inputs,forms,
│        display,layout,lists,feedback,
│        navigation,overlays,media}.png      # wloom category pages
├── screen-{login,onboarding,dashboard,
│           profile,settings,chat}.png       # wloom demo templates
└── wb-*.png                                  # wloom wb stories
```

All shots use the same viewport so README rows line up.

---

## Pre-flight

1. `cd c:\repos\WolwoLoom\packages\wolwoloom; flutter analyze --no-fatal-infos` is clean.
2. `flutter test` is green.
3. No uncommitted UI work you don't want frozen into the shots.
4. Python 3 on PATH (used to serve the built web bundles).

---

## Recipe

### 1. Build both web bundles (release)

```pwsh
# wloom (showcase)
cd c:\repos\WolwoLoom\packages\wolwoloom\example
flutter build web --release

# wloom wb (widgetbook) — for LOCAL screenshot capture, omit --base-href.
# Re-add --base-href /wloom/ ONLY for the GitHub Pages publish.
cd c:\repos\WolwoLoom\apps\widgetbook
flutter build web --release
```

### 2. Serve each on a fixed port

Open two terminals (or run as background jobs):

```pwsh
# Terminal A — wloom on :8765
cd c:\repos\WolwoLoom\packages\wolwoloom\example\build\web
python -m http.server 8765

# Terminal B — wloom wb on :8766
cd c:\repos\WolwoLoom\apps\widgetbook\build\web
python -m http.server 8766
```

Both must stay running for the full capture pass.

### 3. Probe the actual viewport FIRST (do not trust setViewportSize)

The VS Code embedded browser ignores `page.setViewportSize`, so the rendered
canvas is whatever the chat panel is sized to (commonly 1051 × 1257 on a
1440-wide window). If you screenshot blindly with a hard-coded `1280 × 900`
clip, you'll get **whitespace on the right** for every shot.

**Always do this first** before capturing anything:

```js
await page.goto('http://127.0.0.1:8765/?theme=dark', { waitUntil: 'load' });
await page.waitForTimeout(2000);
const sz = await page.evaluate(() => ({
  w: window.innerWidth,
  h: window.innerHeight,
  dpr: window.devicePixelRatio,
}));
console.log(sz); // e.g. { w: 1051, h: 1257, dpr: 1 }
```

Use `{ x: 0, y: 0, width: sz.w, height: Math.min(sz.h, 900) }` as the **clip**
on every `page.screenshot` call so each PNG fills the canvas edge-to-edge with
a consistent ~900 px tall hero. Re-probe `sz` once per pass — the viewport is
stable across navigations within a session.

### 4. Capture wloom (showcase) routes

The showcase app exposes deep-links via query string. The router reads them in [`packages/wolwoloom/example/lib/main.dart`](../../packages/wolwoloom/example/lib/main.dart):

| Param | Values |
| --- | --- |
| `?theme=` | `dark` · `light` · `system` |
| `?page=` | `foundations` · `buttons` · `inputs` · `forms` · `display` · `layout` · `lists` · `feedback` · `navigation` · `overlays` · `media` |
| `?screen=` | `login` · `onboarding` · `dashboard` · `profile` · `settings` · `chat` |

```js
const base = 'http://127.0.0.1:8765';
const dir  = 'c:/repos/WolwoLoom/docs/screenshots/';

async function shot(url, file) {
  await page.goto(url, { waitUntil: 'load' });
  await page.waitForTimeout(2400);                       // Flutter web settle
  const sz = await page.evaluate(() => ({ w: window.innerWidth, h: window.innerHeight }));
  await page.screenshot({
    path: dir + file,
    clip: { x: 0, y: 0, width: sz.w, height: Math.min(sz.h, 900) },
  });
}

for (const theme of ['dark', 'light']) {
  await shot(`${base}/?theme=${theme}`, `catalog-home-${theme}.png`);
}

// category pages (single theme — dark)
const pages = ['foundations','buttons','inputs','forms','display',
               'layout','lists','feedback','navigation','overlays','media'];
for (const p of pages) await shot(`${base}/?theme=dark&page=${p}`, `page-${p}.png`);

// demo screens
const screens = ['login','onboarding','dashboard','profile','settings','chat'];
for (const s of screens) await shot(`${base}/?theme=dark&screen=${s}`, `screen-${s}.png`);
```

> **Note** — the first navigation per session triggers a slow Flutter web cold boot. Bump `waitForTimeout` to `8000` for the very first call if shots come out blank.

### 5. Capture wloom wb (widgetbook) stories

Widgetbook addresses stories via `#/?path=<category>/<component>/<usecase>`:

```js
const wb = 'http://127.0.0.1:8766/';   // local build — no /wloom/ prefix

const stories = {
  'wb-foundations-typography': 'foundations/typography/all-styles',
  'wb-foundations-palette':    'foundations/palette/scheme-swatches',
  'wb-foundations-spacing':    'foundations/tokens/spacing',
  'wb-foundations-radii':      'foundations/tokens/radii',
  'wb-buttons':                'buttons/primary/default',
  'wb-inputs':                 'inputs/text-field/default',
  'wb-kpi-card':               'display/kpi-card/default',
  'wb-timeline':               'display/timeline/default',
  'wb-message-bubble':         'display/message-bubble/default',
  'wb-data-table':             'display/data-table/default',
  'wb-layout-surface':         'layout/surface/default',
  'wb-layout-card':            'layout/card/default',
  'wb-lists':                  'lists/list-tile/default',
  'wb-feedback':               'feedback/snackbar/default',
  'wb-navigation':             'navigation/bottom-nav/default',
  'wb-action-sheet':           'overlays/action-sheet/default',
};

for (const [file, path] of Object.entries(stories)) {
  await page.goto(`${wb}#/?path=${path}`, { waitUntil: 'load' });
  await page.waitForTimeout(2800);
  const sz = await page.evaluate(() => ({ w: window.innerWidth, h: window.innerHeight }));
  await page.screenshot({
    path: `c:/repos/WolwoLoom/docs/screenshots/${file}.png`,
    clip: { x: 0, y: 0, width: sz.w, height: Math.min(sz.h, 900) },
  });
}
```

If a `path=` value 404s in the addressbar, open the widgetbook nav and copy the slug from the URL — they may have been renamed.

### 6. Verify

```pwsh
Get-ChildItem c:\repos\WolwoLoom\docs\screenshots -Filter *.png |
  Select-Object Name, Length |
  Sort-Object Length
```

Sanity-check:

- Every file is **> 8 KB**. Smaller = blank/loading frame — re-capture with a longer `waitForTimeout`.
- Both `catalog-home-dark.png` and `catalog-home-light.png` exist and have matching dimensions.
- Open one of each theme and confirm surface colour matches.

### 7. Tear down

```pwsh
# Stop both python -m http.server processes (Ctrl-C in each terminal).
```

---

## Common pitfalls

| Symptom | Cause | Fix |
| --- | --- | --- |
| **Whitespace on the right** of every PNG | Used a hard-coded `{ width: 1280 }` clip but the embedded VS Code browser is narrower | Probe `window.innerWidth` first (Step 3) and clip to it on every shot |
| `setViewportSize` had no effect | The VS Code embedded Playwright surface ignores it | Don't rely on it — read `window.innerWidth/innerHeight` and clip instead |
| Widgetbook 404 (`/wloom/`) | The bundle was built with `--base-href /wloom/` (for GitHub Pages) but served from `/` locally | Rebuild without `--base-href` for local capture, or serve from a path that matches the base-href |
| Blank/white PNG | Captured before Flutter finished booting after navigation | Wait 6–8 s after the very first `goto`, longer on cold boot |
| Theme didn't change | Forgot `?theme=light` in the URL | Re-include the query param every navigation; the showcase reads `Uri.base.queryParameters` once at startup so a hash-only change won't repaint the theme |
| Wrong screen rendered | Missed `?screen=` vs `?page=` | `screen` = full demo template (login/dashboard/…); `page` = component category page |
| Widgetbook 404 | Story path was renamed | Browse the gallery manually, copy the new `?path=` slug |
| `goto` throws Timeout | `waitUntil: 'load'` waits on slow assets | Use `waitUntil: 'commit'` + manual `waitForTimeout` |
| Port already in use | Previous run left `python -m http.server` running | `Get-NetTCPConnection -LocalPort 8765` then `Stop-Process` the owning PID |

---

## Routes reference

### wloom (showcase) — `?page=` values

| Slug | Page |
| --- | --- |
| `foundations` | Tokens, palette, type, motion |
| `buttons` | Primary / secondary / ghost / icon / fab |
| `inputs` | Text / search / key / segmented / slider / stepper / etc. |
| `forms` | Composed form patterns |
| `display` | Badge / chip / pill / spec-row / kpi / timeline / message bubble / etc. |
| `layout` | Surface / card / page header / scaffold / accordion / breadcrumbs |
| `lists` | List tile / action row / switch / checkbox / radio tiles |
| `feedback` | Loader / scan-bar / skeleton / snack / toast / banner / empty / error |
| `navigation` | Bottom nav / tabs / step dots / shell / pagination |
| `overlays` | Bottom sheet / dialog / popover / menu / command palette / action sheet |
| `media` | Network image / progressive image / masonry grid |

### wloom (showcase) — `?screen=` values

| Slug | Demo template |
| --- | --- |
| `login` | Login / sign-up |
| `onboarding` | Multi-step onboarding |
| `dashboard` | KPI dashboard |
| `profile` | User profile |
| `settings` | Settings page |
| `chat` | Chat / message bubbles |

---

## When to update this skill

- A new top-level showcase route is added → extend `pages` / `screens` arrays in §4.
- A new widgetbook story is added → extend the `stories` map in §5.
- The router base href changes → update §1 + §5.
- Default theme flips → update README copy and the priority of files in the grid table.
