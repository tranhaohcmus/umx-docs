# Navigation Flow - Educare Connect

Tài liệu này mô tả chi tiết **toàn bộ luồng điều hướng** trong ứng dụng Educare Connect, bao gồm các điểm vào, hành động của người dùng, và kết quả của từng tương tác.

---

## 📱 Bottom Navigation (4 Tabs Chính)

```
┌─────────────────────────────────┐
│ [🏠 Nhà] [📝 Ghi] [📊 Báo] [👤 Tôi] │
└─────────────────────────────────┘
```

### 1. 🏠 Tab Nhà (Home)

- **Screen 01**: Dashboard - Danh sách học sinh
- **Screen 02**: Student Detail - Chi tiết học sinh

### 2. 📝 Tab Ghi (Logging)

- **Screen 11**: Session Selector - Chọn buổi học
- **Screen 12-16**: Logging Flow - Ghi nhật ký 4 bước

### 3. 📊 Tab Báo cáo (Reports)

- **Screen 20-22**: Analytics & Reports

### 4. 👤 Tab Tôi (Profile)

- **Screen 23-24**: Profile & Settings

---

## 🎯 LUỒNG 1: TẠO BUỔI HỌC MỚI

### Entry Point: Từ Student Detail

```
Screen 02: Student Detail
    ↓
[Tap ➕ TẠO BUỔI HỌC MỚI] button
    ↓
Screen 03: Create Method Sheet (Bottom Sheet)
```

### Screen 03: Chọn Phương Thức

**2 Options:**

#### Option A: Tạo Thủ Công

```
Screen 03: [Tap CHỌN → Tạo thủ công]
    ↓
Screen 04: Manual Step 1 - Basic Info
    ├─ Chọn: Ngày học
    ├─ Chọn: Buổi (Sáng/Chiều)
    ├─ Chọn: Thời gian (start-end)
    └─ Nhập: Ghi chú (optional)
    ↓
[Tap TIẾP TỤC (1/3) →]
    ↓
Screen 05: Manual Step 2 - Content
    ├─ [Tap ➕ Thêm nội dung mới]
    │   ↓
    │   Screen 06: Modal Add Content (Bottom Sheet)
    │   ├─ Nhập: Tên nội dung
    │   ├─ Chọn: Domain (🧠/🏃/💬/🤝/🍴)
    │   ├─ Thêm: Mục tiêu (goals)
    │   └─ [Tap LƯU]
    │       ↓
    │   Quay lại Screen 05 với nội dung mới
    │
    ├─ Drag & Drop để sắp xếp
    ├─ [Tap ✏️ Sửa] để chỉnh sửa
    └─ [Tap 🗑️ Xóa] để xóa nội dung
    ↓
[Tap TIẾP TỤC (2/3) →]
    ↓
Screen 07: Manual Step 3 - Review
    ├─ Xem lại: Tổng quan buổi học
    ├─ Xem lại: Chi tiết từng nội dung
    └─ [Tap Sửa] để quay lại Step 2 nếu cần
    ↓
[Tap 💾 TẠO BUỔI HỌC]
    ↓
✅ Lưu vào database
    ↓
Screen 28: Success State
    ↓
Navigate back to Screen 02: Student Detail (cập nhật calendar)
```

#### Option B: Tạo với AI

```
Screen 03: [Tap CHỌN → Tạo với AI]
    ↓
Screen 08: AI Upload
    ├─ Option 1: [Tap 📷 Chụp ảnh trực tiếp]
    │   ↓ Open camera → Chụp → Upload file
    │
    ├─ Option 2: [Tap 📱 Chọn từ thư viện]
    │   ↓ Open file picker → Chọn file (PDF/DOCX/JPG)
    │
    └─ Option 3: Dán văn bản
        ↓ Paste text vào textarea (max 5000 chars)
    ↓
[Tap 🚀 PHÂN TÍCH NGAY]
    ↓
Screen 09: AI Processing
    ├─ Hiển thị: Progress bar (0-100%)
    ├─ Hiển thị: Step checklist
    ├─ Ước tính: ~20 giây
    └─ [Tap ❌ HỦY PHÂN TÍCH] để hủy (có confirmation)
    ↓
✅ AI phân tích xong
    ↓
Screen 10: AI Preview & Edit
    ├─ Hiển thị: 12 buổi học AI tạo ra
    ├─ [Tap header] để expand/collapse từng buổi
    ├─ [Tap ☑️ checkbox] để chọn/bỏ chọn
    ├─ [Tap ✏️ Sửa] để chỉnh sửa buổi
    ├─ [Tap 🗑️ Xóa] để xóa buổi
    └─ [Chọn tất cả] / [Bỏ chọn] để bulk action
    ↓
[Tap ✅ TẠO 12 BUỔI HỌC (12)]
    ↓
✅ Lưu tất cả buổi học đã chọn
    ↓
Screen 28: Success State
    ↓
Navigate back to Screen 02: Student Detail
```

---

## 🎯 LUỒNG 2: GHI NHẬT KÝ (4 BƯỚC)

### Entry Point 1: Từ Bottom Nav [📝 Ghi]

```
[Tap 📝 Ghi tab]
    ↓
Screen 11: Session Selector
```

### Entry Point 2: Từ Student Detail

```
Screen 02: Student Detail
    ↓
[Tap vào session card trong calendar]
    ↓
Screen 12: Log Overview (Case 1 hoặc Case 2)
```

### Entry Point 3: Từ Dashboard

```
Screen 01: Dashboard
    ↓
[Tap [BẮT ĐẦU GHI →] button trên student card]
    ↓
Screen 11: Session Selector (pre-filtered cho học sinh đó)
```

### Screen 11: Session Selector

```
Screen 11: Chọn Phiên Để Ghi
    ├─ Hiển thị: Danh sách sessions hôm nay
    ├─ Filter: Theo ngày (Hôm nay / Các ngày khác)
    ├─ Status icons:
    │   ├─ ⭕ Chưa bắt đầu đánh giá
    │   └─ ✅ Đã hoàn thành đánh giá
    ├─ [Tap 🔍] để search session
    └─ [Tap session card]
        ↓
        Check status:
        ├─ If ⭕ Chưa bắt đầu → Screen 12 (Case 1)
        └─ If ✅ Đã hoàn thành → Screen 12 (Case 2)
```

### Screen 12: Log Overview (2 Cases)

#### Case 1: Chưa Đánh Giá (Not Yet Evaluated)

```
Screen 12: Log Overview - Case 1
    ├─ Hiển thị: Session info (student, date, time)
    ├─ Hiển thị: Danh sách nội dung (5 items)
    ├─ [Tap nội dung] để expand/collapse xem mục tiêu
    └─ [Tap 📝 BẮT ĐẦU ĐÁNH GIÁ →]
        ↓
    Screen 13: Đánh giá Tất cả Mục tiêu (Step 1/4)
```

#### Case 2: Đã Đánh Giá (Completed)

```
Screen 12: Log Overview - Case 2
    ├─ Hiển thị: Tổng quan kết quả
    │   ├─ ✅ 15/16 mục tiêu đạt
    │   ├─ 😊 Thái độ: Tốt
    │   ├─ 📝 Có ghi chú GV
    │   ├─ 📷 2 ảnh đính kèm
    │   └─ ⚠️ 2 hành vi ghi nhận
    │
    ├─ 5 Sections (progressive disclosure):
    │   1. 📚 Nội dung buổi học (expand/collapse)
    │   2. 😊 Thái độ & Tâm trạng (expand/collapse)
    │   3. 📝 Ghi chú Giáo viên (expand/collapse)
    │   4. ⚠️ Hành vi ghi nhận (expand/collapse)
    │
    ├─ [Tap ✏️ Chỉnh sửa] → Screen 13 (Edit mode)
    ├─ [Tap 📤 Chia sẻ] → Export options
    │
    └─ [Tap ⋮ Menu]
        ├─ ✏️ Sửa thông tin buổi học → Screen 32
        ├─ 🗑️ Xóa buổi học → Confirmation → Delete
        └─ 📤 Xuất báo cáo → Export dialog
```

### Bước 1/4: Đánh Giá Tất Cả Mục Tiêu

```
Screen 13: Đánh giá Tất cả Mục tiêu (Step 1/4)
    ├─ Progress: 25% (Bước 1/4)
    ├─ Quick nav sidebar: [1] [2] [3] [4] [5]
    │   └─ [Tap number] để jump tới content đó
    │
    ├─ Scrollable list: Tất cả nội dung & mục tiêu
    │   ├─ Sticky headers: Tên nội dung khi scroll
    │   └─ Đối với mỗi mục tiêu:
    │       ├─ Radio buttons: ● Đạt / ○ Chưa đạt / ○ N/A
    │       └─ [Tap radio] để chọn trạng thái
    │
    ├─ Ghi chú per content (optional)
    └─ [Tap TIẾP TỤC (1/4) →]
        ↓
    Screen 14: Thái độ Học tập (Step 2/4)
```

### Bước 2/4: Thái độ Học tập

```
Screen 14: Thái độ Học tập (Step 2/4)
    ├─ Progress: 50% (Bước 2/4)
    │
    ├─ 😊 Tâm trạng chung:
    │   └─ [Tap emoji] để chọn 1/5: 😢 😟 😐 🙂 😊
    │
    ├─ 3 Sliders (5 levels):
    │   ├─ 🤝 Hợp tác: [Drag slider] Rất tốt ↔ Khó khăn
    │   ├─ 🎯 Tập trung: [Drag slider]
    │   └─ 💪 Tự lập: [Drag slider]
    │
    ├─ 📝 Ghi chú về thái độ (optional, max 500 chars)
    │
    ├─ [Tap ← Quay lại] → Quay lại Screen 13
    └─ [Tap TIẾP TỤC (2/4) →]
        ↓
    Screen 15: Ghi chú Giáo viên (Step 3/4)
```

### Bước 3/4: Ghi chú Giáo viên

```
Screen 15: Ghi chú Giáo viên (Step 3/4)
    ├─ Progress: 75% (Bước 3/4)
    │
    ├─ 📝 Quan sát chung:
    │   └─ Textarea (max 1000 chars) với character counter
    │
    ├─ 🎤 Ghi chú bằng giọng nói:
    │   ├─ [Tap 🎤 GHI ÂM] → Start recording
    │   │   ├─ Hiển thị: ⏺️ 00:00 / 05:00
    │   │   ├─ [Tap ⏸️ Tạm dừng] / [Tap ⏹️ Dừng]
    │   │   └─ Max 5 minutes
    │   │
    │   └─ After recording:
    │       ├─ Hiển thị: 🔊 Ghi chú giọng nói (1) 📝 02:34
    │       ├─ [Tap ▶️ Phát] để nghe lại
    │       └─ [Tap 🗑️ Xóa] để xóa recording
    │
    ├─ 📸 Đính kèm ảnh/video:
    │   ├─ [Tap 📷] → Open camera
    │   ├─ [Tap 🖼️] → Open gallery
    │   ├─ [Tap 🎥] → Record video
    │   ├─ Max 5 media files
    │   └─ Hiển thị thumbnails: [📷] [📷] [+ Thêm]
    │
    ├─ 💡 Gợi ý mẫu câu (quick insert)
    │
    ├─ [Tap ← Quay lại] → Quay lại Screen 14
    └─ [Tap TIẾP TỤC (3/4) →]
        ↓
    Screen 16: Hành vi A-B-C (Step 4/4)
```

### Bước 4/4: Hành vi A-B-C

```
Screen 16: Hành vi A-B-C (Step 4/4)
    ├─ Progress: 100% (Bước 4/4)
    │
    ├─ Hiển thị: ⚠️ Đã ghi nhận: X hành vi
    │
    ├─ Danh sách behavior cards (nếu có):
    │   ├─ Mỗi card hiển thị:
    │   │   ├─ 🏃 Tên hành vi
    │   │   ├─ 🅰️ Antecedent (tình huống)
    │   │   ├─ 🅱️ Behavior (hành vi)
    │   │   ├─ ©️ Consequence (kết quả)
    │   │   ├─ 📊 Mức độ
    │   │   └─ 🕐 Thời điểm
    │   │
    │   └─ Actions: [Xem] [Sửa] [Xóa]
    │
    ├─ [Tap ➕ THÊM HÀNH VI MỚI]
    │   ↓
    │   Screen 17: ABC Bottom Sheet (3 steps)
    │       │
    │       ├─ Step 1: 🅰️ Antecedent
    │       │   ├─ Search hoặc chọn từ gợi ý
    │       │   └─ [Tap Tiếp →]
    │       │
    │       ├─ Step 2: 🅱️ Behavior
    │       │   ├─ [Tap behavior] từ thư viện
    │       │   ├─ Hiển thị: ⭐ Thường dùng (với usage count)
    │       │   ├─ [Tap 📚 Xem tất cả] → Screen 18
    │       │   └─ [Tap Tiếp →]
    │       │
    │       └─ Step 3: ©️ Consequence
    │           ├─ Search hoặc chọn từ gợi ý
    │           ├─ 📊 Drag slider: Mức độ (Nhẹ → Nghiêm trọng)
    │           ├─ 🕐 Chọn thời điểm
    │           ├─ 📝 Mô tả chi tiết (optional)
    │           ├─ [Tap 📋 Lưu làm mẫu] (optional)
    │           └─ [Tap 💾 LƯU]
    │               ↓
    │           Quay lại Screen 16 với behavior mới
    │
    ├─ 📚 Quick tags: [😤 Cáu giận] [🗣️ La hét] [🏃 Rời chỗ]...
    │   └─ [Tap tag] để quick add (auto-fill behavior name)
    │
    ├─ 💡 Bỏ qua bước này nếu không có hành vi
    │
    ├─ [Tap ← Quay lại] → Quay lại Screen 15
    ├─ [Tap Bỏ qua bước] → Skip to complete
    └─ [Tap ✅ HOÀN TẤT & LƯU]
        ↓
    ✅ Lưu toàn bộ log vào database
        ↓
    Screen 28: Success State "Đã lưu thành công!"
        ↓
    Navigate back to Screen 12 (Case 2 - Completed view)
```

---

## 🎯 LUỒNG 3: TỪ ĐIỂN HÀNH VI

### Entry Point 1: Từ ABC Sheet

```
Screen 17: ABC Bottom Sheet - Step 2 (Behavior)
    ↓
[Tap 📚 Xem tất cả 127 hành vi]
    ↓
Screen 18: Dictionary Home
```

### Entry Point 2: Từ Bottom Nav (nếu có tab riêng)

```
[Tap bottom nav hoặc menu]
    ↓
Screen 18: Dictionary Home
```

### Screen 18: Dictionary Home

```
Screen 18: Từ điển Hành vi
    ├─ [Tap 🔍] để search behavior
    │
    ├─ Filters:
    │   ├─ [Tap 🏷️ Lọc] → Filter by category
    │   ├─ [Tap 📊 Sắp xếp] → Sort options
    │   └─ [Tap ⭐ Yêu thích] → Show favorites only
    │
    ├─ 3 Sections:
    │   │
    │   ├─ ⭐ Yêu thích của bạn (3):
    │   │   └─ [Tap behavior card] → Screen 19
    │   │
    │   ├─ 🔥 Xu hướng tuần này:
    │   │   ├─ Hiển thị: Trend indicators (↗️ +15%)
    │   │   └─ [Tap behavior card] → Screen 19
    │   │
    │   └─ 📂 Danh mục (4 categories grid):
    │       ├─ Aggression (⚠️ 45)
    │       ├─ Avoidance (🏃 32)
    │       ├─ Attention (📢 28)
    │       └─ Self-stimulation (🔄 22)
    │       └─ [Tap category] → Filter list
    │
    ├─ [Tap Xem tất cả 127 hành vi →] → Full list
    └─ [Tap behavior card]
        ↓
    Screen 19: Dictionary Detail
```

### Screen 19: Dictionary Detail

```
Screen 19: Chi tiết Hành vi
    ├─ Hiển thị:
    │   ├─ ⚠️ Tên hành vi
    │   ├─ 📝 Định nghĩa
    │   ├─ 🎯 Chức năng (Function)
    │   ├─ 💡 Ví dụ quan sát
    │   ├─ 🅰️ Nguyên nhân thường gặp
    │   ├─ ©️ Kết quả thường thấy
    │   ├─ 💪 Can thiệp đề xuất
    │   └─ 📊 Thống kê sử dụng
    │
    ├─ [Tap ⭐] để toggle favorite
    ├─ [Tap 📤] để share
    │
    └─ [Tap ← Back] → Quay lại Screen 18
```

---

## 🎯 LUỒNG 4: SỬA BUỔI HỌC

### Entry Point 1: Từ Student Detail

```
Screen 02: Student Detail
    ↓
[Long press hoặc tap ⋮ trên session card]
    ↓
Context Menu:
    ├─ ✏️ Sửa buổi học → Screen 32
    ├─ 🗑️ Xóa buổi học → Confirmation → Delete
    ├─ 📋 Sao chép → Duplicate session
    └─ ❌ Hủy
```

### Entry Point 2: Từ Log Overview

```
Screen 12: Log Overview (Case 2)
    ↓
[Tap ⋮ Menu trên nav bar]
    ↓
Menu Options:
    ├─ ✏️ Sửa thông tin buổi học → Screen 32
    ├─ 🗑️ Xóa buổi học → Confirmation → Delete
    ├─ 📤 Xuất báo cáo → Export dialog
    └─ ❌ Hủy
```

### Screen 32: Edit Session

```
Screen 32: Sửa Buổi học
    ├─ Hiển thị: 👤 Student info (read-only)
    │
    ├─ Editable fields:
    │   ├─ 📅 Ngày học [Tap để đổi]
    │   ├─ 🕐 Buổi (Sáng/Chiều) [Tap toggle]
    │   ├─ ⏰ Thời gian (start-end) [Tap để đổi]
    │   └─ 📝 Ghi chú [Edit text]
    │
    ├─ 💡 Lưu ý:
    │   └─ "Không thể sửa Nội dung/Mục tiêu ở đây"
    │
    ├─ ⚠️ Warning (nếu có evaluation):
    │   └─ "Buổi học đã có đánh giá. Thay đổi sẽ giữ nguyên đánh giá."
    │
    ├─ [Tap Hủy] → Discard changes confirmation
    └─ [Tap 💾 LƯU THAY ĐỔI]
        ↓
    ✅ Update database
        ↓
    Success toast: "✅ Đã lưu thay đổi"
        ↓
    Navigate back to previous screen (02 hoặc 12)
```

---

## 🎯 LUỒNG 5: BÁO CÁO & PHÂN TÍCH

### Entry Point: Từ Bottom Nav

```
[Tap 📊 Báo tab]
    ↓
Screen 20: Analytics Overview
```

### Screen 20: Analytics Overview

```
Screen 20: Báo cáo & Phân tích
    ├─ [Tap date range dropdown: Tuần này ▼]
    │   └─ Select: Tuần này / Tháng này / 3 tháng / 6 tháng / Tùy chọn
    │       ↓
    │   All data updates for selected range
    │
    ├─ Hiển thị 4 sections:
    │   │
    │   ├─ 1. Tổng quan (Summary stats)
    │   │   └─ 89% Hoàn thành, 24 Buổi, 18 Hành vi, 8 Học sinh
    │   │
    │   ├─ 2. 📈 Xu hướng Hành vi (Line chart)
    │   │   └─ [Tap data point] → Show details
    │   │
    │   ├─ 3. 🔝 Top 5 Hành vi Phổ biến
    │   │   └─ [Tap [Chi tiết →]]
    │   │       ↓
    │   │   Screen 21: Analytics Detail (specific behavior)
    │   │
    │   └─ 4. 🎯 Phân tích theo Chức năng (4 categories)
    │       ├─ Attention (📢 8 - 44%)
    │       ├─ Escape (🚪 6 - 33%)
    │       ├─ Sensory (🎨 3 - 17%)
    │       └─ Tangible (🎁 1 - 6%)
    │       └─ [Tap category] → Filter to that function
    │
    ├─ [Tap 📤] → Export full report (PDF)
    └─ [Tap 📊 Xem báo cáo đầy đủ →]
        ↓
    PDF export options
```

### Screen 21: Analytics Detail

```
Screen 21: Chi tiết Hành vi (Analytics)
    ├─ Hiển thị: ⚠️ Ném đồ vật - Tháng 10/2025 • 6 lần
    │
    ├─ 5 Sections:
    │   │
    │   ├─ 1. 📊 Xu hướng (Line chart)
    │   │   └─ ↗️ Tăng 50% so tháng trước
    │   │
    │   ├─ 2. 🎯 Phân tích A-B-C
    │   │   ├─ 🅰️ Nguyên nhân phổ biến (bar chart)
    │   │   └─ ©️ Kết quả thường gặp (bar chart)
    │   │
    │   ├─ 3. 📊 Phân bố Mức độ
    │   │   └─ Nhẹ 33% / TB 50% / Nặng 17%
    │   │
    │   ├─ 4. 🕐 Thời điểm hay xảy ra
    │   │   └─ Sáng 67% / Chiều 33%
    │   │
    │   └─ 5. 📝 Chi tiết các lần ghi nhận
    │       └─ [Tap incident card] → Expand full A-B-C detail
    │
    ├─ [Tap 📤 Xuất PDF/Excel] → Export this behavior report
    └─ [Tap ← Back] → Quay lại Screen 20
```

### Screen 22: Analytics Compare

```
Screen 22: So sánh Tiến trình
    ├─ [Select 2 students hoặc 2 time periods]
    ├─ Hiển thị: Side-by-side comparison charts
    ├─ Metrics: Goals, Behaviors, Mood, Attendance
    └─ [Tap 📤] → Export comparison report
```

---

## 🎯 LUỒNG 6: PROFILE & SETTINGS

### Entry Point: Từ Bottom Nav

```
[Tap 👤 Tôi tab]
    ↓
Screen 23: Profile
```

### Screen 23: Profile

```
Screen 23: Tài khoản
    ├─ [Tap avatar hoặc [Sửa ảnh đại diện]]
    │   ↓ Change profile photo
    │
    ├─ 📧 Thông tin cá nhân:
    │   ├─ [Tap [Sửa] Email] → Edit email
    │   ├─ [Tap [Sửa] Phone] → Edit phone
    │   └─ [Tap [Sửa] School] → Edit school name
    │
    ├─ 🔒 Bảo mật:
    │   ├─ [Tap Đổi mật khẩu →] → Change password flow
    │   └─ [Tap Bật 2FA →] → Enable 2-factor auth
    │
    ├─ 💾 Dữ liệu:
    │   ├─ [Tap Sao lưu ngay →] → Backup data to cloud
    │   └─ [Tap Tải xuống CSV/PDF →] → Export all data
    │
    ├─ ❓ Hỗ trợ:
    │   ├─ [Tap 📚 Hướng dẫn sử dụng] → User guide
    │   ├─ [Tap 💬 Liên hệ hỗ trợ] → Contact support
    │   └─ [Tap ⭐ Đánh giá ứng dụng] → App store rating
    │
    ├─ [Tap ⚙️ icon trên nav bar] → Screen 24
    │
    └─ [Tap 🚪 Đăng xuất]
        ↓
    Confirmation: "Bạn có chắc muốn đăng xuất?"
        ↓
    Logout → Navigate to Login screen
```

### Screen 24: Settings

```
Screen 24: Cài đặt
    ├─ Appearance
    ├─ Notifications
    ├─ Language
    ├─ Privacy
    └─ About
```

---

## 🎨 SUPPORTING SCREENS (GLOBAL)

### Screen 25: Empty States

```
Used whenever there's no data:
├─ Empty student list: "Chưa có học sinh nào"
├─ Empty sessions: "Chưa có buổi học nào"
├─ Empty behaviors: "Không có hành vi đặc biệt"
└─ Each with appropriate CTA button
```

### Screen 26: Error States

```
Used for error scenarios:
├─ Network error: "Không thể kết nối"
├─ Server error: "Đã xảy ra lỗi"
├─ Validation error: "Vui lòng kiểm tra lại"
└─ Each with [Thử lại] button
```

### Screen 27: Loading States

```
Used during async operations:
├─ Skeleton screens for lists
├─ Spinner for quick actions
├─ Progress bars for long operations
└─ "Đang tải..." messages
```

### Screen 28: Success States

```
Used after successful actions:
├─ "✅ Đã tạo buổi học!"
├─ "✅ Đã lưu đánh giá!"
├─ "✅ Đã cập nhật thành công!"
└─ Auto-dismiss after 2 seconds
```

### Screen 29: Onboarding

```
First-time user flow:
├─ Welcome screen
├─ Feature highlights (3-4 slides)
├─ Permission requests (camera, mic, notifications)
└─ [Bắt đầu] → Screen 01 (Dashboard)
```

### Screen 30: Confirmations

```
Used for destructive actions:
├─ Delete student: "Xóa học sinh này?"
├─ Delete session: "Xóa buổi học?" (2 variants)
├─ Discard changes: "Hủy thay đổi?"
└─ Logout: "Đăng xuất?"
Each with [Hủy] [Xác nhận] buttons
```

### Screen 31: Gesture Guide

```
Help overlay showing:
├─ Swipe gestures
├─ Long press actions
├─ Drag & drop
└─ Pull to refresh
Can be triggered from any screen via help icon
```

---

## 🚀 SMART NAVIGATION FEATURES

### 1. Context-Aware Routing

**Khi tap [📝 Ghi] tab:**

```javascript
if (hasInProgressSession && sessionCount === 1) {
    // Show resume dialog
    Dialog: "Tiếp tục ghi buổi học Bé An - Sáng?"
        [Tiếp tục] → Screen 12 (continue)
        [Chọn khác] → Screen 11 (choose different session)
} else if (currentContext.studentId) {
    // Pre-filter to this student's sessions
    Navigate to Screen 11 (filtered)
} else {
    // Show all sessions
    Navigate to Screen 11 (all)
}
```

### 2. Deep Linking Support

```
educare://session/sess_123
    → Direct to Screen 12 (Log Overview)

educare://student/std_abc
    → Direct to Screen 02 (Student Detail)

educare://behavior/throw
    → Direct to Screen 19 (Dictionary Detail)

educare://analytics?date=2025-10-22
    → Direct to Screen 20 (Analytics)

educare://log/create
    → Direct to Screen 11 (Session Selector)
```

### 3. Back Stack Management

**Luồng ghi nhật ký (13 → 14 → 15 → 16):**

```
Back button behavior:
├─ Screen 13: [←] → Screen 12 (with confirmation if data entered)
├─ Screen 14: [←] → Screen 13 (data preserved)
├─ Screen 15: [←] → Screen 14 (data preserved)
└─ Screen 16: [←] → Screen 15 (data preserved)

[✕] Close button:
└─ Any screen: Show "Hủy ghi nhật ký? Dữ liệu sẽ không được lưu."
    [Tiếp tục ghi] [Hủy bỏ]
```

### 4. Auto-save & Draft Recovery

```
During logging flow (13-16):
├─ Auto-save draft every 30 seconds
├─ Recover draft if app crashes or exits
└─ Show "Có bản nháp chưa hoàn thành. Tiếp tục?" when returning
    [Tiếp tục] [Xóa bản nháp]
```

### 5. Badge Notifications

```
Bottom Navigation badges:
├─ [🏠] - No badge
├─ [📝 3] - 3 sessions pending evaluation today
├─ [📊] - No badge
└─ [👤 •] - Red dot if profile incomplete
```

---

## 📊 SCREEN INVENTORY

### Session Creation & Management (01-10)

| Screen | Name                | Purpose               |
| ------ | ------------------- | --------------------- |
| 01     | Dashboard           | Danh sách học sinh    |
| 02     | Student Detail      | Chi tiết học sinh     |
| 03     | Create Method Sheet | Chọn phương thức tạo  |
| 04     | Manual Step 1       | Thông tin cơ bản      |
| 05     | Manual Step 2       | Nội dung dạy học      |
| 06     | Modal Add Content   | Thêm nội dung mới     |
| 07     | Manual Step 3       | Review & Confirm      |
| 08     | AI Upload           | Upload giáo án        |
| 09     | AI Processing       | AI đang xử lý         |
| 10     | AI Preview          | Xem trước & chỉnh sửa |

### Session Logging (11-17)

| Screen | Name             | Purpose                   |
| ------ | ---------------- | ------------------------- |
| 11     | Session Selector | Chọn buổi học ghi         |
| 12     | Log Overview     | Overview buổi học         |
| 13     | Log Detail       | Đánh giá mục tiêu         |
| 14     | Log Attitude     | Thái độ học tập           |
| 15     | Log Notes        | Ghi chú giáo viên         |
| 16     | Log Behavior     | Hành vi A-B-C             |
| 17     | ABC Sheet        | Bottom sheet thêm hành vi |

### Behavior Dictionary (18-19)

| Screen | Name              | Purpose          |
| ------ | ----------------- | ---------------- |
| 18     | Dictionary Home   | Thư viện hành vi |
| 19     | Dictionary Detail | Chi tiết hành vi |

### Analytics & Reports (20-22)

| Screen | Name               | Purpose            |
| ------ | ------------------ | ------------------ |
| 20     | Analytics Overview | Tổng quan báo cáo  |
| 21     | Analytics Detail   | Chi tiết hành vi   |
| 22     | Analytics Compare  | So sánh tiến trình |

### Profile & Settings (23-24)

| Screen | Name     | Purpose           |
| ------ | -------- | ----------------- |
| 23     | Profile  | Thông tin cá nhân |
| 24     | Settings | Cài đặt ứng dụng  |

### Supporting Screens (25-32)

| Screen | Name           | Purpose                |
| ------ | -------------- | ---------------------- |
| 25     | Empty States   | Trạng thái rỗng        |
| 26     | Error States   | Trạng thái lỗi         |
| 27     | Loading States | Trạng thái loading     |
| 28     | Success States | Trạng thái thành công  |
| 29     | Onboarding     | Giới thiệu lần đầu     |
| 30     | Confirmations  | Xác nhận hành động     |
| 31     | Gesture Guide  | Hướng dẫn thao tác     |
| 32     | Edit Session   | Sửa thông tin buổi học |

### Design Files

| File                 | Purpose             |
| -------------------- | ------------------- |
| component-library.md | Thư viện components |
| design-specs.md      | Specs thiết kế      |
| ux-guidelines.md     | Nguyên tắc UX       |

---

## 📝 KEY NAVIGATION PATTERNS

### Pattern 1: Progressive Disclosure

- Screen 12 (Case 2): 5 collapsible sections
- Screen 13: Sticky headers khi scroll
- Screen 05: Expand/collapse content items

### Pattern 2: Multi-Step Forms

- Manual creation: 04 → 05 → 07 (3 steps)
- Logging flow: 13 → 14 → 15 → 16 (4 steps)
- ABC Sheet: 17 (3 steps in modal)

### Pattern 3: Bottom Sheets

- Screen 03: Create method selection
- Screen 06: Add content modal
- Screen 17: ABC entry (3-step)

### Pattern 4: Tab Navigation

- Bottom nav: 4 main tabs always visible
- Sub-tabs: Filters in Screen 11, 18, 20

### Pattern 5: Context Menus

- Long press on session card → Actions
- Tap ⋮ menu → Options
- Swipe gestures → Quick actions

---

**Total Screens**: 32 (including edit session)
**Total Supporting Files**: 3 (component-library, design-specs, ux-guidelines)
**Total Files**: 36 including README, NAVIGATION_FLOW

---

_Tài liệu này mô tả toàn bộ luồng điều hướng trong Educare Connect. Mỗi section bao gồm các điểm vào (entry points), hành động người dùng (user actions), và kết quả (results) một cách chi tiết._
