# Component Library

## Buttons

### Primary Button

```
Style:
- Background: Primary (#4F46E5)
- Text: White
- Padding: 12px 24px
- Border Radius: 8px
- Height: 48pt
- Font: 16pt Semibold

States:
- Default: Primary background
- Hover: Primary Dark (#3730A3)
- Active: Primary Dark + slight scale (0.98)
- Disabled: Gray 300 background, Gray 400 text
- Loading: Spinner + "Đang xử lý..."

Usage:
- Primary actions (Create, Save, Submit)
- One per screen maximum
- Full width on mobile
```

### Secondary Button

```
Style:
- Background: Transparent
- Border: 2px solid Primary
- Text: Primary
- Padding: 12px 24px
- Border Radius: 8px
- Height: 48pt

Usage:
- Secondary actions (Cancel, Back)
- Alternative to primary
- Can have multiple per screen
```

### Tertiary Button (Text)

```
Style:
- Background: Transparent
- Text: Primary
- No border
- Padding: 8px 16px
- Underline on hover

Usage:
- Low priority actions
- Links, "Learn more"
- Navigation
```

### Icon Button

```
Style:
- Size: 44x44pt minimum
- Icon: 24pt
- Background: Transparent (default)
- Hover: Gray 100 background
- Active: Gray 200 background

Usage:
- More menus (⋮)
- Close buttons (✕)
- Favorites (⭐)
```

### Floating Action Button (FAB)

```
Style:
- Size: 56x56pt
- Icon: 24pt
- Background: Primary
- Shadow: Shadow 3
- Border Radius: Round

Position:
- Bottom right: 16pt from edges
- Above bottom navigation

Usage:
- Primary action (Add student, Create session)
- One per screen
```

## Cards

### Standard Card

```
Style:
- Background: White
- Border: 1px solid Gray 200 (optional)
- Border Radius: 12px
- Padding: 16px
- Shadow: Shadow 2

Variants:
- Flat: No shadow, border only
- Elevated: Shadow 2
- Outlined: Border, no shadow

Usage:
- Student cards
- Session cards
- Content containers
```

### Collapsible Card

```
Components:
- Header (clickable)
- Collapse icon (↕️)
- Content (expandable)

States:
- Collapsed: Header only
- Expanded: Header + Content

Animation:
- Expand/Collapse: 300ms ease-out
- Icon rotation: 150ms

Usage:
- Session detail
- Content with goals
- Long lists
```

### Interactive Card

```
Features:
- Hover state: Slight elevation
- Active state: Scale 0.98
- Ripple effect (Android)

Usage:
- Tappable cards
- Navigation cards
- Selectable items
```

## Forms

### Text Input

```
Style:
- Height: 48pt
- Padding: 12px 16px
- Border: 1px solid Gray 300
- Border Radius: 8px
- Font: 16pt Regular

States:
- Default: Gray border
- Focus: Primary border (2px)
- Error: Error border, error message below
- Disabled: Gray 100 background
- Success: Success border (optional)

Label:
- Above input
- 14pt Medium
- Required indicator: * (red)

Helper Text:
- Below input
- 12pt Regular
- Gray 500 (default), Error (error)
```

### Text Area

```
Style:
- Min Height: 96pt (4 lines)
- Max Height: 192pt (8 lines)
- Scrollable if exceeds max
- Auto-grow enabled

Character Counter:
- Position: Bottom right
- Format: "250/1000"
- Color: Gray 500 (default), Error (exceeded)
```

### Select/Picker

```
Style:
- Same as text input
- Icon: Chevron down (▼)
- Icon position: Right side

Dropdown:
- Max Height: 300pt (scrollable)
- Shadow: Shadow 3
- Border Radius: 8px
- Item Height: 48pt

Usage:
- Date picker
- Time picker
- Dropdown menus
```

### Checkbox

```
Style:
- Size: 20x20pt
- Border: 2px solid Gray 400
- Border Radius: 4px
- Checkmark: Primary

States:
- Unchecked: Empty box
- Checked: Checkmark + Primary background
- Indeterminate: Horizontal line (for parent items)
- Disabled: Gray 200 background

Usage:
- Multi-select lists
- Confirmation checkboxes
- Settings toggles
```

### Radio Button

```
Style:
- Size: 20x20pt circle
- Border: 2px solid Gray 400
- Dot: Primary (8x8pt)

States:
- Unselected: Empty circle
- Selected: Dot + Primary border
- Disabled: Gray 200

Usage:
- Single selection
- Goal assessment (Đạt/Đang học/Chưa)
- Theme selection
```

### Toggle Switch

```
Style:
- Width: 52pt
- Height: 32pt
- Thumb: 28x28pt
- Track: Border Radius round

States:
- Off: Gray 300 track, Gray 500 thumb
- On: Primary track, White thumb
- Disabled: Reduced opacity

Animation:
- Thumb slide: 150ms ease-out
- Track color: 150ms

Usage:
- Settings (notifications)
- Feature flags
- Boolean options
```

### Slider

```
Style:
- Track: 4pt height
- Thumb: 28x28pt circle
- Active thumb: 32x32pt (scale on drag)
- Fill: Primary
- Background: Gray 200

Labels:
- Min/Max: Below track
- Current value: Above thumb (optional)

Usage:
- Attitude rating (5 levels)
- Volume, brightness
- Severity level
```

## Lists

### Basic List

```
Item:
- Height: 56pt (single line), 72pt (two line)
- Padding: 16px
- Divider: 1px Gray 200

Components:
- Leading: Icon or Avatar (40x40pt)
- Title: 16pt Regular
- Subtitle: 14pt Regular, Gray 500
- Trailing: Icon, badge, or action

Usage:
- Student list
- Session list
- Settings
```

### Swipeable List

```
Swipe Actions:
- Swipe left: Destructive (Delete)
- Swipe right: Positive (Archive, Complete)

Action Style:
- Width: 80pt per action
- Icon: 24pt
- Background: Error (delete), Success (complete)
- Text: 12pt (optional)

Animation:
- Swipe threshold: 50pt
- Confirm threshold: 100pt
- Spring back if not confirmed
```

### Drag-and-Drop List

```
Handle:
- Icon: ⋮⋮ (vertical dots)
- Position: Right or left
- Size: 44x44pt touch target

States:
- Dragging: Elevated shadow, slight rotation
- Drop zone: Dashed border highlight
- Placeholder: Gray dashed outline

Usage:
- Reorder content
- Reorder goals
- Priority sorting
```

## Navigation

### Bottom Navigation

```
Style:
- Height: 56pt (+ safe area)
- Background: White
- Shadow: Top shadow
- Border: 1px top Gray 200

Tab Item:
- Width: Equal distribution
- Icon: 24pt
- Label: 12pt
- Padding: 8pt vertical

States:
- Active: Primary color, bold label
- Inactive: Gray 500

Max Tabs: 5 (recommended: 4)

Usage:
- Main navigation (Nhà, Ghi, Báo, Tôi)
- Always visible
- Highlight active screen
```

### Top Navigation Bar

```
Style:
- Height: 44pt (iOS), 56pt (Android) + status bar
- Background: White
- Shadow: Bottom shadow

Components:
- Left: Back button or Menu
- Center: Screen title (18pt Semibold)
- Right: Action buttons (1-2 icons)

Usage:
- Secondary screens
- With back navigation
- Screen title
```

### Tab Bar (Segmented Control)

```
Style:
- Background: Gray 100
- Border Radius: 8px
- Padding: 2px

Tab:
- Padding: 8px 16px
- Border Radius: 6px
- Selected: White background + Shadow 1

Usage:
- Filter tabs (Tất cả, Đang học, Tạm dừng)
- View switchers (Day, Week, Month)
- 2-5 options
```

## Overlays

### Modal

```
Style:
- Background: White
- Border Radius: 16px (top) or 16px (all)
- Padding: 24px
- Max Width: 90% screen width

Backdrop:
- Color: rgba(0, 0, 0, 0.6)
- Blur: 4px (iOS)
- Tap to dismiss: Optional

Animation:
- Open: Scale + Fade (300ms)
- Close: Fade (200ms)

Usage:
- Add content modal
- Confirmation dialogs
- Forms
```

### Bottom Sheet

```
Style:
- Background: White
- Border Radius: 16px (top corners)
- Padding: 24px
- Handle: 4pt x 32pt gray bar (top center)

Heights:
- Small: 30% screen
- Medium: 50% screen
- Large: 90% screen
- Full: 100% - status bar

Gestures:
- Swipe down: Dismiss
- Tap outside: Dismiss (optional)

Usage:
- Create method selector
- ABC behavior entry
- Quick actions
```

### Tooltip

```
Style:
- Background: Gray 800
- Text: White, 14pt
- Padding: 8px 12px
- Border Radius: 6px
- Max Width: 200pt
- Arrow: 8pt triangle

Position:
- Top, Bottom, Left, Right
- Auto-adjust if off-screen

Trigger:
- Hover (desktop)
- Long press (mobile)
- Info icon tap

Auto-dismiss: 3 seconds or tap outside
```

### Toast/Snackbar

```
Style:
- Background: Gray 800
- Text: White, 14pt
- Padding: 12px 16px
- Border Radius: 8px
- Shadow: Shadow 4
- Max Width: 90% screen

Position:
- Top: 16pt from top
- Bottom: 16pt from bottom (+ safe area)

Duration:
- Short: 2 seconds
- Long: 3 seconds
- Action: Until dismissed

Components:
- Message (left)
- Action button (right, optional)
- Close button (optional)

Usage:
- Success messages
- Error messages
- Undo actions
```

## Progress Indicators

### Spinner

```
Style:
- Size: 24pt (small), 32pt (medium), 48pt (large)
- Color: Primary
- Stroke: 3pt

Animation:
- Rotation: 1s linear infinite
- iOS: Native ActivityIndicator
- Android: CircularProgressIndicator

Usage:
- Button loading state
- Content loading
- Full screen loading
```

### Progress Bar

```
Style:
- Height: 4pt (thin), 8pt (thick)
- Border Radius: Round
- Background: Gray 200
- Fill: Primary

Types:
- Determinate: 0-100% known
- Indeterminate: Unknown duration

Animation:
- Determinate: Smooth transition
- Indeterminate: Moving gradient

Usage:
- AI processing
- File upload
- Task completion
```

### Skeleton

```
Style:
- Background: Gray 200
- Border Radius: Match content
- Shimmer: Gray 100 → Gray 300

Animation:
- 1.5s linear infinite
- Left to right gradient

Shapes:
- Text: 16pt height rectangles
- Avatar: Circle (40-80pt)
- Image: Rectangle (match aspect ratio)
- Card: Full card outline

Usage:
- List loading
- Page loading
- Better than spinner for content
```

## Badges

### Status Badge

```
Style:
- Padding: 4px 8px
- Border Radius: 4px
- Font: 12pt Semibold
- Height: 24pt

Variants:
- Success: Green background
- Warning: Amber background
- Error: Red background
- Info: Blue background
- Neutral: Gray background

Usage:
- Session status (✅, 🔄, ⏰, ⚠️)
- User status
- Notification indicators
```

### Count Badge

```
Style:
- Size: 20x20pt (min)
- Background: Error (#EF4444)
- Text: White, 12pt Bold
- Border Radius: Round
- Border: 2px White (if on colored background)

Position:
- Top right of icon
- Offset: -4pt from edges

Max: Display "99+" for values > 99

Usage:
- Notification count
- Unread count
- New items
```

## Charts (Simple)

### Bar Chart

```
Bar:
- Width: Dynamic
- Border Radius: 4pt (top)
- Fill: Primary
- Background: Gray 200

Axes:
- X-axis: Labels below
- Y-axis: Optional grid lines
- Font: 12pt Regular

Interactive:
- Tap bar: Show tooltip
- Tooltip: Value + label

Usage:
- Behavior frequency
- Goal completion
- Time distribution
```

### Line Chart

```
Line:
- Stroke: 2pt
- Color: Primary
- Smooth: Curved (optional)

Points:
- Size: 6pt
- Fill: Primary
- Stroke: 2pt White

Grid:
- Horizontal lines: Gray 200
- Vertical: Optional

Interactive:
- Tap point: Show details
- Pinch: Zoom (optional)

Usage:
- Behavior trends
- Progress over time
- Comparison
```

### Pie/Donut Chart

```
Slice:
- Stroke: 2pt White separator
- Fill: Color coded

Center (Donut):
- Size: 40% of radius
- Text: Total value

Legend:
- Position: Right or bottom
- Color indicator: 12x12pt square

Interactive:
- Tap slice: Highlight + details

Usage:
- Function distribution
- Severity breakdown
- Category proportions
```

## Accessibility

- All interactive elements: 44x44pt minimum
- Color contrast: 4.5:1 for text, 3:1 for UI
- Focus indicators: Visible 2pt ring
- VoiceOver labels: All components
- Dynamic type: Support system font scaling
- Haptic feedback: On important actions
- Error messages: Read by screen reader
