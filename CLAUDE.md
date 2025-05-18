# Jekyll Blog Setup and Style Guide

## Build Commands

- `jekyll serve` - Builds and serves site locally
- `jekyll serve --port 4001` or `just run` - Serves on custom port
- `just hash_css` - Generates MD5 hash for CSS (cache busting)
- `just gen_photo_frontmatter photo` - Generates photo post frontmatter
- `just push` - Git add/commit/push to all remotes

## Code Style Guidelines

- **Markdown**: Use frontmatter with layout, title, date, description, image, tags
- **HTML/Templates**: 2-space indentation, use includes via `{% include file.html %}`
- **CSS**: 2-space indentation, consistent class naming
- **Images**: Reference using `{{ "/path/to/image" | absolute_url }}`
- **JavaScript**: Import via CDN, keep post-specific JS in /static/js/posts/

## Naming Conventions

- Posts: `YYYY-MM-DD-title-slug.md` in `_posts/` directory
- Photos: Same date pattern in `_photos/` directory
- Images: Organize by post in `/static/images/posts/[post-date-slug]/`
- Post URLs: Use descriptive, kebab-case slugs

## Best Practices

- Support dark/light theme with CSS variables and `prefers-color-scheme`
- Use responsive design with appropriate media queries
- Convert JPG to WebP for performance (both formats stored)
- Keep markup semantic and accessible

## Directory Structure

```
.
├── _drafts             # Draft posts not yet published
├── _includes           # Reusable HTML components
├── _layouts            # Page layout templates
├── _photos             # Photo posts with metadata
├── _posts              # Blog posts
├── _site               # Generated site (not tracked in git)
├── archive             # Archive pages
├── static              # Static assets
│   ├── css             # Stylesheets
│   ├── images          # Images
│   │   ├── photos      # Photo gallery images
│   │   └── posts       # Post-specific images
│   └── js              # JavaScript files
│       └── posts       # Post-specific JS
└── unlisted            # Unlisted/private posts
```
