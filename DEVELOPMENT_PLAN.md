# Children's Gym & Play Space — Development Plan

## Overview

A polished Flutter mobile app demo for a children's gym/play space. The goal is to demonstrate core features, clean UI/UX, and publishable builds (Android APK + optional TestFlight) within a tight timeline.

---

## Scope — What We're Building

### Core Screens

| Screen | What It Shows |
|---|---|
| **Splash & Onboarding** | Brand intro, sign-up / login (email + social auth UI). |
| **Home Dashboard** | Quick check-in button, upcoming bookings, membership status. |
| **Booking Calendar** | `table_calendar` widget showing available slots for open play & classes. |
| **Class/Slot Detail** | Time, age group, capacity bar, book button. |
| **Check-In QR Code** | Dynamic QR displayed on tap, ready for front-desk scanning. |
| **Child Profiles** | Add/view child (name, DOB, allergies) — form + list. |
| **Digital Waiver** | In-app signature pad, accept & sign flow. |
| **Membership / Passes** | Simple plan cards (drop-in, monthly), Stripe-ready UI. |
| **Settings / Profile** | Parent info, logout. |

### What We're NOT Building (Time Savers)

- Real backend — use mock data / local state.
- Real payment processing — UI only, Stripe integration placeholder.
- Staff-side portal.
- Loyalty program, in-app store, party booking (Phase 2+).
- Push notifications.

---

## Tech Stack

| Layer | Choice |
|---|---|
| **Framework** | Flutter 3.x |
| **State Management** | `flutter_riverpod` |
| **Routing** | `go_router` |
| **UI/Styling** | `velocity_x` + `google_fonts` |
| **Calendar** | `table_calendar` |
| **QR Code** | `qr_flutter` |
| **Icons** | `font_awesome_flutter` |
| **Backend (mock)** | Local JSON / Riverpod state (Supabase-ready architecture) |

---

## UI/UX Approach

- **Style:** Clean, playful, kid-friendly — rounded corners, soft pastels, bold typography.
- **Navigation:** Bottom nav bar (Home, Book, Check-In, Profiles, Settings).
- **Key Interaction:** Prominent "Check-In" button on home — one tap to QR code.
- **Design System:** Consistent spacing, color tokens, reusable components.

---

## Color Palette

| Role | Hex | Usage |
|---|---|---|
| **Coral (Primary)** | `#FF6B4A` | Buttons, CTAs, highlights. |
| **Golden Yellow (Accent)** | `#FFD166` | Badges, stars, highlights. |
| **Mint Green (Success)** | `#06D6A0` | Confirmed states, active membership. |
| **Dark Navy (Text)** | `#1E293B` | Headers, body text. |
| **Background** | `#F8F9FA` | App background. |
| **Surface** | `#FFFFFF` | Cards, modals. |
| **Error** | `#EF4444` | Alerts, form errors. |
| **Muted Text** | `#94A3B8` | Secondary labels, placeholders. |

Light tints derived at runtime using `withValues(alpha: 0.1)`.

**Typography:** Nunito or Poppins (Google Fonts).

---

## Deliverables

1. **Flutter source code** — clean, well-structured, documented.
2. **Android APK** — installable build.
3. **(Optional) iOS TestFlight** — if Mac available.
4. **(Optional) Landing page** — single-page marketing site for the app.

---

## Out of Scope

- Real backend/database integration.
- Real payment processing.
- Staff/admin dashboard.
- Advanced features (waitlists, parties, loyalty, etc.).
