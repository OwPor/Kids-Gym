# PlaySpace Website Plan

## Goal
One-page marketing site supporting the trial submission: present PlaySpace, mirror the app's look, and give reviewers a big **Download APK** button. No backend — same as the app.

## Stack Decision
**Static HTML + self-hosted Tailwind CSS v3** (compiled, committed — zero CDN dependencies).
- Why: free hosting anywhere (GitHub Pages / Netlify / Vercel), instant load, utility classes keep styling consistent, no runtime build.
- Toolchain (local only, NOT committed): Tailwind standalone CLI v3.4.19 (`tailwindcss-windows-x64.exe`, kept outside the repo) compiles `src/input.css` → `assets/tailwind.css` using `tailwind.config.js` (brand tokens: coral/navy/golden/mint/cream/coralLight, Nunito).
- Regen command (repo root): `tailwindcss-windows-x64.exe -i src/input.css -o assets/tailwind.css --minify`
- Rejected: Tailwind Play CDN (runtime dependency, violates self-hosted rule), Flutter web build (heavy, awkward landing page), React/Vite (overkill for one page).

## Design System (mirrors the app)
- Font: Nunito (Google Fonts CDN, system-ui fallback), weights 400/600/700/800.
- Colors: Coral `#FF6B4A` (primary/CTA), Navy `#1E293B` (text, footer), Golden `#FFD166` (accents/badges), Mint `#06D6A0` (checkmarks), Background `#F8F9FA`, Surface `#FFFFFF`.
- Shape language: 16–24px rounded cards, pill badges, soft shadows — same as app cards.
- Voice: playful, parent-focused ("Book a class in 30 seconds").

## Sections (single page, top to bottom)
1. **Sticky nav** — logo, links (Features, How it works, Pricing, FAQ), Download button.
2. **Hero** — headline + subcopy, Download APK + See Features CTAs, phone mockup with home-screen screenshot, small stat chips (e.g. "6 class types", "QR check-in").
3. **Trust strip** — 3–4 one-liners (certified coaches, padded floors, waiver built-in).
4. **Features grid** — 6 cards mapping 1:1 to app tabs/features: Book a Session, QR Check-In, Kids Profiles, E-Waiver, Memberships, Notifications.
5. **How it works** — 3 steps: Create account → Sign waiver → Book & tap to check in.
6. **Screenshots** — 3–4 real captures (Home, Booking, Check-In QR with code redacted/blurred, Kids).
7. **Pricing** — the 3 mock tiers verbatim from the app (Drop-In $25, Monthly $89 popular, Family $149).
8. **FAQ** — 4–5 items (ages, waiver validity, refunds demo-note, what to bring).
9. **Download CTA band** — coral background, APK button + version string.
10. **Footer** — demo contact (support@playspace.com, (555) 987-6543), "Demo project" note, copyright.

## Assets Needed
- Screenshots: run app in Edge, capture at mobile width (~390px). Blur QR payload before publishing.
- APK: attach to a GitHub release, link the asset URL from both Download buttons.
- Favicon + logo: inline SVG (coral circle + white "P"), no external files.

## Branch & Hosting Strategy
- **`website` branch** (created, uncommitted): site lives at branch **root** so GitHub Pages serves it directly. App code on `main` is untouched.
- GitHub Pages setup: repo Settings → Pages → Deploy from branch → `website` / root.
- `.nojekyll` at root disables Jekyll processing so all assets serve as-is.
- `main.js` dropped — vanilla JS wasn't needed; interactions (if any) will be inline.

## File Structure (branch root)
```
index.html
assets/
  tailwind.css     (generated, committed — never hand-edit, regen via CLI)
  shot-home.png  shot-booking.png  shot-checkin.png  shot-kids.png
  favicon.svg
.nojekyll
tailwind.config.js  (brand tokens — committed)
src/input.css       (tailwind directives — committed)
```

## Build Phases
- [ ] 1. Scaffold + tokens (layout shell, CSS variables, responsive grid).
- [ ] 2. All 10 sections with final copy.
- [ ] 3. Responsive pass (390px / 768px / 1200px) + polish (hover states, reveal-on-scroll).
- [ ] 4. Capture screenshots, wire APK links, favicon.
- [ ] 5. Deploy to GitHub Pages, smoke-test on phone + desktop.
- [ ] 6. Link site URL + APK in trial submission.

## Acceptance Criteria
- Renders correctly at 390px and 1440px, no horizontal scroll.
- Both Download buttons fetch the APK (correct version).
- No console errors; images lazy-loaded.
- Visual match: a reviewer flipping between app and site sees one brand.

## Open Questions
- Hosting: GitHub Pages (needs repo) vs Netlify Drop (drag-and-drop, fastest)?
- Copy: invent gym details (address/hours) or keep everything generic-demo?
- Screenshots in light mode, dark mode, or one of each?
