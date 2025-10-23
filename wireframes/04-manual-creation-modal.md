# 4. Modal: Tạo Thủ công

```
┌─────────────────────────────────┐
│  Tạo buổi học thủ công     ✕   │
├─────────────────────────────────┤
│                                 │
│  📅 Ngày *                     │
│  ┌─────────────────────────┐   │
│  │ 22/10/2025            📅│   │
│  └─────────────────────────┘   │
│                                 │
│  🕐 Buổi *                     │
│  ◉ Sáng    ○ Chiều            │
│                                 │
│  ⏰ Thời gian                  │
│  ┌───────┐     ┌───────┐       │
│  │ 8:00  │  -  │ 11:00 │       │
│  └───────┘     └───────┘       │
│                                 │
│  📝 Nội dung dạy học           │
│  ┌─────────────────────────┐   │
│  │ 1. Phân biệt màu      ✕│   │
│  │    Mục tiêu:            │   │
│  │    • Gọi tên được...    │   │
│  │    • Nhận diện khuôn mặt│   │
│  │    [Sửa] [Xóa]          │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 2. Hoạt động vận động... │   │
│  │    [Sửa] [Xóa]          │   │
│  └─────────────────────────┘   │
│                                 │
│  [+ Thêm nội dung mới]         │
│                                 │
│  [Hủy]              [Lưu thay đổi]│
└─────────────────────────────────┘
```

## Mục đích

- Tạo buổi học thủ công từng bước
- Cho phép thêm nhiều nội dung với mục tiêu

## Components

- **Date Picker**: Chọn ngày
- **Period Radio**: Sáng/Chiều
- **Time Pickers**: Start time - End time
- **Content List**: Danh sách nội dung với mục tiêu, nút sửa/xóa
- **Add Content Button**
- **Action Buttons**: Hủy, Lưu

## Interactions

- Tap date field → Open date picker
- Tap time field → Open time picker
- Tap "+ Thêm nội dung mới" → Open content creation modal
- Tap "Sửa" → Edit content
- Tap "Xóa" → Delete content
- Tap "Lưu thay đổi" → Save session
