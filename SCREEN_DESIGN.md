# Thiết kế Chi tiết Màn hình - Educare Connect

## Mục lục

1. [Dashboard - Màn hình Chính](#1-dashboard---màn-hình-chính)
2. [Màn hình Nhật ký Buổi học](#2-màn-hình-nhật-ký-buổi-học)
3. [Form Chi tiết Nội dung](#3-form-chi-tiết-nội-dung)
4. [Popup Form A-B-C](#4-popup-form-a-b-c)
5. [Màn hình Từ điển Hành vi](#5-màn-hình-từ-điển-hành-vi)
6. [Màn hình Chi tiết Hành vi](#6-màn-hình-chi-tiết-hành-vi)
7. [Màn hình Báo cáo Phân tích](#7-màn-hình-báo-cáo-phân-tích)

---

## 1. Dashboard - Màn hình Chính

### Mục đích

- Điểm khởi đầu của ứng dụng
- Hiển thị danh sách học sinh
- Truy cập nhanh các chức năng chính

### Layout Wireframe

```
┌─────────────────────────────────────────┐
│  ☰  Educare Connect         🔔  👤     │ Header
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
│  │  👦 Bé An (Nguyễn Văn An)      │   │
│  │  5 tuổi • Tự kỷ               │   │
│  │                                 │   │
│  │  [📝 Ghi Nhật ký]  [📈 Phân tích]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👧 Bé Bình (Trần Thị Bình)    │   │
│  │  4 tuổi • Chậm phát triển      │   │
│  │                                 │   │
│  │  [📝 Ghi Nhật ký]  [📈 Phân tích]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👦 Bé Châu (...)              │   │
│  │  ...                           │   │
│  └─────────────────────────────────┘   │
│                                         │
├─────────────────────────────────────────┤
│  [🏠 Trang chủ] [📖 Từ điển] [⚙️ Cài đặt]│ Bottom Nav
└─────────────────────────────────────────┘
```

### Components

#### 1.1. Header

- **Logo/Tên App**: "Educare Connect"
- **Icon thông báo**: 🔔 (số badge nếu có thông báo mới)
- **Avatar giáo viên**: 👤 (link đến profile)

#### 1.2. Welcome Section

- **Lời chào**: "Xin chào, [Tên giáo viên]!"
- **Ngày hiện tại**: "Hôm nay: Thứ Hai, 22/10/2025"

#### 1.3. Search Bar

- **Placeholder**: "🔍 Tìm kiếm học sinh..."
- **Chức năng**: Lọc danh sách học sinh theo tên

#### 1.4. Student Card (Thẻ học sinh)

**Thông tin hiển thị**:

- Icon giới tính (👦/👧)
- Tên đầy đủ và tên thường gọi
- Tuổi
- Chẩn đoán/Tình trạng

**Hành động**:

- **Nút chính 1**: "📝 Ghi Nhật ký" → Chuyển đến Màn hình Nhật ký Buổi học
- **Nút chính 2**: "📈 Phân tích" → Chuyển đến Màn hình Báo cáo Phân tích

**Trạng thái**:

- Badge "Đã ghi" nếu đã hoàn thành nhật ký hôm nay
- Màu sắc: Xanh (đã ghi), Xám (chưa ghi)

#### 1.5. Bottom Navigation

- **🏠 Trang chủ**: Dashboard (active)
- **📖 Từ điển**: Màn hình Từ điển Hành vi
- **⚙️ Cài đặt**: Settings

### Tương tác

| Hành động                     | Kết quả                               |
| ----------------------------- | ------------------------------------- |
| Tap vào Student Card          | Mở menu hoặc highlight card           |
| Tap "📝 Ghi Nhật ký"          | Navigate → Màn hình Nhật ký Buổi học  |
| Tap "📈 Phân tích"            | Navigate → Màn hình Báo cáo Phân tích |
| Tap "📖 Từ điển" (Bottom Nav) | Navigate → Màn hình Từ điển Hành vi   |
| Pull to refresh               | Refresh danh sách học sinh            |

---

## 2. Màn hình Nhật ký Buổi học

### Mục đích

- Hiển thị các nội dung dạy học đã lên kế hoạch
- Cho phép giáo viên ghi nhận từng nội dung
- Hỗ trợ ghi nhật ký cho các ngày trước (retroactive logging) khi giáo viên quên ghi trong ngày thực tế

### Layout Wireframe

```
┌─────────────────────────────────────────┐
│  ← Nhật ký Buổi học             ⋮      │ Header
├─────────────────────────────────────────┤
│                                         │
│  👦 Bé An (Nguyễn Văn An)              │
│  📅 Thứ Hai, 22/10/2025                │
│  🕐 Buổi sáng (8:00 - 11:00)           │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  Nội dung Dạy học (3/5 đã hoàn thành)  │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ✅ Nội dung 1                  │   │
│  │ Phân biệt màu sắc              │   │
│  │ Đã hoàn thành • 09:15          │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⭕ Nội dung 2                  │   │
│  │ Kỹ năng vận động tinh          │   │
│  │ Nhấn để ghi nhận               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ✅ Nội dung 3                  │   │
│  │ Giao tiếp xã hội               │   │
│  │ Đã hoàn thành • 10:30          │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⭕ Nội dung 4                  │   │
│  │ Nhận biết cảm xúc              │   │
│  │ Nhấn để ghi nhận               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⭕ Nội dung 5                  │   │
│  │ Kỹ năng tự phục vụ             │   │
│  │ Nhấn để ghi nhận               │   │
│  └─────────────────────────────────┘   │
│                                         │
│         [Hoàn tất Buổi học]            │
└─────────────────────────────────────────┘
```

### Components

#### 2.1. Header

- **Back button**: ← (Quay về Dashboard)
- **Title**: "Nhật ký Buổi học"
- **Menu**: ⋮ (Tùy chọn: Chia sẻ, Xuất, v.v.)

#### 2.2. Session Info

- **Tên học sinh**: 👦 Bé An (Nguyễn Văn An)
- **Ngày**: 📅 Thứ Hai, 22/10/2025
- **Buổi học**: 🕐 Buổi sáng (8:00 - 11:00)

#### Date Selector / Date Pill

- Khi mở màn hình Nhật ký Buổi học, hiển thị rõ ràng ngày đang được chỉnh sửa ở dạng "Date Pill" ngay dưới tên học sinh.
- Format: 📅 Thứ Hai, 22/10/2025 • Trạng thái: "Hôm nay" / "Retroactive" (màu khác nhau)
- Tap vào Date Pill sẽ mở Date Picker (native) để chọn ngày khác (retroactive). Sau khi chọn ngày, giao diện cập nhật tất cả timestamps liên quan.
- Nếu đang chỉnh sửa cho ngày trước (retroactive), hiển thị badge nhỏ: "Retroactive entry" (màu vàng/amber) và tooltip: "Bạn đang ghi cho ngày 20/10/2025. Mọi timestamp mặc định sẽ theo ngày này (recorded_for_date)".

#### Calendar & Unlogged Sessions Card

- Dashboard và màn hình Nhật ký hỗ trợ một card nhỏ dạng Mini-Calendar ở phần đầu hoặc dưới tên học sinh, hiển thị các ngày đã/chuẩn bị ghi/ chưa ghi.
- Mini-Calendar highlights:
  - Xanh: Đã ghi
  - Xám: Chưa ghi
  - Vàng: Retroactive entries tồn tại (ngày đã được ghi nhưng không phải hôm nay)
- Dưới Mini-Calendar có một card "Unlogged Sessions" liệt kê các buổi đã lên kế hoạch nhưng chưa được ghi cho khoảng thời gian đã chọn. Tapping vào một item trong danh sách sẽ mở màn hình Nhật ký cho chính ngày/buổi đó (với Date Pill đã set tương ứng).

#### Reminders & Notifications UI

- Trong Settings, cho phép bật/tắt Reminders với các tùy chọn: Hằng ngày (08:00), Trước buổi (30 phút), Không nhắc.
- Khi Reminders bật, hiển thị local notification vào thời điểm đã chọn.
- Trong Dashboard, hiển thị một small banner "Bạn có 2 buổi chưa ghi hôm nay" kèm nút "Ghi ngay".
- Khi giáo viên mở màn hình Nhật ký mà hệ thống phát hiện có unlogged sessions trong lịch (ví dụ, hôm qua có buổi chưa ghi), hiển thị modal nhẹ: "Phát hiện buổi chưa ghi vào 21/10/2025 — Ghi bây giờ / Nhắc lại sau".

#### Metadata & Timestamps

- Mỗi bản ghi lưu hai trường thời gian chính:
  - recorded_for_date: date (the day the session happened) — dùng để phân loại ngày/thống kê
  - recorded_at: timestamp (when entry was created) — dùng để audit và hiển thị dòng thời gian
- Khi giáo viên chỉnh sửa một entry retroactively, giữ nguyên recorded_for_date nhưng cập nhật recorded_at để phản ánh thời gian chỉnh sửa (và ghi log thay đổi).

#### 2.3. Progress Indicator

- **Text**: "Nội dung Dạy học (3/5 đã hoàn thành)"
- **Progress bar**: 60% (3/5)

#### 2.4. Content Card (Thẻ nội dung)

**Trạng thái "Chưa hoàn thành"**:

```
┌─────────────────────────────────┐
│ ⭕ Nội dung 2                  │
│ Kỹ năng vận động tinh          │
│ Nhấn để ghi nhận               │
└─────────────────────────────────┘
```

**Trạng thái "Đã hoàn thành"**:

```
┌─────────────────────────────────┐
│ ✅ Nội dung 1                  │
│ Phân biệt màu sắc              │
│ Đã hoàn thành • 09:15          │
│ [Xem chi tiết]                 │
└─────────────────────────────────┘
```

#### 2.5. Complete Button

- **Text**: "Hoàn tất Buổi học"
- **Enabled**: Khi tất cả nội dung đã được ghi nhận
- **Action**: Lưu toàn bộ session, quay về Dashboard

### Tương tác

| Hành động                              | Kết quả                                       |
| -------------------------------------- | --------------------------------------------- |
| Tap vào Content Card (chưa hoàn thành) | Navigate → Form Chi tiết Nội dung             |
| Tap vào Content Card (đã hoàn thành)   | Mở Bottom Sheet xem chi tiết hoặc chỉnh sửa   |
| Tap "Hoàn tất Buổi học"                | Confirmation dialog → Lưu → Quay về Dashboard |
| Swipe Content Card                     | Hiển thị option: Xóa, Chỉnh sửa               |

---

## 3. Form Chi tiết Nội dung

### Mục đích

- Ghi nhận đánh giá chi tiết cho một nội dung dạy học
- Cho phép thêm ghi nhận hành vi A-B-C nếu cần

### Layout Wireframe

```
┌─────────────────────────────────────────┐
│  ← Nội dung: Phân biệt màu      💾      │ Header
├─────────────────────────────────────────┤
│  ⚠️ Nhớ lưu trước khi thoát             │ Warning
│                                         │
│  📋 1. Mục tiêu Buổi học               │
│  ┌─────────────────────────────────┐   │
│  │ ☐ Gọi tên được màu đỏ          │   │
│  │ ☐ Nhận thức được màu đỏ        │   │
│  │ ☐ Phân biệt đỏ với xanh        │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ✅ 2. Đánh giá Mục tiêu               │
│  Mục tiêu 1: Gọi tên được màu đỏ       │
│  ◉ Đạt    ○ Chưa đạt   ○ Đang học     │
│                                         │
│  Mục tiêu 2: Nhận thức được màu đỏ     │
│  ◉ Đạt    ○ Chưa đạt   ○ Đang học     │
│                                         │
│  😊 3. Thái độ Học tập                 │
│  ├─────●─────┼─────┼─────┼─────┤      │
│  Rất tốt                    Khó khăn   │
│                                         │
│  🤝 Mức độ hợp tác: Tốt                │
│  🎯 Mức độ tập trung: Trung bình       │
│                                         │
│  📝 4. Ghi chú của Giáo viên           │
│  ┌─────────────────────────────────┐   │
│  │ Con đã nhận thức được màu đỏ,  │   │
│  │ tuy nhiên có lúc tự ý rời khỏi │   │
│  │ chỗ ngồi khi làm bài tập...    │   │
│  │                                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ⚠️ 5. Ghi nhận Hành vi (A-B-C)        │
│  ┌─────────────────────────────────┐   │
│  │  Đã ghi nhận 1 hành vi:        │   │
│  │  • Tự ý rời khỏi chỗ (10:15)   │   │
│  │  [Xem chi tiết]                │   │
│  └─────────────────────────────────┘   │
│                                         │
│  [➕ Thêm ghi nhận hành vi A-B-C]      │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  [Hủy]          [Hoàn tất Nội dung]    │
└─────────────────────────────────────────┘
```

### Components

#### 3.1. Header

- **Back button**: ← (Quay về Màn hình Nhật ký Buổi học)
- **Title**: "Nội dung: [Tên nội dung]"
- **Save icon**: 💾 (Lưu nháp tự động)

#### 3.2. Warning Banner

- **Icon**: ⚠️
- **Text**: "Nhớ lưu trước khi thoát"
- **Style**: Nền vàng nhạt, có thể dismiss

#### 3.3. Section 1: Mục tiêu Buổi học

- **Display**: Danh sách checkbox (read-only)
- **Nguồn**: Đã được định sẵn khi lên kế hoạch
- **Ví dụ**: "☐ Gọi tên được màu đỏ"

#### 3.4. Section 2: Đánh giá Mục tiêu

- **Per Goal**: Radio buttons
  - ◉ Đạt
  - ○ Chưa đạt
  - ○ Đang học
- **Required**: Phải đánh giá tất cả mục tiêu

#### 3.5. Section 3: Thái độ Học tập

**Slider 1: Thái độ chung**

```
Rất tốt ├─────●─────┼─────┼─────┤ Khó khăn
         5     4     3     2     1
```

**Dropdown/Buttons**:

- **Mức độ hợp tác**: Rất tốt / Tốt / Trung bình / Cần cải thiện
- **Mức độ tập trung**: Rất tốt / Tốt / Trung bình / Kém

#### 3.6. Section 4: Ghi chú của Giáo viên

- **Component**: Multiline TextInput
- **Placeholder**: "Nhập ghi chú chi tiết về buổi học..."
- **Max length**: 500 ký tự
- **Character counter**: "450/500"

#### 3.7. Section 5: Ghi nhận Hành vi (A-B-C)

**Nếu chưa có hành vi**:

```
┌─────────────────────────────────┐
│  Chưa có hành vi nào được ghi   │
│  nhận trong nội dung này        │
└─────────────────────────────────┘

[➕ Thêm ghi nhận hành vi A-B-C]
```

**Nếu đã có hành vi**:

```
┌─────────────────────────────────┐
│  Đã ghi nhận 2 hành vi:        │
│  • Tự ý rời khỏi chỗ (10:15)   │
│  • La hét (10:40)              │
│  [Xem tất cả chi tiết]         │
└─────────────────────────────────┘

[➕ Thêm ghi nhận hành vi A-B-C]
```

#### 3.8. Action Buttons

- **Hủy**: Discard changes, confirmation dialog
- **Hoàn tất Nội dung**: Validate → Save → Navigate back

### Validation Rules

| Field             | Rule                               |
| ----------------- | ---------------------------------- |
| Đánh giá Mục tiêu | Tất cả mục tiêu phải được đánh giá |
| Thái độ Học tập   | Ít nhất 1 slider phải được chọn    |
| Ghi chú           | Không bắt buộc, tối đa 500 ký tự   |
| Hành vi A-B-C     | Không bắt buộc                     |

### Tương tác

| Hành động                      | Kết quả                                                       |
| ------------------------------ | ------------------------------------------------------------- |
| Tap "➕ Thêm ghi nhận hành vi" | Mở Popup Form A-B-C                                           |
| Tap "Xem chi tiết" (Hành vi)   | Mở Bottom Sheet hiển thị chi tiết A-B-C                       |
| Tap "Hoàn tất Nội dung"        | Validate → Save → Navigate back                               |
| Tap "Hủy"                      | Confirmation: "Bạn có chắc muốn hủy? Dữ liệu chưa lưu sẽ mất" |
| Auto-save                      | Mỗi 30 giây hoặc khi switch field                             |

---

## 4. Popup Form A-B-C

### Mục đích

- Ghi nhận nhanh hành vi bất thường theo phương pháp A-B-C
- Giao diện đơn giản, dễ sử dụng trong lúc giảng dạy

### Layout Wireframe

```
┌─────────────────────────────────────────┐
│                                         │
│  ╔═══════════════════════════════════╗ │
│  ║  Ghi nhận Hành vi (A-B-C)    ✕   ║ │
│  ╠═══════════════════════════════════╣ │
│  ║                                   ║ │
│  ║  🔴 A - Tiền đề (Nguyên nhân)    ║ │
│  ║  ┌─────────────────────────────┐ ║ │
│  ║  │ Yêu cầu làm việc khó      ▼│ ║ │
│  ║  └─────────────────────────────┘ ║ │
│  ║  • Yêu cầu làm việc khó          ║ │
│  ║  • Môi trường quá kích thích     ║ │
│  ║  • Thiếu chú ý từ người lớn      ║ │
│  ║  • Thay đổi lịch trình           ║ │
│  ║  • Khác...                       ║ │
│  ║                                   ║ │
│  ║  🟡 B - Hành vi (Mô tả)          ║ │
│  ║  ┌─────────────────────────────┐ ║ │
│  ║  │ Tự ý rời khỏi chỗ         ▼│ ║ │
│  ║  └─────────────────────────────┘ ║ │
│  ║  • Ném đồ vật                    ║ │
│  ║  • Tự ý rời khỏi chỗ             ║ │
│  ║  • La hét                        ║ │
│  ║  • Đánh người khác               ║ │
│  ║  • Tự gây thương tích            ║ │
│  ║  • Khác...                       ║ │
│  ║                                   ║ │
│  ║  🟢 C - Hệ quả (Kết quả)         ║ │
│  ║  ┌─────────────────────────────┐ ║ │
│  ║  │ Tránh nhiệm vụ             ▼│ ║ │
│  ║  └─────────────────────────────┘ ║ │
│  ║  • Được chú ý                    ║ │
│  ║  • Tránh nhiệm vụ                ║ │
│  ║  • Nhận kích thích cảm giác      ║ │
│  ║  • Nhận đồ vật/hoạt động yêu thích║ │
│  ║  • Khác...                       ║ │
│  ║                                   ║ │
│  ║  📝 Ghi chú bổ sung (tùy chọn)   ║ │
│  ║  ┌─────────────────────────────┐ ║ │
│  ║  │ Nhập ghi chú...             │ ║ │
│  ║  └─────────────────────────────┘ ║ │
│  ║                                   ║ │
│  ║  🕐 Thời gian: 10:15 (Tự động)   ║ │
│  ║                                   ║ │
│  ║  ─────────────────────────────── ║ │
│  ║                                   ║ │
│  ║  [Hủy]           [Lưu hành vi]   ║ │
│  ╚═══════════════════════════════════╝ │
│                                         │
└─────────────────────────────────────────┘
```

### Components

#### 4.1. Modal Header

- **Title**: "Ghi nhận Hành vi (A-B-C)"
- **Close button**: ✕ (Đóng modal)

#### 4.2. Dropdown A - Tiền đề

**Danh sách tùy chọn**:

- Yêu cầu làm việc khó
- Môi trường quá kích thích (ồn ào, sáng quá, đông người)
- Thiếu chú ý từ người lớn
- Thay đổi lịch trình đột ngột
- Cảm thấy mệt mỏi/đói/khó chịu
- Không được đồ vật/hoạt động yêu thích
- Khác... (Mở text input)

#### 4.3. Dropdown B - Hành vi

**Danh sách tùy chọn**:

- Ném đồ vật
- Tự ý rời khỏi chỗ ngồi
- La hét/Kêu to
- Đánh người khác (bạn/giáo viên)
- Tự gây thương tích
- Cắn người/vật
- Phá hủy đồ vật
- Từ chối làm việc
- Khác... (Mở text input)

#### 4.4. Dropdown C - Hệ quả

**Danh sách tùy chọn**:

- Được chú ý từ người lớn/bạn bè
- Tránh được nhiệm vụ khó
- Nhận được kích thích cảm giác (âm thanh, xúc giác)
- Nhận được đồ vật/hoạt động yêu thích
- Được rời khỏi tình huống khó chịu
- Khác... (Mở text input)

#### 4.5. Ghi chú bổ sung

- **Component**: Multiline TextInput
- **Placeholder**: "Nhập ghi chú bổ sung (nếu có)..."
- **Optional**: Không bắt buộc
- **Max length**: 200 ký tự

#### 4.6. Timestamp

- **Display**: 🕐 Thời gian: 10:15 (Tự động)
- **Auto-filled**: Lấy thời gian hiện tại
- **Editable**: Có thể chỉnh sửa nếu cần

#### 4.7. Action Buttons

- **Hủy**: Đóng modal, không lưu
- **Lưu hành vi**: Validate → Save → Đóng modal → Update Form Chi tiết

### Validation Rules

| Field       | Rule                      |
| ----------- | ------------------------- |
| A - Tiền đề | Bắt buộc chọn             |
| B - Hành vi | Bắt buộc chọn             |
| C - Hệ quả  | Bắt buộc chọn             |
| Ghi chú     | Tùy chọn                  |
| Thời gian   | Tự động, có thể chỉnh sửa |

### Tương tác

| Hành động         | Kết quả                                                    |
| ----------------- | ---------------------------------------------------------- |
| Tap Dropdown      | Mở danh sách tùy chọn                                      |
| Chọn "Khác..."    | Hiển thị text input để nhập tự do                          |
| Tap "Lưu hành vi" | Validate → Save to DB → Close modal → Update parent screen |
| Tap "Hủy" hoặc ✕  | Close modal, không lưu                                     |
| Tap outside modal | Confirmation: "Bạn có muốn lưu hành vi trước khi đóng?"    |

### UI Notes

- **Modal**: Full screen trên mobile, popup trên tablet
- **Backdrop**: Dim background 50% opacity
- **Animation**: Slide up from bottom
- **Keyboard behavior**: Đẩy modal lên khi keyboard xuất hiện

---

## 5. Màn hình Từ điển Hành vi

### Mục đích

- Tra cứu thông tin về các hành vi thách thức phổ biến
- Tìm hiểu chức năng và cách can thiệp

### Layout Wireframe

```
┌─────────────────────────────────────────┐
│  ← Từ điển Hành vi              ⋮      │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🔍 Tìm kiếm hành vi...         │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📚 Danh mục                           │
│  [Tất cả] [Công kích] [Tự kích thích] │
│  [Từ chối] [Khác]                      │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  Hành vi Phổ biến                      │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  ⚠️ Ném đồ vật                 │   │
│  │  Hành vi công kích • 127 lượt  │   │
│  │  [Xem chi tiết →]              │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  😤 La hét / Kêu to            │   │
│  │  Hành vi tự kích thích • 89 lượt│   │
│  │  [Xem chi tiết →]              │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🏃 Tự ý rời khỏi chỗ          │   │
│  │  Hành vi tránh né • 156 lượt   │   │
│  │  [Xem chi tiết →]              │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👊 Đánh người khác            │   │
│  │  Hành vi công kích • 64 lượt   │   │
│  │  [Xem chi tiết →]              │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🙅 Từ chối làm việc           │   │
│  │  Hành vi tránh né • 201 lượt   │   │
│  │  [Xem chi tiết →]              │   │
│  └─────────────────────────────────┘   │
│                                         │
├─────────────────────────────────────────┤
│  [🏠 Trang chủ] [📖 Từ điển] [⚙️ Cài đặt]│ Bottom Nav
└─────────────────────────────────────────┘
```

### Components

#### 5.1. Header

- **Back button**: ← (Quay về Dashboard)
- **Title**: "Từ điển Hành vi"
- **Menu**: ⋮ (Tùy chọn: Yêu cầu thêm hành vi mới)

#### 5.2. Search Bar

- **Placeholder**: "🔍 Tìm kiếm hành vi..."
- **Auto-complete**: Gợi ý khi gõ
- **Recent searches**: Hiển thị lịch sử tìm kiếm

#### 5.3. Category Tabs

- **Chips/Pills**:
  - [Tất cả] (active)
  - [Công kích]
  - [Tự kích thích]
  - [Từ chối/Tránh né]
  - [Khác]
- **Filter**: Lọc danh sách theo category

#### 5.4. Behavior Card

```
┌─────────────────────────────────┐
│  ⚠️ Ném đồ vật                 │
│  Hành vi công kích • 127 lượt  │
│  [Xem chi tiết →]              │
└─────────────────────────────────┘
```

**Thông tin**:

- **Icon**: Emoji đại diện (⚠️😤🏃👊🙅)
- **Tên hành vi**: "Ném đồ vật"
- **Category**: "Hành vi công kích"
- **Usage count**: "127 lượt" (số lần được ghi nhận trong hệ thống)

#### 5.5. Bottom Navigation

- Same as Dashboard

### Tương tác

| Hành động         | Kết quả                              |
| ----------------- | ------------------------------------ |
| Nhập vào Search   | Filter danh sách real-time           |
| Tap Category Tab  | Filter danh sách theo category       |
| Tap Behavior Card | Navigate → Màn hình Chi tiết Hành vi |
| Pull to refresh   | Refresh danh sách                    |

---

## 6. Màn hình Chi tiết Hành vi

### Mục đích

- Hiển thị thông tin chi tiết về một hành vi cụ thể
- Cung cấp gợi ý can thiệp
- Link đến phân tích dữ liệu của học sinh cụ thể

### Layout Wireframe

```
┌─────────────────────────────────────────┐
│  ← Ném đồ vật                   ⭐ 📤   │ Header
├─────────────────────────────────────────┤
│                                         │
│  ⚠️                                     │
│  Ném đồ vật                             │
│                                         │
│  📊 Đã ghi nhận 127 lần trong hệ thống │
│  📈 Xu hướng: Tăng 15% tuần này        │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  📄 Mô tả Hành vi                       │
│  ┌─────────────────────────────────┐   │
│  │ Hành vi ném các vật dụng, đồ   │   │
│  │ chơi trong lớp học hoặc tại    │   │
│  │ nhà. Có thể ném về phía người  │   │
│  │ khác hoặc ném bừa bãi.         │   │
│  │                                 │   │
│  │ Thường xảy ra khi:             │   │
│  │ • Được yêu cầu làm việc khó    │   │
│  │ • Không được chú ý             │   │
│  │ • Cảm thấy khó chịu            │   │
│  └─────────────────────────────────┘   │
│                                         │
│  🎯 Chức năng Có thể có                │
│  ┌─────────────────────────────────┐   │
│  │ 1. Thu hút sự chú ý            │   │
│  │    - Từ giáo viên, phụ huynh   │   │
│  │    - Từ bạn bè                 │   │
│  │                                 │   │
│  │ 2. Tránh nhiệm vụ khó          │   │
│  │    - Thoát khỏi hoạt động      │   │
│  │    - Delay thời gian           │   │
│  │                                 │   │
│  │ 3. Kích thích cảm giác         │   │
│  │    - Âm thanh khi vật rơi      │   │
│  │    - Cảm giác ném               │   │
│  │                                 │   │
│  │ 4. Thể hiện cảm xúc            │   │
│  │    - Tức giận, bực bội         │   │
│  │    - Không biết cách diễn đạt  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  💡 Gợi ý Can thiệp Chung              │
│  ┌─────────────────────────────────┐   │
│  │ ✓ Dạy kỹ năng giao tiếp thay thế│   │
│  │   Ví dụ: "Cho con nghỉ"        │   │
│  │                                 │   │
│  │ ✓ Cung cấp kích thích cảm giác │   │
│  │   Cho phép ném vào rổ/túi mềm  │   │
│  │                                 │   │
│  │ ✓ Điều chỉnh môi trường        │   │
│  │   Giảm độ khó nhiệm vụ         │   │
│  │                                 │   │
│  │ ✓ Tăng cường khen thưởng       │   │
│  │   Khi không ném đồ              │   │
│  │                                 │   │
│  │ ✓ Bỏ qua hành vi nhỏ           │   │
│  │   Không phản ứng quá mức       │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  📊 Phân tích cho Học sinh của bạn     │
│                                         │
│  Chọn học sinh để xem biểu đồ phân tích│
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👦 Bé An                      │   │
│  │  12 lần ghi nhận               │   │
│  │  [Xem Biểu đồ Phân tích →]    │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👧 Bé Bình                    │   │
│  │  5 lần ghi nhận                │   │
│  │  [Xem Biểu đồ Phân tích →]    │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

### Components

#### 6.1. Header

- **Back button**: ← (Quay về Từ điển)
- **Title**: Tên hành vi ("Ném đồ vật")
- **Icons**:
  - ⭐ Bookmark/Favorite
  - 📤 Share

#### 6.2. Hero Section

- **Icon**: Emoji lớn (⚠️)
- **Title**: "Ném đồ vật"
- **Stats**:
  - 📊 Số lần ghi nhận trong hệ thống
  - 📈 Xu hướng (tăng/giảm)

#### 6.3. Mô tả Hành vi

- **Section Title**: "📄 Mô tả Hành vi"
- **Content**: Văn bản mô tả chi tiết
- **Sub-list**: "Thường xảy ra khi:"

#### 6.4. Chức năng Có thể có

- **Section Title**: "🎯 Chức năng Có thể có"
- **Format**: Numbered list với sub-items
- **Content**: Các chức năng có thể có của hành vi (4 chức năng chính theo ABA)

#### 6.5. Gợi ý Can thiệp

- **Section Title**: "💡 Gợi ý Can thiệp Chung"
- **Format**: Checklist với ✓
- **Content**: Các chiến lược can thiệp dựa trên bằng chứng

#### 6.6. Student Analysis Section

- **Section Title**: "📊 Phân tích cho Học sinh của bạn"
- **Description**: "Chọn học sinh để xem biểu đồ phân tích"
- **Student Cards**:

```
┌─────────────────────────────────┐
│  👦 Bé An                      │
│  12 lần ghi nhận               │
│  [Xem Biểu đồ Phân tích →]    │
└─────────────────────────────────┘
```

- Hiển thị học sinh có hành vi này
- Số lần ghi nhận
- Nút link đến Báo cáo Phân tích

### Tương tác

| Hành động                   | Kết quả                                                 |
| --------------------------- | ------------------------------------------------------- |
| Tap ⭐ (Bookmark)           | Lưu vào danh sách yêu thích                             |
| Tap 📤 (Share)              | Chia sẻ thông tin hành vi                               |
| Tap "Xem Biểu đồ Phân tích" | Navigate → Màn hình Báo cáo Phân tích (cho học sinh đó) |
| Scroll                      | Parallax effect cho hero section                        |

---

## 7. Màn hình Báo cáo Phân tích

### Mục đích

- Hiển thị phân tích trực quan dữ liệu A-B-C
- Cung cấp insight và gợi ý can thiệp dựa trên dữ liệu

### Layout Wireframe

```
┌─────────────────────────────────────────┐
│  ← Báo cáo Phân tích            📤 💾   │ Header
├─────────────────────────────────────────┤
│                                         │
│  👦 Bé An (Nguyễn Văn An)              │
│  ⚠️ Hành vi: Ném đồ vật                │
│  📅 Dữ liệu: 01/10 - 22/10/2025        │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ [7 ngày] [30 ngày] [Tùy chỉnh]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  📊 1. Biểu đồ Tần suất               │
│  ┌─────────────────────────────────┐   │
│  │        Tần suất Hành vi        │   │
│  │  6┤                             │   │
│  │  5┤     ●                       │   │
│  │  4┤         ●                   │   │
│  │  3┤ ●           ●       ●       │   │
│  │  2┤                 ●       ●   │   │
│  │  1┤                             │   │
│  │  0└─────────────────────────────│   │
│  │    1  5  9  13 17 21 25 29 Ngày│   │
│  │                                 │   │
│  │  Trung bình: 3.2 lần/ngày      │   │
│  │  Cao nhất: 5 lần (ngày 05/10)  │   │
│  │  Thấp nhất: 0 lần (ngày 20/10) │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📊 2. Biểu đồ Tiền đề (A)            │
│  ┌─────────────────────────────────┐   │
│  │    Nguyên nhân Phổ biến        │   │
│  │                                 │   │
│  │  Yêu cầu việc khó  ████████ 40%│   │
│  │  Thiếu chú ý       ███████ 35% │   │
│  │  Môi trường kích   ███ 15%     │   │
│  │  Khác              ██ 10%      │   │
│  │                                 │   │
│  │  [Xem chi tiết từng trường hợp]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  📊 3. Biểu đồ Hệ quả (C)             │
│  ┌─────────────────────────────────┐   │
│  │      Kết quả Củng cố           │   │
│  │                                 │   │
│  │  Được chú ý        ██████████ 50%│   │
│  │  Tránh nhiệm vụ    ██████ 30%  │   │
│  │  Kích thích CG     ███ 15%     │   │
│  │  Khác              █ 5%        │   │
│  │                                 │   │
│  │  [Xem chi tiết từng trường hợp]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  💡 Kết luận & Gợi ý Tự động          │
│  ┌─────────────────────────────────┐   │
│  │  📌 Phân tích Dữ liệu:         │   │
│  │                                 │   │
│  │  • Hành vi xảy ra trung bình   │   │
│  │    3.2 lần/ngày trong 2 tuần   │   │
│  │                                 │   │
│  │  • Nguyên nhân chính:          │   │
│  │    Yêu cầu làm việc khó (40%)  │   │
│  │                                 │   │
│  │  • Hậu quả củng cố:            │   │
│  │    Được chú ý (50%)            │   │
│  │                                 │   │
│  │  ──────────────────────────────│   │
│  │                                 │   │
│  │  💊 Gợi ý Can thiệp:           │   │
│  │                                 │   │
│  │  1. Giảm độ khó nhiệm vụ      │   │
│  │     Chia nhỏ thành các bước    │   │
│  │     đơn giản hơn               │   │
│  │                                 │   │
│  │  2. Dạy kỹ năng thay thế      │   │
│  │     Dạy con xin nghỉ bằng      │   │
│  │     lời nói hoặc thẻ hình      │   │
│  │                                 │   │
│  │  3. Tăng khen thưởng          │   │
│  │     Khen ngay khi hoàn thành   │   │
│  │     nhiệm vụ mà không ném đồ   │   │
│  │                                 │   │
│  │  4. Giảm chú ý khi hành vi     │   │
│  │     Chỉ dọn dẹp, không mắng    │   │
│  │     hoặc giảng giải nhiều      │   │
│  │                                 │   │
│  │  ──────────────────────────────│   │
│  │                                 │   │
│  │  📅 Theo dõi tiếp:             │   │
│  │  Đánh giá lại sau 2 tuần       │   │
│  │  (Ngày 05/11/2025)             │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  📄 Xuất Báo cáo                       │
│  ┌─────────────────────────────────┐   │
│  │  Tạo báo cáo PDF để gửi cho:   │   │
│  │  ☐ Phụ huynh                   │   │
│  │  ☐ Đồng nghiệp                 │   │
│  │  ☐ Chuyên gia                  │   │
│  │                                 │   │
│  │  [Xuất Báo cáo PDF]            │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ⚠️ Tính năng đang được phát triển     │
│                                         │
└─────────────────────────────────────────┘
```

### Components

#### 7.1. Header

- **Back button**: ← (Quay về màn hình trước)
- **Title**: "Báo cáo Phân tích"
- **Icons**:
  - 📤 Share
  - 💾 Save/Bookmark

#### 7.2. Info Section

- **Student**: 👦 Bé An (Nguyễn Văn An)
- **Behavior**: ⚠️ Hành vi: Ném đồ vật
- **Date Range**: 📅 Dữ liệu: 01/10 - 22/10/2025

#### 7.3. Time Range Selector

- **Tabs**:
  - [7 ngày]
  - [30 ngày] (active)
  - [Tùy chỉnh] (date picker)

#### 7.4. Chart 1: Biểu đồ Tần suất

- **Type**: Line Chart
- **X-axis**: Ngày (1-30)
- **Y-axis**: Số lần hành vi (0-6)
- **Data points**: Số lần hành vi mỗi ngày
- **Stats**:
  - Trung bình: 3.2 lần/ngày
  - Cao nhất: 5 lần (ngày 05/10)
  - Thấp nhất: 0 lần (ngày 20/10)

#### 7.5. Chart 2: Biểu đồ Tiền đề (A)

- **Type**: Horizontal Bar Chart
- **Data**:
  - Yêu cầu làm việc khó: 40%
  - Thiếu chú ý từ người lớn: 35%
  - Môi trường quá kích thích: 15%
  - Khác: 10%
- **Action**: "Xem chi tiết từng trường hợp" → Drilldown

#### 7.6. Chart 3: Biểu đồ Hệ quả (C)

- **Type**: Horizontal Bar Chart
- **Data**:
  - Được chú ý: 50%
  - Tránh nhiệm vụ: 30%
  - Nhận kích thích cảm giác: 15%
  - Khác: 5%
- **Action**: "Xem chi tiết từng trường hợp" → Drilldown

#### 7.7. Insight Box: Kết luận & Gợi ý

**Phân tích Dữ liệu**:

- Tần suất trung bình
- Nguyên nhân chính
- Hậu quả củng cố chính

**Gợi ý Can thiệp** (AI-generated):

1. Giảm độ khó nhiệm vụ
2. Dạy kỹ năng thay thế
3. Tăng khen thưởng
4. Giảm chú ý khi hành vi

**Theo dõi tiếp**:

- Ngày đánh giá lại (2 tuần sau)

#### 7.8. Export Section

- **Title**: "📄 Xuất Báo cáo"
- **Checkboxes**:
  - ☐ Phụ huynh
  - ☐ Đồng nghiệp
  - ☐ Chuyên gia
- **Button**: "Xuất Báo cáo PDF"
- **Note**: "⚠️ Tính năng đang được phát triển" (cho demo)

### Tương tác

| Hành động                   | Kết quả                                               |
| --------------------------- | ----------------------------------------------------- |
| Tap Time Range Tab          | Cập nhật tất cả biểu đồ với dữ liệu mới               |
| Tap "Xem chi tiết" (Chart)  | Mở Bottom Sheet với danh sách các trường hợp cụ thể   |
| Tap data point (Line chart) | Hiển thị tooltip với chi tiết ngày đó                 |
| Tap "Xuất Báo cáo PDF"      | (Demo) Hiển thị thông báo "Tính năng đang phát triển" |
| Tap 📤 (Share)              | Share snapshot của báo cáo                            |
| Tap 💾 (Save)               | Lưu báo cáo vào "Báo cáo đã lưu"                      |

### Chart Interaction

**Line Chart (Tần suất)**:

- Tap data point → Tooltip: "Ngày 05/10: 5 lần"
- Pinch to zoom
- Pan to scroll

**Bar Charts (Tiền đề & Hệ quả)**:

- Tap bar → Drilldown: Danh sách các trường hợp cụ thể với timestamp

**Example Drilldown**:

```
┌─────────────────────────────────┐
│  Yêu cầu làm việc khó (12 lần) │
├─────────────────────────────────┤
│  • 01/10 09:15 - Nội dung 1    │
│  • 01/10 10:30 - Nội dung 3    │
│  • 03/10 08:45 - Nội dung 2    │
│  • 05/10 09:00 - Nội dung 1    │
│  ...                           │
│  [Đóng]                        │
└─────────────────────────────────┘
```

---

## Design System

### Color Palette

```
Primary Colors:
- Primary Blue: #4A90E2
- Primary Green: #7ED321
- Primary Orange: #F5A623
- Primary Red: #D0021B

Neutral Colors:
- Dark Gray: #4A4A4A
- Medium Gray: #9B9B9B
- Light Gray: #E0E0E0
- Background: #F8F8F8
- White: #FFFFFF

Semantic Colors:
- Success: #7ED321
- Warning: #F5A623
- Error: #D0021B
- Info: #4A90E2

Chart Colors:
- Chart 1: #4A90E2
- Chart 2: #7ED321
- Chart 3: #F5A623
- Chart 4: #D0021B
```

### Typography

```
Font Family: Roboto / San Francisco (iOS)

Heading 1: 28px Bold
Heading 2: 24px Bold
Heading 3: 20px SemiBold
Body: 16px Regular
Caption: 14px Regular
Small: 12px Regular
```

### Spacing

```
xs: 4px
sm: 8px
md: 16px
lg: 24px
xl: 32px
xxl: 48px
```

### Border Radius

```
Small: 4px (Buttons, Inputs)
Medium: 8px (Cards)
Large: 16px (Modals)
Round: 50% (Avatar, Icons)
```

### Shadows

```
Small: 0 2px 4px rgba(0,0,0,0.1)
Medium: 0 4px 8px rgba(0,0,0,0.15)
Large: 0 8px 16px rgba(0,0,0,0.2)
```

---

## Responsive Design

### Breakpoints

```
Mobile: < 768px (Primary target)
Tablet: 768px - 1024px
Desktop: > 1024px (Optional)
```

### Layout Adjustments

**Mobile**:

- Single column layout
- Bottom sheet cho modals
- Sticky bottom navigation

**Tablet**:

- Two column layout (khi phù hợp)
- Side drawer navigation
- Floating modals

**Desktop** (Optional):

- Multi-column layout
- Sidebar navigation
- Multiple panels

---

## Accessibility

### WCAG Guidelines

- **Contrast ratio**: Ít nhất 4.5:1 cho text
- **Touch targets**: Ít nhất 44x44px
- **Font size**: Có thể scale lên 200%
- **Screen reader**: Hỗ trợ VoiceOver/TalkBack

### Keyboard Navigation

- Tab order logic
- Enter để submit
- Esc để close modal

---

**Tài liệu tiếp theo**: Xem [DATA_STRUCTURE.md](./DATA_STRUCTURE.md) để biết chi tiết cấu trúc dữ liệu.
