# CLAUDE.md - Repository Guidelines

## Build Commands
- Run site locally: `jekyll serve` or `jekyll serve --port 4001`
- Using justfile: `just run` (runs on port 4001)
- Generate photo frontmatter: `just gen_photo_frontmatter <filename>`
- Generate CSS hash: `just hash_css` (paste output into default.html)
- Commit and push to all remotes: `just push`

## Image Handling
- Convert JPG to WebP: `cwebp -q 75 <input.jpg> -o <output.webp>`
- Bulk convert JPGs: `find ./ -type f -name '*.jpg' -exec sh -c 'cwebp -q 75 "$1" -o "${1%.jpg}.webp"' _ {} \;`
- Extract photo metadata: `exiftool <image> -S -Title -ImageWidth -ImageHeight -Make -Model -FNumber -ExposureTime -ISO -LensID -Keywords -DateTimeOriginal -d "%Y-%m-%d %H:%M:%S"`

## Code Style
- Jekyll-based static site with GitHub Pages integration
- Maintain consistent frontmatter format in posts and photos
- Follow existing HTML/CSS conventions
- File structure: posts in `_posts/`, photos in `_photos/`, static assets in `static/`
- Use relative URLs with `absolute_url` filter

## Python Notebooks
- Convert to markdown: `jupyter nbconvert --to markdown <notebook.ipynb>`
- Move images to `static/images/posts/` directory
- Update image links with `absolute_url` directive