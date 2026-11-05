# Optional local fonts

Put custom `.ttf` or `.otf` font files here only if their licenses permit redistribution.

Local compilation and GitHub Actions both pass `--font-path font` to Typst.

The Touying University theme uses fonts available in the Typst environment by default. If you want a custom font, configure it with `#set text(font: "Font Name")` in the shared presentation setup, and ensure the same font files are available in CI.

Do not commit font files unless you have permission to distribute them.
