---
name: Bharat AI Enterprise
colors:
  surface: '#f8f9fa'
  surface-dim: '#d9dadb'
  surface-bright: '#f8f9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f5'
  surface-container: '#edeeef'
  surface-container-high: '#e7e8e9'
  surface-container-highest: '#e1e3e4'
  on-surface: '#191c1d'
  on-surface-variant: '#44474e'
  inverse-surface: '#2e3132'
  inverse-on-surface: '#f0f1f2'
  outline: '#74777f'
  outline-variant: '#c4c6cf'
  surface-tint: '#465f88'
  primary: '#000a1e'
  on-primary: '#ffffff'
  primary-container: '#002147'
  on-primary-container: '#708ab5'
  inverse-primary: '#aec7f6'
  secondary: '#904d00'
  on-secondary: '#ffffff'
  secondary-container: '#fd8b00'
  on-secondary-container: '#603100'
  tertiary: '#000d0d'
  on-tertiary: '#ffffff'
  tertiary-container: '#002626'
  on-tertiary-container: '#2f9696'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d6e3ff'
  primary-fixed-dim: '#aec7f6'
  on-primary-fixed: '#001b3d'
  on-primary-fixed-variant: '#2d476f'
  secondary-fixed: '#ffdcc3'
  secondary-fixed-dim: '#ffb77d'
  on-secondary-fixed: '#2f1500'
  on-secondary-fixed-variant: '#6e3900'
  tertiary-fixed: '#93f2f2'
  tertiary-fixed-dim: '#76d6d5'
  on-tertiary-fixed: '#002020'
  on-tertiary-fixed-variant: '#004f4f'
  background: '#f8f9fa'
  on-background: '#191c1d'
  surface-variant: '#e1e3e4'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -1px
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.5px
  label-sm:
    fontFamily: Inter
    fontSize: 10px
    fontWeight: '500'
    lineHeight: 14px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  container-margin: 24px
  gutter: 16px
  card-padding: 20px
  section-gap: 32px
---

## Brand & Style

This design system is engineered for a premium SaaS ERP experience tailored to the Indian MSME (Micro, Small, and Medium Enterprises) sector. The aesthetic balances the rigorous structural requirements of an ERP with the forward-thinking intelligence of AI integration.

The style is rooted in **Modern Corporate** principles with influences from **Material Design 3**. It prioritizes extreme clarity, data density management, and a professional "Enterprise-Grade" feel. The emotional goal is to evoke feelings of stability, technological advancement, and local reliability. The interface uses a clean, expansive white-space strategy to ensure that complex financial and operational data remains approachable and easy to scan.

## Colors

The palette is anchored by **Deep Navy Blue**, representing the core strength and institutional trust required for business management. **Vibrant Orange** is used sparingly as a high-intent accent for primary actions and brand highlights.

- **Primary Deep Navy:** Used for navigation sidebars, primary headers, and high-level structural elements.
- **Accent Orange:** Reserved for "Call to Action" buttons, focus states, and key notifications.
- **GST Teal/Green:** A dedicated success color specifically for compliance-related indicators and positive financial status.
- **Amber Warning:** Used for pending payments and ledger discrepancies.
- **AI Special:** AI-driven insights and automated features are distinguished by a subtle gradient or a soft blue/orange glow to differentiate machine-generated content from manual entries.
- **Background:** A very soft gray (#F8F9FA) reduces eye strain during long hours of data entry compared to pure white.

## Typography

The design system utilizes **Inter** for its exceptional legibility in data-heavy environments. The typeface is systematic and utilitarian, ensuring that numbers and financial figures are clear at small sizes.

Hierarchy is established through weight rather than dramatic size shifts to maintain density. **Medium (500)** and **Semi-Bold (600)** weights are used for headers and interactive labels to provide a "grounded" professional feel. For mobile views, typography scales down slightly to accommodate narrower horizontal space while maintaining touch-target legibility.

## Layout & Spacing

The layout follows a **Fluid Grid** model with a max-width container for ultra-wide displays (1440px). 

- **Desktop:** A 12-column grid with 16px gutters and 24px outer margins. The sidebar is fixed at 280px for high-level navigation.
- **Tablet:** Transitions to an 8-column grid. The sidebar collapses into a rail or hamburger menu.
- **Mobile:** A 4-column grid with 16px margins. 

Spacing follows an 8px base unit. Data tables utilize a "Compact" vertical rhythm (variable padding) to maximize information visibility, while dashboard views utilize "Comfortable" spacing (24px+) to allow for strategic analysis.

## Elevation & Depth

Visual hierarchy is achieved through **Tonal Layering** and **Ambient Shadows**. 

1. **Level 0 (Background):** The soft-gray base layer.
2. **Level 1 (Cards/Surfaces):** Pure white surfaces with a very subtle, diffused shadow (Blur: 8px, Y: 2px, Opacity: 4%, Color: Navy). This creates a "lifted" feel without overwhelming the user.
3. **Level 2 (Active/Hover):** Increased shadow depth (Blur: 16px, Y: 4px, Opacity: 8%) to indicate interactivity.
4. **AI Layers:** AI-generated panels or modals use a subtle 1px border with a soft orange-to-blue gradient to denote "Assistant" status.

Avoid heavy black shadows; instead, tint shadows with the Primary Navy color to keep the UI clean and integrated.

## Shapes

The design system uses a **Rounded** shape language to soften the industrial nature of ERP software.

- **Standard Cards:** 16px corner radius (`rounded-lg`) to provide a premium, modern SaaS feel.
- **Buttons & Inputs:** 8px corner radius for a professional balance.
- **Chips/Status Tags:** Fully pill-shaped (100px radius) to distinguish them from interactive buttons.
- **AI Tooltips:** 12px radius to match the card language but feel distinct in size.

## Components

### Buttons
- **Primary:** Solid Deep Navy with white text.
- **Secondary:** White background, 1.5px Deep Navy border.
- **Urgent/CTA:** Solid Vibrant Orange with white text.
- **AI Suggestion:** Navy background with a subtle orange outer glow.

### Input Fields
- **Default:** 8px radius, light gray border (#E0E4E8). On focus, border changes to Deep Navy with a 2px stroke.
- **Validation:** Clear Teal (Success) or Amber (Warning) bottom borders for quick visual status checks.

### Cards
- Always 16px radius.
- Must include a consistent 20px internal padding.
- Section headers within cards should use a bottom hairline divider (0.5px).

### Chips (Status Indicators)
- **GST Compliant:** Teal background (10% opacity) with dark teal text.
- **Pending Payment:** Amber background (10% opacity) with dark amber text.
- **Overdue:** Soft Red background (10% opacity) with dark red text.

### Data Tables
- Row hover states use a subtle #F1F3F5 tint.
- Right-aligned numerical columns for financial accuracy.
- Sticky headers for long ledger scrolling.