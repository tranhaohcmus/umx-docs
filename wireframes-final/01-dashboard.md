# Dashboard - Trang chủ

## Wireframe

```
┌─────────────────────────────────┐
│            Educare              │
├─────────────────────────────────┤
│                                 │
│  ✨ Xin chào, Cô Mai!           │
│  Hôm nay: T3, 22/10/2025        │
│                                 │
│  📊 Tổng quan nhanh             │
│  ┌──────┬──────┬──────┬──────┐│
│  │  5   │  12  │  8   │  3   ││
│  │ Học  │ Buổi │ Buổi │ Cần  ││
│  │ sinh │ tuần │ hoàn │ ghi  ││
│  │      │ này  │ thành│      ││
│  └──────┴──────┴──────┴──────┘│
│                                │
│  👥 Danh sách Học sinh (5)     │
│  ┌───────────────────────────┐ │
│  │ 🔍 Tìm kiếm...            │ │ Search bar
│  └───────────────────────────┘ │
│                                 │
│  [🏷️ Tất cả] [🟢 Đang học] [⏸️ Tạm dừng]│
│                                 │
│  ┌───────────────────────────┐ │
│  │ ┌─────────┐               │ │
│  │ │   BA    │  Bé An        │ │ Avatar
│  │ └─────────┘  5 tuổi • Nam │ │ 60x60
│  │                           │ │
│  │ 🎯 Tuần này: 3 buổi       │ │
│  │ ✅ Đã ghi: 2 • ⏰ Chưa: 1 │ │
│  │                           │ │
│  │ ┌────────────────────┐    │ │
│  │ │██████░░░░ 67%      │    │ │ Progress
│  │ └────────────────────┘    │ │
│  │                           │ │
│  │ [XEM CHI TIẾT →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ┌─────────┐               │ │
│  │ │   BL    │  Bé Linh      │ │
│  │ └─────────┘  4 tuổi • Nữ  │ │
│  │                           │ │
│  │ 🎯 Tuần này: 4 buổi       │ │
│  │ ✅ Đã ghi: 4 • ✨ 100%    │ │
│  │                           │ │
│  │ ┌────────────────────┐    │ │
│  │ │████████████ 100%   │    │ │
│  │ └────────────────────┘    │ │
│  │                           │ │
│  │ [XEM CHI TIẾT →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ┌─────────┐               │ │
│  │ │   MC    │  Bé Cường     │ │
│  │ └─────────┘  6 tuổi • Nam │ │
│  │                           │ │
│  │ 🎯 Tuần này: 2 buổi       │ │
│  │ ⚠️ Chưa ghi: 2 buổi       │ │
│  │                           │ │
│  │ ┌────────────────────┐    │ │
│  │ │░░░░░░░░░░ 0%       │    │ │
│  │ └────────────────────┘    │ │
│  │                           │ │
│  │ [BẮT ĐẦU GHI →]           │ │
│  └───────────────────────────┘ │
│                                 │
│  [+ 2 học sinh khác...]        │
│                                 │
├─────────────────────────────────┤
│ [🏠 Nhà] [📝 Ghi] [📊 Báo] [👤 Tôi]│ Bottom Nav
└─────────────────────────────────┘
```

## Purpose

Dashboard là màn hình chính sau khi đăng nhập, cung cấp tổng quan nhanh về:

- Số lượng học sinh và buổi học
- Tiến độ ghi nhật ký
- Truy cập nhanh đến các chức năng chính
- Danh sách học sinh với trạng thái học tập

## Components

### Header

- **Time**: 9:41 (System time)
- **Title**: "Educare" (App name)
- **Icons**: Profile (👤), Settings (⚙️)

### Greeting Section

- **Welcome message**: "Xin chào, Cô Mai!"
- **Current date**: "Hôm nay: T3, 22/10/2025"

### Quick Stats (4 metrics)

1. **Học sinh**: Total students (5)
2. **Buổi tuần này**: Sessions this week (12)
3. **Buổi hoàn thành**: Completed sessions (8)
4. **Cần ghi**: Pending logs (3)

### Quick Actions (2 buttons)

1. **➕ Thêm học sinh**: Add new student
2. **📋 Ghi nhật ký**: Log session

### Student List

- **Search bar**: "🔍 Tìm kiếm..."
- **Filter tabs**:
  - 🏷️ Tất cả (All)
  - 🟢 Đang học (Active)
  - ⏸️ Tạm dừng (Paused)

### Student Card (Repeatable)

- **Avatar**: 60x60pt with initials
- **Name**: "Bé An"
- **Info**: Age (5 tuổi), Gender (Nam/Nữ)
- **Week stats**: "Tuần này: 3 buổi"
- **Status**:
  - ✅ Đã ghi: 2 (Completed)
  - ⏰ Chưa ghi: 1 (Pending)
- **Progress bar**: Visual completion percentage
- **CTA button**: "XEM CHI TIẾT →" or "BẮT ĐẦU GHI →"

### Bottom Navigation

- 🏠 **Nhà** (Home) - Active
- 📝 **Ghi** (Record)
- 📊 **Báo** (Reports)
- 👤 **Tôi** (Profile)

## Interactions

### Gestures

- **Pull down** = Refresh data
- **Tap student card** = Navigate to student detail
- **Tap quick action** = Navigate to respective screen
- **Tap search** = Focus search bar
- **Tap filter tab** = Filter student list
- **Swipe left on student card** = Quick actions (Edit, Archive)

### Navigation

- **Profile icon (👤)** → Profile screen
- **Settings icon (⚙️)** → Settings screen
- **Student card** → Student Detail screen
- **Bottom nav tabs** → Respective screens

### States

- **Loading**: Skeleton screens for student cards
- **Empty**: "Chưa có học sinh nào. Thêm học sinh đầu tiên!"
- **Error**: "Không thể tải dữ liệu. Vui lòng thử lại."

## Validation Rules

- Must have at least 1 student to show list
- Progress bars calculated from completed sessions
- Quick stats update in real-time
- Filter tabs show count badges

## Notes

- **Offline support**: Cached data available offline
- **Auto-refresh**: Data syncs every 5 minutes
- **Badge notifications**: Show unread counts on bottom nav
- **Accessibility**: VoiceOver support for all interactive elements
- **Performance**: List virtualization for 100+ students
