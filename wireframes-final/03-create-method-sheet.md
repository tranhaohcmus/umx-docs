# Bottom Sheet - Chọn phương thức tạo

## Wireframe

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│                                 │
│     ┌───────────────────────┐   │
│     │ ──                    │   │ Handle
│     │                       │   │
│     │ Tạo buổi học mới      │   │ 20pt Bold
│     │                       │   │
│     │ ┌─────────────────┐   │   │
│     │ │  ✍️             │   │   │
│     │ │  Tạo thủ công   │   │   │
│     │ │                 │   │   │
│     │ │  Nhập từng bước │   │   │
│     │ │  chi tiết       │   │   │
│     │ │                 │   │   │
│     │ │  [Chọn →]       │   │   │
│     │ └─────────────────┘   │   │
│     │                       │   │
│     │ ┌─────────────────┐   │   │
│     │ │  🤖             │   │   │
│     │ │  Tạo với AI     │   │   │
│     │ │                 │   │   │
│     │ │  Upload giáo án │   │   │
│     │ │  AI tự phân tích│   │   │
│     │ │                 │   │   │
│     │ │  [Chọn →]       │   │   │
│     │ └─────────────────┘   │   │
│     │                       │   │
│     │ [Hủy]                 │   │
│     │                       │   │
│     └───────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## Purpose

Bottom sheet modal cho phép giáo viên chọn phương thức tạo buổi học:

1. **Tạo thủ công**: Nhập từng bước chi tiết
2. **Tạo với AI**: Upload giáo án, AI tự động phân tích

Sheet này xuất hiện khi tap vào nút "➕ TẠO BUỔI HỌC MỚI" từ Student Detail hoặc Dashboard.

## Components

### Handle

- **Drag handle**: "──" (visual indicator for swipe)
- Positioned at top center

### Header

- **Title**: "Tạo buổi học mới" (20pt Bold)
- Centered alignment

### Method 1: Manual Creation

- **Icon**: ✍️ (Large, centered)
- **Title**: "Tạo thủ công" (18pt Semibold)
- **Description**: "Nhập từng bước chi tiết" (14pt Regular, gray)
- **CTA button**: "[Chọn →]" (Primary style)
- **Card style**: White background, rounded corners, shadow

### Method 2: AI Creation

- **Icon**: 🤖 (Large, centered)
- **Title**: "Tạo với AI" (18pt Semibold)
- **Description**: "Upload giáo án\nAI tự phân tích" (14pt Regular, gray)
- **CTA button**: "[Chọn →]" (Primary style)
- **Card style**: White background, rounded corners, shadow
- **Badge**: "✨ Mới" (optional, top-right corner)

### Cancel Button

- **Text**: "Hủy" (16pt Regular)
- **Style**: Text button, centered
- **Color**: Gray/Secondary

### Background

- **Dim overlay**: 60% black opacity
- **Blur effect**: 4px (optional for iOS)

## Interactions

### Gestures

- **Swipe down on handle** = Close sheet
- **Tap outside (background)** = Close sheet
- **Tap "Tạo thủ công"** = Navigate to Manual Step 1
- **Tap "Tạo với AI"** = Navigate to AI Upload screen
- **Tap "Hủy"** = Close sheet

### Animation

- **Open**: Slide up from bottom (300ms ease-out)
- **Close**: Slide down (300ms ease-in)
- **Background dim**: Fade in/out (200ms)

### Navigation

- **Manual option** → Manual Step 1 (Basic Info)
- **AI option** → AI Upload screen
- **Cancel/Outside tap** → Dismiss sheet, return to previous screen

### States

- **Default**: Both options enabled
- **AI disabled** (if offline): Show "⚠️ Cần kết nối internet" under AI option
- **Loading**: Show spinner if pre-loading data

## Validation Rules

- Must select one option or dismiss
- AI option requires internet connection
- Both options require student to be selected (if coming from Dashboard)

## Notes

- **Modal behavior**: Blocks interaction with background
- **Keyboard handling**: Dismisses keyboard if open
- **Safe area**: Respects bottom safe area on iPhone X+
- **Height**: Auto-adjusts to content (~60% of screen height)
- **Backdrop**: Tap to dismiss
- **Accessibility**:
  - VoiceOver support for both options
  - Escape key to dismiss (keyboard support)
  - Focus trap within sheet
- **Analytics**: Track which method is chosen more frequently
- **A/B Testing**: Test different descriptions or icon styles

## Related Screens

- **Previous**: Student Detail, Dashboard
- **Next (Manual)**: 04-manual-step1.md
- **Next (AI)**: 08-ai-upload.md
