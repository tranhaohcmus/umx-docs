# Database Design - Educare Connect (Enhanced Version)

Tài liệu này mô tả **cấu trúc cơ sở dữ liệu cải tiến** cho ứng dụng Educare Connect.

---

## 📊 THAY ĐỔI CHÍNH

### ✨ Cải tiến Structure

1. **Name fields**: Tách `full_name` → `first_name` + `last_name`
2. **Soft delete**: Thêm `deleted_at` cho Students, Sessions, Content Library
3. **Audit trail**: Thêm `created_by`, `updated_by` tracking
4. **Session management**: Cải thiện validation và tracking
5. **Behavior system**: Tối ưu search và performance
6. **Media management**: Cải thiện storage tracking
7. **Data integrity**: Thêm constraints và business rules

---

## 📋 BẢNG DỮ LIỆU CHI TIẾT

### 1. TEACHERS (Giáo viên)

| Column         | Type         | Constraints                | Description              |
| -------------- | ------------ | -------------------------- | ------------------------ |
| id             | UUID         | PRIMARY KEY                | ID duy nhất              |
| email          | VARCHAR(255) | UNIQUE, NOT NULL           | Email đăng nhập          |
| first_name     | VARCHAR(100) | NOT NULL                   | Tên                      |
| last_name      | VARCHAR(100) | NOT NULL                   | Họ                       |
| phone          | VARCHAR(20)  | -                          | Số điện thoại            |
| school         | VARCHAR(255) | -                          | Tên trường               |
| avatar_url     | TEXT         | -                          | URL ảnh đại diện         |
| password_hash  | VARCHAR(255) | NOT NULL                   | Password (bcrypt hashed) |
| is_verified    | BOOLEAN      | DEFAULT FALSE              | Email đã xác thực?       |
| is_active      | BOOLEAN      | DEFAULT TRUE               | Tài khoản còn hoạt động? |
| two_fa_enabled | BOOLEAN      | DEFAULT FALSE              | Bật 2FA?                 |
| two_fa_secret  | VARCHAR(100) | -                          | Secret key cho 2FA       |
| timezone       | VARCHAR(50)  | DEFAULT 'Asia/Ho_Chi_Minh' | Múi giờ                  |
| language       | VARCHAR(10)  | DEFAULT 'vi'               | Ngôn ngữ (vi, en)        |
| last_login_at  | TIMESTAMP    | -                          | Lần đăng nhập cuối       |
| last_login_ip  | VARCHAR(50)  | -                          | IP đăng nhập cuối        |
| created_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP  | Ngày tạo tài khoản       |
| updated_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP  | Ngày cập nhật            |

**Indexes:**

- `idx_teachers_email` ON (email)
- `idx_teachers_is_active` ON (is_active)
- `idx_teachers_created_at` ON (created_at DESC)

**Virtual Field:**

```sql
full_name = CONCAT(first_name, ' ', last_name)
```

---

### 2. STUDENTS (Học sinh)

| Column        | Type         | Constraints                               | Description                  |
| ------------- | ------------ | ----------------------------------------- | ---------------------------- |
| id            | UUID         | PRIMARY KEY                               | ID duy nhất                  |
| teacher_id    | UUID         | FOREIGN KEY → teachers(id)                | Giáo viên quản lý            |
| first_name    | VARCHAR(100) | NOT NULL                                  | Tên                          |
| last_name     | VARCHAR(100) | NOT NULL                                  | Họ                           |
| nickname      | VARCHAR(50)  | NOT NULL                                  | Tên gọi tắt (VD: "BA", "BL") |
| date_of_birth | DATE         | NOT NULL                                  | Ngày sinh                    |
| gender        | VARCHAR(10)  | CHECK IN ('male', 'female', 'other')      | Giới tính                    |
| avatar_url    | TEXT         | -                                         | URL ảnh đại diện             |
| status        | VARCHAR(20)  | CHECK IN ('active', 'paused', 'archived') | Trạng thái học               |
| diagnosis     | TEXT         | -                                         | Chẩn đoán y khoa (nếu có)    |
| notes         | TEXT         | -                                         | Ghi chú về học sinh          |
| parent_name   | VARCHAR(255) | -                                         | Tên phụ huynh                |
| parent_phone  | VARCHAR(20)  | -                                         | SĐT phụ huynh                |
| parent_email  | VARCHAR(255) | -                                         | Email phụ huynh              |
| created_at    | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                 | Ngày tạo                     |
| updated_at    | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                 | Ngày cập nhật                |
| deleted_at    | TIMESTAMP    | -                                         | Ngày xóa (soft delete)       |

**Indexes:**

- `idx_students_teacher_id` ON (teacher_id)
- `idx_students_status` ON (status)
- `idx_students_deleted_at` ON (deleted_at)
- `idx_students_teacher_active` ON (teacher_id, status) WHERE deleted_at IS NULL

**Virtual Field:**

```sql
full_name = CONCAT(first_name, ' ', last_name)
age = EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth))
```

**Business Rules:**

- Không thể có 2 students cùng teacher_id và nickname (trừ khi deleted)
- date_of_birth không được là tương lai
- age tự động tính từ date_of_birth

---

### 3. SESSIONS (Buổi học)

| Column           | Type         | Constraints                                    | Description                      |
| ---------------- | ------------ | ---------------------------------------------- | -------------------------------- |
| id               | UUID         | PRIMARY KEY                                    | ID duy nhất                      |
| student_id       | UUID         | FOREIGN KEY → students(id)                     | Học sinh                         |
| session_date     | DATE         | NOT NULL                                       | Ngày học (YYYY-MM-DD)            |
| time_slot        | VARCHAR(20)  | CHECK IN ('morning', 'afternoon', 'evening')   | Buổi học                         |
| start_time       | TIME         | NOT NULL                                       | Giờ bắt đầu (HH:MM)              |
| end_time         | TIME         | NOT NULL                                       | Giờ kết thúc (HH:MM)             |
| duration_minutes | INTEGER      | GENERATED ALWAYS AS                            | Thời lượng (phút) - computed     |
| location         | VARCHAR(255) | -                                              | Địa điểm (phòng học, online...)  |
| notes            | TEXT         | -                                              | Ghi chú buổi học                 |
| creation_method  | VARCHAR(20)  | CHECK IN ('manual', 'ai')                      | Phương thức tạo                  |
| status           | VARCHAR(20)  | CHECK IN ('pending', 'completed', 'cancelled') | Trạng thái                       |
| has_evaluation   | BOOLEAN      | DEFAULT FALSE                                  | Đã có đánh giá?                  |
| cancelled_reason | TEXT         | -                                              | Lý do hủy (nếu status=cancelled) |
| cancelled_at     | TIMESTAMP    | -                                              | Thời điểm hủy                    |
| created_by       | UUID         | FOREIGN KEY → teachers(id)                     | Người tạo                        |
| created_at       | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                      | Ngày tạo                         |
| updated_at       | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                      | Ngày cập nhật                    |
| deleted_at       | TIMESTAMP    | -                                              | Ngày xóa (soft delete)           |

**Indexes:**

- `idx_sessions_student_id` ON (student_id)
- `idx_sessions_date` ON (session_date)
- `idx_sessions_status` ON (status)
- `idx_sessions_student_date` ON (student_id, session_date)
- `idx_sessions_created_by` ON (created_by)
- `idx_sessions_deleted_at` ON (deleted_at)

**Constraints:**

- `CHECK (end_time > start_time)`
- `CHECK (cancelled_reason IS NOT NULL WHEN status = 'cancelled')`
- `CHECK (cancelled_at IS NOT NULL WHEN status = 'cancelled')`

**Computed Fields:**

```sql
duration_minutes = EXTRACT(EPOCH FROM (end_time - start_time)) / 60
```

---

### 4. SESSION_CONTENTS (Nội dung dạy học)

| Column             | Type         | Constraints                                                        | Description                  |
| ------------------ | ------------ | ------------------------------------------------------------------ | ---------------------------- |
| id                 | UUID         | PRIMARY KEY                                                        | ID duy nhất                  |
| session_id         | UUID         | FOREIGN KEY → sessions(id) ON DELETE CASCADE                       | Buổi học                     |
| content_library_id | UUID         | FOREIGN KEY → content_library(id) ON DELETE SET NULL               | Tham chiếu thư viện (nếu có) |
| title              | VARCHAR(255) | NOT NULL                                                           | Tiêu đề nội dung             |
| domain             | VARCHAR(50)  | CHECK IN ('cognitive', 'motor', 'language', 'social', 'self_care') | Lĩnh vực                     |
| description        | TEXT         | -                                                                  | Mô tả chi tiết               |
| materials_needed   | TEXT         | -                                                                  | Vật liệu cần thiết           |
| order_index        | INTEGER      | NOT NULL                                                           | Thứ tự sắp xếp (1, 2, 3...)  |
| estimated_duration | INTEGER      | -                                                                  | Thời lượng dự kiến (phút)    |
| notes              | TEXT         | -                                                                  | Ghi chú riêng                |
| created_at         | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày tạo                     |
| updated_at         | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày cập nhật                |

**Indexes:**

- `idx_session_contents_session_id` ON (session_id)
- `idx_session_contents_order` ON (session_id, order_index)
- `idx_session_contents_domain` ON (domain)
- `idx_session_contents_library` ON (content_library_id)

**Business Rules:**

- order_index phải unique trong cùng session_id
- order_index bắt đầu từ 1

---

### 5. CONTENT_GOALS (Mục tiêu học tập)

| Column             | Type        | Constraints                                          | Description         |
| ------------------ | ----------- | ---------------------------------------------------- | ------------------- |
| id                 | UUID        | PRIMARY KEY                                          | ID duy nhất         |
| session_content_id | UUID        | FOREIGN KEY → session_contents(id) ON DELETE CASCADE | Nội dung dạy học    |
| description        | TEXT        | NOT NULL                                             | Mô tả mục tiêu      |
| goal_type          | VARCHAR(50) | CHECK IN ('knowledge', 'skill', 'behavior')          | Loại mục tiêu       |
| is_primary         | BOOLEAN     | DEFAULT TRUE                                         | Là mục tiêu chính?  |
| order_index        | INTEGER     | NOT NULL                                             | Thứ tự (1, 2, 3...) |
| created_at         | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                            | Ngày tạo            |
| updated_at         | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                            | Ngày cập nhật       |

**Indexes:**

- `idx_content_goals_content_id` ON (session_content_id)
- `idx_content_goals_order` ON (session_content_id, order_index)
- `idx_content_goals_type` ON (goal_type)

**Business Rules:**

- order_index phải unique trong cùng session_content_id

---

### 6. SESSION_LOGS (Nhật ký đánh giá buổi học)

| Column             | Type        | Constraints                                                             | Description                 |
| ------------------ | ----------- | ----------------------------------------------------------------------- | --------------------------- |
| id                 | UUID        | PRIMARY KEY                                                             | ID duy nhất                 |
| session_id         | UUID        | FOREIGN KEY → sessions(id) ON DELETE CASCADE, UNIQUE                    | Buổi học (1-1 relationship) |
| logged_at          | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                               | Thời điểm bắt đầu ghi       |
| completed_at       | TIMESTAMP   | -                                                                       | Thời điểm hoàn tất          |
| actual_start_time  | TIME        | -                                                                       | Giờ bắt đầu thực tế         |
| actual_end_time    | TIME        | -                                                                       | Giờ kết thúc thực tế        |
| mood               | VARCHAR(20) | CHECK IN ('very_difficult', 'difficult', 'normal', 'good', 'very_good') | Tâm trạng chung             |
| energy_level       | INTEGER     | CHECK (energy_level BETWEEN 1 AND 5)                                    | Mức năng lượng 1-5          |
| cooperation_level  | INTEGER     | CHECK (cooperation_level BETWEEN 1 AND 5)                               | Mức độ hợp tác 1-5          |
| focus_level        | INTEGER     | CHECK (focus_level BETWEEN 1 AND 5)                                     | Mức độ tập trung 1-5        |
| independence_level | INTEGER     | CHECK (independence_level BETWEEN 1 AND 5)                              | Mức độ tự lập 1-5           |
| attitude_summary   | TEXT        | -                                                                       | Tóm tắt thái độ             |
| progress_notes     | TEXT        | -                                                                       | Ghi chú tiến bộ             |
| challenges_faced   | TEXT        | -                                                                       | Khó khăn gặp phải           |
| recommendations    | TEXT        | -                                                                       | Khuyến nghị cho buổi sau    |
| teacher_notes_text | TEXT        | -                                                                       | Ghi chú văn bản GV          |
| overall_rating     | INTEGER     | CHECK (overall_rating BETWEEN 1 AND 5)                                  | Đánh giá chung buổi học 1-5 |
| created_by         | UUID        | FOREIGN KEY → teachers(id)                                              | Người tạo                   |
| created_at         | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                               | Ngày tạo                    |
| updated_at         | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                               | Ngày cập nhật               |

**Indexes:**

- `idx_session_logs_session_id` ON (session_id)
- `idx_session_logs_completed` ON (completed_at)
- `idx_session_logs_mood` ON (mood)
- `idx_session_logs_created_by` ON (created_by)

**Business Rules:**

- Khi session_log được tạo (completed_at IS NOT NULL), sessions.status tự động = 'completed'
- actual_end_time > actual_start_time (nếu có)

---

### 7. LOG_MEDIA_ATTACHMENTS (Media đính kèm)

| Column         | Type         | Constraints                                      | Description                          |
| -------------- | ------------ | ------------------------------------------------ | ------------------------------------ |
| id             | UUID         | PRIMARY KEY                                      | ID duy nhất                          |
| session_log_id | UUID         | FOREIGN KEY → session_logs(id) ON DELETE CASCADE | Nhật ký buổi học                     |
| media_type     | VARCHAR(20)  | CHECK IN ('image', 'video', 'audio')             | Loại media                           |
| url            | TEXT         | NOT NULL                                         | URL file (cloud storage)             |
| thumbnail_url  | TEXT         | -                                                | URL thumbnail (cho video/image)      |
| filename       | VARCHAR(255) | NOT NULL                                         | Tên file gốc                         |
| file_size      | BIGINT       | NOT NULL                                         | Kích thước (bytes)                   |
| mime_type      | VARCHAR(100) | -                                                | MIME type (image/jpeg, video/mp4...) |
| duration       | INTEGER      | -                                                | Thời lượng (giây) - cho audio/video  |
| width          | INTEGER      | -                                                | Chiều rộng (px) - cho image/video    |
| height         | INTEGER      | -                                                | Chiều cao (px) - cho image/video     |
| caption        | TEXT         | -                                                | Chú thích                            |
| uploaded_by    | UUID         | FOREIGN KEY → teachers(id)                       | Người upload                         |
| created_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                        | Ngày tạo                             |

**Indexes:**

- `idx_media_log_id` ON (session_log_id)
- `idx_media_type` ON (media_type)
- `idx_media_uploaded_by` ON (uploaded_by)
- `idx_media_created_at` ON (created_at DESC)

**Business Rules:**

- file_size không vượt quá giới hạn cấu hình (vd: 50MB cho video, 10MB cho ảnh)
- duration bắt buộc cho audio/video

---

### 8. GOAL_EVALUATIONS (Đánh giá mục tiêu)

| Column            | Type        | Constraints                                                                                    | Description             |
| ----------------- | ----------- | ---------------------------------------------------------------------------------------------- | ----------------------- |
| id                | UUID        | PRIMARY KEY                                                                                    | ID duy nhất             |
| session_log_id    | UUID        | FOREIGN KEY → session_logs(id) ON DELETE CASCADE                                               | Nhật ký buổi học        |
| content_goal_id   | UUID        | FOREIGN KEY → content_goals(id) ON DELETE CASCADE                                              | Mục tiêu được đánh giá  |
| status            | VARCHAR(20) | CHECK IN ('achieved', 'partially_achieved', 'not_achieved', 'not_applicable')                  | Trạng thái đạt mục tiêu |
| achievement_level | INTEGER     | CHECK (achievement_level BETWEEN 0 AND 100)                                                    | Mức độ đạt được (%)     |
| support_level     | VARCHAR(50) | CHECK IN ('independent', 'minimal_prompt', 'moderate_prompt', 'full_prompt', 'hand_over_hand') | Mức hỗ trợ cần thiết    |
| notes             | TEXT        | -                                                                                              | Ghi chú chi tiết        |
| next_steps        | TEXT        | -                                                                                              | Bước tiếp theo          |
| created_at        | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                                                      | Ngày tạo                |
| updated_at        | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                                                      | Ngày cập nhật           |

**Indexes:**

- `idx_goal_eval_log_id` ON (session_log_id)
- `idx_goal_eval_goal_id` ON (content_goal_id)
- `idx_goal_eval_status` ON (status)
- `idx_goal_eval_achievement` ON (achievement_level)

**Constraints:**

- `UNIQUE (session_log_id, content_goal_id)`

**Business Rules:**

- achievement_level = 0 khi status = 'not_achieved'
- achievement_level = 100 khi status = 'achieved'
- achievement_level = 1-99 khi status = 'partially_achieved'

---

### 9. BEHAVIOR_GROUPS (Nhóm Hành vi)

| Column         | Type         | Constraints               | Description                     |
| -------------- | ------------ | ------------------------- | ------------------------------- |
| id             | UUID         | PRIMARY KEY               | ID duy nhất                     |
| code           | VARCHAR(20)  | UNIQUE, NOT NULL          | Mã nhóm (GROUP_01, GROUP_02...) |
| name_vn        | VARCHAR(255) | NOT NULL                  | Tên tiếng Việt                  |
| name_en        | VARCHAR(255) | NOT NULL                  | Tên tiếng Anh                   |
| description_vn | TEXT         | -                         | Mô tả tiếng Việt                |
| description_en | TEXT         | -                         | Mô tả tiếng Anh                 |
| icon           | VARCHAR(50)  | -                         | Icon/emoji đại diện             |
| color_code     | VARCHAR(7)   | -                         | Mã màu hex (#FF5733)            |
| common_tips    | JSON         | -                         | Mảng mẹo chung                  |
| order_index    | INTEGER      | NOT NULL                  | Thứ tự hiển thị                 |
| is_active      | BOOLEAN      | DEFAULT TRUE              | Còn hiển thị?                   |
| created_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP | Ngày tạo                        |
| updated_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP | Ngày cập nhật                   |

**Indexes:**

- `idx_behavior_groups_code` ON (code)
- `idx_behavior_groups_order` ON (order_index)
- `idx_behavior_groups_active` ON (is_active)

---

### 10. BEHAVIOR_LIBRARY (Thư viện Hành vi)

| Column                | Type         | Constraints                       | Description                           |
| --------------------- | ------------ | --------------------------------- | ------------------------------------- |
| id                    | UUID         | PRIMARY KEY                       | ID duy nhất                           |
| behavior_group_id     | UUID         | FOREIGN KEY → behavior_groups(id) | Nhóm hành vi                          |
| behavior_code         | VARCHAR(20)  | UNIQUE, NOT NULL                  | Mã hành vi (BH_01_01, BH_01_02...)    |
| name_vn               | VARCHAR(255) | NOT NULL                          | Tên tiếng Việt                        |
| name_en               | VARCHAR(255) | NOT NULL                          | Tên tiếng Anh                         |
| keywords_vn           | JSON         | NOT NULL                          | Mảng từ khóa tiếng Việt (10-15 từ)    |
| keywords_en           | JSON         | -                                 | Mảng từ khóa tiếng Anh                |
| manifestation_vn      | TEXT         | NOT NULL                          | Mô tả biểu hiện (tiếng Việt)          |
| manifestation_en      | TEXT         | -                                 | Mô tả biểu hiện (tiếng Anh)           |
| age_range_min         | INTEGER      | -                                 | Độ tuổi tối thiểu thường gặp          |
| age_range_max         | INTEGER      | -                                 | Độ tuổi tối đa thường gặp             |
| severity_indicators   | JSON         | -                                 | Mảng chỉ báo mức độ nghiêm trọng      |
| explanation           | JSON         | NOT NULL                          | Mảng {title, description} - lý thuyết |
| solutions             | JSON         | NOT NULL                          | Mảng {title, description} - can thiệp |
| prevention_strategies | JSON         | -                                 | Mảng chiến lược phòng ngừa            |
| sources               | JSON         | NOT NULL                          | Mảng trích dẫn học thuật              |
| related_behaviors     | JSON         | -                                 | Mảng ID hành vi liên quan             |
| icon                  | VARCHAR(50)  | -                                 | Icon/emoji đại diện                   |
| is_active             | BOOLEAN      | DEFAULT TRUE                      | Còn hiển thị?                         |
| usage_count           | INTEGER      | DEFAULT 0                         | Số lần sử dụng (auto increment)       |
| last_used_at          | TIMESTAMP    | -                                 | Lần sử dụng cuối                      |
| created_at            | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP         | Ngày tạo                              |
| updated_at            | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP         | Ngày cập nhật                         |

**Indexes:**

- `idx_behavior_group` ON (behavior_group_id)
- `idx_behavior_code` ON (behavior_code)
- `idx_behavior_active` ON (is_active)
- `idx_behavior_usage` ON (usage_count DESC)
- `idx_behavior_last_used` ON (last_used_at DESC)
- `idx_behavior_age_range` ON (age_range_min, age_range_max)
- Full-text search index on keywords_vn (PostgreSQL GIN)

**Business Rules:**

- behavior*code format: BH*{GROUP*CODE}*{SEQUENCE} (e.g., BH_01_01, BH_01_02, BH_02_01)
- keywords_vn phải có ít nhất 10 từ khóa
- explanation phải có ít nhất 2 frameworks
- solutions phải có ít nhất 4 strategies
- sources phải có ít nhất 2 academic citations

---

### 11. BEHAVIOR_INCIDENTS (Hành vi ghi nhận)

| Column                 | Type      | Constraints                                      | Description                  |
| ---------------------- | --------- | ------------------------------------------------ | ---------------------------- |
| id                     | UUID      | PRIMARY KEY                                      | ID duy nhất                  |
| session_log_id         | UUID      | FOREIGN KEY → session_logs(id) ON DELETE CASCADE | Nhật ký buổi học             |
| behavior_library_id    | UUID      | FOREIGN KEY → behavior_library(id)               | Hành vi từ thư viện          |
| incident_number        | INTEGER   | NOT NULL                                         | Số thứ tự trong buổi học     |
| antecedent             | TEXT      | NOT NULL                                         | A: Tình huống xảy ra         |
| behavior_description   | TEXT      | NOT NULL                                         | B: Mô tả hành vi cụ thể      |
| consequence            | TEXT      | NOT NULL                                         | C: Kết quả sau đó            |
| duration_minutes       | INTEGER   | -                                                | Thời lượng hành vi (phút)    |
| intensity_level        | INTEGER   | CHECK (intensity_level BETWEEN 1 AND 5)          | Cường độ 1-5                 |
| frequency_count        | INTEGER   | DEFAULT 1                                        | Số lần xảy ra trong incident |
| intervention_used      | TEXT      | -                                                | Can thiệp đã sử dụng         |
| intervention_effective | BOOLEAN   | -                                                | Can thiệp có hiệu quả?       |
| environmental_factors  | TEXT      | -                                                | Yếu tố môi trường            |
| occurred_at            | TIMESTAMP | NOT NULL                                         | Thời điểm xảy ra             |
| notes                  | TEXT      | -                                                | Ghi chú chi tiết             |
| requires_followup      | BOOLEAN   | DEFAULT FALSE                                    | Cần theo dõi thêm?           |
| followup_notes         | TEXT      | -                                                | Ghi chú theo dõi             |
| recorded_by            | UUID      | FOREIGN KEY → teachers(id)                       | Người ghi nhận               |
| created_at             | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                        | Ngày tạo                     |
| updated_at             | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                        | Ngày cập nhật                |

**Indexes:**

- `idx_incidents_log_id` ON (session_log_id)
- `idx_incidents_behavior_id` ON (behavior_library_id)
- `idx_incidents_intensity` ON (intensity_level)
- `idx_incidents_occurred` ON (occurred_at)
- `idx_incidents_followup` ON (requires_followup)
- `idx_incidents_recorded_by` ON (recorded_by)

**Business Rules:**

- incident_number auto-increment trong cùng session_log_id
- occurred_at phải trong khoảng thời gian của session

---

### 12. CONTENT_LIBRARY (Thư viện Nội dung)

| Column             | Type         | Constraints                                                        | Description                  |
| ------------------ | ------------ | ------------------------------------------------------------------ | ---------------------------- |
| id                 | UUID         | PRIMARY KEY                                                        | ID duy nhất                  |
| teacher_id         | UUID         | FOREIGN KEY → teachers(id) ON DELETE CASCADE                       | NULL = system template       |
| code               | VARCHAR(50)  | -                                                                  | Mã nội dung (optional)       |
| title              | VARCHAR(255) | NOT NULL                                                           | Tiêu đề nội dung             |
| domain             | VARCHAR(50)  | CHECK IN ('cognitive', 'motor', 'language', 'social', 'self_care') | Lĩnh vực                     |
| description        | TEXT         | -                                                                  | Mô tả chi tiết               |
| target_age_min     | INTEGER      | -                                                                  | Độ tuổi mục tiêu (tối thiểu) |
| target_age_max     | INTEGER      | -                                                                  | Độ tuổi mục tiêu (tối đa)    |
| difficulty_level   | VARCHAR(20)  | CHECK IN ('beginner', 'intermediate', 'advanced')                  | Mức độ khó                   |
| default_goals      | JSON         | -                                                                  | Mảng mục tiêu mặc định       |
| materials_needed   | TEXT         | -                                                                  | Vật liệu cần thiết           |
| estimated_duration | INTEGER      | -                                                                  | Thời lượng dự kiến (phút)    |
| instructions       | TEXT         | -                                                                  | Hướng dẫn thực hiện          |
| tips               | TEXT         | -                                                                  | Mẹo và lưu ý                 |
| is_template        | BOOLEAN      | DEFAULT FALSE                                                      | Là template hệ thống?        |
| is_public          | BOOLEAN      | DEFAULT FALSE                                                      | Chia sẻ công khai?           |
| usage_count        | INTEGER      | DEFAULT 0                                                          | Số lần sử dụng               |
| rating_avg         | DECIMAL(3,2) | CHECK (rating_avg BETWEEN 0 AND 5)                                 | Đánh giá TB (0-5)            |
| rating_count       | INTEGER      | DEFAULT 0                                                          | Số lượt đánh giá             |
| tags               | JSON         | -                                                                  | Mảng tags                    |
| created_at         | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày tạo                     |
| updated_at         | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | Ngày cập nhật                |
| deleted_at         | TIMESTAMP    | -                                                                  | Ngày xóa (soft delete)       |

**Indexes:**

- `idx_content_lib_teacher` ON (teacher_id)
- `idx_content_lib_domain` ON (domain)
- `idx_content_lib_template` ON (is_template)
- `idx_content_lib_public` ON (is_public)
- `idx_content_lib_difficulty` ON (difficulty_level)
- `idx_content_lib_age_range` ON (target_age_min, target_age_max)
- `idx_content_lib_usage` ON (usage_count DESC)
- `idx_content_lib_rating` ON (rating_avg DESC)
- `idx_content_lib_deleted` ON (deleted_at)

**Business Rules:**

- System templates có teacher_id = NULL
- is_public chỉ áp dụng cho user-created content (teacher_id NOT NULL)

---

### 13. CONTENT_LIBRARY_RATINGS (Đánh giá Nội dung)

| Column             | Type      | Constraints                                         | Description            |
| ------------------ | --------- | --------------------------------------------------- | ---------------------- |
| id                 | UUID      | PRIMARY KEY                                         | ID duy nhất            |
| content_library_id | UUID      | FOREIGN KEY → content_library(id) ON DELETE CASCADE | Nội dung được đánh giá |
| teacher_id         | UUID      | FOREIGN KEY → teachers(id) ON DELETE CASCADE        | Giáo viên đánh giá     |
| rating             | INTEGER   | CHECK (rating BETWEEN 1 AND 5)                      | Điểm đánh giá 1-5      |
| review             | TEXT      | -                                                   | Nhận xét               |
| created_at         | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                           | Ngày tạo               |
| updated_at         | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                           | Ngày cập nhật          |

**Indexes:**

- `idx_ratings_content` ON (content_library_id)
- `idx_ratings_teacher` ON (teacher_id)
- `idx_ratings_score` ON (rating)

**Constraints:**

- `UNIQUE (content_library_id, teacher_id)`

---

### 14. TEACHER_FAVORITES (Yêu thích)

| Column           | Type        | Constraints                                  | Description              |
| ---------------- | ----------- | -------------------------------------------- | ------------------------ |
| id               | UUID        | PRIMARY KEY                                  | ID duy nhất              |
| teacher_id       | UUID        | FOREIGN KEY → teachers(id) ON DELETE CASCADE | Giáo viên                |
| favoritable_type | VARCHAR(50) | CHECK IN ('behavior', 'content')             | Loại đối tượng yêu thích |
| favoritable_id   | UUID        | NOT NULL                                     | ID đối tượng yêu thích   |
| notes            | TEXT        | -                                            | Ghi chú riêng            |
| created_at       | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                    | Ngày thêm                |

**Indexes:**

- `idx_favorites_teacher` ON (teacher_id)
- `idx_favorites_type_id` ON (favoritable_type, favoritable_id)

**Constraints:**

- `UNIQUE (teacher_id, favoritable_type, favoritable_id)`

**Business Rules:**

- favoritable_id tham chiếu đến behavior_library(id) khi type='behavior'
- favoritable_id tham chiếu đến content_library(id) khi type='content'

---

### 15. STUDENT_PROGRESS_SNAPSHOTS (Snapshot Tiến độ)

| Column             | Type        | Constraints                                  | Description               |
| ------------------ | ----------- | -------------------------------------------- | ------------------------- |
| id                 | UUID        | PRIMARY KEY                                  | ID duy nhất               |
| student_id         | UUID        | FOREIGN KEY → students(id) ON DELETE CASCADE | Học sinh                  |
| snapshot_date      | DATE        | NOT NULL                                     | Ngày chụp snapshot        |
| snapshot_type      | VARCHAR(20) | CHECK IN ('weekly', 'monthly', 'quarterly')  | Loại snapshot             |
| period_start       | DATE        | NOT NULL                                     | Đầu kỳ                    |
| period_end         | DATE        | NOT NULL                                     | Cuối kỳ                   |
| total_sessions     | INTEGER     | NOT NULL                                     | Tổng số buổi học          |
| completed_sessions | INTEGER     | NOT NULL                                     | Số buổi hoàn thành        |
| domain_scores      | JSON        | NOT NULL                                     | Điểm theo lĩnh vực        |
| behavior_summary   | JSON        | -                                            | Tóm tắt hành vi           |
| top_achievements   | JSON        | -                                            | Thành tựu nổi bật         |
| areas_for_growth   | JSON        | -                                            | Lĩnh vực cần cải thiện    |
| teacher_summary    | TEXT        | -                                            | Nhận xét tổng quan của GV |
| generated_by       | UUID        | FOREIGN KEY → teachers(id)                   | Người tạo                 |
| created_at         | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                    | Ngày tạo                  |

**Indexes:**

- `idx_snapshots_student` ON (student_id)
- `idx_snapshots_date` ON (snapshot_date DESC)
- `idx_snapshots_type` ON (snapshot_type)
- `idx_snapshots_period` ON (period_start, period_end)

**JSON Structures:**

```json
// domain_scores
{
  "cognitive": {"avg_achievement": 75, "sessions_count": 10},
  "motor": {"avg_achievement": 82, "sessions_count": 8},
  "language": {"avg_achievement": 68, "sessions_count": 12}
}

// behavior_summary
{
  "total_incidents": 15,
  "most_common": ["BH_01_01", "BH_02_03"],
  "improvement_rate": 20
}
```

---

### 16. USER_SETTINGS (Cài đặt)

| Column     | Type         | Constraints                                  | Description                        |
| ---------- | ------------ | -------------------------------------------- | ---------------------------------- |
| id         | UUID         | PRIMARY KEY                                  | ID duy nhất                        |
| teacher_id | UUID         | FOREIGN KEY → teachers(id) ON DELETE CASCADE | Giáo viên                          |
| category   | VARCHAR(50)  | NOT NULL                                     | Nhóm setting (ui, notification...) |
| key        | VARCHAR(100) | NOT NULL                                     | Tên setting                        |
| value      | JSONB        | NOT NULL                                     | Giá trị (JSON)                     |
| is_default | BOOLEAN      | DEFAULT FALSE                                | Là giá trị mặc định?               |
| created_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                    | Ngày tạo                           |
| updated_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                    | Ngày cập nhật                      |

**Indexes:**

- `idx_settings_teacher_category` ON (teacher_id, category)
- `idx_settings_teacher_key` ON (teacher_id, key)

**Constraints:**

- `UNIQUE (teacher_id, category, key)`

**Common Settings:**

```json
// UI Settings
{"theme": "light", "language": "vi", "date_format": "DD/MM/YYYY"}

// Notification Settings
{"email_enabled": true, "reminder_time": "08:00", "weekly_summary": true}

// Session Settings
{"default_duration": 60, "auto_save_interval": 300}
```

---

### 17. NOTIFICATIONS (Thông báo)

| Column              | Type         | Constraints                                              | Description              |
| ------------------- | ------------ | -------------------------------------------------------- | ------------------------ |
| id                  | UUID         | PRIMARY KEY                                              | ID duy nhất              |
| teacher_id          | UUID         | FOREIGN KEY → teachers(id) ON DELETE CASCADE             | Người nhận               |
| notification_type   | VARCHAR(50)  | CHECK IN ('reminder', 'achievement', 'system', 'update') | Loại thông báo           |
| title               | VARCHAR(255) | NOT NULL                                                 | Tiêu đề                  |
| message             | TEXT         | NOT NULL                                                 | Nội dung                 |
| action_url          | TEXT         | -                                                        | URL để xem chi tiết      |
| related_entity_type | VARCHAR(50)  | -                                                        | Loại đối tượng liên quan |
| related_entity_id   | UUID         | -                                                        | ID đối tượng liên quan   |
| priority            | VARCHAR(20)  | CHECK IN ('low', 'normal', 'high')                       | Mức độ ưu tiên           |
| is_read             | BOOLEAN      | DEFAULT FALSE                                            | Đã đọc?                  |
| read_at             | TIMESTAMP    | -                                                        | Thời điểm đọc            |
| expires_at          | TIMESTAMP    | -                                                        | Thời điểm hết hạn        |
| created_at          | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                | Ngày tạo                 |

**Indexes:**

- `idx_notifications_teacher` ON (teacher_id)
- `idx_notifications_unread` ON (teacher_id, is_read) WHERE is_read = FALSE
- `idx_notifications_type` ON (notification_type)
- `idx_notifications_created` ON (created_at DESC)

---

### 18. BACKUP_HISTORY (Lịch sử sao lưu)

| Column        | Type         | Constraints                                               | Description                |
| ------------- | ------------ | --------------------------------------------------------- | -------------------------- |
| id            | UUID         | PRIMARY KEY                                               | ID duy nhất                |
| teacher_id    | UUID         | FOREIGN KEY → teachers(id) ON DELETE CASCADE              | Giáo viên                  |
| backup_type   | VARCHAR(20)  | CHECK IN ('manual', 'auto', 'scheduled')                  | Loại backup                |
| scope         | VARCHAR(50)  | CHECK IN ('full', 'incremental', 'students_only')         | Phạm vi backup             |
| file_url      | TEXT         | NOT NULL                                                  | URL file backup            |
| file_name     | VARCHAR(255) | NOT NULL                                                  | Tên file                   |
| file_size     | BIGINT       | NOT NULL                                                  | Kích thước (bytes)         |
| file_format   | VARCHAR(20)  | CHECK IN ('json', 'sql', 'csv', 'pdf')                    | Định dạng file             |
| checksum      | VARCHAR(64)  | -                                                         | MD5/SHA256 checksum        |
| records_count | JSON         | -                                                         | Số lượng records theo bảng |
| status        | VARCHAR(20)  | CHECK IN ('pending', 'processing', 'completed', 'failed') | Trạng thái                 |
| error_message | TEXT         | -                                                         | Lỗi nếu có                 |
| expires_at    | TIMESTAMP    | -                                                         | Thời điểm hết hạn          |
| created_at    | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                 | Ngày tạo                   |
| completed_at  | TIMESTAMP    | -                                                         | Ngày hoàn thành            |

**Indexes:**

- `idx_backup_teacher` ON (teacher_id)
- `idx_backup_type` ON (backup_type)
- `idx_backup_status` ON (status)
- `idx_backup_created` ON (created_at DESC)

---

### 19. AI_PROCESSING (Xử lý AI)

| Column            | Type        | Constraints                                                                 | Description                     |
| ----------------- | ----------- | --------------------------------------------------------------------------- | ------------------------------- |
| id                | UUID        | PRIMARY KEY                                                                 | ID duy nhất                     |
| teacher_id        | UUID        | FOREIGN KEY → teachers(id) ON DELETE CASCADE                                | Giáo viên                       |
| student_id        | UUID        | FOREIGN KEY → students(id) ON DELETE SET NULL                               | Học sinh (optional)             |
| processing_type   | VARCHAR(50) | CHECK IN ('text_extract', 'session_generate', 'behavior_detect', 'summary') | Loại xử lý                      |
| input_type        | VARCHAR(50) | CHECK IN ('file', 'text', 'url')                                            | Loại đầu vào                    |
| file_url          | TEXT        | -                                                                           | URL file upload                 |
| file_type         | VARCHAR(50) | -                                                                           | Loại file (pdf, docx, txt, jpg) |
| file_size         | BIGINT      | -                                                                           | Kích thước file                 |
| text_content      | TEXT        | -                                                                           | Nội dung text nếu paste         |
| processing_status | VARCHAR(20) | CHECK IN ('pending', 'processing', 'completed', 'failed', 'cancelled')      | Trạng thái xử lý                |
| progress          | INTEGER     | CHECK (progress BETWEEN 0 AND 100)                                          | Tiến độ % (0-100)               |
| result_data       | JSONB       | -                                                                           | Kết quả xử lý (JSON)            |
| tokens_used       | INTEGER     | -                                                                           | Số tokens AI đã dùng            |
| processing_time   | INTEGER     | -                                                                           | Thời gian xử lý (giây)          |
| error_message     | TEXT        | -                                                                           | Lỗi nếu có                      |
| error_code        | VARCHAR(50) | -                                                                           | Mã lỗi                          |
| retry_count       | INTEGER     | DEFAULT 0                                                                   | Số lần thử lại                  |
| created_at        | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                                                   | Ngày tạo                        |
| started_at        | TIMESTAMP   | -                                                                           | Thời điểm bắt đầu xử lý         |
| completed_at      | TIMESTAMP   | -                                                                           | Ngày hoàn thành                 |

**Indexes:**

- `idx_ai_teacher` ON (teacher_id)
- `idx_ai_student` ON (student_id)
- `idx_ai_status` ON (processing_status)
- `idx_ai_type` ON (processing_type)
- `idx_ai_created` ON (created_at DESC)

**JSON result_data structure:**

```json
{
  "sessions_created": [
    { "session_id": "uuid", "date": "2025-01-15", "contents_count": 3 }
  ],
  "behaviors_detected": [
    { "behavior_code": "BH_01_01", "confidence": 0.85, "context": "..." }
  ],
  "summary": {
    "total_sessions": 5,
    "total_goals": 20,
    "avg_achievement": 75
  }
}
```

---

### 20. AUDIT_LOGS (Nhật ký Audit)

| Column      | Type        | Constraints                                   | Description                          |
| ----------- | ----------- | --------------------------------------------- | ------------------------------------ |
| id          | UUID        | PRIMARY KEY                                   | ID duy nhất                          |
| teacher_id  | UUID        | FOREIGN KEY → teachers(id) ON DELETE SET NULL | Người thực hiện                      |
| action_type | VARCHAR(50) | NOT NULL                                      | Loại hành động (create, update...)   |
| entity_type | VARCHAR(50) | NOT NULL                                      | Loại đối tượng (student, session...) |
| entity_id   | UUID        | NOT NULL                                      | ID đối tượng                         |
| changes     | JSONB       | -                                             | Chi tiết thay đổi                    |
| ip_address  | VARCHAR(50) | -                                             | IP thực hiện                         |
| user_agent  | TEXT        | -                                             | User agent                           |
| created_at  | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                     | Thời điểm                            |

**Indexes:**

- `idx_audit_teacher` ON (teacher_id)
- `idx_audit_entity` ON (entity_type, entity_id)
- `idx_audit_action` ON (action_type)
- `idx_audit_created` ON (created_at DESC)

**Partition by:** created_at (monthly partitions for performance)

---

## 🔗 QUAN HỆ GIỮA CÁC BẢNG (ENHANCED)

### One-to-Many (1-N)

1. **TEACHERS → STUDENTS**: 1 giáo viên quản lý nhiều học sinh
2. **TEACHERS → SESSIONS** (via created_by): 1 giáo viên tạo nhiều buổi học
3. **TEACHERS → CONTENT_LIBRARY**: 1 giáo viên tạo nhiều content templates
4. **TEACHERS → NOTIFICATIONS**: 1 giáo viên nhận nhiều thông báo
5. **STUDENTS → SESSIONS**: 1 học sinh có nhiều buổi học
6. **STUDENTS → PROGRESS_SNAPSHOTS**: 1 học sinh có nhiều snapshots
7. **SESSIONS → SESSION_CONTENTS**: 1 buổi học có nhiều nội dung
8. **SESSION_CONTENTS → CONTENT_GOALS**: 1 nội dung có nhiều mục tiêu
9. **SESSION_LOGS → LOG_MEDIA_ATTACHMENTS**: 1 nhật ký có nhiều media
10. **SESSION_LOGS → GOAL_EVALUATIONS**: 1 nhật ký đánh giá nhiều mục tiêu
11. **SESSION_LOGS → BEHAVIOR_INCIDENTS**: 1 nhật ký ghi nhận nhiều hành vi
12. **BEHAVIOR_GROUPS → BEHAVIOR_LIBRARY**: 1 nhóm có nhiều hành vi
13. **BEHAVIOR_LIBRARY → BEHAVIOR_INCIDENTS**: 1 hành vi có nhiều incidents
14. **CONTENT_LIBRARY → CONTENT_LIBRARY_RATINGS**: 1 nội dung có nhiều đánh giá
15. **TEACHERS → AI_PROCESSING**: 1 giáo viên có nhiều lần xử lý AI
16. **TEACHERS → BACKUP_HISTORY**: 1 giáo viên có nhiều backup

### One-to-One (1-1)

1. **SESSIONS → SESSION_LOGS**: 1 buổi học có tối đa 1 nhật ký đánh giá

### Many-to-Many (N-N)

1. **TEACHERS ↔ BEHAVIOR_LIBRARY + CONTENT_LIBRARY** (via TEACHER_FAVORITES):
   - Polymorphic relationship với favoritable_type và favoritable_id

---

## 📊 BUSINESS LOGIC & COMPUTED FIELDS

### Computed Fields (Database Level)

```sql
-- STUDENTS table
CREATE OR REPLACE FUNCTION student_full_name(first_name VARCHAR, last_name VARCHAR)
RETURNS VARCHAR AS $
BEGIN
  RETURN CONCAT(first_name, ' ', last_name);
END;
$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION student_age(date_of_birth DATE)
RETURNS INTEGER AS $
BEGIN
  RETURN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth));
END;
$ LANGUAGE plpgsql STABLE;

-- SESSIONS table
CREATE OR REPLACE FUNCTION session_duration(start_time TIME, end_time TIME)
RETURNS INTEGER AS $
BEGIN
  RETURN EXTRACT(EPOCH FROM (end_time - start_time)) / 60;
END;
$ LANGUAGE plpgsql IMMUTABLE;
```

### Triggers

```sql
-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$ LANGUAGE plpgsql;

-- Apply to all tables
CREATE TRIGGER update_teachers_updated_at BEFORE UPDATE ON teachers
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- (repeat for other tables)

-- Auto-update session status when log completed
CREATE OR REPLACE FUNCTION update_session_status_on_log()
RETURNS TRIGGER AS $
BEGIN
  IF NEW.completed_at IS NOT NULL THEN
    UPDATE sessions SET
      status = 'completed',
      has_evaluation = TRUE
    WHERE id = NEW.session_id;
  END IF;
  RETURN NEW;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER session_log_completed
AFTER INSERT OR UPDATE ON session_logs
FOR EACH ROW EXECUTE FUNCTION update_session_status_on_log();

-- Auto-increment usage_count
CREATE OR REPLACE FUNCTION increment_usage_count()
RETURNS TRIGGER AS $
BEGIN
  UPDATE behavior_library
  SET usage_count = usage_count + 1,
      last_used_at = CURRENT_TIMESTAMP
  WHERE id = NEW.behavior_library_id;
  RETURN NEW;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER behavior_incident_created
AFTER INSERT ON behavior_incidents
FOR EACH ROW EXECUTE FUNCTION increment_usage_count();

-- Auto-update content library ratings
CREATE OR REPLACE FUNCTION update_content_rating()
RETURNS TRIGGER AS $
BEGIN
  UPDATE content_library SET
    rating_avg = (SELECT AVG(rating) FROM content_library_ratings WHERE content_library_id = NEW.content_library_id),
    rating_count = (SELECT COUNT(*) FROM content_library_ratings WHERE content_library_id = NEW.content_library_id)
  WHERE id = NEW.content_library_id;
  RETURN NEW;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER content_rating_changed
AFTER INSERT OR UPDATE OR DELETE ON content_library_ratings
FOR EACH ROW EXECUTE FUNCTION update_content_rating();
```

---

## 🔍 ADVANCED QUERIES

### Dashboard Statistics

```sql
-- Student overview with progress
SELECT
  s.*,
  student_full_name(s.first_name, s.last_name) as full_name,
  student_age(s.date_of_birth) as age,
  COUNT(DISTINCT sess.id) as total_sessions,
  COUNT(DISTINCT CASE WHEN sess.status = 'completed' THEN sess.id END) as completed_sessions,
  AVG(sl.overall_rating) as avg_rating,
  COUNT(DISTINCT bi.id) as total_behaviors,
  MAX(sess.session_date) as last_session_date
FROM students s
LEFT JOIN sessions sess ON s.id = sess.student_id AND sess.deleted_at IS NULL
LEFT JOIN session_logs sl ON sess.id = sl.session_id
LEFT JOIN behavior_incidents bi ON sl.id = bi.session_log_id
WHERE s.teacher_id = :teacher_id
  AND s.status = 'active'
  AND s.deleted_at IS NULL
GROUP BY s.id
ORDER BY last_session_date DESC NULLS LAST;
```

### Behavior Analytics with Trends

```sql
-- Weekly behavior trends
WITH weekly_data AS (
  SELECT
    DATE_TRUNC('week', bi.occurred_at) as week,
    bg.name_vn as group_name,
    bl.behavior_code,
    bl.name_vn as behavior_name,
    COUNT(*) as incident_count,
    AVG(bi.intensity_level) as avg_intensity,
    SUM(CASE WHEN bi.intervention_effective = TRUE THEN 1 ELSE 0 END) as effective_interventions
  FROM behavior_incidents bi
  JOIN session_logs sl ON bi.session_log_id = sl.id
  JOIN sessions sess ON sl.session_id = sess.id
  JOIN behavior_library bl ON bi.behavior_library_id = bl.id
  JOIN behavior_groups bg ON bl.behavior_group_id = bg.id
  WHERE sess.student_id = :student_id
    AND bi.occurred_at >= CURRENT_DATE - INTERVAL '12 weeks'
  GROUP BY week, bg.name_vn, bl.behavior_code, bl.name_vn
)
SELECT
  week,
  group_name,
  behavior_code,
  behavior_name,
  incident_count,
  ROUND(avg_intensity, 2) as avg_intensity,
  ROUND(100.0 * effective_interventions / incident_count, 1) as intervention_success_rate,
  LAG(incident_count) OVER (PARTITION BY behavior_code ORDER BY week) as prev_week_count,
  CASE
    WHEN LAG(incident_count) OVER (PARTITION BY behavior_code ORDER BY week) IS NULL THEN NULL
    WHEN LAG(incident_count) OVER (PARTITION BY behavior_code ORDER BY week) = 0 THEN NULL
    ELSE ROUND(100.0 * (incident_count - LAG(incident_count) OVER (PARTITION BY behavior_code ORDER BY week)) /
         LAG(incident_count) OVER (PARTITION BY behavior_code ORDER BY week), 1)
  END as change_percentage
FROM weekly_data
ORDER BY week DESC, incident_count DESC;
```

### Goal Achievement Analysis

```sql
-- Goal achievement by domain and student
SELECT
  s.first_name || ' ' || s.last_name as student_name,
  sc.domain,
  COUNT(DISTINCT cg.id) as total_goals,
  COUNT(DISTINCT CASE WHEN ge.status = 'achieved' THEN ge.id END) as achieved_goals,
  COUNT(DISTINCT CASE WHEN ge.status = 'partially_achieved' THEN ge.id END) as partially_achieved,
  COUNT(DISTINCT CASE WHEN ge.status = 'not_achieved' THEN ge.id END) as not_achieved,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN ge.status = 'achieved' THEN ge.id END) /
        NULLIF(COUNT(DISTINCT cg.id), 0), 1) as achievement_rate,
  AVG(ge.achievement_level) as avg_achievement_level
FROM students s
JOIN sessions sess ON s.id = sess.student_id
JOIN session_contents sc ON sess.id = sc.session_id
JOIN content_goals cg ON sc.id = cg.session_content_id
LEFT JOIN goal_evaluations ge ON cg.id = ge.content_goal_id
WHERE s.teacher_id = :teacher_id
  AND sess.status = 'completed'
  AND sess.deleted_at IS NULL
  AND s.deleted_at IS NULL
  AND sess.session_date >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY s.id, s.first_name, s.last_name, sc.domain
ORDER BY student_name, sc.domain;
```

### Smart Behavior Search

```sql
-- Search behaviors with relevance scoring
SELECT
  bl.*,
  bg.name_vn as group_name,
  bg.icon as group_icon,
  -- Relevance scoring
  (
    CASE WHEN bl.behavior_code ILIKE :search_term || '%' THEN 100 ELSE 0 END +
    CASE WHEN bl.name_vn ILIKE '%' || :search_term || '%' THEN 50 ELSE 0 END +
    CASE WHEN EXISTS (
      SELECT 1 FROM jsonb_array_elements_text(bl.keywords_vn) kw
      WHERE kw ILIKE '%' || :search_term || '%'
    ) THEN 30 ELSE 0 END +
    CASE WHEN bl.manifestation_vn ILIKE '%' || :search_term || '%' THEN 10 ELSE 0 END +
    (bl.usage_count / 10)  -- Bonus for popular behaviors
  ) as relevance_score,
  -- Teacher-specific stats
  (SELECT COUNT(*) FROM teacher_favorites tf
   WHERE tf.teacher_id = :teacher_id
   AND tf.favoritable_type = 'behavior'
   AND tf.favoritable_id = bl.id) > 0 as is_favorite,
  (SELECT COUNT(*) FROM behavior_incidents bi
   JOIN session_logs sl ON bi.session_log_id = sl.id
   JOIN sessions sess ON sl.session_id = sess.id
   JOIN students s ON sess.student_id = s.id
   WHERE bi.behavior_library_id = bl.id
   AND s.teacher_id = :teacher_id) as teacher_usage_count
FROM behavior_library bl
JOIN behavior_groups bg ON bl.behavior_group_id = bg.id
WHERE bl.is_active = TRUE
  AND (
    bl.behavior_code ILIKE :search_term || '%'
    OR bl.name_vn ILIKE '%' || :search_term || '%'
    OR bl.name_en ILIKE '%' || :search_term || '%'
    OR EXISTS (
      SELECT 1 FROM jsonb_array_elements_text(bl.keywords_vn) kw
      WHERE kw ILIKE '%' || :search_term || '%'
    )
    OR bl.manifestation_vn ILIKE '%' || :search_term || '%'
  )
ORDER BY relevance_score DESC, teacher_usage_count DESC, bl.usage_count DESC
LIMIT 20;
```

---

## 🔒 SECURITY & DATA INTEGRITY

### Row-Level Security (PostgreSQL)

```sql
-- Enable RLS for all user tables
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE behavior_incidents ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_library ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE backup_history ENABLE ROW LEVEL SECURITY;

-- Policy: Teachers can only access their own students
CREATE POLICY teacher_students_policy ON students
  FOR ALL
  USING (teacher_id = current_setting('app.current_teacher_id')::uuid);

-- Policy: Teachers can only access sessions of their students
CREATE POLICY teacher_sessions_policy ON sessions
  FOR ALL
  USING (
    student_id IN (
      SELECT id FROM students
      WHERE teacher_id = current_setting('app.current_teacher_id')::uuid
    )
  );

-- Policy: Teachers can access system templates + their own content
CREATE POLICY teacher_content_library_policy ON content_library
  FOR ALL
  USING (
    teacher_id = current_setting('app.current_teacher_id')::uuid
    OR teacher_id IS NULL  -- System templates
    OR is_public = TRUE     -- Public shared content
  );

-- Set current teacher context in application
-- Example: SET app.current_teacher_id = 'teacher-uuid';
```

### Data Validation Constraints

```sql
-- Email validation
ALTER TABLE teachers ADD CONSTRAINT valid_email
  CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,});

ALTER TABLE students ADD CONSTRAINT valid_parent_email
  CHECK (parent_email IS NULL OR parent_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,});

-- Phone validation (Vietnamese format)
ALTER TABLE teachers ADD CONSTRAINT valid_phone
  CHECK (phone IS NULL OR phone ~* '^\+?[0-9]{10,15});

ALTER TABLE students ADD CONSTRAINT valid_parent_phone
  CHECK (parent_phone IS NULL OR parent_phone ~* '^\+?[0-9]{10,15});

-- Date validation
ALTER TABLE students ADD CONSTRAINT valid_date_of_birth
  CHECK (date_of_birth <= CURRENT_DATE AND date_of_birth >= '1900-01-01');

ALTER TABLE sessions ADD CONSTRAINT valid_session_date
  CHECK (session_date >= '2020-01-01' AND session_date <= CURRENT_DATE + INTERVAL '1 year');

-- Time validation
ALTER TABLE sessions ADD CONSTRAINT valid_time_range
  CHECK (end_time > start_time);

-- Age range validation
ALTER TABLE content_library ADD CONSTRAINT valid_age_range
  CHECK (target_age_min IS NULL OR target_age_max IS NULL OR target_age_max >= target_age_min);

ALTER TABLE behavior_library ADD CONSTRAINT valid_behavior_age_range
  CHECK (age_range_min IS NULL OR age_range_max IS NULL OR age_range_max >= age_range_min);

-- Percentage validation
ALTER TABLE goal_evaluations ADD CONSTRAINT valid_achievement_percentage
  CHECK (achievement_level >= 0 AND achievement_level <= 100);

-- File size limits
ALTER TABLE log_media_attachments ADD CONSTRAINT valid_file_size
  CHECK (file_size > 0 AND file_size <= 104857600); -- 100MB max

-- JSON validation (ensure valid JSON structure)
ALTER TABLE behavior_library ADD CONSTRAINT valid_keywords_json
  CHECK (jsonb_typeof(keywords_vn::jsonb) = 'array');

ALTER TABLE behavior_library ADD CONSTRAINT valid_explanation_json
  CHECK (jsonb_typeof(explanation::jsonb) = 'array');

ALTER TABLE behavior_library ADD CONSTRAINT valid_solutions_json
  CHECK (jsonb_typeof(solutions::jsonb) = 'array');
```

### Soft Delete Implementation

```sql
-- Function to soft delete
CREATE OR REPLACE FUNCTION soft_delete_student(student_uuid UUID)
RETURNS VOID AS $
BEGIN
  UPDATE students
  SET deleted_at = CURRENT_TIMESTAMP,
      status = 'archived'
  WHERE id = student_uuid;

  -- Also soft delete related sessions
  UPDATE sessions
  SET deleted_at = CURRENT_TIMESTAMP
  WHERE student_id = student_uuid;
END;
$ LANGUAGE plpgsql;

-- Function to restore soft deleted
CREATE OR REPLACE FUNCTION restore_student(student_uuid UUID)
RETURNS VOID AS $
BEGIN
  UPDATE students
  SET deleted_at = NULL,
      status = 'active'
  WHERE id = student_uuid;

  UPDATE sessions
  SET deleted_at = NULL
  WHERE student_id = student_uuid
    AND session_date >= CURRENT_DATE - INTERVAL '6 months'; -- Only recent sessions
END;
$ LANGUAGE plpgsql;

-- Default query filter (exclude soft deleted)
CREATE VIEW active_students AS
SELECT * FROM students WHERE deleted_at IS NULL;

CREATE VIEW active_sessions AS
SELECT * FROM sessions WHERE deleted_at IS NULL;
```

---

## 📈 PERFORMANCE OPTIMIZATION

### Materialized Views for Analytics

```sql
-- Weekly student progress summary
CREATE MATERIALIZED VIEW weekly_student_progress AS
SELECT
  s.id as student_id,
  s.first_name || ' ' || s.last_name as student_name,
  DATE_TRUNC('week', sess.session_date) as week_start,
  COUNT(DISTINCT sess.id) as sessions_count,
  COUNT(DISTINCT sc.id) as contents_count,
  COUNT(DISTINCT cg.id) as goals_count,
  COUNT(DISTINCT ge.id) FILTER (WHERE ge.status = 'achieved') as goals_achieved,
  ROUND(AVG(ge.achievement_level), 1) as avg_achievement,
  ROUND(AVG(sl.overall_rating), 1) as avg_rating,
  COUNT(DISTINCT bi.id) as behavior_incidents
FROM students s
LEFT JOIN sessions sess ON s.id = sess.student_id AND sess.deleted_at IS NULL
LEFT JOIN session_contents sc ON sess.id = sc.session_id
LEFT JOIN content_goals cg ON sc.id = cg.session_content_id
LEFT JOIN goal_evaluations ge ON cg.id = ge.content_goal_id
LEFT JOIN session_logs sl ON sess.id = sl.session_id
LEFT JOIN behavior_incidents bi ON sl.id = bi.session_log_id
WHERE s.deleted_at IS NULL
  AND sess.session_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY s.id, s.first_name, s.last_name, DATE_TRUNC('week', sess.session_date);

-- Refresh weekly (automated via cron)
CREATE INDEX idx_weekly_progress_student ON weekly_student_progress(student_id, week_start DESC);
REFRESH MATERIALIZED VIEW CONCURRENTLY weekly_student_progress;

-- Behavior frequency analysis
CREATE MATERIALIZED VIEW behavior_frequency_stats AS
SELECT
  bl.id as behavior_id,
  bl.behavior_code,
  bl.name_vn,
  bg.name_vn as group_name,
  COUNT(DISTINCT bi.id) as total_incidents,
  COUNT(DISTINCT bi.session_log_id) as sessions_with_behavior,
  COUNT(DISTINCT sess.student_id) as students_affected,
  AVG(bi.intensity_level) as avg_intensity,
  COUNT(*) FILTER (WHERE bi.intervention_effective = TRUE) as effective_interventions,
  DATE_TRUNC('month', MAX(bi.occurred_at)) as last_occurrence_month
FROM behavior_library bl
JOIN behavior_groups bg ON bl.behavior_group_id = bg.id
LEFT JOIN behavior_incidents bi ON bl.id = bi.behavior_library_id
LEFT JOIN session_logs sl ON bi.session_log_id = sl.id
LEFT JOIN sessions sess ON sl.session_id = sess.id
WHERE bl.is_active = TRUE
  AND bi.occurred_at >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY bl.id, bl.behavior_code, bl.name_vn, bg.name_vn;

CREATE INDEX idx_behavior_freq_code ON behavior_frequency_stats(behavior_code);
```

### Partitioning for Large Tables

```sql
-- Partition audit_logs by month (for better query performance)
CREATE TABLE audit_logs_2025_01 PARTITION OF audit_logs
  FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE audit_logs_2025_02 PARTITION OF audit_logs
  FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

-- Auto-create partitions
CREATE OR REPLACE FUNCTION create_monthly_partition()
RETURNS void AS $
DECLARE
  partition_date DATE;
  partition_name TEXT;
  start_date TEXT;
  end_date TEXT;
BEGIN
  -- Create partition for next month
  partition_date := DATE_TRUNC('month', CURRENT_DATE + INTERVAL '1 month');
  partition_name := 'audit_logs_' || TO_CHAR(partition_date, 'YYYY_MM');
  start_date := partition_date::TEXT;
  end_date := (partition_date + INTERVAL '1 month')::TEXT;

  EXECUTE format(
    'CREATE TABLE IF NOT EXISTS %I PARTITION OF audit_logs FOR VALUES FROM (%L) TO (%L)',
    partition_name, start_date, end_date
  );
END;
$ LANGUAGE plpgsql;

-- Schedule via pg_cron or application job
```

### Query Optimization Tips

```sql
-- Use covering indexes for frequent queries
CREATE INDEX idx_sessions_teacher_date_status ON sessions(
  student_id, session_date DESC, status
) WHERE deleted_at IS NULL;

-- Use partial indexes for filtered queries
CREATE INDEX idx_active_students_teacher ON students(teacher_id)
WHERE status = 'active' AND deleted_at IS NULL;

CREATE INDEX idx_unread_notifications ON notifications(teacher_id, created_at DESC)
WHERE is_read = FALSE;

-- Use expression indexes for computed values
CREATE INDEX idx_student_age ON students(
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth))
);

-- EXPLAIN ANALYZE for slow queries
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT * FROM students WHERE teacher_id = 'uuid' AND status = 'active';
```

---

## 🔄 DATA MIGRATION STRATEGY

### Phase 1: Core Schema (Week 1)

```sql
-- Step 1: Create core tables
CREATE TABLE teachers (...);
CREATE TABLE students (...);
CREATE TABLE sessions (...);
CREATE TABLE session_contents (...);
CREATE TABLE content_goals (...);

-- Step 2: Create indexes
CREATE INDEX idx_students_teacher_id ON students(teacher_id);
-- ... other indexes

-- Step 3: Insert seed data
INSERT INTO teachers (id, email, first_name, last_name, password_hash) VALUES
('system-teacher', 'system@educare.vn', 'System', 'Admin', '...');

-- Step 4: Migrate existing data (if any)
-- ALTER TABLE existing_users RENAME TO teachers_old;
-- INSERT INTO teachers SELECT ... FROM teachers_old;
```

### Phase 2: Evaluation System (Week 2)

```sql
CREATE TABLE session_logs (...);
CREATE TABLE log_media_attachments (...);
CREATE TABLE goal_evaluations (...);

-- Create triggers
CREATE TRIGGER update_session_status_on_log ...;
```

### Phase 3: Behavior System (Week 3)

```sql
CREATE TABLE behavior_groups (...);
CREATE TABLE behavior_library (...);
CREATE TABLE behavior_incidents (...);

-- Insert seed behavior data
INSERT INTO behavior_groups VALUES
('group_1', 'GROUP_01', 'CHỐNG ĐỐI & BƯỚNG BỈNH', ...),
('group_2', 'GROUP_02', 'HÀNH VI GÂY HẤN', ...),
('group_3', 'GROUP_03', 'VẤN ĐỀ VỀ GIÁC QUAN', ...);

-- Import behaviors from JSON
INSERT INTO behavior_library
SELECT * FROM json_populate_recordset(null::behavior_library,
  pg_read_file('/data/behaviors.json')::json
);
```

### Phase 4: Advanced Features (Week 4)

```sql
CREATE TABLE content_library (...);
CREATE TABLE content_library_ratings (...);
CREATE TABLE teacher_favorites (...);
CREATE TABLE student_progress_snapshots (...);
CREATE TABLE user_settings (...);
CREATE TABLE notifications (...);
CREATE TABLE backup_history (...);
CREATE TABLE ai_processing (...);
CREATE TABLE audit_logs (...);
```

### Phase 5: Optimization (Week 5)

```sql
-- Create materialized views
CREATE MATERIALIZED VIEW weekly_student_progress ...;
CREATE MATERIALIZED VIEW behavior_frequency_stats ...;

-- Enable RLS
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
CREATE POLICY teacher_students_policy ...;

-- Setup partitioning
CREATE TABLE audit_logs_partitioned ...;
```

---

## 📊 SAMPLE DATA SEED

### Behavior Groups & Library

```sql
-- Insert behavior groups
INSERT INTO behavior_groups (id, code, name_vn, name_en, icon, order_index) VALUES
('bg-01', 'GROUP_01', 'CHỐNG ĐỐI & BƯỚNG BỈNH', 'Opposition & Defiance', '😤', 1),
('bg-02', 'GROUP_02', 'HÀNH VI GÂY HẤN', 'Aggression', '👊', 2),
('bg-03', 'GROUP_03', 'VẤN ĐỀ VỀ GIÁC QUAN', 'Sensory Issues', '👂', 3);

-- Insert sample behaviors
INSERT INTO behavior_library (
  id, behavior_group_id, behavior_code, name_vn, name_en,
  keywords_vn, manifestation_vn, explanation, solutions, sources
) VALUES
(
  'bh-01-01',
  'bg-01',
  'BH_01_01',
  'Ăn vạ',
  'Tantrums',
  '["ăn vạ", "la hét", "nằm lăn", "gào khóc", "tức giận", "khóc dai", "mè nheo", "hờn dỗi", "nổi cáu", "cơn giận"]'::jsonb,
  'Trẻ bộc phát cảm xúc một cách dữ dội, không kiểm soát được. Có thể la hét, khóc dai, nằm lăn ra đất...',
  '[
    {"title": "Nhu cầu Giao tiếp", "description": "Ăn vạ là phương tiện giao tiếp khi trẻ chưa biết nói..."},
    {"title": "Nhu cầu Tự chủ", "description": "Giai đoạn khủng hoảng tự chủ từ 18 tháng đến 3 tuổi..."},
    {"title": "Giới hạn Sinh lý", "description": "Vỏ não trước trán chưa phát triển hoàn thiện..."}
  ]'::jsonb,
  '[
    {"title": "Giữ bình tĩnh", "description": "Phản ứng của người lớn có thể khuếch đại hoặc làm dịu..."},
    {"title": "Không thỏa hiệp", "description": "Nếu cho bánh khi trẻ ăn vạ, trẻ học được cách này hiệu quả..."},
    {"title": "Công nhận Cảm xúc", "description": "Gọi tên cảm xúc: Con đang tức giận phải không?..."},
    {"title": "Phớt lờ có kế hoạch", "description": "Nếu an toàn, hãy làm ngơ nhưng vẫn để mắt theo dõi..."}
  ]'::jsonb,
  '[
    "Potegal, M., & Davidson, R. J. (2003). Temper tantrums in young children. Journal of Developmental & Behavioral Pediatrics.",
    "Sroufe, L. A. (2000). Early relationships and the development of children. Infant Mental Health Journal."
  ]'::jsonb
);
```

### System Content Templates

```sql
INSERT INTO content_library (
  id, teacher_id, code, title, domain, difficulty_level,
  target_age_min, target_age_max, is_template
) VALUES
('ct-cog-01', NULL, 'COG_001', 'Phân loại màu sắc cơ bản', 'cognitive', 'beginner', 3, 5, TRUE),
('ct-mot-01', NULL, 'MOT_001', 'Bắt bóng và ném bóng', 'motor', 'beginner', 3, 6, TRUE),
('ct-lan-01', NULL, 'LAN_001', 'Mô tả tranh đơn giản', 'language', 'beginner', 3, 5, TRUE),
('ct-soc-01', NULL, 'SOC_001', 'Chào hỏi và giao tiếp cơ bản', 'social', 'beginner', 3, 6, TRUE),
('ct-slf-01', NULL, 'SLF_001', 'Rửa tay đúng cách', 'self_care', 'beginner', 3, 5, TRUE);
```

---

## 🔧 MAINTENANCE & MONITORING

### Regular Maintenance Tasks

```sql
-- Daily: Vacuum analyze active tables
VACUUM ANALYZE students, sessions, session_logs;

-- Weekly: Update materialized views
REFRESH MATERIALIZED VIEW CONCURRENTLY weekly_student_progress;
REFRESH MATERIALIZED VIEW CONCURRENTLY behavior_frequency_stats;

-- Weekly: Archive old notifications
UPDATE notifications
SET expires_at = CURRENT_TIMESTAMP
WHERE created_at < CURRENT_DATE - INTERVAL '30 days'
  AND is_read = TRUE;

-- Monthly: Cleanup old audit logs (keep 6 months)
DELETE FROM audit_logs
WHERE created_at < CURRENT_DATE - INTERVAL '6 months';

-- Monthly: Cleanup expired backups
DELETE FROM backup_history
WHERE expires_at < CURRENT_TIMESTAMP;

-- Quarterly: Analyze query performance
SELECT schemaname, tablename, last_vacuum, last_autovacuum, last_analyze
FROM pg_stat_user_tables
ORDER BY last_analyze DESC;
```

### Monitoring Queries

```sql
-- Check database size
SELECT
  pg_database.datname,
  pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database;

-- Check table sizes
SELECT
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size,
  pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) AS table_size,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - pg_relation_size(schemaname||'.'||tablename)) AS external_size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Check index usage
SELECT
  schemaname,
  tablename,
  indexname,
  idx_scan,
  idx_tup_read,
  idx_tup_fetch,
  pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
WHERE idx_scan = 0
  AND schemaname = 'public'
ORDER BY pg_relation_size(indexrelid) DESC;

-- Check slow queries (requires pg_stat_statements extension)
SELECT
  query,
  calls,
  total_exec_time,
  mean_exec_time,
  max_exec_time
FROM pg_stat_statements
WHERE query NOT LIKE '%pg_stat_statements%'
ORDER BY mean_exec_time DESC
LIMIT 20;

-- Active connections
SELECT
  datname,
  usename,
  application_name,
  client_addr,
  state,
  query
FROM pg_stat_activity
WHERE state != 'idle'
ORDER BY query_start;
```

---

## 📝 API INTEGRATION CONSIDERATIONS

### Recommended Endpoints Structure

```typescript
// Student Management
GET    /api/students                    // List students
POST   /api/students                    // Create student
GET    /api/students/:id                // Get student detail
PUT    /api/students/:id                // Update student
DELETE /api/students/:id                // Soft delete student
POST   /api/students/:id/restore        // Restore deleted student

// Session Management
GET    /api/sessions                    // List sessions (filter by student, date range)
POST   /api/sessions                    // Create session
GET    /api/sessions/:id                // Get session detail
PUT    /api/sessions/:id                // Update session
DELETE /api/sessions/:id                // Soft delete session
POST   /api/sessions/:id/cancel         // Cancel session

// Session Evaluation
POST   /api/sessions/:id/log            // Start evaluation
PUT    /api/sessions/:id/log            // Update evaluation
POST   /api/sessions/:id/log/complete   // Complete evaluation
POST   /api/sessions/:id/log/media      // Upload media
POST   /api/sessions/:id/log/goals      // Evaluate goals
POST   /api/sessions/:id/log/behaviors  // Record behaviors

// Behavior Library
GET    /api/behaviors                   // List behaviors (filter, search)
GET    /api/behaviors/:code             // Get behavior detail
GET    /api/behaviors/groups            // List behavior groups
GET    /api/behaviors/search            // Smart search
POST   /api/behaviors/:id/favorite      // Add to favorites
DELETE /api/behaviors/:id/favorite      // Remove from favorites

// Content Library
GET    /api/contents                    // List contents (templates + user)
POST   /api/contents                    // Create content
GET    /api/contents/:id                // Get content detail
PUT    /api/contents/:id                // Update content
DELETE /api/contents/:id                // Soft delete content
POST   /api/contents/:id/rate           // Rate content

// Analytics & Reports
GET    /api/analytics/dashboard         // Dashboard stats
GET    /api/analytics/student/:id       // Student progress
GET    /api/analytics/behaviors         // Behavior analytics
GET    /api/analytics/goals             // Goal achievement
POST   /api/analytics/snapshot          // Generate progress snapshot

// AI Processing
POST   /api/ai/process                  // Start AI processing
GET    /api/ai/jobs/:id                 // Get processing status
POST   /api/ai/jobs/:id/cancel          // Cancel processing

// Settings & Preferences
GET    /api/settings                    // Get user settings
PUT    /api/settings                    // Update settings
GET    /api/notifications               // List notifications
PUT    /api/notifications/:id/read      // Mark as read
DELETE /api/notifications/:id           // Delete notification

// Backup & Export
POST   /api/backup/create               // Create backup
GET    /api/backup/history              // List backups
GET    /api/backup/:id/download         // Download backup
POST   /api/export/sessions             // Export session data (CSV, PDF)
POST   /api/export/report               // Generate student report
```

---

## 🎯 KEY IMPROVEMENTS SUMMARY

### ✅ Structural Improvements

1. **Name fields**: Split `full_name` → `first_name` + `last_name` for better data normalization
2. **Soft delete**: Added `deleted_at` for Students, Sessions, Content Library
3. **Audit trails**: Added `created_by`, `updated_by`, `recorded_by` tracking
4. **Better validation**: Age from DOB, computed duration, email/phone validation

### ✅ Enhanced Features

1. **Progress tracking**: New `student_progress_snapshots` table for periodic summaries
2. **Notifications**: System-wide notification management
3. **Content ratings**: Community rating system for shared content templates
4. **Polymorphic favorites**: Single table for both behaviors and content favorites
5. **Advanced behavior tracking**: Added intensity, duration, intervention tracking

### ✅ Performance Optimizations

1. **Materialized views**: Pre-computed analytics for faster dashboards
2. **Partitioning**: Monthly partitions for audit logs
3. **Strategic indexes**: Covering indexes, partial indexes, expression indexes
4. **Query optimization**: Optimized common query patterns

### ✅ Security Enhancements

1. **Row-level security**: PostgreSQL RLS policies for data isolation
2. **Comprehensive validation**: Email, phone, date, JSON structure validation
3. **Audit logging**: Complete audit trail of all changes
4. **Soft delete**: Recoverable deletion with data retention

### ✅ Data Integrity

1. **Better constraints**: Comprehensive CHECK constraints
2. **Triggers**: Auto-update timestamps, status, usage counts
3. **Foreign key cascades**: Proper cascade rules for referential integrity
4. **Business logic**: Database-level enforcement of business rules

---

## 📚 IMPLEMENTATION CHECKLIST

- [ ] Create database and user
- [ ] Run Phase 1 migrations (core tables)
- [ ] Create all indexes
- [ ] Setup triggers and functions
- [ ] Insert seed data (behavior groups, system templates)
- [ ] Run Phase 2-4 migrations
- [ ] Enable Row-Level Security
- [ ] Create materialized views
- [ ] Setup partitioning for audit_logs
- [ ] Configure backup strategy
- [ ] Setup monitoring and alerts
- [ ] Test all constraints and triggers
- [ ] Populate behavior library with full data
- [ ] Create API integration layer
- [ ] Setup automated maintenance jobs
- [ ] Document all procedures

---

_Enhanced database design for Educare Connect with improved structure, security, and performance. All changes maintain backward compatibility while adding powerful new features._
