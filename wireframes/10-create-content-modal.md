# 10. Modal: Tạo Nội dung Mới

```
┌───────────────────────────────────────┐
│  Tạo Nội dung Mới                ✕  │
├───────────────────────────────────────┤
│                                       │
│  📝 Tên Nội dung *                   │
│  ┌─────────────────────────────────┐ │
│  │ VD: Phân biệt màu sắc          │ │
│  └─────────────────────────────────┘ │
│                                       │
│  📄 Mô tả (Tùy chọn)                 │
│  ┌─────────────────────────────────┐ │
│  │ Học nhận biết và gọi tên màu   │ │
│  │ đỏ, xanh                        │ │
│  └─────────────────────────────────┘ │
│                                       │
│  🎯 Mục tiêu Học tập                 │
│  ┌─────────────────────────────────┐ │
│  │ 1. Gọi tên được màu đỏ    [✕]  │ │
│  │ 2. Nhận thức được màu đỏ  [✕]  │ │
│  │ 3. Phân biệt đỏ với xanh  [✕]  │ │
│  └─────────────────────────────────┘ │
│                                       │
│  [➕ Thêm mục tiêu]                  │
│                                       │
│  ─────────────────────────────────── │
│                                       │
│  [Hủy]                [Tạo nội dung] │
└───────────────────────────────────────┘
```

## Mục đích

- Tạo nội dung mới cho buổi học
- Định nghĩa tên, mô tả và mục tiêu học tập

## Components

- **Name Input**: Tên nội dung (required)
- **Description Input**: Mô tả (optional)
- **Goals List**: Danh sách mục tiêu với nút xóa
- **Add Goal Button**: Thêm mục tiêu mới
- **Action Buttons**: Hủy, Tạo nội dung

## Interactions

- Type in name field → Input content name
- Type in description → Input description
- Type in goal field → Add goal to list
- Tap "➕ Thêm mục tiêu" → Add new goal input
- Tap "[✕]" next to goal → Remove goal
- Tap "Tạo nội dung" → Save and add to session
