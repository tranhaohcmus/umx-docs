# Design Specifications

## Colors

### Primary Palette

```
Primary (Indigo):    #4F46E5
Primary Light:       #818CF8
Primary Dark:        #3730A3
Primary Background:  #EEF2FF
```

### Secondary Palette

```
Secondary (Green):   #10B981
Secondary Light:     #34D399
Secondary Dark:      #059669
Secondary Background: #D1FAE5
```

### Semantic Colors

```
Error:      #EF4444
Warning:    #F59E0B
Success:    #10B981
Info:       #3B82F6
```

### Neutral Colors

```
Gray 50:    #F9FAFB
Gray 100:   #F3F4F6
Gray 200:   #E5E7EB
Gray 300:   #D1D5DB
Gray 400:   #9CA3AF
Gray 500:   #6B7280
Gray 600:   #4B5563
Gray 700:   #374151
Gray 800:   #1F2937
Gray 900:   #111827
```

### Text Colors

```
Primary Text:    #111827 (Gray 900)
Secondary Text:  #6B7280 (Gray 500)
Disabled Text:   #9CA3AF (Gray 400)
Placeholder:     #D1D5DB (Gray 300)
```

### Background Colors

```
Background:         #FFFFFF
Background Alt:     #F9FAFB (Gray 50)
Surface:            #FFFFFF
Surface Elevated:   #FFFFFF (with shadow)
Overlay:            rgba(0, 0, 0, 0.6)
```

## Typography

### Font Family

```
Primary:  SF Pro (iOS) / Roboto (Android)
Monospace: SF Mono / Roboto Mono
```

### Font Sizes

```
Heading 1:  24pt / 32px (Bold)
Heading 2:  20pt / 28px (Bold)
Heading 3:  18pt / 24px (Semibold)
Body Large: 18pt / 24px (Regular)
Body:       16pt / 22px (Regular)
Body Small: 14pt / 20px (Regular)
Caption:    12pt / 16px (Regular)
Overline:   10pt / 14px (Semibold, Uppercase)
```

### Font Weights

```
Regular:    400
Medium:     500
Semibold:   600
Bold:       700
```

### Line Heights

```
Heading:    1.2 (120%)
Body:       1.5 (150%)
Caption:    1.4 (140%)
```

## Spacing

### Spacing Scale

```
XXS:  2px
XS:   4px
S:    8px
M:    16px
L:    24px
XL:   32px
XXL:  48px
XXXL: 64px
```

### Component Spacing

```
Card Padding:        16px
Button Padding:      12px 24px
Input Padding:       12px 16px
Modal Padding:       24px
Screen Padding:      16px
Section Gap:         24px
Item Gap:            12px
```

## Border Radius

```
Small:   4px   (Tags, badges)
Medium:  8px   (Buttons, inputs)
Large:   12px  (Cards)
XLarge:  16px  (Modals, sheets)
Round:   9999px (Pills, avatars)
```

## Shadows

### iOS Style (Soft)

```
Shadow 1 (Subtle):
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05)

Shadow 2 (Card):
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1),
              0 1px 2px rgba(0, 0, 0, 0.06)

Shadow 3 (Elevated):
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07),
              0 2px 4px rgba(0, 0, 0, 0.06)

Shadow 4 (Modal):
  box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1),
              0 4px 6px rgba(0, 0, 0, 0.05)

Shadow 5 (Large):
  box-shadow: 0 20px 25px rgba(0, 0, 0, 0.1),
              0 10px 10px rgba(0, 0, 0, 0.04)
```

## Touch Targets

```
Minimum Size:     44x44pt (iOS) / 48x48dp (Android)
Button Height:    48pt
Input Height:     48pt
Icon Size:        24pt (default), 20pt (small), 32pt (large)
Avatar:           40pt (small), 60pt (medium), 80pt (large), 100pt (xlarge)
```

## Animation Timing

### Duration

```
Fast:       150ms   (Micro-interactions, hover)
Normal:     300ms   (Standard transitions)
Slow:       500ms   (Complex animations, modals)
Very Slow:  800ms   (Page transitions)
```

### Easing Functions

```
Ease Out:     cubic-bezier(0, 0, 0.2, 1)      // Decelerate
Ease In:      cubic-bezier(0.4, 0, 1, 1)      // Accelerate
Ease In Out:  cubic-bezier(0.4, 0, 0.2, 1)    // Accelerate-Decelerate
Spring:       cubic-bezier(0.34, 1.56, 0.64, 1) // Bounce
```

### Common Animations

```
Fade In/Out:     opacity 300ms ease-out
Slide Up:        transform 300ms ease-out
Scale:           transform 150ms ease-out
Shimmer:         1.5s linear infinite
```

## Icons

### Size Scale

```
Small:    16px
Default:  24px
Large:    32px
XLarge:   48px
```

### Style

```
Line weight:  2px (default)
Corner:       Rounded
Fill:         Outline (default), Filled (selected state)
```

### Usage

```
Navigation:   24px
Buttons:      20px (with text), 24px (icon only)
List items:   24px
Avatars:      Icon size = Avatar size / 2
```

## Grid & Layout

### Screen Breakpoints

```
Mobile S:     320px   (iPhone SE)
Mobile M:     375px   (iPhone 13/14)
Mobile L:     414px   (iPhone 13 Pro Max)
Tablet:       768px   (iPad)
Tablet L:     1024px  (iPad Pro)
```

### Grid System

```
Columns:      12 (tablet+), 4 (mobile)
Gutter:       16px
Margin:       16px (mobile), 24px (tablet+)
Max Width:    1200px (desktop)
```

### Safe Areas

```
iOS Notch:       Top 44pt, Bottom 34pt
Android Status:  Top 24dp
Bottom Nav:      Bottom 56pt (mobile), 64pt (tablet)
```

## Z-Index Layers

```
Base:           0     (Default content)
Dropdown:       1000  (Dropdowns, tooltips)
Sticky:         1100  (Sticky headers)
Fixed:          1200  (Fixed navigation)
Modal Backdrop: 1300  (Modal overlay)
Modal:          1400  (Modal content)
Popover:        1500  (Popovers, menus)
Toast:          1600  (Notifications, toasts)
Tooltip:        1700  (Tooltips)
```

## Accessibility

### Contrast Ratios (WCAG AA)

```
Normal Text:      4.5:1 minimum
Large Text:       3:1 minimum
UI Components:    3:1 minimum
```

### Focus States

```
Focus Ring:       2px solid Primary (#4F46E5)
Focus Offset:     2px
Focus Opacity:    100%
```

### Touch Targets

```
Minimum:          44x44pt (iOS), 48x48dp (Android)
Recommended:      48x48pt minimum
Spacing:          8pt minimum between targets
```

## Dark Mode (Optional)

### Colors

```
Background:       #000000
Surface:          #1C1C1E
Surface Elevated: #2C2C2E
Text Primary:     #FFFFFF
Text Secondary:   #98989D
Border:           #38383A
```

### Adjustments

```
Reduce contrast slightly for comfort
Increase elevation shadows
Reduce white to prevent glare
```

## Platform-Specific

### iOS

```
Navigation Bar:   44pt height
Tab Bar:          49pt height (+ safe area)
Search Bar:       36pt height
List Separator:   0.5pt
Corner Radius:    10pt (system)
```

### Android

```
App Bar:          56dp height
Bottom Nav:       56dp height
FAB:              56x56dp
List Divider:     1dp
Corner Radius:    4dp (small), 8dp (medium)
```

## Implementation Notes

- Use design tokens for consistency
- Support dynamic type (iOS) / font scaling (Android)
- Test with different system font sizes
- Ensure 3:1 contrast for UI elements
- Support dark mode where appropriate
- Use native components when possible
- Follow platform-specific guidelines (HIG for iOS, Material for Android)
