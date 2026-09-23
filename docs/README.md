# DiabolicUI Developer Docs

Built with [Hugo](https://gohugo.io/) and the
[hugo-book](https://github.com/alex-shpak/hugo-book) theme (vendored under
`themes/hugo-book`, no Hugo Modules/Go required).

```bash
# serve locally with live reload, from the docs/ folder
hugo server

# or a static build, output goes to docs/public/ (gitignored)
hugo --minify
```

Content lives under `content/docs/*.md`; page order is controlled by each
page's `weight` front matter field.
