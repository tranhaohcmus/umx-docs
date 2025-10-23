# 16. Màn hình Profile

```
┌─────────────────────────────────────────┐
│  ← Profile                      ⚙️      │
├─────────────────────────────────────────┤
│                                         │
│         ┌────────┐                      │
│         │        │                      │
│         │   CH   │                      │
│         │        │                      │
│         └────────┘                      │
│                                         │
│         Cô Hoa                          │
│         coho@gmail.com                  │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  👤 Thông tin cá nhân                  │
│  ┌─────────────────────────────────┐   │
│  │ Họ và tên                       │   │
│  │ Nguyễn Thị Hoa              →  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ Email                           │   │
│  │ coho@gmail.com              →  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ Số điện thoại                   │   │
│  │ 0901234567                  →  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ⚙️ Cài đặt                            │
│  ┌─────────────────────────────────┐   │
│  │ 🔔 Thông báo                →  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 🔄 Đồng bộ dữ liệu          →  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 🌐 Ngôn ngữ                 →  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 🔒 Đổi mật khẩu             →  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  [🚪 Đăng xuất]                        │
│                                         │
├─────────────────────────────────────────┤
│  [🏠 Trang chủ] [📖 Từ điển] [👤 Profile]│
└─────────────────────────────────────────┘
```

## Mục đích

- Hiển thị thông tin cá nhân giáo viên
- Quản lý cài đặt ứng dụng
- Đăng xuất

## Components

- **Avatar**: Circle avatar with initials
- **Name & Email**: Display name and email
- **Personal Info Cards**: Name, Email, Phone with edit access
- **Settings Cards**: Notifications, Sync, Language, Password
- **Logout Button**
- **Bottom Navigation**: Trang chủ, Từ điển, Profile (active)

## Interactions

- Tap avatar → Change avatar
- Tap personal info card → Edit info
- Tap "🔔 Thông báo" → Notification settings
- Tap "🔄 Đồng bộ dữ liệu" → Sync settings
- Tap "🌐 Ngôn ngữ" → Language selection
- Tap "🔒 Đổi mật khẩu" → Change password
- Tap "🚪 Đăng xuất" → Logout (with confirmation)
