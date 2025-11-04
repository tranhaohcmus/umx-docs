# Product Requirements Document (PRD) - FEATURES_OVERVIEW

## Phiên bản: 1.0

**Ngày**: 23/10/2025
**Dự án**: Educare Connect
**Chủ sở hữu**: Nhóm Sản phẩm

---

## 1. Product Overview

### 1.1 Mục tiêu sản phẩm

Educare Connect là ứng dụng di động dành cho giáo viên giáo dục đặc biệt, giúp quản lý học sinh, tạo buổi học (thủ công và với AI), ghi nhật ký theo phương pháp ABC, và phân tích hành vi để hỗ trợ can thiệp cá nhân hóa.

### 1.2 Vấn đề cần giải quyết

- Giáo viên GDĐB thiếu công cụ đơn giản, tổ chức để ghi chép buổi học và hành vi.
- Quá trình tạo giáo án tốn nhiều thời gian; cần hỗ trợ AI để tự động trích xuất giáo án.
- Thiếu analytics thực tiễn giúp theo dõi xu hướng hành vi học sinh.

### 1.3 Đối tượng mục tiêu

Giáo viên giáo dục đặc biệt tại trường học và trung tâm can thiệp.

### 1.4 MVP Scope

- Student management (CRUD)
- Session creation (manual + AI) basic flow
- Session logging MVP (overview, detail, ABC)
- Behavior dictionary read-only + favorites
- Basic analytics (overview & behavior trend)
- Authentication + Profile
- Offline support basic sync

---

## 2. User Personas

### Persona A: Cô Lan - Giáo viên GDĐB

- Tuổi: 28-45
- Vai trò: Full-time teacher tại trung tâm can thiệp
- Pain points: Quản lý nhiều học sinh, thiếu thời gian để ghi nhật ký chi tiết
- Goals: Tối giản thời gian ghi chép, có insight nhanh về hành vi học sinh

### Persona B: Anh Minh - Quản lý trung tâm

- Tuổi: 30-50
- Vai trò: Supervisor, cần báo cáo tiến độ và KPI
- Pain points: Thiếu dashboard tập trung, khó tổng hợp data
- Goals: Theo dõi tiến độ đội ngũ, xuất báo cáo cho phụ huynh

### Persona C: Phụ huynh

- Tuổi: 30-55
- Vai trò: Nhận báo cáo, theo dõi tiến độ
- Goals: Hiểu tiến bộ của con, nhận thông tin kịp thời

---

## 3. User Stories

### 3.1 Epic: Quản lý Học sinh

- As a Teacher, I want to add a new student so that I can manage their sessions.
- As a Teacher, I want to view student details so that I can review history and progress.
- As a Teacher, I want to edit and soft-delete students so that I can correct mistakes and recover if needed.

### 3.2 Epic: Tạo Buổi học

- As a Teacher, I want to create sessions manually so that I can schedule lessons.
- As a Teacher, I want to upload a lesson plan and let AI propose session templates so that I save time.
- As a Teacher, I want to preview and edit AI-generated sessions before bulk creation.

### 3.3 Epic: Ghi Nhật ký

- As a Teacher, I want to select today's session quickly so that I can start logging.
- As a Teacher, I want to mark content/goal completion so that I track progress.
- As a Teacher, I want to record ABC behavior entries so that I can analyze antecedents and consequences.
- As a Teacher, I want to attach notes/media to sessions so that I have qualitative context.

### 3.4 Epic: Phân tích & Báo cáo

- As a Teacher, I want to see monthly summaries so that I understand trends.
- As a Supervisor, I want to compare behaviors across students so that I can prioritize interventions.
- As a Teacher, I want to export reports (PDF/Excel) so that I can share with parents.

### 3.5 Epic: Settings & Onboarding

- As a new user, I want a short onboarding so that I can learn the app quickly.
- As a Teacher, I want to configure reminders and notifications so that I don't miss sessions.

---

## 4. Feature List

### Must-have (MVP)

1. Authentication (email/password) + Profile management
2. Student CRUD
3. Session creation (manual flow)
4. Session selector for logging
5. Session logging: overview, detail, attitude, notes, ABC
6. Behavior dictionary browsing and favorites
7. Basic analytics dashboard (overview + behavior trend)
8. Offline-first data storage with sync
9. Error/Loading/Empty/Success UI states
10. Onboarding screens

### Should-have

1. AI-driven session creation (upload + processing)
2. Biometric login
3. Export reports (PDF/Excel)
4. Push notifications & reminders
5. Inline media attachments (photo/audio)
6. Advanced filtering & search (students, behaviors)

### Nice-to-have

1. Multi-teacher team sharing (sharing student data)
2. Role-based access (admin/supervisor)
3. Integration with calendar apps (Google Calendar)
4. In-app messaging to parents
5. Custom behavior templates

---

## 5. Acceptance Criteria

For each feature group, clear acceptance criteria must be defined. Below are core acceptance criteria for MVP features.

### 5.1 Authentication

- User can register and receive verification email within 30s.
- User can login and remain authenticated for 7 days with "Remember me".
- Invalid credentials display user-friendly error.

### 5.2 Student Management

- User can add a student within 60s, with required fields validated.
- Student list loads within 1s for 100 students.
- Soft-delete retains recoverable state for 30 days.

### 5.3 Session Creation (Manual)

- Create flow (3 steps) completes within 2 minutes for a single session.
- Validation prevents overlapping sessions.

### 5.4 Session Logging

- Session selector shows today's sessions <1s.
- Auto-save every 2 minutes and on navigation events.
- ABC entry creation/edit/delete functional and synced within 3s.

### 5.5 Behavior Dictionary

- Dictionary list loads <1s and supports fuzzy search.
- Behavior detail shows recommended interventions.

### 5.6 Analytics

- Dashboard loads <2s with cached data available offline.
- Exported reports reflect displayed filters and date ranges.

---

## 6. Assumptions & Constraints

### Assumptions

- Primary users are Vietnamese-speaking teachers; default locale is Vietnamese.
- Backend uses Firebase (Firestore/Auth/Storage) and OpenAI API for AI features.
- AI processing may incur cost and rate limits; quota management required.
- Offline-first implementation relies on SQLite local DB with conflict resolution.

### Constraints

- File upload size limit: 10MB per file for AI processing.
- Initial MVP supports single-teacher scope (no team-sharing by default).
- Compliance: GDPR and Vietnamese data laws must be considered.
- Device constraints: Support Android 9+ and iOS 13+.

---

## 7. Traceability & Next Steps

- Map PRD features to `FRS.md` (functional requirements) and `wireframes-final/` screens.
- Create detailed acceptance test cases and QA test plan (`TEST_CASES.md`).
- Prioritize backlog into sprints (MVP first 4 sprints).

---

**Kết thúc PRD (FEATURES_OVERVIEW.md)**
