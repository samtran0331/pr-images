# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A collection of PR meme images hosted on GitHub. The raw URLs are shared as GitHub PR/issue comments using the HTML snippet format so images render inline.

## README format

Each image entry in `README.md` follows this exact pattern, sorted **alphabetically by display name**:

```markdown
### display name
<p align="center">
  <img src="https://raw.githubusercontent.com/samtran0331/pr-images/main/FILENAME" width="300">
</p>

```
<p align="center">
  <img src="https://raw.githubusercontent.com/samtran0331/pr-images/main/FILENAME" width="300">
</p>
```
```

The preview and code block use identical HTML — the code block is what users copy to paste into a PR comment.

## Adding new images

Use the `/add-pr-images` skill — it handles viewing images, deriving display names, and inserting entries in alphabetical order. If not available, manually: view each new image file, pick a short descriptive display name, insert in sorted order using the format above. Remove README entries for any deleted image files.
