# Onboarding Flow

## Screen 1: Welcome

```
┌─────────────────────────────────┐
│ 9:41                     [Bỏ qua]│
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────────┐         │
│         │   EDUCARE   │         │ Logo large
│         │             │         │
│         │    [📱]     │         │ Illustration
│         └─────────────┘         │
│                                 │
│  Chào mừng đến với Educare!     │
│                                 │
│  Ứng dụng hỗ trợ giáo viên giáo │
│  dục đặc biệt ghi nhật ký và    │
│  theo dõi tiến độ học sinh.     │
│                                 │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ●  ○  ○                   │ │ Page indicator
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │    BẮT ĐẦU →              │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│                                 │
└─────────────────────────────────┘
```

## Screen 2: Features 1 - Easy Logging

```
┌─────────────────────────────────┐
│ 9:41                ← [Bỏ qua] │
├─────────────────────────────────┤
│                                 │
│         ┌─────────────┐         │
│         │             │         │
│         │   [📝✨]    │         │ Illustration
│         │             │         │
│         │  Ghi nhật ký│         │
│         │  dễ dàng    │         │
│         └─────────────┘         │
│                                 │
│  Ghi nhật ký nhanh chóng        │
│                                 │
│  • Tạo buổi học thủ công hoặc  │
│    với AI                       │
│  • Đánh giá mục tiêu học tập    │
│  • Ghi nhận hành vi A-B-C       │
│  • Lưu offline, đồng bộ cloud   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ○  ●  ○                   │ │ Page indicator
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │    TIẾP THEO →            │ │
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]                  │
│                                 │
├─────────────────────────────────┤
│                                 │
└─────────────────────────────────┘
```

## Screen 3: Features 2 - Analytics

```
┌─────────────────────────────────┐
│ 9:41                ← [Bỏ qua] │
├─────────────────────────────────┤
│                                 │
│         ┌─────────────┐         │
│         │             │         │
│         │   [📊📈]    │         │ Illustration
│         │             │         │
│         │  Phân tích  │         │
│         │  chi tiết   │         │
│         └─────────────┘         │
│                                 │
│  Theo dõi tiến độ trực quan     │
│                                 │
│  • Báo cáo thống kê theo tuần   │
│  • Phân tích hành vi A-B-C      │
│  • So sánh nhiều hành vi        │
│  • Xuất PDF chia sẻ phụ huynh   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ○  ○  ●                   │ │ Page indicator
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │    BẮT ĐẦU SỬ DỤNG →     │ │
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]                  │
│                                 │
├─────────────────────────────────┤
│                                 │
└─────────────────────────────────┘
```

## Purpose

Onboarding giới thiệu ứng dụng cho người dùng mới:

- Welcome & value proposition
- Key features showcase
- Quick start

## Components

### Common Elements (All Screens)

- **Skip button**: Top right (except last screen)
- **Back button**: Bottom left (except first screen)
- **Page indicator**: Dots showing progress (●○○)
- **Illustration**: Large, friendly visual
- **Title**: Feature headline
- **Description**: Brief explanation or list
- **CTA**: Primary action button

### Screen Progression

1. **Welcome** (Screen 1)

   - Logo & app name
   - Brief description
   - CTA: "BẮT ĐẦU →"
   - Can skip

2. **Easy Logging** (Screen 2)

   - Logging features
   - 4 bullet points
   - CTA: "TIẾP THEO →"
   - Can go back or skip

3. **Analytics** (Screen 3)
   - Analytics features
   - 4 bullet points
   - CTA: "BẮT ĐẦU SỬ DỤNG →"
   - Can go back or skip

## Interactions

### Gestures

- **Swipe left** = Next screen
- **Swipe right** = Previous screen
- **Tap CTA** = Navigate forward
- **Tap Bỏ qua** = Skip to app
- **Tap ← Quay lại** = Go back

### Navigation Flow

1. Welcome → Features 1 → Features 2 → Dashboard
2. Can skip at any point → Dashboard
3. Back button available (except first screen)

### First-Time Only

- Shows only on first app launch
- Never shown again after completion
- Can be accessed from Settings → Hướng dẫn

## Design Principles

- **Concise**: 3 screens max
- **Visual**: Large illustrations
- **Skippable**: Don't force users
- **Mobile-friendly**: Swipe gestures
- **Clear value**: Each screen highlights benefit
- **Progressive**: Build understanding step by step

## Illustrations

- **Screen 1**: Phone with app interface
- **Screen 2**: Notepad with checkmarks and AI sparkles
- **Screen 3**: Charts and graphs

## Animation

- **Screen transition**: Horizontal slide (300ms)
- **Illustration**: Fade in + scale (400ms)
- **Text**: Fade in with delay (200ms)
- **Page indicator**: Smooth dot animation

## Accessibility

- VoiceOver support for all text
- High contrast illustrations
- Touch targets 44x44pt minimum
- Clear CTAs

## Related Screens

- **After onboarding**: Dashboard (01-dashboard.md)
- **Access from**: Settings (23-settings.md)
