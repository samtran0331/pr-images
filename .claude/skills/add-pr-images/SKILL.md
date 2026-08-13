# Add PR Images to README

Sync `README.md` so it exactly matches the image files on disk — add missing entries, remove stale ones.

## Process

1. **Discover all image files on disk** using `find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \)` run from the repo root. Collect the basenames.

2. **Discover all image filenames referenced in README.md** by grepping for `pr-images/main/` lines. Collect those basenames.

3. **Compute the diff:**
   - **Missing from README** = on disk but not in README → add
   - **Stale in README** = in README but not on disk → remove

4. For each **missing** file, use the Read tool to view it as an image, then derive a short human-friendly display name from the content (not just the filename).

5. **Insert** each missing entry into `README.md` in **alphabetical order by display name**, using this exact format:

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

6. **Remove** each stale entry from `README.md` — delete the `### heading` plus the preview block and code block beneath it.

7. Commit and push to main.
