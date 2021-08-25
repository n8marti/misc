### Convert SVG to Windows ICO

```bash
# Option 1
convert -background none icon.svg -define icon:auto-resize icon.ico

# Option 2
$ inkscape -w 16 -h 16 -e 16.png icon.svg
$ inkscape -w 32 -h 32 -e 16.png icon.svg
$ inkscape -w 48 -h 48 -e 16.png icon.svg
$ convert 16.png 32.png 48.png icon.ico # imagemagick

# Verification
$ identify icon.ico
# ...output...
```
