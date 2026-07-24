# Add PR Images to README

You are helping add new image files to the `README.md` in the `pr-images` repo.

## Process

1. Run `git status` to identify untracked `.jpg`/`.png`/`.jpeg` image files not yet in the README.

2. For each new image file, use the Read tool to view it as an image so you understand its content.

3. Derive a short, human-friendly display name from the image content (not just the filename).

4. Insert each new image into `README.md` in **alphabetical order by display name**, using this exact format:

```
### display name
<p align="center">
  <img src="https://raw.githubusercontent.com/samtran0331/pr-images/main/FILENAME" width="450">
</p>

\```
<p align="center">
  <img src="https://raw.githubusercontent.com/samtran0331/pr-images/main/FILENAME" width="450">
</p>
\```
```

Replace `FILENAME` with the actual file name (e.g. `pr-gandalf.jpg`).

5. Also remove any entries whose image file no longer exists in the repo (check with `git status` for deleted files).

6. Commit and push to main.
