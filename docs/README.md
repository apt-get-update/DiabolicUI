# DiabolicUI Developer Docs

Published at https://apt-get-update.github.io/DiabolicUI/ by
`.github/workflows/docs.yml` on every push that changes `docs/`.

Built with [Hugo](https://gohugo.io/) and the
[hugo-book](https://github.com/alex-shpak/hugo-book) theme (vendored under
`themes/hugo-book`, no Hugo Modules/Go required). Pages are AsciiDoc: Hugo
needs the `asciidoctor` command (and its `rouge` gem for code colors).

```bash
# serve locally with live reload, from the docs/ folder
hugo server

# or a static build, output goes to docs/public/ (gitignored)
hugo --minify
```

Content lives under `content/docs/*.adoc`; page order is controlled by each
page's `weight` front matter field. Diagrams are Mermaid, in a passthrough
block:

```asciidoc
++++
{{< mermaid >}}
flowchart LR
    a["📜 A"] --> b["⚙️ B"]
{{< /mermaid >}}
++++
```
