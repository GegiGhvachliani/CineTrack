# Light / Dark appearance

## Palette

Light Mode uses warm neutral surfaces: `backgroundMain` #F8F6F0,
`backgroundPrimary` #FFFFFF, and `backgroundSecondary` #E3DFD5.
Primary text is #201F1B and secondary text is #656158.
Existing dark background and brand colors are preserved.

- `Brand.primary` / `Brand.primaryPressed`: original gold asset values and color spaces in both appearances.
- `Button.textButton`: original asset values in both appearances.
- `Text.onBrand`: consistently dark text on gold fills, independent of appearance.
- `Text.onImage`: consistently white controls/text over imagery.
- `Media.scrim`: black image shading and modal dimming, independent of appearance.
- `Media.placeholder`: adaptive image-loading and missing-image surfaces.

Light status colors use darker green, amber and red. Dark success/warning
assets previously contained white values and now use green/amber instead.

## UI changes

Search, Profile and VideosList now use adaptive backgrounds. Biography,
playlist and profile text no longer assumes a dark background. Shared image
placeholders, Home search, authentication/onboarding buttons, selected search
filters, and the tab bar use the asset-backed semantic colors.

Gold-filled controls use `Text.onBrand`, not `Text.inverse`: an inverse text
color would become white on a light gold button. Gold text and actions retain
the original Brand and TextButton colors, as requested.

Image-overlay text stays white with dark shading where needed. The embedded
YouTube player deliberately retains a black HTML/native canvas: it is video
content, not the surrounding adaptive application surface. System semantic
styles such as `.secondary` remain adaptive and need no fixed-color replacement.

No tests were added or changed. Simulator visual inspection is still needed
for both appearances, including loaded images and larger accessibility text.
