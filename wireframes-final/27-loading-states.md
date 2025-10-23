# Loading States

## 1. Skeleton Loading (Student List)

```
┌─────────────────────────────────┐
│ 9:41          Educare   👤 ⚙️  │
├─────────────────────────────────┤
│                                 │
│  ✨ Xin chào, Cô Mai!           │
│  Hôm nay: T3, 22/10/2025        │
│                                 │
│  📊 Tổng quan nhanh             │
│  ┌──────┬──────┬──────┬──────┐│
│  │ ░░░  │ ░░░  │ ░░░  │ ░░░  ││ Shimmer
│  │ ░░░  │ ░░░  │ ░░░  │ ░░░  ││
│  │ ░░░  │ ░░░  │ ░░░  │ ░░░  ││
│  └──────┴──────┴──────┴──────┘│
│                                 │
│  👥 Danh sách Học sinh          │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ┌─────┐                   │ │
│  │ │░░░░░│  ░░░░░░░░░        │ │ Skeleton
│  │ └─────┘  ░░░░░░░░         │ │
│  │                           │ │
│  │ ░░░░░░░░░░░░░░            │ │
│  │ ░░░░░░░░░░░░              │ │
│  │                           │ │
│  │ ┌────────────────────┐    │ │
│  │ │░░░░░░░░░░░░        │    │ │
│  │ └────────────────────┘    │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ┌─────┐                   │ │
│  │ │░░░░░│  ░░░░░░░░░        │ │
│  │ └─────┘  ░░░░░░░░         │ │
│  │                           │ │
│  │ ░░░░░░░░░░░░░░            │ │
│  │ ░░░░░░░░░░░░              │ │
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## 2. Pull-to-Refresh

```
┌─────────────────────────────────┐
│ 9:41          Educare   👤 ⚙️  │
├─────────────────────────────────┤
│                                 │
│         ┌─────────┐             │
│         │   🔄    │             │ Spinning
│         └─────────┘             │
│                                 │
│  Đang tải dữ liệu mới...        │
│                                 │
│  ✨ Xin chào, Cô Mai!           │
│  Hôm nay: T3, 22/10/2025        │
│                                 │
│  [Rest of content...]           │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## 3. Full-Screen Loading (Initial Load)

```
┌─────────────────────────────────┐
│ 9:41                            │
├─────────────────────────────────┤
│                                 │
│                                 │
│                                 │
│         ┌─────────┐             │
│         │ EDUCARE │             │ Logo
│         └─────────┘             │
│                                 │
│         ┌─────────┐             │
│         │   ⊙     │             │ Spinner
│         └─────────┘             │
│                                 │
│  Đang tải dữ liệu...            │
│                                 │
│                                 │
│                                 │
│                                 │
│                                 │
│                                 │
├─────────────────────────────────┤
│                                 │
└─────────────────────────────────┘
```

## 4. Inline Loading (Button)

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  [Form content...]              │
│                                 │
│  ┌───────────────────────────┐ │
│  │  ⊙  ĐANG TẠO...           │ │ Disabled
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## 5. Progress Bar (AI Processing)

```
┌─────────────────────────────────┐
│ 9:41   ← AI đang xử lý  [✕]    │
├─────────────────────────────────┤
│                                 │
│         ┌─────────┐             │
│         │   🤖    │             │ Animated
│         └─────────┘             │
│                                 │
│  AI đang phân tích giáo án...  │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ████████████░░░░░░  65%   │ │ Progress
│  └───────────────────────────┘ │
│                                 │
│  ✅ Đọc file thành công         │
│  ✅ Trích xuất cấu trúc         │
│  🔄 Phân tích nội dung...       │
│  ⏳ Tạo danh sách buổi học      │
│                                 │
│  ⏱️ Ước tính: ~15 giây          │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## Purpose

Loading states cung cấp phản hồi trực quan khi tải dữ liệu.

## Types

### 1. Skeleton Loading

- **Use**: Initial page load, list loading
- **Animation**: Shimmer effect (left to right)
- **Color**: Light gray gradient
- **Speed**: 1.5s cycle
- **Advantage**: Shows content structure

### 2. Pull-to-Refresh

- **Use**: Manual refresh by user
- **Icon**: Spinning refresh (🔄)
- **Position**: Top of screen
- **Text**: "Đang tải dữ liệu mới..."
- **Duration**: Until data loaded

### 3. Full-Screen Loading

- **Use**: App launch, major transitions
- **Elements**: Logo + Spinner + Text
- **Background**: Brand color or white
- **Centered**: All elements
- **Timeout**: Max 5 seconds

### 4. Inline Loading

- **Use**: Button actions, form submissions
- **State**: Button disabled
- **Icon**: Small spinner
- **Text**: Action in progress ("Đang tạo...")
- **Prevents**: Multiple submissions

### 5. Progress Bar

- **Use**: Long processes (AI, uploads)
- **Type**: Determinate (0-100%)
- **Steps**: Checklist with status icons
- **Time**: Estimated remaining time
- **Cancellable**: Optional cancel button

## Design Principles

- **Immediate feedback**: Show loading within 100ms
- **Skeleton over spinner**: For list/card content
- **Progress indication**: For >3 second waits
- **Cancellation**: Allow cancel for long processes
- **Smooth transitions**: Fade in when loaded
- **Contextual**: Match loading to content type

## Animation Specs

- **Shimmer**: 1.5s linear infinite
- **Spinner**: 1s ease-in-out infinite
- **Fade in**: 300ms when content loads
- **Progress bar**: Smooth transitions between steps

## Related Screens

- All screens can have loading states
- Context-specific implementation
