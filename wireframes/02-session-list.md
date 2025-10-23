# 2. Chọn Buổi học (Session List)

```
┌─────────────────────────────────────────┐
│  ← Buổi học - Bé An             📅  ➕ │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  📅 Tuần 42, Tháng 10/2025  ◀ ▶│   │
│  │  ───────────────────────────── │   │
│  │  MO  TU  WE  TH  FR  SA  SU   │   │
│  │  21● 22● 23○ 24○ 25⚠ 26  27  │   │
│  │                                 │   │
│  │  ← Swipe để xem tuần khác →    │   │
│  │                                 │   │
│  │  • = Đã ghi  ○ = Chưa ghi      │   │
│  │  ⚠ = Quá hạn                   │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📅 Thứ Hai, 22/10/2025                │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ✅ Buổi sáng (8:00-11:00)      │   │
│  │ 5/5 nội dung đã hoàn thành     │   │
│  │ Đã ghi lúc: 11:30              │   │
│  │ [Xem chi tiết →]               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 📝 Buổi chiều (14:00-16:30)    │   │
│  │ 2/4 nội dung đã ghi            │   │
│  │ Đang ghi...                    │   │
│  │ [Tiếp tục ghi →]               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📅 Thứ Ba, 23/10/2025                 │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⏰ Buổi sáng (8:00-11:00)      │   │
│  │ Đã lên lịch • 5 nội dung       │   │
│  │ Chưa bắt đầu ghi               │   │
│  │ [Bắt đầu ghi →]                │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📅 Thứ Tư, 21/10/2025 (Hôm qua)      │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⚠️ Buổi sáng (8:00-11:00)      │   │
│  │ QUÊN GHI - Chưa có nhật ký     │   │
│  │ [Ghi bổ sung →]                │   │
│  └─────────────────────────────────┘   │
│                                         │
│         [➕ Tạo buổi học mới]          │
│                                         │
└─────────────────────────────────────────┘
```

## Mục đích

- Hiển thị buổi học theo tuần
- Phân biệt trạng thái: Đã ghi / Chưa ghi / Quá hạn
- Cho phép tạo buổi học mới (thủ công hoặc AI)

## Components

- **Weekly Calendar**: Hiển thị 7 ngày với indicators, swipe left/right
- **Session Cards**: 4 trạng thái (Completed, In Progress, Scheduled, Overdue)
- **Create Button**: Mở modal chọn phương thức

## Interactions

- **Swipe calendar trái/phải** → Load tuần trước/sau
- **Tap ◀ ▶** → Chuyển tuần
- Tap ngày → Scroll to session
- Tap "➕ Tạo buổi học mới" → Open choose method modal
