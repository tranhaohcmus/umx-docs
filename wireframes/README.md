# Wireframes - Educare Connect

Tài liệu wireframes được chia thành 16 màn hình riêng biệt để dễ quản lý và tham khảo.

## 📱 Module 1: Teaching Journal (12 screens)

### Main Screens

1. **[Dashboard](./01-dashboard.md)** - Màn hình chính với danh sách học sinh
2. **[Session List](./02-session-list.md)** - Danh sách buổi học theo tuần với calendar

### Create Session Flow

3. **[Choose Method Modal](./03-choose-method-modal.md)** - Chọn phương thức tạo buổi học
4. **[Manual Creation Modal](./04-manual-creation-modal.md)** - Tạo buổi học thủ công
5. **[AI Upload Modal](./05-ai-upload-modal.md)** - Upload file cho AI phân tích
6. **[AI Processing Screen](./06-ai-processing-screen.md)** - AI đang xử lý
7. **[AI Preview Screen](./07-ai-preview-screen.md)** - Xem trước kết quả AI
8. **[Edit AI Session Modal](./08-edit-ai-session-modal.md)** - Chỉnh sửa buổi học AI

### Logging Flow

9. **[Session Log Screen](./09-session-log-screen.md)** - Ghi nhật ký buổi học
10. **[Create Content Modal](./10-create-content-modal.md)** - Tạo nội dung mới
11. **[Content Detail Form](./11-content-detail-form.md)** - Đánh giá chi tiết nội dung
12. **[ABC Form Popup](./12-abc-form-popup.md)** - Ghi nhận hành vi A-B-C

## 📊 Module 2: Dictionary & Analytics (3 screens)

13. **[Behavior Dictionary Screen](./13-behavior-dictionary-screen.md)** - Từ điển hành vi
14. **[Behavior Detail Screen](./14-behavior-detail-screen.md)** - Chi tiết hành vi
15. **[Analytics Report Screen](./15-analytics-report-screen.md)** - Báo cáo phân tích

## 👤 Shared (1 screen)

16. **[Profile Screen](./16-profile-screen.md)** - Thông tin cá nhân và cài đặt

---

## 🎯 Navigation Flow

```
Dashboard
  ├─→ Session List (chọn học sinh)
  │     ├─→ Create Session (➕)
  │     │     ├─→ Manual Creation
  │     │     └─→ AI Creation Flow
  │     │           ├─→ Upload
  │     │           ├─→ Processing
  │     │           ├─→ Preview
  │     │           └─→ Edit Session
  │     │
  │     └─→ Session Log (chọn buổi học)
  │           ├─→ Create Content
  │           └─→ Content Detail
  │                 └─→ ABC Form
  │
  ├─→ Analytics (từ Student Card)
  │
  ├─→ Behavior Dictionary (Bottom Nav)
  │     └─→ Behavior Detail
  │           └─→ Analytics Report
  │
  └─→ Profile (Bottom Nav)
```

## 🔑 Key Features

### AI-Powered Lesson Creation

- Upload file (PDF, DOCX, TXT, JPG, PNG) hoặc paste text
- AI phân tích và tạo danh sách buổi học
- Tự động đánh số nội dung (1, 2, 3...) và mục tiêu (1.1, 1.2, 2.1...)
- Preview và edit trước khi tạo
- Bulk create nhiều buổi học cùng lúc

### Weekly Calendar

- Hiển thị lịch theo tuần (7 ngày)
- Swipe left/right để chuyển tuần
- Indicators: ● (đã ghi), ○ (chưa ghi), ⚠ (quá hạn)
- Tap ngày để scroll đến buổi học

### Mobile-Friendly

- Không có drag & drop (dùng file picker native)
- Button "Chọn file từ thiết bị" thay vì "Kéo thả file"
- Swipe gestures cho calendar navigation
- Bottom navigation cho các tab chính

### ABC Behavior Tracking

- Ghi nhận hành vi theo phương pháp A-B-C
- Liên kết với behavior dictionary
- Phân tích và báo cáo xu hướng

---

## 📝 Design Notes

### Avatar System

- 60x60px circular avatars
- Initials fallback khi chưa có ảnh
- Border color theo trạng thái

### Button Labels

- "Nhật ký" (thay vì "Ghi Nhật ký")
- "Chọn file từ thiết bị" (mobile-friendly)
- "Upload và Phân tích" (clear action)

### Numbering System

- Nội dung: 1, 2, 3...
- Mục tiêu: 1.1, 1.2, 2.1, 2.2...
- Collapse button "^" để thu gọn

### Bottom Navigation

- 🏠 Trang chủ
- 📖 Từ điển
- 👤 Profile

---

**Version**: 1.0  
**Last Updated**: October 23, 2025  
**Total Screens**: 16
