# 8. Modal: Chỉnh sửa Buổi học AI

```
┌─────────────────────────────────┐
│  Chỉnh sửa buổi học        ✕   │
├─────────────────────────────────┤
│                                 │
│  📅 Ngày                       │
│  ┌─────────────────────────┐   │
│  │ 22/10/2025            📅│   │
│  └─────────────────────────┘   │
│                                 │
│  🕐 Buổi                       │
│  ◉ Sáng    ○ Chiều            │
│                                 │
│  ⏰ Thời gian                  │
│  ┌───────┐     ┌───────┐       │
│  │ 8:00  │  -  │ 11:00 │       │
│  └───────┘     └───────┘       │
│                                 │
│  📝 Nội dung                   │
│  ┌─────────────────────────┐   │
│  │ 1. Ai đây?            ✕│   │
│  │    (Nhận biết bản thân) │   │
│  │    Mục tiêu:            │   │
│  │    1.1. Nhận biết tên   │   │
│  │    1.2. Trỏ vào ảnh mình│   │
│  │    1.3. Phản ứng khi gọi│   │
│  │    [Sửa] [Xóa]          │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 2. Hoạt động vận động ✕│   │
│  │    (Phát triển vận động)│   │
│  │    Mục tiêu:            │   │
│  │    2.1. Chạy thẳng 10m  │   │
│  │    2.2. Nhảy tại chỗ 5 lần│   │
│  │    2.3. Bắt bóng 2 tay  │   │
│  │    [Sửa] [Xóa]          │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 3. Nghỉ giải lao      ✕│   │
│  │    Mục tiêu:            │   │
│  │    3.1. Tự uống nước    │   │
│  │    3.2. Rửa tay đúng    │   │
│  │    [Sửa] [Xóa]          │   │
│  └─────────────────────────┘   │
│                                 │
│  [+ Thêm nội dung]             │
│                                 │
│  [Hủy]              [💾 Lưu]   │
└─────────────────────────────────┘
```

## Mục đích

- Chỉnh sửa buổi học được AI tạo ra
- Có thể thay đổi ngày, buổi, thời gian
- Sửa/xóa nội dung và mục tiêu
- Đánh số thứ tự cho nội dung và mục tiêu

## Components

- **Date Picker**: Chọn ngày
- **Period Radio**: Sáng/Chiều
- **Time Pickers**: Start - End time
- **Content List**: Nội dung được đánh số với mục tiêu phân cấp
- **Action Buttons per Content**: Sửa, Xóa
- **Add Content Button**
- **Main Actions**: Hủy, Lưu

## Interactions

- Tap date → Open date picker
- Tap time → Open time picker
- Tap "Sửa" (content) → Edit content inline or modal
- Tap "Xóa" (content) → Remove content
- Tap "+ Thêm nội dung" → Add new content
- Tap "💾 Lưu" → Save changes
