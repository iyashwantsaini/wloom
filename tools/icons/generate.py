"""Generate the wolwoloom app/favicon mark in editorial monospace style.

Outputs:
  tools/icons/wlm-mark-1024.png   — square master (light bg)
  tools/icons/wlm-mark-1024-dark.png — dark bg variant

The mark: ALL-CAPS "wlm" set in JetBrains Mono, with a hairline
border and a small "v0" caret at the bottom-right — feels like a
masthead clipping rather than a typical app icon.
"""

from PIL import Image, ImageDraw, ImageFont
import os, sys

SIZE = 1024
HAIRLINE = 12         # ~1px at 96px exported size
PADDING = 80
RADIUS = 160
ACCENT = (107, 105, 224)   # periwinkle

INK_LIGHT = (15, 15, 18)
PAPER_LIGHT = (245, 244, 240)
INK_DARK = (235, 234, 230)
PAPER_DARK = (10, 10, 12)


def find_mono_font(size):
    candidates = [
        r"C:\Windows\Fonts\consola.ttf",
        r"C:\Windows\Fonts\CascadiaCode.ttf",
        r"C:\Windows\Fonts\CascadiaMono.ttf",
        r"C:\Windows\Fonts\cour.ttf",
    ]
    for p in candidates:
        if os.path.exists(p):
            return ImageFont.truetype(p, size)
    return ImageFont.load_default()


def draw_mark(paper, ink, accent, hairline_alpha=200):
    img = Image.new("RGBA", (SIZE, SIZE), paper + (255,))
    d = ImageDraw.Draw(img)

    # Outer hairline border (just inside the square, with rounded corners)
    border_color = ink + (hairline_alpha,)
    d.rounded_rectangle(
        [(PADDING, PADDING), (SIZE - PADDING, SIZE - PADDING)],
        radius=RADIUS,
        outline=border_color,
        width=HAIRLINE,
    )

    # Top-left eyebrow: "WOLWOLOOM"
    eyebrow_font = find_mono_font(48)
    d.text(
        (PADDING + 56, PADDING + 56),
        "WOLWOLOOM",
        font=eyebrow_font,
        fill=ink + (180,),
        spacing=8,
    )

    # Centerpiece: lowercase "wlm" big
    big_font = find_mono_font(420)
    text = "wlm"
    bbox = d.textbbox((0, 0), text, font=big_font)
    w = bbox[2] - bbox[0]
    h = bbox[3] - bbox[1]
    x = (SIZE - w) // 2 - bbox[0]
    y = (SIZE - h) // 2 - bbox[1] + 40
    d.text((x, y), text, font=big_font, fill=ink + (255,))

    # Accent square (the "ink dot") top-right
    sq = 96
    sx = SIZE - PADDING - 56 - sq
    sy = PADDING + 56
    d.rectangle([(sx, sy), (sx + sq, sy + sq)], fill=accent + (255,))

    # Bottom caption
    cap_font = find_mono_font(46)
    cap = "v0.3 · MIT"
    cbbox = d.textbbox((0, 0), cap, font=cap_font)
    cw = cbbox[2] - cbbox[0]
    d.text(
        ((SIZE - cw) // 2, SIZE - PADDING - 56 - 46),
        cap,
        font=cap_font,
        fill=ink + (160,),
    )

    return img


def maskable(paper, ink, accent):
    """Maskable variant: same mark but on a full-bleed paper square so
    Android's adaptive masks don't crop the hairline border."""
    img = Image.new("RGBA", (SIZE, SIZE), paper + (255,))
    d = ImageDraw.Draw(img)
    big_font = find_mono_font(360)
    text = "wlm"
    bbox = d.textbbox((0, 0), text, font=big_font)
    w = bbox[2] - bbox[0]
    h = bbox[3] - bbox[1]
    x = (SIZE - w) // 2 - bbox[0]
    y = (SIZE - h) // 2 - bbox[1]
    d.text((x, y), text, font=big_font, fill=ink + (255,))
    # tiny accent square to top-right safe zone
    sq = 80
    d.rectangle(
        [(SIZE * 0.78 - sq // 2, SIZE * 0.22 - sq // 2),
         (SIZE * 0.78 + sq // 2, SIZE * 0.22 + sq // 2)],
        fill=accent + (255,),
    )
    return img


OUT = os.path.join(os.path.dirname(__file__), "out")
os.makedirs(OUT, exist_ok=True)

light = draw_mark(PAPER_LIGHT, INK_LIGHT, ACCENT)
dark = draw_mark(PAPER_DARK, INK_DARK, ACCENT)
m_light = maskable(PAPER_LIGHT, INK_LIGHT, ACCENT)
m_dark = maskable(PAPER_DARK, INK_DARK, ACCENT)

light.save(os.path.join(OUT, "wlm-1024.png"))
dark.save(os.path.join(OUT, "wlm-1024-dark.png"))
m_light.save(os.path.join(OUT, "wlm-maskable-1024.png"))
m_dark.save(os.path.join(OUT, "wlm-maskable-1024-dark.png"))

# Common web/PWA sizes
for size in (16, 32, 48, 64, 96, 128, 192, 256, 384, 512):
    light.resize((size, size), Image.LANCZOS).save(
        os.path.join(OUT, f"wlm-{size}.png"))
    m_light.resize((size, size), Image.LANCZOS).save(
        os.path.join(OUT, f"wlm-maskable-{size}.png"))

# Multi-res favicon.ico
ico_imgs = [light.resize((s, s), Image.LANCZOS) for s in (16, 32, 48, 64)]
ico_imgs[0].save(
    os.path.join(OUT, "favicon.ico"),
    format="ICO",
    sizes=[(16, 16), (32, 32), (48, 48), (64, 64)],
)

print("Wrote icons to", OUT)
