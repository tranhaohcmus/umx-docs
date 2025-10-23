# 7. Screen: AI Preview

```
┌─────────────────────────────────────────┐
│  ← Kết quả phân tích AI                │
├─────────────────────────────────────────┤
│                                         │
│  ✨ AI đã tạo 12 buổi học cho bạn      │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 📅 Thứ Hai, 22/10/2025     ^   │   │
│  │ ⏰ Buổi sáng • 8:00-11:00       │   │
│  │ ──────────────────────────────  │   │
│  │ Nội dung (3):                   │   │
│  │                                 │   │
│  │ 1. Ai đây? (Nhận biết bản thân)│   │
│  │    Mục tiêu:                    │   │
│  │    1.1. Nhận biết tên của mình │   │
│  │    1.2. Trỏ vào ảnh bản thân   │   │
│  │    1.3. Phản ứng khi được gọi  │   │
│  │                                 │   │
│  │ 2. Hoạt động vận động           │   │
│  │    Mục tiêu:                    │   │
│  │    2.1. Chạy thẳng 10m          │   │
│  │    2.2. Nhảy tại chỗ 5 lần     │   │
│  │    2.3. Bắt bóng bằng 2 tay    │   │
│  │                                 │   │
│  │ 3. Nghỉ giải lao                │   │
│  │    Mục tiêu:                    │   │
│  │    3.1. Tự uống nước            │   │
│  │    3.2. Rửa tay đúng cách      │   │
│  │                                 │   │
│  │ [✏️ Sửa]  [🗑️ Xóa]              │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 📅 Thứ Ba, 23/10/2025      ^   │   │
│  │ ⏰ Buổi sáng • 8:00-11:00       │   │
│  │ ──────────────────────────────  │   │
│  │ Nội dung (4):                   │   │
│  │                                 │   │
│  │ 1. Nhận biết màu sắc            │   │
│  │    Mục tiêu:                    │   │
│  │    1.1. Gọi tên màu đỏ          │   │
│  │    1.2. Gọi tên màu xanh        │   │
│  │    1.3. Phân biệt đỏ và xanh   │   │
│  │                                 │   │
│  │ 2. Ghép hình đơn giản           │   │
│  │    Mục tiêu:                    │   │
│  │    2.1. Ghép hình tròn          │   │
│  │    2.2. Ghép hình vuông         │   │
│  │                                 │   │
│  │ 3. Hoạt động ngoài trời         │   │
│  │    Mục tiêu:                    │   │
│  │    3.1. Đi bộ 50m               │   │
│  │    3.2. Leo cầu trượt           │   │
│  │                                 │   │
│  │ 4. Ôn tập                       │   │
│  │    Mục tiêu:                    │   │
│  │    4.1. Nhắc lại màu đã học    │   │
│  │                                 │   │
│  │ [✏️ Sửa]  [🗑️ Xóa]              │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 📅 Thứ Tư, 24/10/2025      ^   │   │
│  │ ...                             │   │
│  └─────────────────────────────────┘   │
│                                         │
│  [✅ Tạo tất cả (12 buổi)]             │
│                                         │
└─────────────────────────────────────────┘
```

## Mục đích

- Hiển thị kết quả AI phân tích
- Cho phép xem và chỉnh sửa trước khi tạo
- Đánh số thứ tự cho nội dung và mục tiêu
- Nút ^ để thu gọn/mở rộng mục tiêu

## Components

- **Summary Header**: Số buổi học được tạo
- **Session Cards**: Có thể expand/collapse
  - Ngày, buổi, thời gian
  - Danh sách nội dung được đánh số (1, 2, 3...)
  - Mục tiêu được đánh số phân cấp (1.1, 1.2, 2.1...)
- **Collapse Button**: ^ để thu gọn mục tiêu
- **Action Buttons per Session**: Sửa, Xóa
- **Main Action Button**: Tạo tất cả

## Interactions

- Tap "^" → Toggle collapse/expand goals
- Tap "✏️ Sửa" → Open edit session modal
- Tap "🗑️ Xóa" → Remove session from list
- Tap "✅ Tạo tất cả" → Bulk create all sessions
