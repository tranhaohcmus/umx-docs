# 9. Màn hình Nhật ký Buổi học

```
┌─────────────────────────────────────────┐
│  ← Nhật ký - Bé An              💾  ⋮  │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 📅 Thứ Hai, 22/10/2025         │   │
│  │ ⏰ Buổi sáng                   │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📊 Nội dung Dạy học (3/5 hoàn thành)  │
│  ▓▓▓▓▓▓░░░░ 60%                        │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ✅ 1. Phân biệt màu sắc        │   │
│  │ Hoàn thành lúc: 09:15          │   │
│  │ [Xem chi tiết]                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ✅ 2. Kỹ năng vận động tinh    │   │
│  │ Hoàn thành lúc: 10:00          │   │
│  │ [Xem chi tiết]                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ✅ 3. Nhận biết cảm xúc        │   │
│  │ Hoàn thành lúc: 10:30          │   │
│  │ [Xem chi tiết]                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⭕ 4. Hoạt động nhóm            │   │
│  │ Nhấn để ghi nhận               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⭕ 5. Ôn tập và đánh giá        │   │
│  │ Nhấn để ghi nhận               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  [+ Thêm nội dung mới]                 │
│                                         │
│  [Hoàn tất Buổi học]                   │
│                                         │
└─────────────────────────────────────────┘
```

## Mục đích

- Ghi nhật ký các nội dung trong buổi học
- Theo dõi tiến độ hoàn thành
- Truy cập form chi tiết để đánh giá

## Components

- **Session Info**: Ngày, buổi học
- **Progress Bar**: % nội dung đã hoàn thành
- **Content Cards**:
  - ✅ Completed: Hiển thị thời gian hoàn thành
  - ⭕ Pending: Nhấn để ghi nhận
- **Add Content Button**
- **Complete Session Button**

## Interactions

- Tap content card (pending) → Open content detail form
- Tap "Xem chi tiết" (completed) → View/edit content detail
- Tap "+ Thêm nội dung mới" → Add new content
- Tap "Hoàn tất Buổi học" → Complete and save session
