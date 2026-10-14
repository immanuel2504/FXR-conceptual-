from __future__ import annotations

import argparse
from pathlib import Path

import pypdfium2 as pdfium


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("pdf", type=Path)
    parser.add_argument("output_dir", type=Path)
    parser.add_argument("--dpi", type=int, default=144)
    args = parser.parse_args()

    args.output_dir.mkdir(parents=True, exist_ok=True)
    document = pdfium.PdfDocument(args.pdf)
    scale = args.dpi / 72.0
    for index in range(len(document)):
        image = document[index].render(scale=scale).to_pil()
        image.save(args.output_dir / f"page-{index + 1:03d}.png")
    print(f"pages={len(document)}")


if __name__ == "__main__":
    main()
