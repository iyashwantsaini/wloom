"""Generate wolwoloom editorial icon set: 'wlm' lockup on ink with periwinkle accent."""
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

INK = (16, 16, 18, 255)
PAPER = (245, 244, 240, 255)
ACCENT = (140, 137, 200, 255)
HAIRLINE = (60, 60, 65, 255)
DIMMED = (170, 170, 175, 255)

MONO_BOLD = "C:/Windows/Fonts/consolab.ttf"
MONO = "C:/Windows/Fonts/consola.ttf"


def _font(path: str, size: int) -> ImageFont.ImageFont:
    try:
        return ImageFont.truetype(path, size)
    except OSError:
        return ImageFont.load_default()


def draw_icon(size: int, *, maskable: bool = False) -> Image.Image:
    img = Image.new("RGBA", (size, size), INK)
    d = ImageDraw.Draw(img)

    pad = int(size * (0.18 if maskable else 0.08))
    inner_w = size - 2 * pad

    if not maskable and size >= 48:
        d.rectangle(
            [pad, pad, size - pad - 1, size - pad - 1],
            outline=HAIRLINE,
            width=max(1, size // 128),
        )

    if size >= 64:
        s = max(4, int(size * 0.06))
        margin = pad + max(4, int(size * 0.04))
        d.rectangle(
            [size - margin - s, margin, size - margin, margin + s],
            fill=ACCENT,
        )

    if size >= 128:
        eyebrow_size = max(8, int(size * 0.045))
        f_eye = _font(MONO, eyebrow_size)
        d.text(
            (pad + max(4, int(size * 0.03)), pad + max(4, int(size * 0.03))),
            "WOLWOLOOM",
            fill=DIMMED,
            font=f_eye,
        )

    big_size = int(inner_w * (0.42 if size >= 128 else 0.55))
    f_big = _font(MONO_BOLD, big_size)
    text = "wlm"
    bbox = d.textbbox((0, 0), text, font=f_big)
    tw = bbox[2] - bbox[0]
    th = bbox[3] - bbox[1]
    tx = (size - tw) / 2 - bbox[0]
    ty = (size - th) / 2 - bbox[1]
    d.text((tx, ty), text, fill=PAPER, font=f_big)

    if size >= 128:
        cap_size = max(8, int(size * 0.045))
        f_cap = _font(MONO, cap_size)
        cap = "v0.3 \u00b7 MIT"
        cbbox = d.textbbox((0, 0), cap, font=f_cap)
        cw = cbbox[2] - cbbox[0]
        cx = (size - cw) / 2 - cbbox[0]
        cy = size - pad - cap_size - max(4, int(size * 0.025))
        d.text((cx, cy), cap, fill=DIMMED, font=f_cap)

    return img


def write_set(out_dir: Path):
    out_dir.mkdir(parents=True, exist_ok=True)
    icons_dir = out_dir / "icons"
    icons_dir.mkdir(exist_ok=True)

    draw_icon(64).save(out_dir / "favicon.png")

    for size in (192, 512):
        draw_icon(size).save(icons_dir / f"Icon-{size}.png")
        draw_icon(size, maskable=True).save(
            icons_dir / f"Icon-maskable-{size}.png"
        )

    print(f"wrote icon set to {out_dir}")


if __name__ == "__main__":
    import sys
    targets = sys.argv[1:] or [
        "packages/wolwoloom/example/web",
        "apps/widgetbook/web",
    ]
    for t in targets:
        write_set(Path(t))
