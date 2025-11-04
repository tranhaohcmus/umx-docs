# Product Requirements Document (PRD)

# Educare Connect - Tài liệu Yêu cầu Sản phẩm (Tiếng Việt)

**Phiên bản tài liệu:** 1.0  
**Ngày:** 4/11/2025  
**Product Owner:** Đội Sản phẩm  
**Mục tiêu phát hành:** MVP (Tháng 8)

---

## Mục lục

1. Tổng quan sản phẩm
2. Personas (Người dùng mẫu)
3. User Stories
4. Danh sách tính năng (Must / Should / Nice-to-have)
5. Acceptance Criteria
6. Assumptions & Constraints

---

## 1. Tổng quan sản phẩm

Mục tiêu: Educare Connect là ứng dụng di động dành cho giáo viên giáo dục đặc biệt giúp ghi nhật ký buổi học, theo dõi hành vi học sinh theo mô hình ABC, phân tích tiến độ và xuất báo cáo chuyên nghiệp. Ứng dụng sẽ cung cấp cả luồng tạo buổi học thủ công (3 bước) và tạo tự động bằng AI (upload giáo án → OCR/NLP → gợi ý buổi học).

Phạm vi MVP (8 tháng):

- Ứng dụng di động (iOS 13+, Android 8+)
- Xác thực giáo viên, quản lý hồ sơ
- Quản lý học sinh (CRUD)
- Tạo buổi học (Manual + AI)
- Ghi nhật ký 4 bước: Đánh giá mục tiêu (toàn bộ), Thái độ, Ghi chú, Hành vi (A-B-C)
- Từ điển hành vi evidence-based (127+)
- Dashboard phân tích & xuất báo cáo (PDF/Excel)
- Offline-first: cache + queue sync

---

## 2. Personas

Persona 1 — Cô Mai (Giáo viên có kinh nghiệm)

- Tuổi: 28-35, quản lý 5-8 học sinh
- Mục tiêu: Rút ngắn thời gian ghi, tạo báo cáo chuyên nghiệp cho phụ huynh, theo dõi tiến độ
- Cái khó: Ghi chép tốn thời gian, thiếu dữ liệu chuẩn

Persona 2 — Thầy Minh (Giáo viên mới)

- Tuổi: 22-26, <2 năm kinh nghiệm
- Mục tiêu: Học cách ghi chuẩn, dùng template, tham khảo intervention
- Cái khó: Không biết ghi gì, dễ bỏ sót

Persona 3 — Bà Lan (Phụ huynh, secondary user)

- Tuổi: 30-45
- Mục tiêu: Nhận báo cáo định kỳ, hiểu tiến độ con
- Cái khó: Chưa hiểu thuật ngữ chuyên môn

---

## 3. User Stories (tổ chức theo Epic)

Epic A — Authentication & Onboarding

- US-001: Đăng ký giáo viên (email + mật khẩu, xác thực email)
- US-002: Đăng nhập (email/password, biometric tùy chọn)
- US-003: Onboarding ngắn (3 màn hình)

Epic B — Student Management

- US-004: Thêm học sinh (tên, tuổi, avatar)
- US-005: Xem danh sách học sinh (search, filter)
- US-006: Xem chi tiết học sinh (lịch, thống kê)

Epic C — Session Creation (Manual)

- US-007: Tạo buổi (Bước 1: Thông tin cơ bản)
- US-008: Tạo buổi (Bước 2: Nội dung & Mục tiêu)
- US-009: Tạo buổi (Bước 3: Review & Confirm)

Epic D — Session Creation (AI)

- US-010: Upload giáo án (PDF/DOCX/TXT/JPG) hoặc dán văn bản
- US-011: Xử lý AI & preview các buổi trích xuất được

Epic E — Session Logging

- US-012: Chọn buổi để ghi (smart selector)
- US-013: Xem tổng quan buổi (trước & sau ghi)
- US-014: Đánh giá TẤT CẢ mục tiêu trong 1 màn hình (sticky headers, quick nav)
- US-015: Ghi thái độ & mood (emoji + 3 slider)
- US-016: Ghi chú giáo viên (text, voice, photos, videos)
- US-017: Ghi hành vi (A-B-C) với thư viện & custom

Epic F — Behavior Dictionary

- US-018: Duyệt từ điển hành vi (filter group, favorites)
- US-019: Tìm kiếm hành vi (10-15 keywords per behavior)
- US-020: Xem chi tiết hành vi (manifestation, explanations, solutions, sources)

Epic G — Analytics & Reports

- US-021: Xem dashboard analytics (trend, top 5 behaviors)
- US-022: Export báo cáo (PDF/Excel)

Epic H — Offline & Sync

- US-023: Truy cập dữ liệu đã cache khi offline
- US-024: Ghi buổi offline và tự động sync khi online

---

## 4. Danh sách tính năng (MoSCoW simplified)

Must-Have (MVP):

- Xác thực & quản lý profile
- Quản lý học sinh (CRUD) với calendar
- Tạo buổi thủ công (3 bước)
- Tạo buổi AI (upload + preview)
- Ghi nhật ký 4 bước (Goals, Attitude, Notes, Behaviors)
- Thư viện hành vi (127+), tìm kiếm, favorites
- Dashboard analytics cơ bản
- Export PDF/Excel
- Offline: cache & sync queue

Should-Have:

- Templates nội dung / mục tiêu
- Favorites & Trending behaviors
- Biometric login
- Media upload (compress + progress)
- Auto-save/draft cho forms

Nice-to-Have (could):

- Push notifications (nhắc ghi)
- Dark mode
- Bi-lingual UI (en) — Year 2
- Parent portal (future)

---

## 5. Acceptance Criteria (tóm tắt quan trọng)

- Ứng dụng phải cho phép giáo viên tạo/tìm/ghi buổi theo user stories ở trên.
- Tạo buổi AI: hệ thống trả về preview có thể sửa được trước khi lưu.
- Đánh giá tất cả mục tiêu: auto-save 2 phút, hiển thị time-last-saved.
- Ghi hành vi theo A-B-C: mỗi bản ghi cần có Antecedent, Behavior, Consequence; severity 1-5.
- Tìm kiếm hành vi trả về kết quả <200ms (backend sử dụng GIN index trên keywords).
- Export PDF: file <5MB, tạo trong <5s cho single session.
- Offline: đọc được data cached; ghi offline lưu vào queue và sync tự động khi online.

---

## 6. Assumptions & Constraints

Assumptions:

- Người dùng chính là giáo viên GDĐB, dùng smartphone (iOS/Android)
- Giáo viên sẽ ghi buổi trong vòng 4 giờ sau khi kết thúc buổi
- Supabase và OpenAI có độ sẵn sàng theo hợp đồng SLA

Constraints:

- Ngân sách/Timeline MVP (8 months)
- MVP chỉ hỗ trợ tiếng Việt (English planned Year 2)
- File upload giới hạn 10MB cho AI

---

## Ghi chú kết thúc

File này được tạo dựa trên toàn bộ wireframes trong thư mục `wireframes-final` (01-32) và tài liệu thiết kế/DB/API. Nếu cần chỉnh mức chi tiết (ví dụ: acceptance criteria cho từng user story), tôi sẽ mở rộng theo yêu cầu.
