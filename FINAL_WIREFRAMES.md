# Educare Connect - Mobile App Wireframes

## UX Optimized for iOS & Android

---

## 📱 NAVIGATION STRUCTURE

```
Bottom Navigation (Persistent):
┌────────┬────────┬────────┬────────┐
│ 🏠 Nhà │ 📝 Ghi │ 📊 Báo │ 👤 Tôi │
└────────┴────────┴────────┴────────┘
```

---

## 18. TỪ ĐIỂN - CHI TIẾT HÀNH VI

```
┌─────────────────────────────────┐
│ 9:41  ← Ném đồ vật    ⭐ 📤 ⋮  │
├─────────────────────────────────┤
│                                 │
│  ⚠️ Ném đồ vật                  │
│  (Throwing Objects)             │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📊 THỐNG KÊ TOÀN HỆ THỐNG │ │
│  │                           │ │
│  │ 127 lần • Aggression      │ │
│  │ ████████░░ Phổ biến #1    │ │
│  │                           │ │
│  │ 📈 Xu hướng: ↗️ +15% tuần │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 👥 HỌC SINH CỦA BẠN       │ │
│  │                           │ │
│  │ 12 lần ghi nhận           │ │
│  │ 3/6 học sinh có hành vi   │ │
│  │                           │ │
│  │ [Xem phân tích chi tiết →]│ │
│  └───────────────────────────┘ │
│                                 │
│  ─────────────────────────────  │
│                                 │
│  📄 Mô tả                       │
│  ┌───────────────────────────┐ │
│  │ Hành vi ném các vật dụng, │ │
│  │ đồ chơi, học liệu trong   │ │
│  │ lớp học hoặc môi trường   │ │
│  │ học tập. Có thể ném về    │ │
│  │ phía người khác hoặc ném  │ │
│  │ bừa bãi không có mục tiêu.│ │
│  │                           │ │
│  │ [Đọc thêm ↓]              │ │
│  └───────────────────────────┘ │
│                                 │
│  🔍 Nguyên nhân Phổ biến        │
│                                 │
│  ┌────────────────────────┐    │
│  │ ⚡ Yêu cầu làm việc khó │    │ Expandable
│  │ ████████░░ 45%         │    │
│  │ [Xem chi tiết ↓]       │    │
│  └────────────────────────┘    │
│                                 │
│  ┌────────────────────────┐    │
│  │ 👁️ Không được chú ý    │    │
│  │ ██████░░░░ 30%         │    │
│  │ [Xem chi tiết ↓]       │    │
│  └────────────────────────┘    │
│                                 │
│  ┌────────────────────────┐    │
│  │ 😣 Cảm giác khó chịu   │    │
│  │ ███░░░░░░░ 15%         │    │
│  │ [Xem chi tiết ↓]       │    │
│  └────────────────────────┘    │
│                                 │
│  [+ Xem 2 nguyên nhân khác]    │
│                                 │
│  🎯 Chức năng Hành vi           │
│  • 🎪 Attention (Thu hút chú ý)│
│  • 🚪 Escape (Thoát nhiệm vụ)  │
│  • 🎨 Sensory (Kích thích)     │
│  • 🎁 Tangible (Có được vật)   │
│                                 │
│  💡 Can thiệp Gợi ý             │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⚡ ƯU TIÊN CAO (3)        │ │
│  │                           │ │
│  │ 1️⃣ Dạy kỹ năng thay thế   │ │
│  │    Dạy con cách xin nghỉ │ │
│  │    bằng lời hoặc cử chỉ  │ │
│  │    [Xem hướng dẫn →]      │ │
│  │                           │ │
│  │ 2️⃣ Điều chỉnh môi trường  │ │
│  │    Giảm độ khó bài tập   │ │
│  │    [Xem video →]          │ │
│  │                           │ │
│  │ 3️⃣ Khen thưởng tích cực   │ │
│  │    Khen khi hoàn thành   │ │
│  │    [Xem ví dụ →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  [+ Xem 5 can thiệp khác]      │
│                                 │
│  📚 Tài liệu liên quan          │
│  • Video: Xử lý hành vi ném    │
│  • Bài viết: Hiểu nguyên nhân  │
│  • Case study: Bé An thành công│
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Swipe down sections = Collapse
• Tap ⭐ = Add to favorites
• Tap 📤 = Share to colleagues
```

---

## 19. BÁO CÁO PHÂN TÍCH - OVERVIEW

```
┌─────────────────────────────────┐
│ 9:41      📊 Báo cáo        ⋮   │
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐ │
│  │ Chọn học sinh để phân tích│ │ Dropdown
│  │ ▼ Bé An (Nguyễn Văn An)   │ │
│  └───────────────────────────┘ │
│                                 │
│  [7 ngày] [30 ngày] [Tùy chỉnh]│ Tab selector
│                                 │
│  📅 01/10 - 22/10/2025 (22 ngày)│
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                 │
│  📊 Tổng quan                   │
│                                 │
│  ┌──────┬──────┬──────┬──────┐│
│  │  18  │  89% │  24  │  12  ││
│  │ Buổi │ Hoàn │ Hành │ Giờ/ ││
│  │ học  │ thành│ vi   │ tuần ││
│  └──────┴──────┴──────┴──────┘│
│                                 │
│  ⚠️ Hành vi Đáng chú ý (3)      │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🏃 Tự ý rời chỗ       ↗️  │ │
│  │ 12 lần • +15% tuần này    │ │
│  │ ┌──────────────────────┐  │ │
│  │ │  ●                   │  │ │ Mini chart
│  │ │ ●│ ●     ●           │  │ │
│  │ │●││●│   ● │●          │  │ │
│  │ │││││ ● │ ││           │  │ │
│  │ │1 5 10 15 20 (ngày)   │  │ │
│  │ └──────────────────────┘  │ │
│  │ [Xem phân tích →]         │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⚠️ Ném đồ vật         ↗️  │ │
│  │ 8 lần • +20% tuần này     │ │
│  │ [Xem phân tích →]         │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📢 La hét             ↘️  │ │
│  │ 4 lần • -10% tuần này     │ │
│  │ [Xem phân tích →]         │ │
│  └───────────────────────────┘ │
│                                 │
│  🎯 Tiến độ Học tập             │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Nhận diện màu sắc         │ │
│  │ ████████░░ 80% hoàn thành │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Kỹ năng vận động          │ │
│  │ ██████████ 95% hoàn thành │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  [Xem tất cả báo cáo →]        │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📥 TẢI BÁO CÁO PDF        │ │ Secondary CTA
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📧 GỬI CHO PHỤ HUYNH      │ │ Secondary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Swipe left/right on tabs = Change period
• Tap chart = Expand detail
• Pull down = Refresh data
```

---

## 20. BÁO CÁO - CHI TIẾT HÀNH VI

```
┌─────────────────────────────────┐
│ 9:41  ← Tự ý rời chỗ   📤 💾   │
├─────────────────────────────────┤
│                                 │
│  BA Bé An • 🏃 Tự ý rời chỗ     │
│                                 │
│  📅 Dữ liệu: 01/10 - 22/10/2025│
│  [7 ngày] [30 ngày] [Tùy chỉnh]│
│                                 │
│  📊 Tóm tắt                     │
│  ┌───────────────────────────┐ │
│  │ 12 lần ↗️ +15% tuần trước │ │
│  │ Cao điểm: T3, 10:00-11:00 │ │
│  │ Trung bình: 0.5 lần/buổi  │ │
│  └───────────────────────────┘ │
│                                 │
│  📈 Biểu đồ Xu hướng            │
│  ┌───────────────────────────┐ │
│  │     [Tần suất] [Cường độ]│ │ Toggle
│  │                           │ │
│  │  5╷                       │ │
│  │  4┼     ●                 │ │
│  │  3┼   ● │ ●               │ │
│  │  2┼ ● │ │ │ ●             │ │
│  │  1┼ │ │ │ │ │ ●           │ │
│  │  0┼─┴─┴─┴─┴─┴─┴──         │ │
│  │   1 5 10 15 20 (ngày)     │ │
│  │                           │ │
│  │ Nhấn điểm để xem chi tiết│ │
│  └───────────────────────────┘ │
│                                 │
│  🔍 Phân tích Nguyên nhân (A)  │
│  ┌───────────────────────────┐ │
│  │ TOP 3 TÌNH HUỐNG:         │ │
│  │                           │ │
│  │ 1. Yêu cầu bài khó        │ │
│  │    ███████░░░ 45% (5 lần) │ │
│  │    [Xem chi tiết ↓]       │ │
│  │                           │ │
│  │ 2. Không được chú ý       │ │
│  │    ██████░░░░ 30% (3 lần) │ │
│  │    [Xem chi tiết ↓]       │ │
│  │                           │ │
│  │ 3. Mệt mỏi/Buồn ngủ       │ │
│  │    ███░░░░░░░ 15% (2 lần) │ │
│  │    [Xem chi tiết ↓]       │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 Phân tích Hệ quả (C)        │
│  ┌───────────────────────────┐ │
│  │ KẾT QUẢ THƯỜNG THẤY:      │ │
│  │                           │ │
│  │ 1. Được nghỉ ngơi         │ │
│  │    █████████░ 50% (6 lần) │ │
│  │                           │ │
│  │ 2. Được chú ý             │ │
│  │    ███████░░░ 35% (4 lần) │ │
│  │                           │ │
│  │ 3. Bị nhắc nhở            │ │
│  │    ███░░░░░░░ 15% (2 lần) │ │
│  └───────────────────────────┘ │
│                                 │
│  🕐 Phân bố Thời gian           │
│  ┌───────────────────────────┐ │
│  │ [Theo giờ] [Theo ngày]    │ │
│  │                           │ │
│  │ 8-9h:  ██░ 2 lần          │ │
│  │ 9-10h: ████ 4 lần         │ │
│  │ 10-11h:███ 3 lần ← Cao    │ │
│  │ 14-15h:██░ 2 lần          │ │
│  │ 15-16h:█░░ 1 lần          │ │
│  └───────────────────────────┘ │
│                                 │
│  🤖 AI Phân tích & Gợi ý        │
│  ┌───────────────────────────┐ │
│  │ 🔍 PHÁT HIỆN:             │ │
│  │                           │ │
│  │ • Hành vi tăng 15% tuần này│ │
│  │ • Tập trung vào 10-11h sáng│ │
│  │ • Chủ yếu khi bài tập khó │ │
│  │ • Chức năng: Escape (thoát)│ │
│  │                           │ │
│  │ 💡 GỢI Ý CAN THIỆP:       │ │
│  │                           │ │
│  │ ⚡ Ưu tiên cao:            │ │
│  │ 1. Giảm độ khó bài tập    │ │
│  │    Thời gian: Ngay        │ │
│  │    [Xem hướng dẫn →]      │ │
│  │                           │ │
│  │ 2. Dạy cách xin nghỉ      │ │
│  │    Thời gian: 2-3 tuần    │ │
│  │    [Xem video →]          │ │
│  │                           │ │
│  │ 3. Tăng thời gian nghỉ    │ │
│  │    Thời gian: Ngay        │ │
│  │    [Xem kế hoạch →]       │ │
│  │                           │ │
│  │ [Xem 4 gợi ý khác →]      │ │
│  └───────────────────────────┘ │
│                                 │
│  📋 Danh sách Chi tiết (12)    │
│  ┌───────────────────────────┐ │
│  │ 📅 T3, 22/10 • 10:15      │ │
│  │ ──────────────────────────│ │
│  │ A: Yêu cầu làm bài toán   │ │
│  │ B: Rời chỗ, đi lại lớp    │ │
│  │ C: Được nghỉ 5 phút       │ │
│  │ Cường độ: ●●●○○           │ │
│  │ [Xem] [Sửa] [Xóa]         │ │
│  └───────────────────────────┘ │
│                                 │
│  [Xem tất cả 12 lần →]         │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📥 XUẤT BÁO CÁO PDF       │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📧 GỬI PHỤ HUYNH          │ │
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Pinch chart = Zoom in/out
• Tap data point = See detail
• Swipe detail cards = Navigate
```

---

## 21. BÁO CÁO - SO SÁNH NHIỀU HÀNH VI

```
┌─────────────────────────────────┐
│ 9:41  ← So sánh         ✕ 📤   │
├─────────────────────────────────┤
│                                 │
│  BA Bé An                       │
│  📅 30 ngày qua                 │
│                                 │
│  Chọn hành vi để so sánh:       │
│  ┌───────────────────────────┐ │
│  │ ☑️ Tự ý rời chỗ (12×)     │ │
│  │ ☑️ Ném đồ vật (8×)        │ │
│  │ ☑️ La hét (4×)            │ │
│  │ ☐ Cắn (2×)                │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 Biểu đồ Xu hướng            │
│  ┌───────────────────────────┐ │
│  │                           │ │
│  │  5╷  —— Rời chỗ           │ │
│  │  4┼  ··· Ném đồ           │ │
│  │  3┼  ─ ─ La hét           │ │
│  │  2┼  ●—●                  │ │
│  │  1┼ ●│··│● ●              │ │
│  │  0┼─┴·─┴─┴─┴──           │ │
│  │   1 10 20 30 (ngày)       │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 So sánh Tần suất            │
│  ┌───────────────────────────┐ │
│  │ Tự ý rời chỗ              │ │
│  │ ██████████████ 12         │ │
│  │                           │ │
│  │ Ném đồ vật                │ │
│  │ ██████████░░░░ 8          │ │
│  │                           │ │
│  │ La hét                    │ │
│  │ ██████░░░░░░░░ 4          │ │
│  └───────────────────────────┘ │
│                                 │
│  🔍 Phân tích Tương quan        │
│  ┌───────────────────────────┐ │
│  │ 💡 PHÁT HIỆN:             │ │
│  │                           │ │
│  │ • "Rời chỗ" và "Ném đồ"  │ │
│  │   thường xảy ra cùng lúc  │ │
│  │   (60% trùng khớp)        │ │
│  │                           │ │
│  │ • Cả 3 hành vi đều tăng   │ │
│  │   vào buổi sáng 10-11h    │ │
│  │                           │ │
│  │ • "La hét" giảm khi "Rời │ │
│  │   chỗ" được can thiệp     │ │
│  │                           │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Gợi ý Can thiệp Tổng hợp    │
│  ┌───────────────────────────┐ │
│  │ Vì 3 hành vi có cùng      │ │
│  │ nguyên nhân (thoát bài khó)│ │
│  │ nên có thể can thiệp chung:│ │
│  │                           │ │
│  │ 1. Giảm độ khó bài tập    │ │
│  │ 2. Dạy kỹ năng xin nghỉ   │ │
│  │ 3. Tăng khen thưởng       │ │
│  │                           │ │
│  │ [Xem kế hoạch chi tiết →] │ │
│  └───────────────────────────┘ │
│                                 │
│  [📥 Xuất báo cáo so sánh]     │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 22. PROFILE - THÔNG TIN CÁ NHÂN

```
┌─────────────────────────────────┐
│ 9:41                        ⚙️  │
├─────────────────────────────────┤
│                                 │
│         ┌─────────┐             │
│         │   CH    │             │ Avatar
│         └─────────┘             │
│                                 │
│         Cô Hoa                  │
│         coho@gmail.com          │
│                                 │
│  [📸 Đổi ảnh]                   │
│                                 │
│  ─────────────────────────────  │
│                                 │
│  👤 Thông tin cá nhân           │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Họ và tên              →  │ │
│  │ Nguyễn Thị Hoa            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Email                  →  │ │
│  │ coho@gmail.com            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Số điện thoại          →  │ │
│  │ 0901234567                │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Trường/Cơ sở           →  │ │
│  │ Trung tâm Educare HCM     │ │
│  └───────────────────────────┘ │
│                                 │
│  ⚙️ Cài đặt                     │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔔 Thông báo           →  │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔄 Đồng bộ dữ liệu     →  │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🌐 Ngôn ngữ            →  │ │
│  │ Tiếng Việt                │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔒 Đổi mật khẩu        →  │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 💾 Quản lý bộ nhớ      →  │ │
│  │ Đã dùng: 245 MB / 2 GB    │ │
│  └───────────────────────────┘ │
│                                 │
│  ℹ️ Hỗ trợ                      │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📖 Hướng dẫn sử dụng   →  │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 💬 Liên hệ hỗ trợ      →  │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⭐ Đánh giá ứng dụng   →  │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📄 Điều khoản & Chính sách│ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🚪 ĐĂNG XUẤT               │ │ Destructive
│  └───────────────────────────┘ │
│                                 │
│  Phiên bản: 1.0.0 (Build 23)   │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 23. CÀI ĐẶT - THÔNG BÁO

```
┌─────────────────────────────────┐
│ 9:41   ← Thông báo              │
├─────────────────────────────────┤
│                                 │
│  🔔 Cài đặt Thông báo           │
│                                 │
│  📱 Thông báo Push              │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Bật thông báo push    [●] │ │ Toggle ON
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Nhắc nhở ghi nhật ký  [●] │ │
│  │ Mỗi ngày lúc 16:00        │ │
│  │ [Thay đổi giờ →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Buổi học sắp tới      [●] │ │
│  │ Trước 30 phút             │ │
│  │ [Thay đổi →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Quá hạn ghi nhật ký   [●] │ │
│  │ Sau 24 giờ                │ │
│  │ [Thay đổi →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Báo cáo hành vi       [○] │ │ Toggle OFF
│  │ Khi có hành vi mới        │ │
│  │ [Bật →]                   │ │
│  └───────────────────────────┘ │
│                                 │
│  📧 Email                       │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Báo cáo tuần          [●] │ │
│  │ Mỗi T2 lúc 8:00           │ │
│  │ [Thay đổi →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Báo cáo tháng         [○] │ │
│  │ Ngày 1 mỗi tháng          │ │
│  │ [Bật →]                   │ │
│  └───────────────────────────┘ │
│                                 │
│  🔕 Không làm phiền             │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Bật chế độ DND        [○] │ │
│  │                           │ │
│  │ Từ: 21:00 - Đến: 7:00    │ │
│  │ [Cài đặt →]               │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🧪 GỬI THÔNG BÁO THỬ      │ │ Test button
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 24. EMPTY STATES

### A. Dashboard - Chưa có học sinh

```
┌─────────────────────────────────┐
│ 9:41          🔋 100% ••••• 📶 │
├─────────────────────────────────┤
│                                 │
│  Xin chào, Cô Hoa! 👋          │
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   📚    │             │
│         └─────────┘             │
│                                 │
│    Chưa có học sinh nào         │
│                                 │
│  Hãy thêm học sinh đầu tiên     │
│  để bắt đầu sử dụng Educare     │
│  Connect                        │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ THÊM HỌC SINH ĐẦU TIÊN │ │
│  └───────────────────────────┘ │
│                                 │
│  [📖 Xem hướng dẫn]             │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

### B. Chưa có buổi học

```
┌─────────────────────────────────┐
│ 9:41   ← Bé An                  │
├─────────────────────────────────┤
│                                 │
│  BA Bé An • 5 tuổi              │
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   📅    │             │
│         └─────────┘             │
│                                 │
│   Chưa có buổi học nào          │
│                                 │
│  Tạo buổi học đầu tiên cho      │
│  Bé An để bắt đầu ghi nhật ký   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ TẠO BUỔI HỌC ĐẦU TIÊN  │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Bạn có thể:                 │
│  • Tạo thủ công từng bước       │
│  • Dùng AI phân tích giáo án    │
│                                 │
│  [📖 Xem hướng dẫn]             │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

### C. Chưa có hành vi

```
┌─────────────────────────────────┐
│ 9:41   ← Phân tích              │
├─────────────────────────────────┤
│                                 │
│  BA Bé An                       │
│  📅 30 ngày qua                 │
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   📊    │             │
│         └─────────┘             │
│                                 │
│  Chưa có dữ liệu hành vi        │
│                                 │
│  Hãy ghi nhật ký và ghi nhận    │
│  hành vi để xem phân tích       │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📝 BẮT ĐẦU GHI NHẬT KÝ    │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Gợi ý:                      │
│  • Ghi nhật ký đầy đủ mỗi ngày │
│  • Ghi nhận hành vi kịp thời    │
│  • Dùng A-B-C để phân tích      │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 25. ERROR STATES

### A. Lỗi kết nối mạng

```
┌─────────────────────────────────┐
│ 9:41          🔋 100% ⚠️ Offline│
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   📡    │             │
│         └─────────┘             │
│                                 │
│  Không có kết nối mạng          │
│                                 │
│  Vui lòng kiểm tra kết nối      │
│  WiFi hoặc dữ liệu di động      │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔄 THỬ LẠI                │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📱 MỞ CÀI ĐẶT MẠNG        │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Chế độ Offline:             │
│  Bạn vẫn có thể:                │
│  • Xem dữ liệu đã tải           │
│  • Ghi nhật ký (tự động lưu)    │
│  • Sẽ đồng bộ khi có mạng       │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

### B. AI Upload thất bại

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo với AI             │
├─────────────────────────────────┤
│                                 │
│         ┌─────────┐             │
│         │   ⚠️    │             │
│         └─────────┘             │
│                                 │
│  Không thể phân tích file       │
│                                 │
│  File của bạn không đúng định   │
│  dạng hoặc không thể đọc được   │
│                                 │
│  ❌ Lỗi: Invalid file format    │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔄 THỬ FILE KHÁC          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✍️ TẠO THỦ CÔNG           │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Lưu ý:                      │
│  • File phải là PDF, DOCX, TXT  │
│  • Dung lượng tối đa 10MB       │
│  • Nội dung phải rõ ràng        │
│                                 │
│  [📧 Báo lỗi cho hỗ trợ]        │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 26. LOADING STATES

### A. Skeleton Loading - Dashboard

```
┌─────────────────────────────────┐
│ 9:41          🔋 100% ••••• 📶 │
├─────────────────────────────────┤
│                                 │
│  Xin chào, ████████! 👋        │ Shimmer effect
│  ███████, ██ █████ ██          │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⚡ ████████████████        │ │
│  │                           │ │
│  │ ███████████████████       │ │
│  │ ███████████████████       │ │
│  │                           │ │
│  │ ████████                  │ │
│  └───────────────────────────┘ │
│                                 │
│  🔍 ████████████████████        │
│                                 │
│  📌 ████████ (█)                │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ██                        │ │
│  │ ██ ████████ • █ ████   ██ │ │
│  │ ██                        │ │
│  │ ████████████              │ │
│  │                           │ │
│  │ ████████  ████████        │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ██                        │ │
│  │ ██ ████████ • █ ████   ██ │ │
│  │ ██                        │ │
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

### B. Pull-to-Refresh

```
┌─────────────────────────────────┐
│        ┌─────┐                  │
│        │  ○  │  Đang tải...     │ Spinner
│        └─────┘                  │
├─────────────────────────────────┤
│                                 │
│  Dashboard content...           │
│                                 │
└─────────────────────────────────┘
```

---

## 27. SUCCESS STATES

### A. Tạo buổi học thành công

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│   ┌─────────────────────────┐   │
│   │                         │   │
│   │      ┌─────────┐        │   │
│   │      │   ✅    │        │   │ Animation
│   │      └─────────┘        │   │
│   │                         │   │
│   │  Tạo buổi học thành công│   │
│   │                         │   │
│   │  Đã tạo 12 buổi học cho │   │
│   │  Bé An                  │   │
│   │                         │   │
│   │  [Xem buổi học]         │   │
│   │  [Đóng]                 │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘

Auto dismiss sau 3 giây
```

### B. Lưu nhật ký thành công

```
┌─────────────────────────────────┐
│ ┌─────────────────────────────┐ │
│ │ ✅ Đã lưu nhật ký           │ │ Toast
│ └─────────────────────────────┘ │
│                                 │
│  Dashboard content...           │
│                                 │
└─────────────────────────────────┘

Toast tự động ẩn sau 2 giây
```

---

## 28. ONBOARDING FLOW

### Screen 1 - Welcome

```
┌─────────────────────────────────┐
│ 9:41          🔋 100% ••••• 📶 │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   🎓    │             │ Large icon
│         └─────────┘             │
│                                 │
│    Chào mừng đến với            │
│    Educare Connect!             │
│                                 │
│  Ứng dụng hỗ trợ giáo viên      │
│  giáo dục đặc biệt ghi nhật ký  │
│  và phân tích hành vi học sinh  │
│                                 │
│                                 │
│                                 │
│  ○ ● ○ ○                        │ Pagination dots
│                                 │
│                                 │
│  ┌───────────────────────────┐ │
│  │    BẮT ĐẦU  →             │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [Bỏ qua]                       │
│                                 │
└─────────────────────────────────┘

Swipe left để xem tiếp
```

### Screen 2 - Feature 1

```
┌─────────────────────────────────┐
│                                 │
│         ┌─────────┐             │
│         │   📝    │             │
│         └─────────┘             │
│                                 │
│    Ghi nhật ký dễ dàng          │
│                                 │
│  • Tạo buổi học bằng AI         │
│  • Ghi nhận nhanh trên điện thoại│
│  • Đánh giá mục tiêu học tập    │
│  • Ghi âm, chụp ảnh, quay video │
│                                 │
│                                 │
│  ○ ○ ● ○                        │
│                                 │
│  ┌───────────────────────────┐ │
│  │    TIẾP TỤC  →            │ │
│  └───────────────────────────┘ │
│                                 │
│  [Bỏ qua]                       │
│                                 │
└─────────────────────────────────┘
```

### Screen 3 - Feature 2

```
┌─────────────────────────────────┐
│                                 │
│         ┌─────────┐             │
│         │   📊    │             │
│         └─────────┘             │
│                                 │
│    Phân tích hành vi A-B-C      │
│                                 │
│  • Ghi nhận hành vi theo A-B-C  │
│  • Phân tích xu hướng tự động   │
│  • Gợi ý can thiệp bằng AI      │
│  • Báo cáo trực quan dễ hiểu    │
│                                 │
│                                 │
│  ○ ○ ○ ●                        │
│                                 │
│  ┌───────────────────────────┐ │
│  │    BẮT ĐẦU SỬ DỤNG  →    │ │
│  └───────────────────────────┘ │
│                                 │
│  [Bỏ qua]                       │
│                                 │
└─────────────────────────────────┘
```

---

## 29. CONFIRMATION DIALOGS

### A. Xóa buổi học

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│   ┌─────────────────────────┐   │
│   │       ⚠️                │   │
│   │                         │   │
│   │  Xóa buổi học?          │   │
│   │                         │   │
│   │  Bạn có chắc muốn xóa   │   │
│   │  buổi học ngày 22/10    │   │
│   │  (Buổi sáng)?           │   │
│   │                         │   │
│   │  ⚠️ Hành động này không │   │
│   │  thể hoàn tác           │   │
│   │                         │   │
│   │  ┌─────────┬─────────┐  │   │
│   │  │  Hủy    │  Xóa    │  │   │ Destructive
│   │  └─────────┴─────────┘  │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

### B. Hoàn tất buổi học

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│   ┌─────────────────────────┐   │
│   │       ✅                │   │
│   │                         │   │
│   │  Hoàn tất buổi học?     │   │
│   │                         │   │
│   │  Bạn có chắc đã hoàn    │   │
│   │  thành tất cả nội dung? │   │
│   │                         │   │
│   │  📊 Tiến độ: 5/5 (100%) │   │
│   │  ⚠️ 2 hành vi ghi nhận  │   │
│   │                         │   │
│   │  Sau khi hoàn tất, bạn  │   │
│   │  vẫn có thể chỉnh sửa   │   │
│   │                         │   │
│   │  ┌─────────┬─────────┐  │   │
│   │  │  Hủy    │ Hoàn tất│  │   │
│   │  └─────────┴─────────┘  │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

---

## 30. GESTURE GUIDES

```
┌─────────────────────────────────┐
│  HƯỚNG DẪN CỬ CHỈ              │
├─────────────────────────────────┤
│                                 │
│  📱 Navigation                  │
│  • Swipe left:  Xem tuần sau   │
│  • Swipe right: Xem tuần trước │
│  • Pull down:   Làm mới dữ liệu│
│  • Swipe up:    Xem thêm        │
│                                 │
│  🗂️ Cards & Items              │
│  • Tap:         Xem chi tiết    │
│  • Long press:  Xem tùy chọn    │
│  • Swipe left:  Xóa nhanh       │
│  • Swipe right: Đánh dấu xong   │
│  • Drag ⋮⋮:     Sắp xếp lại     │
│                                 │
│  📊 Charts                      │
│  • Tap point:   Xem giá trị     │
│  • Pinch:       Zoom in/out     │
│  • Double tap:  Reset zoom      │
│  • Pan:         Di chuyển       │
│                                 │
│  ⌨️ Text Input                 │
│  • Tap field:   Mở bàn phím     │
│  • Tap outside: Đóng bàn phím   │
│  • 🎤 icon:     Ghi âm          │
│                                 │
│  📸 Media                       │
│  • Tap +        Thêm file       │
│  • Long press:  Xem trước       │
│  • Tap ✕:       Xóa file        │
│                                 │
└─────────────────────────────────┘
```

---

## 📝 DESIGN SPECIFICATIONS

### Colors (Suggested)

```
Primary:    #4F46E5 (Indigo)
Secondary:  #10B981 (Green)
Accent:     #F59E0B (Amber)
Error:      #EF4444 (Red)
Warning:    #F59E0B (Amber)
Success:    #10B981 (Green)
Background: #F9FAFB (Gray 50)
Surface:    #FFFFFF (White)
Text:       #111827 (Gray 900)
TextLight:  #6B7280 (Gray 500)
```

### Typography

```
Heading 1:  24pt / Bold / -0.5pt
Heading 2:  20pt / Bold / -0.3pt
Heading 3:  18pt / Semibold / -0.2pt
Body:       16pt / Regular / 0pt
Caption:    14pt / Regular / 0pt
Small:      12pt / Regular / 0pt
Button:     16pt / Semibold / 0pt
```

### Spacing

```
XS:  4px
S:   8px
M:   16px
L:   24px
XL:  32px
XXL: 48px
```

### Border Radius

```
Small:  4px
Medium: 8px
Large:  12px
XLarge: 16px
Full:   999px
```

### Touch Targets

```
Minimum: 44x44 pt (Apple HIG)
Minimum: 48x48 dp (Material Design)
Recommended: 48x48 pt/dp
```

### Animation Timing

```
Fast:    150ms  (Micro-interactions)
Normal:  300ms  (Standard transitions)
Slow:    500ms  (Complex animations)
```

---

## 🎯 UX PRINCIPLES APPLIED

### 1. **Mobile-First Design**

- Tối ưu cho thao tác một tay
- Bottom navigation dễ chạm
- Large touch targets (48pt minimum)
- Thumb-friendly zones

### 2. **Progressive Disclosure**

- Hiển thị thông tin quan trọng trước
- Collapse/Expand cho chi tiết
- Steppers cho flows phức tạp
- Bottom sheets cho quick actions

### 3. **Feedback & Affordance**

- Loading states cho mọi actions
- Success/Error messages rõ ràng
- Haptic feedback (iOS)
- Visual feedback cho touches

### 4. **Gesture-Based Navigation**

- Swipe để navigate
- Pull-to-refresh
- Swipe actions trên cards
- Long press cho context menu

### 5. **Offline-First**

- Lưu local khi offline
- Sync khi có network
- Báo offline status
- Cache dữ liệu quan trọng

### 6. **Accessibility**

- Font size scalable
- High contrast mode
- VoiceOver/TalkBack support
- Color-blind friendly

### 7. **Performance**

- Skeleton loading
- Lazy loading images
- Pagination cho lists
- Debounced search

### 8. **Error Prevention**

- Validation real-time
- Confirmation dialogs
- Undo actions
- Auto-save drafts

---

## 📊 SCREEN COUNT SUMMARY

**Total: 30 Screens + Variations**

### Core Screens (22)

1. Dashboard
2. Học sinh Chi tiết
   3-8. Tạo Buổi học Flow (6 screens)
   9-16. Ghi Nhật ký Flow (8 screens)
   17-18. Từ điển Hành vi (2 screens)
   19-21. Báo cáo (3 screens)
3. Profile

### Supporting Screens (8)

23. Cài đặt Thông báo
24. Empty States (3 variations)
25. Error States (2 variations)
26. Loading States (2 variations)
27. Success States (2 variations)
28. Onboarding (3 screens)

### Overlays & Modals (8)

29. Confirmation Dialogs (2 types)
30. Gesture Guide

---

## 🚀 IMPLEMENTATION NOTES

### Priority Phases

**Phase 1 - MVP (Core Features)**

- Dashboard
- Học sinh management
- Ghi nhật ký basic
- A-B-C form
- Profile

**Phase 2 - Enhanced**

- AI upload
- Từ điển hành vi
- Báo cáo cơ bản
- Notifications

**Phase 3 - Advanced**

- AI phân tích
- So sánh hành vi
- Advanced reports
- Offline mode

**Phase 4 - Polish**

- Onboarding
- Animations
- Gestures
- Accessibility

---

## ✅ CHECKLIST

### Must Have

- [ ] Bottom navigation
- [ ] Pull to refresh
- [ ] Loading states
- [ ] Error handling
- [ ] Offline mode
- [ ] Auto-save
- [ ] Touch feedback
- [ ] Confirmation dialogs

### Nice to Have

- [ ] Swipe gestures
- [ ] Haptic feedback
- [ ] Skeleton loading
- [ ] Dark mode
- [ ] Widget support
- [ ] 3D Touch/Haptic Touch
- [ ] Siri shortcuts
- [ ] Watch app

---

## 🎨 COMPONENT LIBRARY

### Buttons

```
┌─────────────────────────────────┐
│ PRIMARY BUTTON                  │
│ ┌───────────────────────────┐   │
│ │   TIẾP TỤC  →             │   │ Blue, Bold
│ └───────────────────────────┘   │
│                                 │
│ SECONDARY BUTTON                │
│ ┌───────────────────────────┐   │
│ │   Thêm nội dung           │   │ White bg, Border
│ └───────────────────────────┘   │
│                                 │
│ DESTRUCTIVE BUTTON              │
│ ┌───────────────────────────┐   │
│ │   Xóa buổi học            │   │ Red
│ └───────────────────────────┘   │
│                                 │
│ GHOST BUTTON                    │
│ [Bỏ qua]                        │ Text only
│                                 │
│ ICON BUTTON                     │
│ [📤] [🗑️] [✏️]                  │ 44x44pt min
│                                 │
│ DISABLED STATE                  │
│ ┌───────────────────────────┐   │
│ │   Hoàn tất                │   │ Gray, 50% opacity
│ └───────────────────────────┘   │
└─────────────────────────────────┘
```

### Cards

```
┌─────────────────────────────────┐
│ CARD - DEFAULT                  │
│ ┌───────────────────────────┐   │
│ │ Heading                   │   │
│ │ Body text goes here...    │   │
│ │                           │   │
│ │ [Action]                  │   │
│ └───────────────────────────┘   │
│                                 │
│ CARD - WITH ICON                │
│ ┌───────────────────────────┐   │
│ │ 🎯 Heading                │   │
│ │ Body text...              │   │
│ └───────────────────────────┘   │
│                                 │
│ CARD - SELECTED                 │
│ ┌───────────────────────────┐   │
│ │ ✅ Selected Item          │   │ Blue border
│ └───────────────────────────┘   │
│                                 │
│ CARD - WITH BADGE               │
│ ┌───────────────────────────┐   │
│ │ Title             [⚠️ New]│   │
│ │ Content...                │   │
│ └───────────────────────────┘   │
└─────────────────────────────────┘
```

### Form Elements

```
┌─────────────────────────────────┐
│ TEXT INPUT                      │
│ Label *                         │ * = required
│ ┌───────────────────────────┐   │
│ │ Placeholder text...       │   │
│ └───────────────────────────┘   │
│                                 │
│ TEXT INPUT - FOCUSED            │
│ Label *                         │
│ ┌───────────────────────────┐   │
│ │ User typing...│          │   │ Blue border
│ └───────────────────────────┘   │
│                                 │
│ TEXT INPUT - ERROR              │
│ Label *                         │
│ ┌───────────────────────────┐   │
│ │ Wrong input               │   │ Red border
│ └───────────────────────────┘   │
│ ⚠️ Error message here           │
│                                 │
│ TEXT AREA                       │
│ ┌───────────────────────────┐   │
│ │ Multiple lines...         │   │
│ │                           │   │
│ │ [250/1000 ký tự]          │   │
│ └───────────────────────────┘   │
│                                 │
│ SELECT / DROPDOWN               │
│ ┌───────────────────────────┐   │
│ │ Chọn tùy chọn...        ▼ │   │
│ └───────────────────────────┘   │
│                                 │
│ DATE PICKER                     │
│ ┌───────────────────────────┐   │
│ │ 22/10/2025            📅  │   │
│ └───────────────────────────┘   │
│                                 │
│ TIME PICKER                     │
│ ┌───────────────────────────┐   │
│ │ 10:30                  🕐 │   │
│ └───────────────────────────┘   │
│                                 │
│ TOGGLE SWITCH                   │
│ Bật thông báo              [●] │ ON
│ Tắt thông báo              [○] │ OFF
│                                 │
│ RADIO BUTTONS                   │
│ ● Tùy chọn 1                    │ Selected
│ ○ Tùy chọn 2                    │
│ ○ Tùy chọn 3                    │
│                                 │
│ CHECKBOXES                      │
│ ☑️ Tùy chọn 1                   │ Checked
│ ☑️ Tùy chọn 2                   │ Checked
│ ☐ Tùy chọn 3                    │ Unchecked
│                                 │
│ SLIDER                          │
│ Mức độ hành vi                  │
│ ├────●────┼────┼────┼────┤     │
│ Nhẹ                 Nghiêm trọng│
└─────────────────────────────────┘
```

### Lists

```
┌─────────────────────────────────┐
│ LIST ITEM - BASIC               │
│ ┌───────────────────────────┐   │
│ │ Item title            →   │   │
│ └───────────────────────────┘   │
│                                 │
│ LIST ITEM - WITH ICON           │
│ ┌───────────────────────────┐   │
│ │ 🎯 Item title         →   │   │
│ │ Subtitle text             │   │
│ └───────────────────────────┘   │
│                                 │
│ LIST ITEM - WITH AVATAR         │
│ ┌───────────────────────────┐   │
│ │ [BA] Bé An            →   │   │
│ │      5 tuổi • Nam         │   │
│ └───────────────────────────┘   │
│                                 │
│ LIST ITEM - WITH BADGE          │
│ ┌───────────────────────────┐   │
│ │ Item title       [⚠️ 3]   │   │
│ └───────────────────────────┘   │
│                                 │
│ LIST ITEM - EXPANDABLE          │
│ ┌───────────────────────────┐   │
│ │ ▼ Expanded item           │   │
│ │ ──────────────────────────│   │
│ │ Detail content here...    │   │
│ │                           │   │
│ │ [Action 1] [Action 2]     │   │
│ └───────────────────────────┘   │
│                                 │
│ LIST ITEM - SWIPE ACTIONS       │
│ ┌───────────────────────────┐   │
│ │ ← [✏️][🗑️] Item title     │   │ Revealed
│ └───────────────────────────┘   │
└─────────────────────────────────┘
```

### Navigation

```
┌─────────────────────────────────┐
│ TOP NAV BAR                     │
│ ┌───────────────────────────┐   │
│ │ ← Title           ⋮ 📤    │   │
│ └───────────────────────────┘   │
│                                 │
│ BOTTOM TAB BAR                  │
│ ┌───────────────────────────┐   │
│ │ [🏠] [📝] [📊] [👤]       │   │
│ │ Nhà  Ghi  Báo  Tôi        │   │ Labels
│ └───────────────────────────┘   │
│                                 │
│ SEARCH BAR                      │
│ ┌───────────────────────────┐   │
│ │ 🔍 Tìm kiếm...            │   │
│ └───────────────────────────┘   │
│                                 │
│ TABS                            │
│ [Active Tab] [Tab 2] [Tab 3]   │
│ ━━━━━━━━━━                      │ Indicator
│                                 │
│ SEGMENTED CONTROL               │
│ ┌───────────┬───────────┐       │
│ │ ● Sáng    │ ○ Chiều   │       │
│ └───────────┴───────────┘       │
│                                 │
│ BREADCRUMB                      │
│ Trang chủ > Bé An > Buổi học   │
└─────────────────────────────────┘
```

### Overlays

```
┌─────────────────────────────────┐
│ MODAL - FULL SCREEN             │
│ ┌───────────────────────────┐   │
│ │ ✕ Title                   │   │
│ │ ──────────────────────────│   │
│ │                           │   │
│ │ Content area...           │   │
│ │                           │   │
│ │                           │   │
│ │ [Cancel]    [Save]        │   │
│ └───────────────────────────┘   │
│                                 │
│ BOTTOM SHEET                    │
│   [Background - Tap to close]   │
│ ┌───────────────────────────┐   │
│ │ ──                        │   │ Handle
│ │ Title                     │   │
│ │                           │   │
│ │ Options...                │   │
│ │                           │   │
│ │ [Action]                  │   │
│ └───────────────────────────┘   │
│                                 │
│ ACTION SHEET                    │
│   [Background Dim]              │
│ ┌───────────────────────────┐   │
│ │ Option 1                  │   │
│ │ Option 2                  │   │
│ │ Delete (Red)              │   │
│ │ ──────────────────────────│   │
│ │ Cancel                    │   │
│ └───────────────────────────┘   │
│                                 │
│ ALERT                           │
│   [Background Dim]              │
│ ┌───────────────────────────┐   │
│ │       ⚠️                  │   │
│ │ Alert Title               │   │
│ │ Message text here...      │   │
│ │                           │   │
│ │ [Cancel] [OK]             │   │
│ └───────────────────────────┘   │
│                                 │
│ TOAST / SNACKBAR                │
│ ┌───────────────────────────┐   │
│ │ ✅ Success message  [Undo]│   │ Bottom
│ └───────────────────────────┘   │
└─────────────────────────────────┘
```

### Progress Indicators

```
┌─────────────────────────────────┐
│ PROGRESS BAR                    │
│ ┌───────────────────────────┐   │
│ │ ████████░░░░░░ 60%        │   │
│ └───────────────────────────┘   │
│                                 │
│ STEPPER                         │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│ Bước 2/4: Title                 │
│                                 │
│ CIRCULAR PROGRESS               │
│       ┌─────┐                   │
│       │ 75% │                   │
│       └─────┘                   │
│                                 │
│ LOADING SPINNER                 │
│       ┌─────┐                   │
│       │  ○  │                   │ Animated
│       └─────┘                   │
│                                 │
│ SKELETON LOADER                 │
│ ██████████████                  │ Shimmer
│ ████████                        │
│ ████████████                    │
└─────────────────────────────────┘
```

### Badges & Tags

```
┌─────────────────────────────────┐
│ BADGES                          │
│ [●1] [●12] [●99+]              │ Notification
│ [✅] [⚠️] [⏰] [🔴]            │ Status
│ [New] [Hot] [Sale]             │ Label
│                                 │
│ TAGS                            │
│ [Aggression] [Attention]       │ Category
│ [#red] [#blue] [#green]        │ Color coded
│                                 │
│ PILLS                           │
│ ┌─────┐ ┌─────┐ ┌─────┐        │
│ │ Tag1│ │ Tag2│ │ Tag3│        │ Rounded
│ └─────┘ └─────┘ └─────┘        │
└─────────────────────────────────┘
```

### Charts & Graphs

```
┌─────────────────────────────────┐
│ LINE CHART                      │
│ ┌───────────────────────────┐   │
│ │  5╷     ●                 │   │
│ │  4┼   ● │                 │   │
│ │  3┼ ● │ │ ●               │   │
│ │  2┼ │ │ │ │ ●             │   │
│ │  1┼ │ │ │ │ │             │   │
│ │  0┼─┴─┴─┴─┴─┴──           │   │
│ │   1 5 10 15 20 (days)     │   │
│ └───────────────────────────┘   │
│                                 │
│ BAR CHART                       │
│ ┌───────────────────────────┐   │
│ │ Item 1  ██████████ 50%    │   │
│ │ Item 2  ████████   40%    │   │
│ │ Item 3  ██████     30%    │   │
│ └───────────────────────────┘   │
│                                 │
│ PIE CHART                       │
│       ┌─────┐                   │
│       │ ◐   │ 45% - Category A  │
│       │  ◑  │ 30% - Category B  │
│       │   ◒ │ 25% - Category C  │
│       └─────┘                   │
│                                 │
│ HEATMAP CALENDAR                │
│ ┌───────────────────────────┐   │
│ │ M T W T F S S             │   │
│ │ ▓ ▓ ░ ░ ▓ ░ ░   Week 1   │   │
│ │ ▓ ░ ▓ ▓ ░ ░ ░   Week 2   │   │
│ │ ░ = Low  ▓ = High         │   │
│ └───────────────────────────┘   │
└─────────────────────────────────┘
```

---

## 🔄 STATE TRANSITIONS

```
┌─────────────────────────────────┐
│ BUỔI HỌC STATES                 │
│                                 │
│ ⭕ Chưa có                      │
│  ↓ [Tạo buổi học]               │
│                                 │
│ ⏰ Đã lên lịch                  │
│  ↓ [Bắt đầu ghi]                │
│                                 │
│ 🔄 Đang ghi (Draft)             │
│  ↓ [Tiếp tục ghi]               │
│  ↓ [Lưu nháp]                   │
│                                 │
│ ✅ Hoàn thành                   │
│  ↓ [Xem lại]                    │
│  ↓ [Chỉnh sửa]                  │
│                                 │
│ ⚠️ Quá hạn                      │
│  ↓ [Ghi bổ sung]                │
│                                 │
│ 🗑️ Đã xóa                       │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│ NỘI DUNG STATES                 │
│                                 │
│ ⭕ Chưa ghi                     │
│  ↓ [Nhấn để ghi]                │
│                                 │
│ 🔄 Đang ghi                     │
│  ↓ [Đánh giá mục tiêu]          │
│  ↓ [Ghi chú]                    │
│  ↓ [Ghi hành vi]                │
│                                 │
│ ✅ Đã hoàn thành                │
│  ↓ [Xem chi tiết]               │
│  ↓ [Chỉnh sửa]                  │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│ DATA SYNC STATES                │
│                                 │
│ ☁️ Synced                       │
│ 🔄 Syncing...                   │
│ ⚠️ Sync failed                  │
│ 📱 Local only (Offline)         │
│ 🔄 Pending sync                 │
└─────────────────────────────────┘
```

---

## 📏 RESPONSIVE BREAKPOINTS

```
┌─────────────────────────────────┐
│ DEVICE SIZES                    │
│                                 │
│ iPhone SE:        375 x 667 pt  │
│ iPhone 12/13:     390 x 844 pt  │
│ iPhone 14 Pro:    393 x 852 pt  │
│ iPhone 14 Pro Max: 430 x 932 pt │
│                                 │
│ Android Small:    360 x 640 dp  │
│ Android Medium:   412 x 915 dp  │
│ Android Large:    428 x 926 dp  │
│                                 │
│ Tablet Portrait:  768 x 1024 pt │
│ Tablet Landscape: 1024 x 768 pt │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│ LAYOUT ADAPTATIONS              │
│                                 │
│ Small (< 375pt):                │
│ • Single column                 │
│ • Smaller font sizes            │
│ • Compact spacing               │
│                                 │
│ Medium (375-428pt):             │
│ • Standard layout               │
│ • Normal spacing                │
│ • Default components            │
│                                 │
│ Large (> 428pt):                │
│ • Wider margins                 │
│ • Larger touch targets          │
│ • More whitespace               │
│                                 │
│ Tablet (> 600pt):               │
│ • 2-column layout               │
│ • Split view                    │
│ • Floating modals               │
└─────────────────────────────────┘
```

---

## ⚡ PERFORMANCE OPTIMIZATION

```
┌─────────────────────────────────┐
│ IMAGE OPTIMIZATION              │
│                                 │
│ • Use WebP format               │
│ • Lazy load images              │
│ • Compress uploads              │
│ • Cache thumbnails              │
│ • Progressive JPEG              │
│                                 │
│ LIST OPTIMIZATION               │
│                                 │
│ • Virtual scrolling             │
│ • Pagination (20 items/page)    │
│ • Infinite scroll with loading  │
│ • Debounced search (300ms)      │
│                                 │
│ NETWORK OPTIMIZATION            │
│                                 │
│ • Request batching              │
│ • GraphQL for flexible queries  │
│ • Compress responses (gzip)     │
│ • HTTP/2 multiplexing           │
│ • CDN for static assets         │
│                                 │
│ CACHING STRATEGY                │
│                                 │
│ • Cache-first for static        │
│ • Network-first for dynamic     │
│ • Stale-while-revalidate        │
│ • IndexedDB for large data      │
│                                 │
│ RENDER OPTIMIZATION             │
│                                 │
│ • React.memo for components     │
│ • useMemo for calculations      │
│ • useCallback for functions     │
│ • Code splitting by route       │
│ • Tree shaking unused code      │
└─────────────────────────────────┘
```

---

## 🔐 SECURITY CONSIDERATIONS

```
┌─────────────────────────────────┐
│ DATA SECURITY                   │
│                                 │
│ • Encrypt local storage         │
│ • HTTPS only                    │
│ • Token-based auth (JWT)        │
│ • Biometric auth support        │
│ • Auto logout after 30min       │
│                                 │
│ PRIVACY                         │
│                                 │
│ • GDPR compliant                │
│ • Student data anonymization    │
│ • Parental consent required     │
│ • Data export/delete options    │
│ • Audit logs for access         │
│                                 │
│ INPUT VALIDATION                │
│                                 │
│ • Server-side validation        │
│ • XSS prevention                │
│ • SQL injection protection      │
│ • File upload scanning          │
│ • Rate limiting                 │
└─────────────────────────────────┘
```

---

## 🌐 INTERNATIONALIZATION (i18n)

```
┌─────────────────────────────────┐
│ SUPPORTED LANGUAGES             │
│                                 │
│ 🇻🇳 Tiếng Việt (Primary)        │
│ 🇬🇧 English                     │
│ 🇯🇵 日本語 (Future)              │
│ 🇰🇷 한국어 (Future)              │
│                                 │
│ IMPLEMENTATION                  │
│                                 │
│ • i18next library               │
│ • JSON translation files        │
│ • RTL support ready             │
│ • Date/time localization        │
│ • Number formatting             │
│ • Currency support              │
│                                 │
│ CULTURAL CONSIDERATIONS         │
│                                 │
│ • Local date formats            │
│ • Name order (First/Last)       │
│ • Educational terminology       │
│ • Color meanings                │
│ • Icon appropriateness          │
└─────────────────────────────────┘
```

---

## 📱 PLATFORM-SPECIFIC FEATURES

```
┌─────────────────────────────────┐
│ iOS SPECIFIC                    │
│                                 │
│ • Face ID / Touch ID            │
│ • 3D Touch / Haptic Touch       │
│ • Siri Shortcuts                │
│ • Apple Pencil support (iPad)   │
│ • iCloud sync                   │
│ • Share Sheet integration       │
│ • Spotlight search              │
│ • Widget (iOS 14+)              │
│                                 │
│ ANDROID SPECIFIC                │
│                                 │
│ • Fingerprint / Face unlock     │
│ • Material Design guidelines    │
│ • Google Assistant actions      │
│ • Android Auto backup           │
│ • Share menu integration        │
│ • App Shortcuts                 │
│ • Widgets                       │
│ • Split screen support          │
└─────────────────────────────────┘
```

---

## 🎓 FINAL NOTES

### Key UX Improvements from Original:

1. ✅ **Mobile-optimized layouts** - Single column, large touch targets
2. ✅ **Bottom navigation** - Thumb-friendly zone
3. ✅ **Progressive disclosure** - Collapse/expand patterns
4. ✅ **Gesture-based** - Swipe actions, pull-to-refresh
5. ✅ **Visual feedback** - Loading, success, error states
6. ✅ **Offline support** - Local-first with sync
7. ✅ **Quick actions** - Reduced steps for common tasks
8. ✅ **Empty states** - Onboarding and guidance
9. ✅ **Performance** - Lazy loading, pagination
10. ✅ **Accessibility** - Large text, high contrast

### Design System Benefits:

- **Consistency** across all screens
- **Reusable components** reduce development time
- **Scalable** for future features
- **Maintainable** with clear patterns
- **Professional** appearance

### Development Ready:

- All screens documented
- Component library defined
- Interaction patterns specified
- Technical requirements outlined
- Platform considerations included

**Status: ✅ Complete Mobile Wireframe Package**

```[👤 Tôi]│ Tab Bar
└─────────────────────────────────┘

Gestures:
• Pull down = Refresh
• Swipe left on card = Quick edit
• Swipe right on card = Mark done
• Long press = More options
```

---

## 1. DASHBOARD (Home)

```
┌─────────────────────────────────┐
│ 9:41          🔋 100% ••••• 📶 │ Status Bar
├─────────────────────────────────┤
│                                 │
│  Xin chào, Cô Hoa! 👋          │ 24pt Bold
│  Thứ Hai, 22 Tháng 10          │ 14pt Regular
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⚡ CẦN LÀM HÔM NAY        │ │
│  │                           │ │
│  │ 🔴 3 buổi chưa ghi nhật ký│ │
│  │ 🟡 2 báo cáo cần hoàn tất │ │
│  │                           │ │
│  │ [Xem tất cả →]            │ │
│  └───────────────────────────┘ │
│                                 │
│  🔍 Tìm học sinh hoặc lọc...   │
│                                 │
│  📌 Ưu tiên (2)          [Sửa] │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ┌──┐                      │ │
│  │ │BA│ Bé An • 5 tuổi    ⚠️│ │
│  │ └──┘                      │ │
│  │ 2 buổi chưa ghi          │ │
│  │                           │ │
│  │ [Ghi nhật ký] [Chi tiết→]│ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ┌──┐                      │ │
│  │ │BB│ Bé Bình • 4 tuổi   ✅│ │
│  │ └──┘                      │ │
│  │ Cập nhật 30 phút trước   │ │
│  │                           │ │
│  │ [Xem báo cáo] [Chi tiết→]│ │
│  └───────────────────────────┘ │
│                                 │
│  👥 Tất cả học sinh (6)        │
│  [🔲 Lưới] [📋 Danh sách]      │
│                                 │
│  ┌─────────┬─────────┬───────┐│
│  │ ┌──┐    │ ┌──┐    │ ┌──┐  ││
│  │ │BC│ ✅ │ │BD│ ⏰ │ │BE│⚠️││
│  │ └──┘    │ └──┘    │ └──┘  ││
│  │ Bé Châu │ Bé Dung │ Bé Em ││
│  └─────────┴─────────┴───────┘│
│                                 │
│  ┌─────────┬─────────┬───────┐│
│  │ ┌──┐    │ ┌──┐    │ ┌──┐  ││
│  │ │BF│    │ │BG│    │ [+]   ││
│  │ └──┘    │ └──┘    │ Thêm  ││
│  │ Bé Phát │ Bé Giang│HS     ││
│  └─────────┴─────────┴───────┘│
│                                 │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Pull down = Refresh
• Swipe left on item = Add to favorites
• Tap category = Filter by category
```

---

## 2. HỌC SINH - CHI TIẾT

```
┌─────────────────────────────────┐
│ 9:41      ← Bé An     ⋮  📤    │ Nav Bar
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐ │
│  │       ┌─────────┐          │ │
│  │       │   BA    │          │ │ Avatar 80x80
│  │       └─────────┘          │ │
│  │                            │ │
│  │    Bé An (Nguyễn Văn An)  │ │
│  │    5 tuổi • Nam            │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 Thống kê                   │
│  ┌──────┬──────┬──────┬──────┐│
│  │ 89%  │ 12   │  8   │  45  ││
│  │ Hoàn │ Buổi │ Hành │ Giờ  ││
│  │ thành│ học  │ vi   │ học  ││
│  └──────┴──────┴──────┴──────┘│
│                                 │
│  ─────────────────────────────  │
│                                 │
│  📅 Lịch Buổi học              │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Tháng 10/2025      ◀ Tuần▶│ │
│  │                            │ │
│  │ T2  T3  T4  T5  T6  T7  CN │ │
│  │ ──  ──  ──  ──  ──  ──  ── │ │
│  │ 21  22  23  24  25  26  27 │ │
│  │ ⚠️  ✅  🔄  ⏰  ⭕  ⭕  ⭕ │ │
│  │                            │ │
│  │ • ✅ Hoàn thành            │ │
│  │ • 🔄 Đang ghi              │ │
│  │ • ⏰ Đã lên lịch           │ │
│  │ • ⚠️ Quá hạn/Chưa ghi     │ │
│  │ • ⭕ Chưa có buổi          │ │
│  └───────────────────────────┘ │
│                                 │
│  🎯 Hôm nay - T3, 22/10        │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ BUỔI SÁNG              │ │
│  │ 8:00 - 11:00              │ │
│  │                            │ │
│  │ ████████████ 100%         │ │
│  │ 5/5 nội dung hoàn thành   │ │
│  │ Ghi lúc: 11:30            │ │
│  │                            │ │
│  │ [Xem lại] [Chia sẻ]       │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔄 BUỔI CHIỀU • ĐANG GHI  │ │
│  │ 14:00 - 16:30             │ │
│  │                            │ │
│  │ ████████░░░░ 60%          │ │
│  │ 3/5 nội dung đã ghi       │ │
│  │ Lưu lần cuối: 15:20       │ │
│  │                            │ │
│  │ [TIẾP TỤC GHI →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ⏰ Sắp tới                     │
│                                 │
│  ┌───────────────────────────┐ │
│  │ T4, 23/10 • Buổi sáng     │ │
│  │ 5 nội dung • Chưa bắt đầu │ │
│  │ [Xem trước]               │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ TẠO BUỔI HỌC MỚI       │ │ CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Swipe calendar left/right = Change week
• Tap date = Jump to that day
• Tap session card = Open detail
• Pull down = Refresh data
```

---

## 3. BOTTOM SHEET - CHỌN PHƯƠNG THỨC TẠO

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│                                 │
│     ┌───────────────────────┐   │
│     │ ──                    │   │ Handle
│     │                       │   │
│     │ Tạo buổi học mới      │   │ 20pt Bold
│     │                       │   │
│     │ ┌─────────────────┐   │   │
│     │ │  ✍️              │   │   │
│     │ │  Tạo thủ công   │   │   │
│     │ │                 │   │   │
│     │ │  Nhập từng bước │   │   │
│     │ │  chi tiết       │   │   │
│     │ │                 │   │   │
│     │ │  [Chọn →]       │   │   │
│     │ └─────────────────┘   │   │
│     │                       │   │
│     │ ┌─────────────────┐   │   │
│     │ │  🤖             │   │   │
│     │ │  Tạo với AI     │   │   │
│     │ │                 │   │   │
│     │ │  Upload giáo án │   │   │
│     │ │  AI tự phân tích│   │   │
│     │ │                 │   │   │
│     │ │  [Chọn →]       │   │   │
│     │ └─────────────────┘   │   │
│     │                       │   │
│     │ [Hủy]                 │   │
│     │                       │   │
│     └───────────────────────┘   │
│                                 │
└─────────────────────────────────┘

Gestures:
• Swipe down = Close
• Tap outside = Close
• Tap option = Select & Continue
```

---

## 4. TẠO THỦ CÔNG - STEP 1 (Basic Info)

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 1/3: Thông tin cơ bản    │ Stepper
│                                 │
│  📅 Ngày học *                 │
│  ┌───────────────────────────┐ │
│  │ 22/10/2025            📅  │ │ Date picker
│  └───────────────────────────┘ │
│                                 │
│  🕐 Buổi *                     │
│  ┌─────────────┬─────────────┐ │
│  │ ● Sáng      │ ○ Chiều     │ │ Toggle
│  │ 8:00-11:30  │ 14:00-17:00 │ │
│  └─────────────┴─────────────┘ │
│                                 │
│  ⏰ Thời gian                  │
│  ┌──────────┬───┬──────────┐  │
│  │   8:00   │ - │  11:30   │  │ Time picker
│  └──────────┴───┴──────────┘  │
│                                 │
│  📝 Ghi chú (Tùy chọn)         │
│  ┌───────────────────────────┐ │
│  │ Buổi học về nhận diện màu │ │
│  │ sắc và vận động cơ bản... │ │
│  │                           │ │
│  └───────────────────────────┘ │
│                                 │
│                                 │
│                                 │
│                                 │
│  ┌───────────────────────────┐ │
│  │    TIẾP TỤC (1/3) →       │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 5. TẠO THỦ CÔNG - STEP 2 (Content)

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 2/3: Nội dung dạy học    │
│                                 │
│  📚 Danh sách nội dung (2)     │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⋮⋮ 1. Phân biệt màu sắc  ⋮│ │ Drag handle
│  │                           │ │
│  │    🎯 Mục tiêu: 3         │ │
│  │    • Gọi tên màu đỏ       │ │
│  │    • Nhận diện màu xanh   │ │
│  │    • Phân biệt 2 màu      │ │
│  │                           │ │
│  │    [✏️ Sửa]  [🗑️ Xóa]     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⋮⋮ 2. Hoạt động vận động ⋮│ │
│  │                           │ │
│  │    🎯 Mục tiêu: 4         │ │
│  │    • Chạy thẳng 10m       │ │
│  │    • Nhảy tại chỗ 5 lần   │ │
│  │    • Bắt bóng bằng 2 tay  │ │
│  │    • Ném bóng vào rổ      │ │
│  │                           │ │
│  │    [✏️ Sửa]  [🗑️ Xóa]     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ Thêm nội dung mới       │ │ Secondary CTA
│  └───────────────────────────┘ │
│                                 │
│  💡 Gợi ý: Kéo thả để sắp xếp  │
│                                 │
│  ┌───────────────────────────┐ │
│  │    TIẾP TỤC (2/3) →       │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Drag ⋮⋮ = Reorder items
• Swipe left = Quick delete
• Tap item = Expand/collapse
```

---

## 6. MODAL - THÊM NỘI DUNG

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│   ┌─────────────────────────┐   │
│   │ ──                      │   │
│   │                         │   │
│   │ Thêm nội dung mới       │   │
│   │                         │   │
│   │ 📝 Tên nội dung *       │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ VD: Nhận diện màu   │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ 📄 Mô tả               │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ Học nhận biết và... │ │   │
│   │ │                     │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ 🎯 Mục tiêu học tập    │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 1. Gọi tên màu [✕] │ │   │
│   │ │ 2. Nhận diện màu[✕]│ │   │
│   │ │ 3. Phân biệt màu[✕]│ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ [➕ Thêm mục tiêu]      │   │
│   │                         │   │
│   │ ───────────────────────  │   │
│   │                         │   │
│   │ [Hủy]    [✅ Thêm]     │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

---

## 7. TẠO THỦ CÔNG - STEP 3 (Review)

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 3/3: Xem lại & Xác nhận  │
│                                 │
│  ✅ Tổng quan                   │
│  ┌───────────────────────────┐ │
│  │ 📅 Thứ Ba, 22/10/2025     │ │
│  │ ⏰ Buổi sáng (8:00-11:30) │ │
│  │ 📚 2 nội dung dạy học     │ │
│  │ 🎯 Tổng 7 mục tiêu        │ │
│  └───────────────────────────┘ │
│                                 │
│  📋 Chi tiết nội dung          │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 1. Phân biệt màu sắc   ↓  │ │
│  │                           │ │
│  │ Mục tiêu:                 │ │
│  │ • Gọi tên màu đỏ          │ │
│  │ • Nhận diện màu xanh      │ │
│  │ • Phân biệt 2 màu         │ │
│  │                           │ │
│  │ [Sửa]                     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 2. Hoạt động vận động  ↓  │ │
│  │                           │ │
│  │ Mục tiêu:                 │ │
│  │ • Chạy thẳng 10m          │ │
│  │ • Nhảy tại chỗ 5 lần      │ │
│  │ • Bắt bóng bằng 2 tay     │ │
│  │ • Ném bóng vào rổ         │ │
│  │                           │ │
│  │ [Sửa]                     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │  💾 TẠO BUỔI HỌC          │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]                  │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 8. AI UPLOAD - STEP 1

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo với AI     [✕]    │
├─────────────────────────────────┤
│                                 │
│  📂 Upload giáo án              │
│                                 │
│  ┌───────────────────────────┐ │
│  │         📄                │ │
│  │                           │ │
│  │   Kéo thả file vào đây    │ │
│  │   hoặc nhấn để chọn       │ │
│  │                           │ │
│  │   ✓ PDF, DOCX, TXT, JPG   │ │
│  │   ⚠️ Tối đa 10MB          │ │
│  │                           │ │
│  │   [📱 Chọn file]          │ │
│  │                           │ │
│  └───────────────────────────┘ │
│                                 │
│  ──────── hoặc ────────        │
│                                 │
│  📝 Dán nội dung văn bản       │
│  ┌───────────────────────────┐ │
│  │ Thứ 2:                    │ │
│  │ - Hoạt động 1: Ai đây?    │ │
│  │ - Hoạt động 2: Vận động   │ │
│  │ Thứ 3:                    │ │
│  │ - Hoạt động 1: Màu sắc... │ │
│  │                           │ │
│  │ [0/5000 ký tự]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ✨ AI sẽ giúp bạn:            │
│  • Phân tích cấu trúc giáo án  │
│  • Tự động tạo buổi học        │
│  • Trích xuất mục tiêu         │
│  • Sắp xếp theo ngày/buổi      │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🚀 PHÂN TÍCH NGAY        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 9. AI PROCESSING

```
┌─────────────────────────────────┐
│ 9:41   ← AI đang xử lý  [✕]    │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   🤖    │             │ Animation
│         └─────────┘             │
│                                 │
│  AI đang phân tích giáo án...  │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ████████████░░░░░░  65%   │ │ Progress bar
│  └───────────────────────────┘ │
│                                 │
│  ✅ Đọc file thành công         │
│  ✅ Trích xuất cấu trúc         │
│  🔄 Phân tích nội dung...       │
│  ⏳ Tạo danh sách buổi học      │
│  ⏳ Gợi ý mục tiêu học tập      │
│                                 │
│  ⏱️ Ước tính: ~20 giây          │
│                                 │
│                                 │
│  💡 Mẹo: AI có thể phân tích    │
│  nhiều tuần giáo án cùng lúc   │
│                                 │
│                                 │
│  [Hủy phân tích]               │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 10. AI PREVIEW & EDIT

```
┌─────────────────────────────────┐
│ 9:41  ← Kết quả AI    💾 [✕]   │
├─────────────────────────────────┤
│                                 │
│  ✨ AI đã tạo 12 buổi học       │
│                                 │
│  [Chọn tất cả] [Bỏ chọn]       │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ☑️ T2, 21/10 • Sáng  ↕️   │ │ Collapsible
│  │ ──────────────────────────│ │
│  │ 8:00-11:00 • 3 nội dung   │ │
│  │                           │ │
│  │ 1. Ai đây? (Nhận diện)    │ │
│  │    • Nhận biết tên mình   │ │
│  │    • Trỏ vào ảnh bản thân │ │
│  │    • Phản ứng khi gọi     │ │
│  │                           │ │
│  │ 2. Hoạt động vận động     │ │
│  │    • Chạy thẳng 10m       │ │
│  │    • Nhảy 5 lần           │ │
│  │    • Bắt bóng 2 tay       │ │
│  │                           │ │
│  │ 3. Nghỉ giải lao          │ │
│  │    • Tự uống nước         │ │
│  │    • Rửa tay đúng cách    │ │
│  │                           │ │
│  │ [✏️ Sửa] [🗑️ Xóa] [📋 Copy]│ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ☑️ T2, 21/10 • Chiều ↕️   │ │
│  │ ──────────────────────────│ │
│  │ 14:00-16:30 • 4 nội dung  │ │
│  │ [Nhấn để xem]             │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ☑️ T3, 22/10 • Sáng  ↕️   │ │
│  │ ──────────────────────────│ │
│  │ 14:00-16:30 • 4 nội dung  │ │
│  │ [Nhấn để xem]             │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ + 9 buổi khác...          │ │
│  │ [Mở rộng tất cả]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ TẠO 12 BUỔI HỌC (12)   │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [Sửa hàng loạt] [Chọn lại]    │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Tap header = Expand/collapse
• Swipe left on item = Quick delete
• Long press = Select multiple
• Pull down = Refresh
```

---

## 11. GHI NHẬT KÝ - OVERVIEW

```
┌─────────────────────────────────┐
│ 9:41  ← T3, 22/10 Sáng  💾 ⋮   │
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐ │
│  │ BA Bé An • 5 tuổi         │ │
│  │ Buổi sáng: 8:00-11:00     │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 Tiến độ                     │
│  ┌───────────────────────────┐ │
│  │ ████████░░░░░░ 60%        │ │
│  │ 3/5 nội dung hoàn thành   │ │
│  │ Còn lại: 2 nội dung       │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Nhấn vào nội dung để ghi   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ 1. Phân biệt màu sắc   │ │
│  │ ──────────────────────────│ │
│  │ 🎯 3/3 mục tiêu đạt       │ │
│  │ ⏰ Hoàn thành: 09:15      │ │
│  │ 😊 Thái độ: Tốt           │ │
│  │                           │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ 2. Vận động tinh       │ │
│  │ ──────────────────────────│ │
│  │ 🎯 4/4 mục tiêu đạt       │ │
│  │ ⏰ Hoàn thành: 10:00      │ │
│  │ 😐 Thái độ: Trung bình    │ │
│  │                           │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ 3. Nhận biết cảm xúc   │ │
│  │ ──────────────────────────│ │
│  │ 🎯 2/3 mục tiêu đạt       │ │
│  │ ⏰ Hoàn thành: 10:30      │ │
│  │ ⚠️ 1 hành vi ghi nhận     │ │
│  │                           │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⭕ 4. Hoạt động nhóm       │ │ Tappable
│  │ ──────────────────────────│ │
│  │ 🎯 3 mục tiêu cần ghi     │ │
│  │ ⏰ Chưa ghi               │ │
│  │                           │ │
│  │ [NHẤN ĐỂ GHI →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⭕ 5. Ôn tập đánh giá      │ │
│  │ ──────────────────────────│ │
│  │ 🎯 2 mục tiêu cần ghi     │ │
│  │ ⏰ Chưa ghi               │ │
│  │                           │ │
│  │ [NHẤN ĐỂ GHI →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  [➕ Thêm nội dung khác]        │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ HOÀN TẤT BUỔI HỌC      │ │ Disabled until 100%
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Tap completed item = View detail
• Tap pending item = Start recording
• Swipe left = Quick options
• Pull down = Refresh
```

---

## 12. GHI NHẬT KÝ - CHI TIẾT NỘI DUNG

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ⚠️ Nhớ lưu thường xuyên       │
│  Tự động lưu: 2 phút trước     │
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  1/4: Đánh giá Mục tiêu        │
│                                 │
│  📋 Danh sách Mục tiêu          │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 1. Gọi tên màu đỏ         │ │
│  │                           │ │
│  │ Đánh giá:                 │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │ Radio buttons
│  │                           │ │
│  │ 📝 Ghi chú nhanh:         │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ Con đã gọi đúng...  │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 2. Nhận diện màu đỏ       │ │
│  │                           │ │
│  │ Đánh giá:                 │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 📝 Ghi chú: (Tùy chọn)    │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ ...                 │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 3. Phân biệt đỏ/xanh      │ │
│  │                           │ │
│  │ Đánh giá:                 │ │
│  │ ○ Đạt  ● Đang học ○ Chưa │ │
│  │                           │ │
│  │ 📝 Ghi chú:               │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ Còn nhầm lẫn đôi khi│   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │   TIẾP TỤC (1/4) →        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [Lưu nháp]  [Bỏ qua bước này] │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 13. GHI NHẬT KÝ - THÁI ĐỘ HỌC TẬP

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  2/4: Thái độ Học tập          │
│                                 │
│  😊 Tâm trạng chung             │
│                                 │
│  ┌───────────────────────────┐ │
│  │   😊   😐   😕   😢   😡  │ │ Emoji selector
│  │   ●    ○    ○    ○    ○   │ │
│  └───────────────────────────┘ │
│                                 │
│  🤝 Mức độ hợp tác              │
│                                 │
│  ├────●────┼────┼────┼────┤   │ Slider
│  Rất tốt              Khó khăn │
│                                 │
│  🎯 Mức độ tập trung            │
│                                 │
│  ├────┼────●────┼────┼────┤   │ Slider
│  Rất tốt              Khó khăn │
│                                 │
│  💪 Mức độ tự lập               │
│                                 │
│  ├────●────┼────┼────┼────┤   │ Slider
│  Rất tốt              Khó khăn │
│                                 │
│  📝 Ghi chú về thái độ         │
│  ┌───────────────────────────┐ │
│  │ Con rất vui và hợp tác    │ │
│  │ trong buổi học hôm nay.   │ │
│  │ Tuy nhiên có lúc mất tập  │ │
│  │ trung khi nghe tiếng ồn...│ │
│  │                           │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │   TIẾP TỤC (2/4) →        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]     [Lưu nháp]   │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘

Gestures:
• Tap emoji = Select mood
• Drag slider = Adjust level
• Tap text area = Open keyboard
```

---

## 14. GHI NHẬT KÝ - GHI CHÚ GIÁO VIÊN

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  3/4: Ghi chú Giáo viên        │
│                                 │
│  📝 Quan sát chung              │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Hôm nay con đã thể hiện   │ │ Text area
│  │ sự tiến bộ rõ rệt trong   │ │
│  │ việc nhận diện màu sắc.   │ │
│  │ Con có thể gọi đúng tên   │ │
│  │ màu đỏ và xanh. Tuy nhiên │ │
│  │ vẫn còn nhầm lẫn khi phân │ │
│  │ biệt giữa xanh lá và xanh │ │
│  │ dương...                  │ │
│  │                           │ │
│  │ [250/1000 ký tự]          │ │
│  └───────────────────────────┘ │
│                                 │
│  🎤 Hoặc ghi âm               │ │
│  ┌───────────────────────────┐ │
│  │  🎤 00:00                 │ │ Voice recorder
│  │  [Nhấn để ghi âm]         │ │
│  └───────────────────────────┘ │
│                                 │
│  📸 Đính kèm ảnh/video         │
│  ┌───────────────────────────┐ │
│  │ [📷] [🖼️] [🎥]            │ │
│  │                           │ │
│  │ Đã thêm: 2 ảnh            │ │
│  │ ┌──┐ ┌──┐                │ │
│  │ │📷│ │📷│ [+ Thêm]       │ │
│  │ └──┘ └──┘                │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Gợi ý mẫu câu:             │
│  • "Con đã thể hiện..."        │
│  • "Cần cải thiện..."          │
│  • "Điểm nổi bật..."           │
│                                 │
│  ┌───────────────────────────┐ │
│  │   TIẾP TỤC (3/4) →        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]     [Lưu nháp]   │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 15. GHI NHẬT KÝ - HÀNH VI A-B-C

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  4/4: Ghi nhận Hành vi         │
│                                 │
│  ⚠️ Đã ghi nhận: 1 hành vi      │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🏃 Tự ý rời khỏi chỗ      │ │
│  │ ──────────────────────────│ │
│  │ 🅰️ Yêu cầu làm bài khó    │ │
│  │ 🅱️ Rời chỗ, đi lại        │ │
│  │ ©️ Được nghỉ 5 phút        │ │
│  │ 📊 Mức độ: Trung bình     │ │
│  │ 🕐 10:15                  │ │
│  │                           │ │
│  │ [Xem] [Sửa] [Xóa]         │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ THÊM HÀNH VI MỚI        │ │ Secondary CTA
│  └───────────────────────────┘ │
│                                 │
│  💡 Không có hành vi đặc biệt? │
│  Bạn có thể bỏ qua bước này    │
│                                 │
│                                 │
│                                 │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ HOÀN TẤT & LƯU         │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]  [Bỏ qua bước]   │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

---

## 16. BOTTOM SHEET - THÊM HÀNH VI A-B-C

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│   ┌─────────────────────────┐   │
│   │ ──                      │   │ Swipeable
│   │                         │   │
│   │ Ghi nhận Hành vi        │   │
│   │                         │   │
│   │ 💡 Chọn nhanh từ thư viện│  │
│   │                         │   │
│   │ 🅰️ Tình huống xảy ra    │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🔍 Tìm hoặc chọn... │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ Gợi ý phổ biến:         │   │
│   │ • ⚡ Yêu cầu bài khó     │   │
│   │ • 😴 Buồn ngủ/mệt       │   │
│   │ • 🎵 Môi trường ồn      │   │
│   │ • 🍎 Không được đồ ăn   │   │
│   │ • ➕ Tình huống khác...  │   │
│   │                         │   │
│   │ [Tiếp →]                │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘

[Swipe up to Step 2: Behavior]

┌─────────────────────────────────┐
│   ┌─────────────────────────┐   │
│   │ ──                      │   │
│   │                         │   │
│   │ 🅱️ Hành vi cụ thể       │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🔍 Tìm trong thư viện│ │  │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ ⭐ Thường dùng:         │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ ⚠️ Ném đồ vật  127× │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🏃 Tự ý rời chỗ 98× │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 📢 La hét       85× │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ [📚 Xem tất cả 127 hành vi]│ │
│   │                         │   │
│   │ [← Quay] [Tiếp →]      │   │
│   │                         │   │
│   └─────────────────────────┘   │
└─────────────────────────────────┘

[Swipe up to Step 3: Consequence]

┌─────────────────────────────────┐
│   ┌─────────────────────────┐   │
│   │ ──                      │   │
│   │                         │   │
│   │ ©️ Kết quả sau đó        │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🔍 Tìm hoặc chọn... │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ Phổ biến:               │   │
│   │ • ✅ Được nghỉ ngơi     │   │
│   │ • 👁️ Được chú ý         │   │
│   │ • 🎁 Được đồ chơi       │   │
│   │ • 🚫 Bị nhắc nhở        │   │
│   │ • ⏸️ Tạm dừng hoạt động │   │
│   │ • ➕ Kết quả khác...     │   │
│   │                         │   │
│   │ 📊 Mức độ hành vi       │   │
│   │ ○ ○ ● ○ ○              │   │
│   │ Nhẹ  →  Nghiêm trọng   │   │
│   │                         │   │
│   │ 🕐 Thời điểm            │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 10:15            🕐 │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ 📝 Mô tả chi tiết (TĐ)  │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ Con ném bút xuống...│ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ [← Quay] [💾 Lưu]      │   │
│   │ [📋 Lưu làm mẫu]       │   │
│   │                         │   │
│   └─────────────────────────┘   │
└─────────────────────────────────┘
```

---

## 17. TỪ ĐIỂN HÀNH VI - TRANG CHỦ

```
┌─────────────────────────────────┐
│ 9:41                        🔍  │
├─────────────────────────────────┤
│                                 │
│  📚 Từ điển Hành vi             │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔍 Tìm kiếm hành vi...    │ │ Search bar
│  └───────────────────────────┘ │
│                                 │
│  [🏷️ Lọc] [📊 Sắp xếp] [⭐ Yêu thích]│
│                                 │
│  ⭐ Yêu thích của bạn (3)       │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⚠️ Ném đồ vật          ⭐ │ │
│  │ Aggression • 127× hệ thống│ │
│  │ 12× học sinh của bạn      │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🏃 Tự ý rời chỗ        ⭐ │ │
│  │ Avoidance • 98× hệ thống  │ │
│  │ 8× học sinh của bạn       │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📢 La hét              ⭐ │ │
│  │ Attention • 85× hệ thống  │ │
│  │ 5× học sinh của bạn       │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  🔥 Xu hướng tuần này           │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 😤 Cáu gắt/Bực bội   ↗️45×│ │
│  │ ┌──────────────────────┐  │ │
│  │ │████████░░ +15%       │  │ │ Trend
│  │ └──────────────────────┘  │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🙅 Từ chối tuân theo ↗️32×│ │
│  │ ┌──────────────────────┐  │ │
│  │ │██████░░░░ +20%       │  │ │
│  │ └──────────────────────┘  │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  📂 Danh mục                    │
│                                 │
│  ┌─────┬─────┬─────┬─────┐     │
│  │Aggr │Avoid│Attn │Self │     │ Grid
│  │ ⚠️  │ 🏃  │ 📢  │ 🔄  │     │
│  │ 45  │ 32  │ 28  │ 22  │     │
│  └─────┴─────┴─────┴─────┘     │
│                                 │
│  [Xem tất cả 127 hành vi →]    │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo]
```
