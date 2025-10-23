# FINAL WIREFRAMES - Mobile Optimized

Wireframes chi tiết và tối ưu cho mobile của ứng dụng Educare Connect.

## 📱 Navigation Flow

```
Đăng nhập → Dashboard (Bottom Navigation)
                ├── 🏠 Nhà (Home)
                │   ├── Dashboard
                │   ├── Student Detail
                │   └── Session Management
                │
                ├── 📝 Ghi (Record)
                │   ├── Session Selector
                │   ├── Create Session (Manual/AI)
                │   ├── Log Session
                │   └── ABC Behavior Tracking
                │
                ├── 📊 Báo (Reports)
                │   ├── Analytics Overview
                │   ├── Behavior Detail
                │   └── Behavior Comparison
                │
                └── 👤 Tôi (Profile)
                    ├── Profile Info
                    ├── Settings
                    └── Help
```

## 📂 File Structure

### Core Screens (1-17)

1. **01-dashboard.md** - Dashboard chính với danh sách học sinh
2. **02-student-detail.md** - Chi tiết học sinh với lịch buổi học
3. **03-create-method-sheet.md** - Bottom sheet chọn phương thức tạo buổi
4. **04-manual-step1.md** - Tạo thủ công - Thông tin cơ bản
5. **05-manual-step2.md** - Tạo thủ công - Nội dung dạy học
6. **06-modal-add-content.md** - Modal thêm nội dung mới
7. **07-manual-step3.md** - Tạo thủ công - Review & Confirm
8. **08-ai-upload.md** - Upload giáo án với AI
9. **09-ai-processing.md** - AI đang xử lý
10. **10-ai-preview.md** - Preview và edit kết quả AI
11. **11-session-selector.md** - **[NEW]** Chọn phiên để ghi nhật ký
12. **12-log-overview.md** - Ghi nhật ký - Overview
13. **13-log-detail.md** - Ghi nhật ký - Chi tiết mục tiêu
14. **14-log-attitude.md** - Ghi nhật ký - Thái độ học tập
15. **15-log-notes.md** - Ghi nhật ký - Ghi chú giáo viên
16. **16-log-behavior.md** - Ghi nhật ký - Hành vi A-B-C
17. **17-abc-sheet.md** - Bottom sheet thêm hành vi A-B-C

### Supporting Screens (18-31)

18. **18-dictionary-home.md** - Từ điển hành vi - Trang chủ
19. **19-dictionary-detail.md** - Từ điển - Chi tiết hành vi
20. **20-analytics-overview.md** - Báo cáo - Overview
21. **21-analytics-detail.md** - Báo cáo - Chi tiết hành vi
22. **22-analytics-compare.md** - Báo cáo - So sánh nhiều hành vi
23. **23-profile.md** - Profile - Thông tin cá nhân
24. **24-settings.md** - Cài đặt - Thông báo
25. **25-empty-states.md** - Empty states (No students, sessions, behaviors)
26. **26-error-states.md** - Error states (Network, AI upload failed)
27. **27-loading-states.md** - Loading states (Skeleton, Pull-to-refresh)
28. **28-success-states.md** - Success states (Create/Save success)
29. **29-onboarding.md** - Onboarding flow (3 screens)
30. **30-confirmations.md** - Confirmation dialogs (Delete, Complete session)
31. **31-gesture-guide.md** - Gesture guides

### Design System

- **design-specs.md** - Colors, Typography, Spacing, Animations
- **component-library.md** - Reusable components
- **ux-guidelines.md** - UX principles and patterns

## 🎯 Key Features

### Mobile-First Design

- Bottom navigation (4 tabs)
- Touch-friendly UI (44x44pt minimum)
- Gesture-based interactions
- Progressive disclosure
- Offline-first approach

### AI-Powered

- Upload lesson plans (PDF, DOCX, TXT, JPG)
- Auto-extract structure and goals
- Generate multiple sessions
- Smart recommendations

### ABC Behavior Tracking

- Antecedent (Tình huống)
- Behavior (Hành vi cụ thể)
- Consequence (Kết quả)
- Built-in behavior dictionary (127+ behaviors)
- Trending behaviors

### Analytics & Reports

- Progress tracking (% completion)
- Behavior analysis
- Multi-behavior comparison
- Visual charts and graphs

## 🎨 Design Specifications

### Colors

- Primary: #4F46E5 (Indigo)
- Secondary: #10B981 (Green)
- Error: #EF4444 (Red)
- Warning: #F59E0B (Amber)
- Success: #10B981 (Green)

### Typography

- Heading 1: 24pt Bold
- Heading 2: 20pt Bold
- Heading 3: 18pt Semibold
- Body: 16pt Regular
- Caption: 14pt Regular
- Small: 12pt Regular

### Spacing

- XS: 4px
- S: 8px
- M: 16px
- L: 24px
- XL: 32px
- XXL: 48px

### Animation Timing

- Fast: 150ms (Micro-interactions)
- Normal: 300ms (Transitions)
- Slow: 500ms (Complex animations)

## 📊 Screen Count Summary

- **Total Screens**: 31 (was 30)
- **Core Flows**: 17 screens
- **Supporting**: 14 screens (was 13)
- **Design System Files**: 3 files

### ✨ Recent Updates

- **Added**: 11-session-selector.md - Smart session picker for logging
- **Renumbered**: Files 11-30 → 12-31 to accommodate new screen

## 🔗 Related Documentation

- **WIREFRAMES.md** - Original wireframes (16 screens)
- **SCREEN_DESIGN.md** - Detailed screen specifications
- **DEVELOPMENT_PROCESS.md** - Complete SDLC guide
- **wireframes/** - Modular original wireframes

---

_Tất cả wireframes đã được tối ưu cho mobile với bottom navigation, gesture support, và offline-first approach._
