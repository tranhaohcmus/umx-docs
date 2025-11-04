# Database Design - Educare Connect

Tài liệu này mô tả **cấu trúc cơ sở dữ liệu** hoàn chỉnh cho ứng dụng Educare Connect.

---

## 📊 ERD (Entity Relationship Diagram)

```
┌─────────────────────────────────────────────────────────────────────┐
│                     EDUCARE CONNECT DATABASE                        │
└─────────────────────────────────────────────────────────────────────┘

                        ┌──────────────┐
                        │   TEACHERS   │
                        ├──────────────┤
                        │ id (PK)      │
                        │ email        │
                        │ full_name    │
                        │ phone        │
                        │ school       │
                        │ avatar_url   │
                        │ password     │
                        │ created_at   │
                        │ updated_at   │
                        └──────┬───────┘
                               │ 1
                               │ manages
                               │ N
                        ┌──────▼───────┐
                        │   STUDENTS   │
                        ├──────────────┤
                        │ id (PK)      │
                        │ teacher_id(FK)│
                        │ full_name    │
                        │ nickname     │
                        │ age          │
                        │ gender       │
                        │ avatar_url   │
                        │ status       │ (active, paused, archived)
                        │ notes        │
                        │ created_at   │
                        │ updated_at   │
                        └──────┬───────┘
                               │ 1
                               │ has
                               │ N
                        ┌──────▼───────────────┐
                        │      SESSIONS        │
                        ├──────────────────────┤
                        │ id (PK)              │
                        │ student_id (FK)      │
                        │ date                 │
                        │ time_slot            │ (morning, afternoon, evening)
                        │ start_time           │
                        │ end_time             │
                        │ notes                │
                        │ creation_method      │ (manual, ai)
                        │ status               │ (pending, completed)
                        │ has_evaluation       │ (boolean)
                        │ created_at           │
                        │ updated_at           │
                        └──────┬───────────────┘
                               │ 1
                               │ contains
                               │ N
         ┌─────────────────────┴─────────────────────┐
         │                                           │
         ▼                                           ▼
┌────────────────────┐                    ┌──────────────────────┐
│  SESSION_CONTENTS  │                    │   SESSION_LOGS       │
├────────────────────┤                    ├──────────────────────┤
│ id (PK)            │                    │ id (PK)              │
│ session_id (FK)    │                    │ session_id (FK)      │
│ content_library_id │ (FK - optional)    │ logged_at            │
│ name               │                    │ completed_at         │
│ domain             │                    │ mood                 │ (emoji value)
│ description        │                    │ cooperation_level    │ (1-5)
│ order_index        │                    │ focus_level          │ (1-5)
│ notes              │                    │ independence_level   │ (1-5)
│ created_at         │                    │ attitude_notes       │
│ updated_at         │                    │ teacher_notes_text   │
└────────┬───────────┘                    │ created_at           │
         │ 1                              │ updated_at           │
         │ has                            └──────┬───────────────┘
         │ N                                     │ 1
         ▼                                       │ has
┌─────────────────────┐                         │ N
│   CONTENT_GOALS     │           ┌─────────────▼──────────────┐
├─────────────────────┤           │   LOG_MEDIA_ATTACHMENTS    │
│ id (PK)             │           ├────────────────────────────┤
│ session_content_id  │ (FK)      │ id (PK)                    │
│ description         │           │ session_log_id (FK)        │
│ order_index         │           │ type                       │ (image, video, audio)
│ created_at          │           │ url                        │
│ updated_at          │           │ filename                   │
└─────────┬───────────┘           │ file_size                  │
          │ 1                     │ duration                   │ (for audio/video)
          │ has                   │ created_at                 │
          │ 1                     └────────────────────────────┘
          ▼
┌─────────────────────────┐
│   GOAL_EVALUATIONS      │
├─────────────────────────┤
│ id (PK)                 │
│ session_log_id (FK)     │
│ content_goal_id (FK)    │
│ status                  │ (achieved, not_achieved, not_applicable)
│ notes                   │
│ created_at              │
│ updated_at              │
└─────────────────────────┘


┌──────────────────────┐
│  BEHAVIOR_GROUPS     │
├──────────────────────┤
│ id (PK)              │
│ name_vn              │
│ name_en              │
│ description          │
│ icon                 │
│ common_tips          │ (JSON array)
│ order_index          │
│ is_active            │
│ created_at           │
│ updated_at           │
└──────────┬───────────┘
           │ 1
           │ contains
           │ N
           ▼
┌──────────────────────┐
│  BEHAVIOR_LIBRARY    │
├──────────────────────┤
│ id (PK)              │
│ behavior_group_id(FK)│
│ behavior_id          │ (e.g., "1.1", "1.2", "2.1")
│ name_vn              │
│ name_en              │
│ keywords             │ (JSON array - 10-15 keywords)
│ manifestation        │ (TEXT - clinical description)
│ explanation          │ (JSON array of {title, description})
│ solutions            │ (JSON array of {title, description})
│ sources              │ (JSON array - academic citations)
│ icon                 │
│ is_active            │
│ usage_count          │ (system-wide)
│ created_at           │
│ updated_at           │
└──────────┬───────────┘
           │ 1
           │ used in
           │ N
           ▼
┌────────────────────────────┐
│   BEHAVIOR_INCIDENTS       │
├────────────────────────────┤
│ id (PK)                    │
│ session_log_id (FK)        │
│ behavior_library_id (FK)   │
│ antecedent                 │ (text)
│ behavior_description       │ (text)
│ consequence                │ (text)
│ severity_level             │ (1-5)
│ occurred_at                │ (timestamp)
│ notes                      │
│ created_at                 │
│ updated_at                 │
└────────────────────────────┘


┌────────────────────────┐
│   CONTENT_LIBRARY      │
├────────────────────────┤
│ id (PK)                │
│ teacher_id (FK)        │ (null = system template)
│ name                   │
│ domain                 │ (cognitive, motor, language, social, self_care)
│ description            │
│ default_goals          │ (JSON array)
│ is_template            │
│ usage_count            │
│ created_at             │
│ updated_at             │
└────────────────────────┘


┌───────────────────────────┐
│   TEACHER_FAVORITES       │
├───────────────────────────┤
│ id (PK)                   │
│ teacher_id (FK)           │
│ behavior_library_id (FK)  │
│ created_at                │
└───────────────────────────┘


┌──────────────────────┐
│   USER_SETTINGS      │
├──────────────────────┤
│ id (PK)              │
│ teacher_id (FK)      │
│ key                  │
│ value                │
│ created_at           │
│ updated_at           │
└──────────────────────┘


┌──────────────────────┐
│   BACKUP_HISTORY     │
├──────────────────────┤
│ id (PK)              │
│ teacher_id (FK)      │
│ backup_type          │ (manual, auto)
│ file_url             │
│ file_size            │
│ status               │
│ created_at           │
└──────────────────────┘


┌──────────────────────┐
│   AI_PROCESSING      │
├──────────────────────┤
│ id (PK)              │
│ teacher_id (FK)      │
│ student_id (FK)      │
│ file_url             │
│ file_type            │
│ text_content         │
│ processing_status    │
│ progress             │
│ result_sessions      │ (JSON array of created sessions)
│ error_message        │
│ created_at           │
│ completed_at         │
└──────────────────────┘
```

---

## 📋 BẢNG DỮ LIỆU CHI TIẾT

### 1. TEACHERS (Giáo viên)

Lưu thông tin tài khoản giáo viên.

| Column      | Type         | Constraints               | Description        |
| ----------- | ------------ | ------------------------- | ------------------ |
| id          | UUID         | PRIMARY KEY               | ID duy nhất        |
| email       | VARCHAR(255) | UNIQUE, NOT NULL          | Email đăng nhập    |
| full_name   | VARCHAR(255) | NOT NULL                  | Tên đầy đủ         |
| phone       | VARCHAR(20)  | -                         | Số điện thoại      |
| school      | VARCHAR(255) | -                         | Tên trường         |
| avatar_url  | TEXT         | -                         | URL ảnh đại diện   |
| password    | VARCHAR(255) | NOT NULL                  | Password (hashed)  |
| is_verified | BOOLEAN      | DEFAULT FALSE             | Email đã xác thực? |
| two_fa      | BOOLEAN      | DEFAULT FALSE             | Bật 2FA?           |
| created_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP | Ngày tạo tài khoản |
| updated_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP | Ngày cập nhật      |
| last_login  | TIMESTAMP    | -                         | Lần đăng nhập cuối |

**Indexes:**

- `idx_teachers_email` ON (email)

---

### 2. STUDENTS (Học sinh)

Lưu thông tin học sinh do giáo viên quản lý.

| Column     | Type         | Constraints                               | Description                  |
| ---------- | ------------ | ----------------------------------------- | ---------------------------- |
| id         | UUID         | PRIMARY KEY                               | ID duy nhất                  |
| teacher_id | UUID         | FOREIGN KEY → teachers(id)                | Giáo viên quản lý            |
| full_name  | VARCHAR(255) | NOT NULL                                  | Họ và tên                    |
| nickname   | VARCHAR(50)  | NOT NULL                                  | Tên gọi tắt (VD: "BA", "BL") |
| age        | INTEGER      | NOT NULL                                  | Tuổi                         |
| gender     | VARCHAR(10)  | CHECK IN ('male', 'female')               | Giới tính                    |
| avatar_url | TEXT         | -                                         | URL ảnh đại diện             |
| status     | VARCHAR(20)  | CHECK IN ('active', 'paused', 'archived') | Trạng thái học               |
| notes      | TEXT         | -                                         | Ghi chú về học sinh          |
| created_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                 | Ngày tạo                     |
| updated_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                 | Ngày cập nhật                |

**Indexes:**

- `idx_students_teacher_id` ON (teacher_id)
- `idx_students_status` ON (status)

---

### 3. SESSIONS (Buổi học)

Lưu thông tin các buổi học đã tạo.

| Column          | Type        | Constraints                                  | Description                   |
| --------------- | ----------- | -------------------------------------------- | ----------------------------- |
| id              | UUID        | PRIMARY KEY                                  | ID duy nhất                   |
| student_id      | UUID        | FOREIGN KEY → students(id) ON DELETE CASCADE | Học sinh                      |
| date            | DATE        | NOT NULL                                     | Ngày học (YYYY-MM-DD)         |
| time_slot       | VARCHAR(20) | CHECK IN ('morning', 'afternoon', 'evening') | Buổi học                      |
| start_time      | TIME        | NOT NULL                                     | Giờ bắt đầu (HH:MM)           |
| end_time        | TIME        | NOT NULL                                     | Giờ kết thúc (HH:MM)          |
| notes           | TEXT        | -                                            | Ghi chú buổi học              |
| creation_method | VARCHAR(20) | CHECK IN ('manual', 'ai')                    | Phương thức tạo               |
| status          | VARCHAR(20) | CHECK IN ('pending', 'completed')            | Trạng thái (chưa/đã đánh giá) |
| has_evaluation  | BOOLEAN     | DEFAULT FALSE                                | Đã có đánh giá?               |
| created_at      | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                    | Ngày tạo                      |
| updated_at      | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                    | Ngày cập nhật                 |

**Indexes:**

- `idx_sessions_student_id` ON (student_id)
- `idx_sessions_date` ON (date)
- `idx_sessions_status` ON (status)
- `idx_sessions_student_date` ON (student_id, date)

**Constraints:**

- `CHECK (end_time > start_time)`

---

### 4. SESSION_CONTENTS (Nội dung dạy học)

Lưu các nội dung dạy học của mỗi buổi học.

| Column             | Type         | Constraints                                                        | Description                    |
| ------------------ | ------------ | ------------------------------------------------------------------ | ------------------------------ |
| id                 | UUID         | PRIMARY KEY                                                        | ID duy nhất                    |
| session_id         | UUID         | FOREIGN KEY → sessions(id) ON DELETE CASCADE                       | Buổi học                       |
| content_library_id | UUID         | FOREIGN KEY → content_library(id)                                  | Tham chiếu thư viện (nếu có)   |
| name               | VARCHAR(255) | NOT NULL                                                           | Tên nội dung                   |
| domain             | VARCHAR(50)  | CHECK IN ('cognitive', 'motor', 'language', 'social', 'self_care') | Lĩnh vực                       |
| description        | TEXT         | -                                                                  | Mô tả                          |
| order_index        | INTEGER      | NOT NULL                                                           | Thứ tự sắp xếp (1, 2, 3...)    |
| notes              | TEXT         | -                                                                  | Ghi chú riêng cho nội dung này |
| created_at         | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày tạo                       |
| updated_at         | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày cập nhật                  |

**Indexes:**

- `idx_session_contents_session_id` ON (session_id)
- `idx_session_contents_order` ON (session_id, order_index)

---

### 5. CONTENT_GOALS (Mục tiêu học tập)

Lưu các mục tiêu cụ thể của từng nội dung.

| Column             | Type      | Constraints                                          | Description         |
| ------------------ | --------- | ---------------------------------------------------- | ------------------- |
| id                 | UUID      | PRIMARY KEY                                          | ID duy nhất         |
| session_content_id | UUID      | FOREIGN KEY → session_contents(id) ON DELETE CASCADE | Nội dung dạy học    |
| description        | TEXT      | NOT NULL                                             | Mô tả mục tiêu      |
| order_index        | INTEGER   | NOT NULL                                             | Thứ tự (1, 2, 3...) |
| created_at         | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                            | Ngày tạo            |
| updated_at         | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                            | Ngày cập nhật       |

**Indexes:**

- `idx_content_goals_content_id` ON (session_content_id)
- `idx_content_goals_order` ON (session_content_id, order_index)

---

### 6. SESSION_LOGS (Nhật ký đánh giá buổi học)

Lưu kết quả đánh giá tổng quan của buổi học (4 bước: Goals, Attitude, Notes, Behaviors).

| Column             | Type        | Constraints                                                             | Description                   |
| ------------------ | ----------- | ----------------------------------------------------------------------- | ----------------------------- |
| id                 | UUID        | PRIMARY KEY                                                             | ID duy nhất                   |
| session_id         | UUID        | FOREIGN KEY → sessions(id) ON DELETE CASCADE, UNIQUE                    | Buổi học (1-1 relationship)   |
| logged_at          | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                               | Thời điểm bắt đầu ghi         |
| completed_at       | TIMESTAMP   | -                                                                       | Thời điểm hoàn tất            |
| mood               | VARCHAR(20) | CHECK IN ('very_difficult', 'difficult', 'normal', 'good', 'very_good') | Tâm trạng chung (Step 2)      |
| cooperation_level  | INTEGER     | CHECK (cooperation_level BETWEEN 1 AND 5)                               | Mức độ hợp tác 1-5 (Step 2)   |
| focus_level        | INTEGER     | CHECK (focus_level BETWEEN 1 AND 5)                                     | Mức độ tập trung 1-5 (Step 2) |
| independence_level | INTEGER     | CHECK (independence_level BETWEEN 1 AND 5)                              | Mức độ tự lập 1-5 (Step 2)    |
| attitude_notes     | TEXT        | -                                                                       | Ghi chú về thái độ (Step 2)   |
| teacher_notes_text | TEXT        | -                                                                       | Ghi chú văn bản GV (Step 3)   |
| created_at         | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                               | Ngày tạo                      |
| updated_at         | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                               | Ngày cập nhật                 |

**Indexes:**

- `idx_session_logs_session_id` ON (session_id)
- `idx_session_logs_completed` ON (completed_at)

---

### 7. LOG_MEDIA_ATTACHMENTS (Media đính kèm)

Lưu ảnh, video, audio đính kèm trong ghi chú giáo viên (Step 3).

| Column         | Type         | Constraints                                      | Description                         |
| -------------- | ------------ | ------------------------------------------------ | ----------------------------------- |
| id             | UUID         | PRIMARY KEY                                      | ID duy nhất                         |
| session_log_id | UUID         | FOREIGN KEY → session_logs(id) ON DELETE CASCADE | Nhật ký buổi học                    |
| type           | VARCHAR(20)  | CHECK IN ('image', 'video', 'audio')             | Loại media                          |
| url            | TEXT         | NOT NULL                                         | URL file                            |
| filename       | VARCHAR(255) | -                                                | Tên file gốc                        |
| file_size      | INTEGER      | -                                                | Kích thước (bytes)                  |
| duration       | INTEGER      | -                                                | Thời lượng (giây) - cho audio/video |
| created_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                        | Ngày tạo                            |

**Indexes:**

- `idx_media_log_id` ON (session_log_id)
- `idx_media_type` ON (type)

---

### 8. GOAL_EVALUATIONS (Đánh giá mục tiêu)

Lưu kết quả đánh giá từng mục tiêu (Step 1).

| Column          | Type        | Constraints                                             | Description                    |
| --------------- | ----------- | ------------------------------------------------------- | ------------------------------ |
| id              | UUID        | PRIMARY KEY                                             | ID duy nhất                    |
| session_log_id  | UUID        | FOREIGN KEY → session_logs(id) ON DELETE CASCADE        | Nhật ký buổi học               |
| content_goal_id | UUID        | FOREIGN KEY → content_goals(id) ON DELETE CASCADE       | Mục tiêu được đánh giá         |
| status          | VARCHAR(20) | CHECK IN ('achieved', 'not_achieved', 'not_applicable') | Trạng thái (Đạt/Chưa đạt/N/A)  |
| notes           | TEXT        | -                                                       | Ghi chú riêng cho mục tiêu này |
| created_at      | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                               | Ngày tạo                       |
| updated_at      | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                               | Ngày cập nhật                  |

**Indexes:**

- `idx_goal_eval_log_id` ON (session_log_id)
- `idx_goal_eval_goal_id` ON (content_goal_id)
- `idx_goal_eval_status` ON (status)

**Constraints:**

- `UNIQUE (session_log_id, content_goal_id)` (mỗi mục tiêu chỉ đánh giá 1 lần/buổi)

---

### 9. BEHAVIOR_GROUPS (Nhóm Hành vi)

Phân loại hành vi theo nhóm lý thuyết (thay vì category cũ).

| Column      | Type         | Constraints               | Description                      |
| ----------- | ------------ | ------------------------- | -------------------------------- |
| id          | UUID         | PRIMARY KEY               | ID duy nhất                      |
| name_vn     | VARCHAR(255) | NOT NULL                  | Tên tiếng Việt                   |
| name_en     | VARCHAR(255) | NOT NULL                  | Tên tiếng Anh                    |
| description | TEXT         | -                         | Mô tả đặc điểm chung của nhóm    |
| icon        | VARCHAR(50)  | -                         | Icon/emoji đại diện (😤, 👊, 👂) |
| common_tips | JSON         | -                         | Mảng mẹo chung cho nhóm          |
| order_index | INTEGER      | NOT NULL                  | Thứ tự hiển thị (1, 2, 3...)     |
| is_active   | BOOLEAN      | DEFAULT TRUE              | Còn hiển thị?                    |
| created_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP | Ngày tạo                         |
| updated_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP | Ngày cập nhật                    |

**Indexes:**

- `idx_behavior_groups_order` ON (order_index)
- `idx_behavior_groups_active` ON (is_active)

**Sample Data:**

```sql
INSERT INTO behavior_groups (id, name_vn, name_en, description, icon, common_tips, order_index) VALUES
('group_1', 'CHỐNG ĐỐI & BƯỚNG BỈNH', 'Opposition & Defiance',
 'Nhóm hành vi liên quan đến việc trẻ thể hiện sự chống đối, không tuân theo hướng dẫn hoặc yêu cầu của người lớn. Đây là giai đoạn phát triển bình thường ở trẻ nhỏ khi trẻ khám phá tính tự chủ.',
 '😤',
 '["Giữ bình tĩnh, kiên nhẫn", "Đưa ra yêu cầu rõ ràng, ngắn gọn", "Công nhận cảm xúc của trẻ", "Tránh đối đầu trực tiếp"]',
 1),

('group_2', 'HÀNH VI GÂY HẤN', 'Aggression',
 'Nhóm hành vi sử dụng vũ lực hoặc hành động công kích để gây tổn hại cho người khác. Thường xuất phát từ nhu cầu giao tiếp, bảo vệ lãnh thổ, hoặc thiếu kỹ năng xã hội.',
 '👊',
 '["Can thiệp ngay lập tức", "Đảm bảo an toàn cho tất cả trẻ", "Dạy kỹ năng thay thế", "Giám sát tích cực"]',
 2),

('group_3', 'VẤN ĐỀ VỀ GIÁC QUAN', 'Sensory Issues',
 'Nhóm vấn đề liên quan đến cách trẻ xử lý thông tin cảm giác (âm thanh, ánh sáng, xúc giác, v.v.). Rất phổ biến ở trẻ có rối loạn phổ tự kỷ và rối loạn xử lý cảm giác.',
 '👂',
 '["Điều chỉnh môi trường", "Chuẩn bị trước cho trẻ", "Không ép buộc", "Cung cấp công cụ hỗ trợ"]',
 3);
```

---

### 10. BEHAVIOR_LIBRARY (Thư viện Hành vi)

Thư viện hành vi hệ thống với cấu trúc evidence-based đầy đủ.

| Column            | Type         | Constraints                       | Description                                          |
| ----------------- | ------------ | --------------------------------- | ---------------------------------------------------- |
| id                | UUID         | PRIMARY KEY                       | ID duy nhất                                          |
| behavior_group_id | UUID         | FOREIGN KEY → behavior_groups(id) | Nhóm hành vi                                         |
| behavior_id       | VARCHAR(10)  | UNIQUE, NOT NULL                  | ID phân cấp (e.g., "1.1", "1.2", "2.1")              |
| name_vn           | VARCHAR(255) | NOT NULL                          | Tên tiếng Việt                                       |
| name_en           | VARCHAR(255) | NOT NULL                          | Tên tiếng Anh                                        |
| keywords          | JSON         | NOT NULL                          | Mảng 10-15 từ khóa tiếng Việt cho tìm kiếm           |
| manifestation     | TEXT         | NOT NULL                          | Mô tả biểu hiện lâm sàng (clinical description)      |
| explanation       | JSON         | NOT NULL                          | Mảng {title, description} - giải thích lý thuyết     |
| solutions         | JSON         | NOT NULL                          | Mảng {title, description} - can thiệp evidence-based |
| sources           | JSON         | NOT NULL                          | Mảng trích dẫn học thuật (APA format)                |
| icon              | VARCHAR(50)  | -                                 | Icon/emoji đại diện                                  |
| is_active         | BOOLEAN      | DEFAULT TRUE                      | Còn hiển thị?                                        |
| usage_count       | INTEGER      | DEFAULT 0                         | Số lần sử dụng toàn hệ thống (tự động tăng)          |
| created_at        | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP         | Ngày tạo                                             |
| updated_at        | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP         | Ngày cập nhật                                        |

**Indexes:**

- `idx_behavior_group` ON (behavior_group_id)
- `idx_behavior_id` ON (behavior_id)
- `idx_behavior_active` ON (is_active)
- `idx_behavior_usage` ON (usage_count DESC)
- `idx_behavior_keywords` ON (keywords) USING GIN (for full-text search - PostgreSQL)

**Sample Data:**

```sql
-- Behavior 1.1: Ăn vạ (Tantrums)
INSERT INTO behavior_library (
  behavior_group_id,
  behavior_id,
  name_vn,
  name_en,
  keywords,
  manifestation,
  explanation,
  solutions,
  sources,
  icon
) VALUES (
  'group_1',
  '1.1',
  'Ăn vạ',
  'Tantrums',
  '["ăn vạ", "la hét", "nằm lăn ra đất", "gào khóc", "tức giận dữ dội", "khóc dai", "mè nheo", "hờn dỗi", "nổi cáu", "cơn giận", "bùng nổ cảm xúc", "không kiểm soát được", "khóc không nín", "giãy nảy"]',
  'Trẻ bộc phát cảm xúc một cách dữ dội, không kiểm soát được. Có thể la hét, khóc dai, nằm lăn ra đất, giãy nảy, đạp chân, hoặc ném đồ vật. Cơn ăn vạ thường diễn ra khi trẻ không được đáp ứng ngay lập tức, hoặc khi bị yêu cầu thực hiện một việc không mong muốn.',
  '[
    {
      "title": "Nhu cầu Giao tiếp",
      "description": "Với trẻ nhỏ, đặc biệt là trẻ chưa biết nói hoặc còn hạn chế ngôn ngữ, ăn vạ là một phương tiện giao tiếp để thể hiện nhu cầu, sự thất vọng, mệt mỏi, đói, hoặc khó chịu."
    },
    {
      "title": "Nhu cầu Tự chủ & Độc lập",
      "description": "Từ 18 tháng đến 3 tuổi là giai đoạn khủng hoảng tự chủ. Trẻ muốn tự làm mọi thứ, và khi bị ngăn cản hoặc bị ép làm theo yêu cầu người lớn, trẻ có thể phản ứng bằng cơn ăn vạ."
    },
    {
      "title": "Giới hạn Sinh lý",
      "description": "Vỏ não trước trán (prefrontal cortex), chịu trách nhiệm kiểm soát cảm xúc và lập luận, chưa phát triển hoàn thiện ở trẻ nhỏ."
    }
  ]',
  '[
    {
      "title": "Giữ bình tĩnh & Đảm bảo an toàn",
      "description": "Phản ứng của người lớn có thể khuếch đại hoặc làm dịu cơn ăn vạ. Hãy thở sâu, giữ giọng điệu bình tĩnh, và đảm bảo trẻ không tự làm đau mình."
    },
    {
      "title": "Không thỏa hiệp với cơn ăn vạ",
      "description": "Nếu ăn vạ để đòi bánh, mà bạn cho bánh để trẻ im lặng, trẻ sẽ học được rằng ăn vạ = được điều mình muốn."
    },
    {
      "title": "Công nhận Cảm xúc",
      "description": "Gọi tên cảm xúc của trẻ bằng giọng điệu bình tĩnh: Con đang rất tức giận vì không được chơi tiếp, phải không?"
    },
    {
      "title": "Phớt lờ có kế hoạch (Planned Ignoring)",
      "description": "Nếu ăn vạ không gây nguy hiểm, hãy làm ngơ và tiếp tục công việc của bạn (nhưng vẫn để mắt theo dõi)."
    },
    {
      "title": "Dạy Kỹ năng Điều chỉnh Cảm xúc",
      "description": "Khi trẻ đã bình tĩnh, dạy trẻ các chiến lược đơn giản như Hít thở sâu, Đếm số, Ôm gấu bông."
    }
  ]',
  '[
    "Potegal, M., & Davidson, R. J. (2003). Temper tantrums in young children: 1. Behavioral composition. Journal of Developmental & Behavioral Pediatrics, 24(3), 140-147.",
    "Sroufe, L. A. (2000). Early relationships and the development of children. Infant Mental Health Journal, 21(1‐2), 67-74."
  ]',
  '😤'
);
```

**JSON Field Structures:**

```typescript
// keywords: Array of Vietnamese search keywords
keywords: string[] // 10-15 keywords

// explanation: Array of theoretical frameworks
explanation: Array<{
  title: string      // Framework name
  description: string // Detailed explanation
}>

// solutions: Array of evidence-based interventions
solutions: Array<{
  title: string      // Strategy name
  description: string // Implementation guide
}>

// sources: Array of academic citations
sources: string[] // APA format citations
```

---

### 11. BEHAVIOR_INCIDENTS (Hành vi ghi nhận)

Lưu các hành vi cụ thể ghi nhận trong buổi học (Step 4).

| Column               | Type      | Constraints                                      | Description                     |
| -------------------- | --------- | ------------------------------------------------ | ------------------------------- |
| id                   | UUID      | PRIMARY KEY                                      | ID duy nhất                     |
| session_log_id       | UUID      | FOREIGN KEY → session_logs(id) ON DELETE CASCADE | Nhật ký buổi học                |
| behavior_library_id  | UUID      | FOREIGN KEY → behavior_library(id)               | Hành vi từ thư viện             |
| antecedent           | TEXT      | NOT NULL                                         | A: Tình huống xảy ra            |
| behavior_description | TEXT      | NOT NULL                                         | B: Mô tả hành vi cụ thể         |
| consequence          | TEXT      | NOT NULL                                         | C: Kết quả sau đó               |
| severity_level       | INTEGER   | CHECK (severity_level BETWEEN 1 AND 5)           | Mức độ 1-5 (Nhẹ → Nghiêm trọng) |
| occurred_at          | TIMESTAMP | NOT NULL                                         | Thời điểm xảy ra                |
| notes                | TEXT      | -                                                | Mô tả chi tiết thêm             |
| created_at           | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                        | Ngày tạo                        |
| updated_at           | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                        | Ngày cập nhật                   |

**Indexes:**

- `idx_incidents_log_id` ON (session_log_id)
- `idx_incidents_behavior_id` ON (behavior_library_id)
- `idx_incidents_severity` ON (severity_level)
- `idx_incidents_occurred` ON (occurred_at)

---

### 12. CONTENT_LIBRARY (Thư viện Nội dung)

Thư viện nội dung dạy học có sẵn (templates).

| Column        | Type         | Constraints                                                        | Description            |
| ------------- | ------------ | ------------------------------------------------------------------ | ---------------------- |
| id            | UUID         | PRIMARY KEY                                                        | ID duy nhất            |
| teacher_id    | UUID         | FOREIGN KEY → teachers(id), NULLABLE                               | NULL = system template |
| name          | VARCHAR(255) | NOT NULL                                                           | Tên nội dung           |
| domain        | VARCHAR(50)  | CHECK IN ('cognitive', 'motor', 'language', 'social', 'self_care') | Lĩnh vực               |
| description   | TEXT         | -                                                                  | Mô tả                  |
| default_goals | JSON         | -                                                                  | Mảng mục tiêu mặc định |
| is_template   | BOOLEAN      | DEFAULT FALSE                                                      | Là template hệ thống?  |
| usage_count   | INTEGER      | DEFAULT 0                                                          | Số lần sử dụng         |
| created_at    | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày tạo               |
| updated_at    | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày cập nhật          |

**Indexes:**

- `idx_content_lib_teacher` ON (teacher_id)
- `idx_content_lib_domain` ON (domain)
- `idx_content_lib_template` ON (is_template)

---

### 13. TEACHER_FAVORITES (Yêu thích)

Lưu hành vi yêu thích của giáo viên.

| Column              | Type      | Constraints                                          | Description       |
| ------------------- | --------- | ---------------------------------------------------- | ----------------- |
| id                  | UUID      | PRIMARY KEY                                          | ID duy nhất       |
| teacher_id          | UUID      | FOREIGN KEY → teachers(id) ON DELETE CASCADE         | Giáo viên         |
| behavior_library_id | UUID      | FOREIGN KEY → behavior_library(id) ON DELETE CASCADE | Hành vi yêu thích |
| created_at          | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                            | Ngày thêm         |

**Indexes:**

- `idx_favorites_teacher` ON (teacher_id)
- `idx_favorites_behavior` ON (behavior_library_id)

**Constraints:**

- `UNIQUE (teacher_id, behavior_library_id)`

---

### 14. USER_SETTINGS (Cài đặt)

Lưu các cài đặt cá nhân của giáo viên.

| Column     | Type         | Constraints                                  | Description                           |
| ---------- | ------------ | -------------------------------------------- | ------------------------------------- |
| id         | UUID         | PRIMARY KEY                                  | ID duy nhất                           |
| teacher_id | UUID         | FOREIGN KEY → teachers(id) ON DELETE CASCADE | Giáo viên                             |
| key        | VARCHAR(100) | NOT NULL                                     | Tên setting (VD: "theme", "language") |
| value      | TEXT         | -                                            | Giá trị (JSON)                        |
| created_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                    | Ngày tạo                              |
| updated_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                    | Ngày cập nhật                         |

**Indexes:**

- `idx_settings_teacher_key` ON (teacher_id, key)

**Constraints:**

- `UNIQUE (teacher_id, key)`

---

### 15. BACKUP_HISTORY (Lịch sử sao lưu)

Lưu lịch sử backup dữ liệu.

| Column      | Type        | Constraints                                  | Description        |
| ----------- | ----------- | -------------------------------------------- | ------------------ |
| id          | UUID        | PRIMARY KEY                                  | ID duy nhất        |
| teacher_id  | UUID        | FOREIGN KEY → teachers(id) ON DELETE CASCADE | Giáo viên          |
| backup_type | VARCHAR(20) | CHECK IN ('manual', 'auto')                  | Loại backup        |
| file_url    | TEXT        | NOT NULL                                     | URL file backup    |
| file_size   | INTEGER     | -                                            | Kích thước (bytes) |
| status      | VARCHAR(20) | CHECK IN ('pending', 'completed', 'failed')  | Trạng thái         |
| created_at  | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                    | Ngày tạo           |

**Indexes:**

- `idx_backup_teacher` ON (teacher_id)
- `idx_backup_created` ON (created_at DESC)

---

### 16. AI_PROCESSING (Xử lý AI)

Lưu tiến trình xử lý AI upload.

| Column            | Type        | Constraints                                                            | Description                     |
| ----------------- | ----------- | ---------------------------------------------------------------------- | ------------------------------- |
| id                | UUID        | PRIMARY KEY                                                            | ID duy nhất                     |
| teacher_id        | UUID        | FOREIGN KEY → teachers(id) ON DELETE CASCADE                           | Giáo viên                       |
| student_id        | UUID        | FOREIGN KEY → students(id) ON DELETE SET NULL                          | Học sinh (optional)             |
| file_url          | TEXT        | -                                                                      | URL file upload                 |
| file_type         | VARCHAR(50) | -                                                                      | Loại file (pdf, docx, txt, jpg) |
| text_content      | TEXT        | -                                                                      | Nội dung text nếu paste         |
| processing_status | VARCHAR(20) | CHECK IN ('pending', 'processing', 'completed', 'failed', 'cancelled') | Trạng thái xử lý                |
| progress          | INTEGER     | CHECK (progress BETWEEN 0 AND 100)                                     | Tiến độ % (0-100)               |
| result_sessions   | JSON        | -                                                                      | Mảng sessions AI tạo ra         |
| error_message     | TEXT        | -                                                                      | Lỗi nếu có                      |
| created_at        | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                              | Ngày tạo                        |
| completed_at      | TIMESTAMP   | -                                                                      | Ngày hoàn thành                 |

**Indexes:**

- `idx_ai_teacher` ON (teacher_id)
- `idx_ai_status` ON (processing_status)
- `idx_ai_created` ON (created_at DESC)

---

## 🔗 QUAN HỆ GIỮA CÁC BẢNG

### One-to-Many (1-N)

1. **TEACHERS → STUDENTS**: 1 giáo viên quản lý nhiều học sinh
2. **STUDENTS → SESSIONS**: 1 học sinh có nhiều buổi học
3. **SESSIONS → SESSION_CONTENTS**: 1 buổi học có nhiều nội dung
4. **SESSION_CONTENTS → CONTENT_GOALS**: 1 nội dung có nhiều mục tiêu
5. **SESSION_LOGS → LOG_MEDIA_ATTACHMENTS**: 1 nhật ký có nhiều media
6. **SESSION_LOGS → GOAL_EVALUATIONS**: 1 nhật ký đánh giá nhiều mục tiêu
7. **SESSION_LOGS → BEHAVIOR_INCIDENTS**: 1 nhật ký ghi nhận nhiều hành vi
8. **BEHAVIOR_GROUPS → BEHAVIOR_LIBRARY**: 1 nhóm có nhiều hành vi
9. **BEHAVIOR_LIBRARY → BEHAVIOR_INCIDENTS**: 1 hành vi trong thư viện được sử dụng nhiều lần
10. **TEACHERS → CONTENT_LIBRARY**: 1 giáo viên tạo nhiều content templates
11. **TEACHERS → BACKUP_HISTORY**: 1 giáo viên có nhiều backup
12. **TEACHERS → AI_PROCESSING**: 1 giáo viên có nhiều lần xử lý AI

### One-to-One (1-1)

1. **SESSIONS → SESSION_LOGS**: 1 buổi học có 1 nhật ký đánh giá (hoặc chưa có)

### Many-to-Many (N-N)

1. **TEACHERS ↔ BEHAVIOR_LIBRARY** (thông qua TEACHER_FAVORITES):
   - Giáo viên có thể yêu thích nhiều hành vi
   - Hành vi có thể được nhiều giáo viên yêu thích

---

## 📊 DỮ LIỆU MẪU

### Behavior Groups (Nhóm Hành vi)

```sql
-- 3 nhóm chính dựa trên lý thuyết hành vi và phát triển trẻ em

-- Group 1: Chống đối & Bướng bỉnh (Opposition & Defiance)
--   Icon: 😤
--   Behaviors: 1.1 Ăn vạ, 1.2 Từ chối làm theo yêu cầu

-- Group 2: Hành vi Gây hấn (Aggression)
--   Icon: 👊
--   Behaviors: 2.1 Đánh bạn

-- Group 3: Vấn đề về Giác quan (Sensory Issues)
--   Icon: 👂
--   Behaviors: 3.1 Nhạy cảm với âm thanh
```

### Behavior Data Structure

```json
{
  "behavior_id": "1.1",
  "name_vn": "Ăn vạ",
  "name_en": "Tantrums",
  "keywords": [
    "ăn vạ",
    "la hét",
    "nằm lăn ra đất",
    "gào khóc",
    "tức giận dữ dội",
    "khóc dai",
    "mè nheo",
    "hờn dỗi",
    "nổi cáu",
    "cơn giận",
    "bùng nổ cảm xúc",
    "không kiểm soát được",
    "khóc không nín",
    "giãy nảy"
  ],
  "manifestation": "Trẻ bộc phát cảm xúc một cách dữ dội...",
  "explanation": [
    {
      "title": "Nhu cầu Giao tiếp",
      "description": "Với trẻ nhỏ, đặc biệt là trẻ chưa biết nói..."
    },
    {
      "title": "Nhu cầu Tự chủ & Độc lập",
      "description": "Từ 18 tháng đến 3 tuổi..."
    },
    {
      "title": "Giới hạn Sinh lý",
      "description": "Vỏ não trước trán chưa phát triển hoàn thiện..."
    }
  ],
  "solutions": [
    {
      "title": "Giữ bình tĩnh & Đảm bảo an toàn",
      "description": "Phản ứng của người lớn có thể khuếch đại..."
    },
    {
      "title": "Không thỏa hiệp với cơn ăn vạ",
      "description": "Nếu ăn vạ để đòi bánh..."
    }
  ],
  "sources": [
    "Potegal, M., & Davidson, R. J. (2003)...",
    "Sroufe, L. A. (2000)..."
  ]
}
```

### Domain Values (Lĩnh vực)

```sql
-- Cognitive (Nhận thức) 🧠
-- Motor (Vận động) 🏃
-- Language (Ngôn ngữ) 💬
-- Social (Xã hội) 🤝
-- Self-care (Tự phục vụ) 🍴
```

### Behavior Groups & Behaviors

**From data.md wireframe:**

```sql
-- Group 1: HÀNH VI CHỐNG ĐỐI & BƯỚNG BỈNH (Opposition & Defiance)
--   1.1: Ăn vạ (Tantrums) - 14 keywords, 3 explanations, 5 solutions, 2 sources
--   1.2: Từ chối làm theo yêu cầu (Non-compliance) - 13 keywords, 4 explanations, 4 solutions, 2 sources

-- Group 2: HÀNH VI GÂY HẤN (Aggression)
--   2.1: Đánh bạn (Physical Aggression) - 13 keywords, 4 explanations, 4 solutions, 2 sources

-- Group 3: CÁC VẤN ĐỀ VỀ GIÁC QUAN (Sensory Issues)
--   3.1: Nhạy cảm với âm thanh (Auditory Hypersensitivity) - 10 keywords, 2 explanations, 5 solutions, 2 sources
```

### Old Behavior Categories (Deprecated)

**Note:** Old category system replaced by behavior_groups table.

```sql
-- Old categories (no longer used):
-- Aggression (Hung hăng) ⚠️
-- Avoidance (Tránh né) 🏃
-- Attention (Thu hút chú ý) 📢
-- Self-stimulation (Tự kích thích) 🔄
```

### Old Behavior Functions (Deprecated)

**Note:** Function is no longer a separate field. Now part of explanation JSON.

```sql
-- Old functions (no longer separate field):
-- Attention (Thu hút sự chú ý)
-- Escape (Thoát khỏi tình huống)
-- Sensory (Kích thích giác quan)
-- Tangible (Có được vật phẩm)
```

### Status Values

```sql
-- Student status: active, paused, archived
-- Session status: pending, completed
-- Goal status: achieved, not_achieved, not_applicable
-- Processing status: pending, processing, completed, failed, cancelled
```

---

## 🔐 INDEXES & PERFORMANCE

### Critical Indexes

Đã định nghĩa indexes cho:

1. **Foreign keys**: Tất cả FK đều có index
2. **Search fields**: email, status, date, behavior_id
3. **Filter fields**: behavior_group_id, domain, is_active
4. **Sort fields**: created_at, usage_count, order_index
5. **Composite indexes**: (student_id, date), (teacher_id, key)
6. **Full-text search**: keywords (GIN index for PostgreSQL JSON search)

### Query Optimization Tips

```sql
-- Dashboard query (fast with indexes)
SELECT s.*,
       COUNT(DISTINCT sess.id) as total_sessions,
       COUNT(DISTINCT CASE WHEN sess.status = 'completed' THEN sess.id END) as completed_sessions
FROM students s
LEFT JOIN sessions sess ON s.id = sess.student_id
WHERE s.teacher_id = :teacher_id
  AND s.status = 'active'
GROUP BY s.id;

-- Weekly behavior analytics (indexed by behavior_id, occurred_at)
SELECT bg.name_vn as group_name, b.behavior_id, b.name_vn, COUNT(*) as count
FROM behavior_incidents bi
JOIN behavior_library b ON bi.behavior_library_id = b.id
JOIN behavior_groups bg ON b.behavior_group_id = bg.id
WHERE bi.occurred_at >= :week_start
  AND bi.occurred_at < :week_end
GROUP BY bg.id, bg.name_vn, b.behavior_id, b.name_vn
ORDER BY count DESC
LIMIT 5;

-- Search behaviors by keyword (using GIN index)
SELECT b.*, bg.name_vn as group_name
FROM behavior_library b
JOIN behavior_groups bg ON b.behavior_group_id = bg.id
WHERE b.keywords::text ILIKE '%' || :search_term || '%'
  AND b.is_active = true
ORDER BY b.usage_count DESC;

-- Get behaviors by group with stats
SELECT b.*,
       COUNT(DISTINCT bi.id) as total_incidents,
       COUNT(DISTINCT CASE
         WHEN sl.session_id IN (
           SELECT id FROM sessions WHERE student_id IN (
             SELECT id FROM students WHERE teacher_id = :teacher_id
           )
         ) THEN bi.id
       END) as teacher_incidents
FROM behavior_library b
LEFT JOIN behavior_incidents bi ON b.id = bi.behavior_library_id
LEFT JOIN session_logs sl ON bi.session_log_id = sl.id
WHERE b.behavior_group_id = :group_id
  AND b.is_active = true
GROUP BY b.id
ORDER BY b.behavior_id;
```

---

## 🚀 MIGRATION STRATEGY

### Phase 1: Core Tables

1. teachers
2. students
3. sessions
4. session_contents
5. content_goals

### Phase 2: Logging System

6. session_logs
7. log_media_attachments
8. goal_evaluations

### Phase 3: Behavior System (Updated)

9. behavior_groups (NEW)
10. behavior_library (Enhanced with new fields)
11. behavior_incidents
12. teacher_favorites

### Phase 4: Supporting Features

13. content_library
14. user_settings
15. backup_history
16. ai_processing

---

## 📝 BUSINESS RULES

### Session Rules

1. Một session chỉ có 1 log (1-1 relationship)
2. Session status tự động update thành "completed" khi session_log được tạo
3. Không thể xóa session đã có evaluation
4. Thời gian end_time phải > start_time

### Evaluation Rules

1. Một goal chỉ được đánh giá 1 lần trong 1 session (unique constraint)
2. Không thể đánh giá goal của session khác student
3. Mood và 3 levels (cooperation, focus, independence) là bắt buộc

### Behavior Rules

1. Hierarchical ID (behavior_id) must be unique (e.g., "1.1", "1.2", "2.1")
2. Keywords array must have 10-15 items for effective search
3. Manifestation is required (clinical description)
4. Explanation must have at least 2 theoretical frameworks
5. Solutions must have at least 4 evidence-based strategies
6. Sources must include at least 2 academic citations
7. ABC (Antecedent, Behavior, Consequence) required for incidents
8. Severity level từ 1-5
9. occurred_at phải trong khoảng thời gian session

### Content Rules

1. order_index bắt đầu từ 1, tự động tăng
2. Một session có ít nhất 1 content
3. Một content có ít nhất 1 goal

---

## 💾 STORAGE ESTIMATES

### Per Teacher (Monthly)

- Students: ~10 records
- Sessions: ~50 records
- Contents: ~250 records (5 per session)
- Goals: ~1000 records (4 per content)
- Logs: ~50 records
- Goal Evaluations: ~1000 records
- Behaviors: ~20 records
- Media: ~100 files (images/audio)

### Total Storage (1 Teacher/Month)

- Database: ~5MB
- Media files: ~50-100MB
- Backups: ~10MB

---

## 🔒 SECURITY & PRIVACY

### Data Isolation

- Tất cả queries phải filter by `teacher_id`
- Row-level security (RLS) nếu dùng PostgreSQL
- Soft delete cho student records

### Sensitive Data

- Passwords: bcrypt hash
- Media URLs: Pre-signed URLs với expiration
- Personal info: Encrypted at rest

### Audit Trail

- `created_at`, `updated_at` cho tất cả tables
- Optional: audit_log table cho tracking changes

---

_Database design hoàn chỉnh cho Educare Connect. Schema hỗ trợ tất cả tính năng từ wireframes 01-32._
