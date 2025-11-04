# Đặc tả Yêu cầu Chức năng (FRS) — Educare Connect (Tiếng Việt)

**Phiên bản:** 1.0  
**Ngày:** 4/11/2025  
**Trưởng nhóm Kỹ thuật:** Đội Kỹ thuật

---

## Mục lục

1. Yêu cầu chức năng (Functional Requirements)
2. Yêu cầu phi chức năng (Non-Functional Requirements)
3. Yêu cầu hiệu năng (Performance)
4. Yêu cầu bảo mật (Security)
5. Yêu cầu tuân thủ (Compliance)
6. Dữ liệu & Mô hình (Data)
7. Tích hợp (Integrations)
8. Kiểm thử (Testing)

---

## 1. YÊU CẦU CHỨC NĂNG (FR-001 ...)

### FR-001: Đăng ký giáo viên

- Mô tả: cho phép đăng ký bằng email + mật khẩu, gửi email xác thực.
- Ràng buộc: email theo RFC, mật khẩu tối thiểu 8 ký tự, hash bcrypt cost=12.
- API: `POST /auth/register` -> 201 Created
- Ưu tiên: Must

### FR-002: Đăng nhập

- Mô tả: xác thực, trả access token (JWT 1h) và refresh token (7d).
- Rate limit: 5 lần thất bại / 15 phút; khóa tạm thời sau 10 lần trong 1 giờ.
- API: `POST /auth/login` -> 200 OK
- Ưu tiên: Must

### FR-003: Biometric (tuỳ chọn)

- Mô tả: FaceID/TouchID/Fingerprint sau lần đăng nhập đầu, lưu token trên Keychain/Keystore.
- Ưu tiên: Could

### FR-004: Quản lý Học sinh (Tạo)

- Mô tả: thêm học sinh, validate tuổi 2-18, auto-resize avatar 512x512, liên kết teacher_id.
- API: `POST /api/students` -> 201
- Ưu tiên: Must

### FR-005: Danh sách Học sinh (List)

- Mô tả: trả danh sách theo teacher, search case-insensitive, filter trạng thái, pagination 20/page.
- API: `GET /api/students` -> 200
- Ưu tiên: Must

### FR-006: Tạo Buổi (Manual)

- Mô tả: flow 3 bước (basic, contents+goals, review). Auto-fill time slot; draft auto-save 30s.
- Validations: ngày không quá 6 tháng trước, không quá 1 năm sau; duration >=30 phút; ít nhất 1 content với 1 goal.
- API: `POST /api/sessions` -> 201
- Ưu tiên: Must

### FR-007: Tạo Buổi (AI)

- Mô tả: upload file (PDF/DOCX/TXT/JPG/PNG max 10MB) hoặc paste text (<=5000 chars), OCR (Vision API) + GPT-4 extraction, trả progress và preview sessions có thể chỉnh sửa.
- Fallback: nếu AI fail -> trả lỗi có hướng dẫn tạo thủ công.
- API: `POST /api/ai/process` -> 200 (processing object)
- Ưu tiên: Should

### FR-008: Ghi nhật ký — Bước 1 (Đánh giá mục tiêu toàn bộ)

- Mô tả: hiển thị tất cả mục tiêu, sticky headers, quick-nav, radio per goal (Đạt/Chưa/N/A), auto-save 2 phút.
- API: `PUT /api/session-logs/:id/goals` -> 200
- Ưu tiên: Must

### FR-009: Ghi nhật ký — Bước 2 (Thái độ)

- Mô tả: mood enum + 3 sliders (cooperation, focus, independence 1-5), optional notes.
- API: `PUT /api/session-logs/:id/attitude` -> 200
- Ưu tiên: Must

### FR-010: Ghi nhật ký — Bước 3 (Ghi chú, media)

- Mô tả: text notes (<=2000), voice (<=5min m4a), photos (<=10 x 5MB), videos (<=3 x100MB). Compress + progress bar.
- Storage: Cloudflare R2 (signed URLs)
- API: `POST /api/media/upload` -> 200 (file URL)
- Ưu tiên: Should

### FR-011: Ghi nhật ký — Bước 4 (Hành vi A-B-C)

- Mô tả: cho phép chọn từ library hoặc custom; bắt buộc Antecedent/Behavior/Consequence; severity 1-5; multiple incidents per session.
- API: `POST /api/behavior-incidents` -> 200
- Ưu tiên: Must

### FR-012: Thư viện Hành vi

- Mô tả: lưu 127+ behaviors, tổ chức theo 3 nhóm, hierarchical id (1.1, 1.2...), keywords (10-15) để search.
- DB: bảng `behavior_library` JSONB fields (keywords, explanation, solutions, sources)
- Index: GIN index trên keywords
- API: `GET /api/behaviors` -> 200
- Ưu tiên: Must

### FR-013: Tìm kiếm Hành vi

- Mô tả: search trên name_vn, name_en, keywords; fuzzy matching; debounce 300ms; trả <200ms.
- API: `GET /api/behaviors?q=...&limit=20` -> 200
- Ưu tiên: Must

### FR-014: Favorites hành vi

- Mô tả: toggle favorite, lưu junction table teacher_favorites.
- API: `POST /api/teachers/:id/favorites` -> 200/204
- Ưu tiên: Should

### FR-015: Analytics Dashboard

- Mô tả: date range filters, trend chart, top 5 behaviors, completion rate, cache data refresh 5 phút.
- API: `GET /api/analytics/overview` -> 200
- Ưu tiên: Must

### FR-016: Export Reports (PDF/Excel)

- Mô tả: PDF (student info, sessions, goal table, attitude charts, embedded photos), Excel (raw sheets). Generation performance targets.
- API: `POST /api/reports` -> 200 (file URL)
- Ưu tiên: Should

### FR-017: Offline Cache

- Mô tả: cache student list, last 30 days sessions, full behavior library using SQLite; read-only when offline.
- Local DB: react-native-sqlite-storage
- Ưu tiên: Should

### FR-018: Offline Sync Queue

- Mô tả: queue writes offline, FIFO sync, exponential backoff (max 3), conflict resolution (last-write-wins simple, manual merge for sessions).
- Ưu tiên: Should

---

## 2. YÊU CẦU PHI CHỨC NĂNG (NFR)

### NFR-001 (Usability)

- Mobile-first, touch target >=44x44pt, Vietnamese UI, dynamic type support, VoiceOver/TalkBack support.

### NFR-002 (Accessibility)

- WCAG 2.1 AA, color contrast >=4.5:1, images có alt text, label cho form controls.

### NFR-003 (Reliability)

- Uptime >= 99.5% (service-level), scheduled maintenance off-peak, audit logs cho thay đổi dữ liệu.

### NFR-004 (Maintainability)

- Codebase TypeScript, ESLint (Airbnb), unit coverage >=80%, modular components.

### NFR-005 (Privacy)

- Dữ liệu phân tích là anonymized, user có quyền export & delete data.

---

## 3. YÊU CẦU HIỆU NĂNG (PERFORMANCE)

- App cold start <2s; warm start <1s; screen transition <300ms; API GET p95 <500ms; search <200ms; chart render <500ms.
- Hỗ trợ 500 concurrent users, 100 req/sec, DB scale to 100k users, 10M session logs.

---

## 4. YÊU CẦU BẢO MẬT

- TLS 1.3, JWT auth, refresh token rotation, bcrypt cost=12, rate limiting, input sanitization, parameterized queries, secure storage cho tokens, signed URLs cho media.
- Audit logs: login, failed logins, data modifications.

---

## 5. YÊU CẦU TUÂN THỦ

- GDPR (nếu áp dụng): consent, data export, right to be forgotten, breach notification 72h.
- COPPA: không thu thập data trẻ <13 trực tiếp.
- Vietnam Decree 13/2023: lưu trữ/đồng ý xử lý dữ liệu cá nhân theo quy định.
- WCAG 2.1 AA for accessibility.

---

## 6. DỮ LIỆU & MÔ HÌNH (tóm tắt)

- Tham khảo `DATABASE_DESIGN.md` trong thư mục wireframes-final: Teachers, Students, Sessions, Session_Contents, Content_Goals, Session_Logs, Goal_Evaluations, Behavior_Groups, Behavior_Library, Behavior_Incidents, Content_Library, Teacher_Favorites, Media Attachments, AI_Processing.
- Các trường JSONB: behavior keywords, explanation, solutions, sources.

---

## 7. TÍCH HỢP

- Supabase (Postgres) cho DB/Auth/Storage
- OpenAI GPT-4 cho AI extraction (timeout 60s, retry 3)
- Google Vision API cho OCR
- Cloudflare R2 cho media (signed URLs)
- Firebase cho analytics & crashlytics

---

## 8. KIỂM THỬ

- Unit tests: Jest (>=80% coverage)
- Integration: Supertest + staging DB
- E2E: Detox/Appium (iOS + Android) cho flows: register→login, create student→create session→log session
- Performance: JMeter / API load tests
- Security: OWASP ZAP / Burp Suite scans
- Accessibility: Axe automated + manual VoiceOver/TalkBack checks

---

## Phụ lục

- Tham khảo: `PRD.md`, `DATABASE_DESIGN.md`, `API_SPECIFICATION.md`, wireframes (01-32), design-specs.md, ux-guidelines.md

---

**Ghi chú:** Đây là phiên bản FRS ban đầu. Nếu muốn tôi có thể mở rộng FR chi tiết (mã FR riêng cho từng endpoint, payload mẫu, response mẫu) hoặc tạo matrix traceability (FR → User Story → API → DB column).
