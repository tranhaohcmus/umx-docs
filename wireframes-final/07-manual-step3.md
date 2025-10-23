# Tạo thủ công - Step 3 (Review)

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 3/3: Xem lại & Xác nhận  │
│                                 │
│  ✅ Tổng quan                   │
│  ┌───────────────────────────┐ │
│  │ 📅 Thứ Ba, 22/10/2025     │ │
│  │ ⏰ Buổi sáng (8:00-11:30) │ │
│  │ 📚 2 nội dung dạy học     │ │
│  │ 🎯 Tổng 7 mục tiêu        │ │
│  └───────────────────────────┘ │
│                                 │
│  📋 Chi tiết nội dung          │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 1. Phân biệt màu sắc   ↓  │ │
│  │    🧠 Nhận thức           │ │
│  │                           │ │
│  │ Mục tiêu:                 │ │
│  │ • Gọi tên màu đỏ          │ │
│  │ • Nhận diện màu xanh      │ │
│  │ • Phân biệt 2 màu         │ │
│  │                           │ │
│  │ [Sửa]                     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 2. Hoạt động vận động  ↓  │ │
│  │    🏃 Vận động            │ │
│  │                           │ │
│  │ Mục tiêu:                 │ │
│  │ • Chạy thẳng 10m          │ │
│  │ • Nhảy tại chỗ 5 lần      │ │
│  │ • Bắt bóng bằng 2 tay     │ │
│  │ • Ném bóng vào rổ         │ │
│  │                           │ │
│  │ [Sửa]                     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │  💾 TẠO BUỔI HỌC          │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]                  │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Step 3 hiển thị tổng quan buổi học để xem lại trước khi tạo.

## Components

### Overview Card

- Date, time, session
- Content count
- Total goals

### Content Details

- Collapsible content cards
- Show all goals
- Edit button per content

### CTA

- Create session button
- Back button

## Interactions

- **Tap content card** = Expand/collapse
- **Tap Sửa** = Go back to Step 2
- **Tap ← Quay lại** = Go to Step 2
- **Tap TẠO BUỔI HỌC** = Create session

## Success Flow

1. Create session
2. Show success state
3. Navigate to session detail

## Related Screens

- **Previous**: 05-manual-step2.md
- **Success**: 27-success-states.md
