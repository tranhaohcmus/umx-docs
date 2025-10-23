# 1. Dashboard

```
┌─────────────────────────────────────────┐
│  ☰  Educare Connect         🔔  👤     │
├─────────────────────────────────────────┤
│                                         │
│  Xin chào, Cô Hoa! 👋                  │
│  Hôm nay: Thứ Hai, 22/10/2025          │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🔍 Tìm kiếm học sinh...        │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Danh sách Học sinh (8)                │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  ┌────┐                         │   │
│  │  │ BA │ Bé An (Nguyễn Văn An)  │   │
│  │  └────┘ 5 tuổi                 │   │
│  │                                 │   │
│  │  [📝 Nhật ký]  [📈 Phân tích]   │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  ┌────┐                         │   │
│  │  │ BB │ Bé Bình (Trần Thị Bình)│   │
│  │  └────┘ 4 tuổi                 │   │
│  │                                 │   │
│  │  [📝 Nhật ký]  [📈 Phân tích]   │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  ┌────┐                         │   │
│  │  │ BC │ Bé Châu (...)          │   │
│  │  └────┘ ...                     │   │
│  └─────────────────────────────────┘   │
│                                         │
├─────────────────────────────────────────┤
│  [🏠 Trang chủ] [📖 Từ điển] [👤 Profile]│
└─────────────────────────────────────────┘
```

## Mục đích

- Điểm khởi đầu của ứng dụng
- Hiển thị danh sách học sinh
- Truy cập nhanh các chức năng chính

## Components

- **Header**: Logo, thông báo, avatar
- **Welcome Section**: Lời chào và ngày hiện tại
- **Search Bar**: Tìm kiếm học sinh
- **Student Card**: Avatar (60x60px), tên, tuổi, 2 nút hành động
- **Bottom Navigation**: Trang chủ, Từ điển, Profile

## Interactions

- Tap "📝 Nhật ký" → Navigate to Session List
- Tap "📈 Phân tích" → Navigate to Analytics
- Pull to refresh → Refresh student list
