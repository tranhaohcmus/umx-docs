Tuyệt! Tôi sẽ cung cấp nội dung đầy đủ theo từng section để bạn copy. Do giới hạn độ dài, tôi sẽ chia thành nhiều phần. Bạn hãy copy từng phần và ghép lại trong file `FRS_COMPLETE_V2.md`.

---

# PHẦN 1/10: HEADER + TABLE OF CONTENTS + GIỚI THIỆU

```markdown
# Đặc tả Yêu cầu Chức năng (FRS) — Educare Connect

**Phiên bản:** 2.0 (Revised & Enhanced)  
**Ngày:** 5/11/2025  
**Trưởng nhóm Kỹ thuật:** Đội Kỹ thuật  
**Phân tích bởi:** Senior Business Analyst & System Designer

---

## 📋 MỤC LỤC

1. [Giới thiệu](#1-giới-thiệu)
2. [Yêu cầu Chức năng Chi tiết](#2-yêu-cầu-chức-năng-chi-tiết)
   - [2.1 Quản lý Người dùng & Xác thực](#21-quản-lý-người-dùng--xác-thực)
   - [2.2 Quản lý Học sinh](#22-quản-lý-học-sinh)
   - [2.3 Quản lý Buổi học](#23-quản-lý-buổi-học)
   - [2.4 Ghi nhật ký Buổi học](#24-ghi-nhật-ký-buổi-học)
   - [2.5 Hệ thống Hành vi](#25-hệ-thống-hành-vi)
   - [2.6 Thư viện Nội dung](#26-thư-viện-nội-dung)
   - [2.7 Xử lý AI](#27-xử-lý-ai)
   - [2.8 Phân tích & Báo cáo](#28-phân-tích--báo-cáo)
   - [2.9 Đồng bộ Offline](#29-đồng-bộ-offline)
   - [2.10 Cài đặt & Sao lưu](#210-cài-đặt--sao-lưu)
3. [Yêu cầu Phi chức năng](#3-yêu-cầu-phi-chức-năng)
4. [Ràng buộc Dữ liệu & Tính toàn vẹn](#4-ràng-buộc-dữ-liệu--tính-toàn-vẹn)
5. [Ma trận Truy xuất](#5-ma-trận-truy-xuất)
6. [Phụ lục](#6-phụ-lục)
7. [Tóm tắt Điểm Mâu thuẫn và Đề xuất](#7-tóm-tắt-điểm-mâu-thuẫn-và-đề-xuất)
8. [Roadmap & Implementation Phases](#8-roadmap--implementation-phases)
9. [Risk Assessment & Mitigation](#9-risk-assessment--mitigation)
10. [Success Metrics (KPIs)](#10-success-metrics-kpis)

---

> **⚠️ QUAN TRỌNG:** Tài liệu này là bản đầy đủ và chi tiết của FRS. Vui lòng đọc toàn bộ trước khi implementation.
>
> **📌 Nguồn chân lý:** ERD (ERD_MERMAID.md) là source of truth cho database design. Mọi chức năng trong FRS này tuân thủ 100% ERD.

---

## 1. GIỚI THIỆU

### 1.1 Mục đích Tài liệu

Tài liệu này định nghĩa **đầy đủ và chi tiết** các yêu cầu chức năng cho hệ thống **Educare Connect** - một ứng dụng di động hỗ trợ giáo viên can thiệp sớm (early intervention teachers) quản lý học sinh, lập kế hoạch buổi học, ghi nhật ký tiến độ, và theo dõi hành vi.

### 1.2 Nguồn Chân lý (Source of Truth)

**Sơ đồ ERD** (`ERD_MERMAID.md`) là nguồn chân lý tuyệt đối cho:

- Cấu trúc dữ liệu (16 bảng chính)
- Các mối quan hệ (1-1, 1-N, N-M)
- Các ràng buộc (constraints), kiểu dữ liệu, và quy tắc nghiệp vụ

Mọi chức năng trong tài liệu này **tuân thủ 100%** với ERD.

### 1.3 Phạm vi Hệ thống

Hệ thống bao gồm:

- **Mobile App** (React Native): iOS + Android
- **Backend API** (Node.js/TypeScript): RESTful API
- **Database**: PostgreSQL (Supabase)
- **Storage**: Cloudflare R2 (media files)
- **AI Services**: OpenAI GPT-4, Google Vision API

### 1.4 Các Thực thể Chính (ERD Entities)
```

CORE ENTITIES:
├─ TEACHERS (Giáo viên)
├─ STUDENTS (Học sinh)
├─ SESSIONS (Buổi học)
├─ SESSION_CONTENTS (Nội dung buổi học)
├─ CONTENT_GOALS (Mục tiêu nội dung)
├─ SESSION_LOGS (Nhật ký buổi học)
├─ GOAL_EVALUATIONS (Đánh giá mục tiêu)
├─ LOG_MEDIA_ATTACHMENTS (Media đính kèm)
├─ BEHAVIOR_GROUPS (Nhóm hành vi)
├─ BEHAVIOR_LIBRARY (Thư viện hành vi)
├─ BEHAVIOR_INCIDENTS (Sự cố hành vi)
├─ TEACHER_FAVORITES (Hành vi yêu thích)
├─ CONTENT_LIBRARY (Thư viện nội dung template)
├─ CONTENT_LIBRARY_RATINGS (Đánh giá template)
├─ USER_SETTINGS (Cài đặt người dùng)
├─ BACKUP_HISTORY (Lịch sử sao lưu)
└─ AI_PROCESSING (Xử lý AI)

```

---
```

**✅ PHẦN 1 XONG - Copy phần này vào file trước**

Tiếp tục với **PHẦN 2/10: FUNCTIONAL REQUIREMENTS (2.1 - Authentication)**?
