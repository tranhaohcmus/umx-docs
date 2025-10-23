# Cài đặt - Thông báo

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Cài đặt                │
├─────────────────────────────────┤
│                                 │
│  🔔 Thông báo                   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Nhắc nhở ghi nhật ký      │ │
│  │ ●━━━━━━━━━━━━━━━○ Bật    │ │ Toggle
│  │                           │ │
│  │ ⏰ 16:00 hàng ngày        │ │
│  │ [Thay đổi →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Buổi học sắp tới          │ │
│  │ ●━━━━━━━━━━━━━━━○ Bật    │ │
│  │                           │ │
│  │ ⏰ Trước 30 phút          │ │
│  │ [Thay đổi →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Báo cáo tuần              │ │
│  │ ●━━━━━━━━━━━━━━━○ Bật    │ │
│  │                           │ │
│  │ 📅 Thứ 2, 9:00            │ │
│  │ [Thay đổi →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  🌐 Ngôn ngữ                    │
│  ┌───────────────────────────┐ │
│  │ Tiếng Việt          [✓]  │ │
│  │ [Thay đổi →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  🎨 Giao diện                   │
│  ┌───────────────────────────┐ │
│  │ Chế độ sáng/tối           │ │
│  │ ○ Sáng  ● Tự động  ○ Tối │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Kích thước chữ            │ │
│  │ ○ Nhỏ  ● Vừa  ○ Lớn      │ │
│  └───────────────────────────┘ │
│                                 │
│  💾 Lưu trữ                     │
│  ┌───────────────────────────┐ │
│  │ Dung lượng đã dùng        │ │
│  │ ████████░░░░░░░░░░       │ │
│  │ 245MB / 500MB (49%)       │ │
│  │                           │ │
│  │ [Xóa bộ nhớ cache →]      │ │
│  └───────────────────────────┘ │
│                                 │
│  🔒 Quyền riêng tư              │
│  ┌───────────────────────────┐ │
│  │ [📄 Chính sách bảo mật]   │ │
│  │ [📜 Điều khoản sử dụng]   │ │
│  │ [🔐 Quyền ứng dụng]       │ │
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤 Tôi]         │
└─────────────────────────────────┘
```

## Purpose

Cài đặt ứng dụng bao gồm:

- Thông báo
- Ngôn ngữ
- Giao diện
- Lưu trữ
- Quyền riêng tư

## Components

### Notifications

- **Daily log reminder** (toggle, time)
- **Upcoming sessions** (toggle, advance time)
- **Weekly reports** (toggle, day & time)

### Language

- Current language
- Change option

### Appearance

- **Theme**: Light/Auto/Dark
- **Font size**: Small/Medium/Large

### Storage

- Usage bar
- Used/Total display
- Clear cache option

### Privacy

- Privacy policy link
- Terms of service link
- App permissions link

## Interactions

- **Toggle switch** = Enable/disable
- **Tap time** = Change time picker
- **Tap language** = Language selector
- **Tap theme** = Select theme
- **Tap font size** = Select size
- **Tap Clear cache** = Confirm & clear

## Related Screens

- **Previous**: 22-profile.md
