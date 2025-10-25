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
│  BEHAVIOR_LIBRARY    │
├──────────────────────┤
│ id (PK)              │
│ name_vn              │
│ name_en              │
│ category             │ (aggression, avoidance, attention, self_stim)
│ description          │
│ definition           │
│ function             │ (attention, escape, sensory, tangible)
│ examples             │ (JSON array)
│ common_antecedents   │ (JSON array)
│ common_consequences  │ (JSON array)
│ intervention_tips    │ (JSON array)
│ icon                 │
│ is_active            │
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

### 9. BEHAVIOR_LIBRARY (Thư viện Hành vi)

Thư viện hành vi hệ thống (127+ behaviors).

| Column              | Type         | Constraints                                                    | Description                  |
| ------------------- | ------------ | -------------------------------------------------------------- | ---------------------------- |
| id                  | UUID         | PRIMARY KEY                                                    | ID duy nhất                  |
| name_vn             | VARCHAR(255) | NOT NULL                                                       | Tên tiếng Việt               |
| name_en             | VARCHAR(255) | -                                                              | Tên tiếng Anh                |
| category            | VARCHAR(50)  | CHECK IN ('aggression', 'avoidance', 'attention', 'self_stim') | Danh mục                     |
| description         | TEXT         | -                                                              | Mô tả hành vi                |
| definition          | TEXT         | -                                                              | Định nghĩa chi tiết          |
| function            | VARCHAR(50)  | CHECK IN ('attention', 'escape', 'sensory', 'tangible')        | Chức năng hành vi            |
| examples            | JSON         | -                                                              | Mảng ví dụ quan sát          |
| common_antecedents  | JSON         | -                                                              | Mảng nguyên nhân phổ biến    |
| common_consequences | JSON         | -                                                              | Mảng kết quả thường thấy     |
| intervention_tips   | JSON         | -                                                              | Mảng gợi ý can thiệp         |
| icon                | VARCHAR(50)  | -                                                              | Icon/emoji đại diện          |
| is_active           | BOOLEAN      | DEFAULT TRUE                                                   | Còn hiển thị?                |
| usage_count         | INTEGER      | DEFAULT 0                                                      | Số lần sử dụng toàn hệ thống |
| created_at          | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                      | Ngày tạo                     |
| updated_at          | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                      | Ngày cập nhật                |

**Indexes:**

- `idx_behavior_category` ON (category)
- `idx_behavior_function` ON (function)
- `idx_behavior_active` ON (is_active)
- `idx_behavior_usage` ON (usage_count DESC)

---

### 10. BEHAVIOR_INCIDENTS (Hành vi ghi nhận)

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

### 11. CONTENT_LIBRARY (Thư viện Nội dung)

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

### 12. TEACHER_FAVORITES (Yêu thích)

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

### 13. USER_SETTINGS (Cài đặt)

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

### 14. BACKUP_HISTORY (Lịch sử sao lưu)

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

### 15. AI_PROCESSING (Xử lý AI)

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
8. **BEHAVIOR_LIBRARY → BEHAVIOR_INCIDENTS**: 1 hành vi trong thư viện được sử dụng nhiều lần
9. **TEACHERS → CONTENT_LIBRARY**: 1 giáo viên tạo nhiều content templates
10. **TEACHERS → BACKUP_HISTORY**: 1 giáo viên có nhiều backup
11. **TEACHERS → AI_PROCESSING**: 1 giáo viên có nhiều lần xử lý AI

### One-to-One (1-1)

1. **SESSIONS → SESSION_LOGS**: 1 buổi học có 1 nhật ký đánh giá (hoặc chưa có)

### Many-to-Many (N-N)

1. **TEACHERS ↔ BEHAVIOR_LIBRARY** (thông qua TEACHER_FAVORITES):
   - Giáo viên có thể yêu thích nhiều hành vi
   - Hành vi có thể được nhiều giáo viên yêu thích

---

## 📊 DỮ LIỆU MẪU

### Domain Values (Lĩnh vực)

```sql
-- Cognitive (Nhận thức) 🧠
-- Motor (Vận động) 🏃
-- Language (Ngôn ngữ) 💬
-- Social (Xã hội) 🤝
-- Self-care (Tự phục vụ) 🍴
```

### Behavior Categories

```sql
-- Aggression (Hung hăng) ⚠️
-- Avoidance (Tránh né) 🏃
-- Attention (Thu hút chú ý) 📢
-- Self-stimulation (Tự kích thích) 🔄
```

### Behavior Functions

```sql
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
2. **Search fields**: email, status, date
3. **Filter fields**: category, domain, function
4. **Sort fields**: created_at, usage_count
5. **Composite indexes**: (student_id, date), (teacher_id, key)

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
SELECT b.name_vn, COUNT(*) as count
FROM behavior_incidents bi
JOIN behavior_library b ON bi.behavior_library_id = b.id
WHERE bi.occurred_at >= :week_start
  AND bi.occurred_at < :week_end
GROUP BY b.id, b.name_vn
ORDER BY count DESC
LIMIT 5;
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

### Phase 3: Behavior System

9. behavior_library
10. behavior_incidents
11. teacher_favorites

### Phase 4: Supporting Features

12. content_library
13. user_settings
14. backup_history
15. ai_processing

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

1. ABC (Antecedent, Behavior, Consequence) đều bắt buộc
2. Severity level từ 1-5
3. occurred_at phải trong khoảng thời gian session

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
