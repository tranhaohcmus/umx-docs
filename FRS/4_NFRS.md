# PHẦN 4/10: FUNCTIONAL REQUIREMENTS - SESSION MANAGEMENT

````markdown
## 2.3 Quản lý Buổi học

### **FR-013: Tạo Buổi học Thủ công (Manual Session) - Bước 1: Thông tin Cơ bản**

#### Mã Chức năng

`FR-013`

#### Mô tả

Giáo viên tạo buổi học mới cho học sinh theo flow 3 bước. Đây là **Bước 1: Thông tin cơ bản**.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Giáo viên đã đăng nhập
- Giáo viên đã có ít nhất 1 học sinh (từ FR-007)

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình "Tạo Buổi học mới"

**Bước 2:** Giáo viên chọn Học sinh từ dropdown:

- Hệ thống query danh sách students từ `STUDENTS` WHERE `teacher_id = :authenticated_teacher_id` AND `status = 'active'` AND `deleted_at IS NULL`

**Bước 3:** Giáo viên nhập thông tin cơ bản (mapping sang `SESSIONS` table):

- `student_id` (UUID, required, from dropdown) → `SESSIONS.student_id`
- `session_date` (date, required) → `SESSIONS.session_date`
- `time_slot` (enum: morning/afternoon/evening, required) → `SESSIONS.time_slot`
- `start_time` (time, required) → `SESSIONS.start_time`
- `end_time` (time, required) → `SESSIONS.end_time`
- `location` (string, optional) → `SESSIONS.location`
- `notes` (text, optional) → `SESSIONS.notes`

**Bước 4:** Hệ thống validate:

- `session_date`:
  - Không quá 6 tháng trước: `session_date >= CURRENT_DATE - INTERVAL '6 months'`
  - Không quá 1 năm sau: `session_date <= CURRENT_DATE + INTERVAL '1 year'`
- `end_time` > `start_time`
- `duration_minutes` (computed) >= 30 phút:
  ```sql
  EXTRACT(EPOCH FROM (end_time - start_time)) / 60 >= 30
  ```
````

**Bước 5:** Hệ thống auto-fill `time_slot` dựa vào `start_time` (nếu chưa chọn):

```typescript
if (start_time < "12:00") time_slot = "morning";
else if (start_time < "17:00") time_slot = "afternoon";
else time_slot = "evening";
```

**Bước 6:** Hệ thống tạo **DRAFT** session trong bảng `SESSIONS`:

```sql
INSERT INTO sessions (
  id,
  student_id,
  session_date,
  time_slot,
  start_time,
  end_time,
  duration_minutes,        -- COMPUTED: EXTRACT(EPOCH FROM (end_time - start_time)) / 60
  location,
  notes,
  creation_method,         -- 'manual'
  status,                  -- 'pending' (chưa hoàn tất)
  has_evaluation,          -- FALSE
  created_by,              -- authenticated_teacher_id
  created_at,
  updated_at
) VALUES (...)
RETURNING *;
```

**Bước 7:** Hệ thống lưu `session_id` vào **local draft state** (hoặc DB với flag `is_draft = true`)

**Bước 8:** Hệ thống chuyển sang **Bước 2** (FR-014)

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                               | Mô tả                                                            |
| ------------ | ---------------------------------------- | ---------------------------------------------------------------- |
| **RB-013-1** | `SESSIONS.student_id` FK → `STUDENTS.id` | Chỉ được tạo session cho học sinh thuộc giáo viên đang đăng nhập |
| **RB-013-2** | `SESSIONS.session_date`                  | Phải trong khoảng 6 tháng trước đến 1 năm sau                    |
| **RB-013-3** | `SESSIONS.start_time`, `end_time` CHECK  | end_time > start_time                                            |
| **RB-013-4** | `SESSIONS.duration_minutes` (computed)   | Tối thiểu 30 phút                                                |
| **RB-013-5** | `SESSIONS.time_slot` CHECK               | Chỉ chấp nhận 'morning', 'afternoon', 'evening'                  |
| **RB-013-6** | `SESSIONS.creation_method`               | Giá trị 'manual' (phân biệt với 'ai' từ FR-028)                  |
| **RB-013-7** | `SESSIONS.status`                        | Mặc định 'pending' cho session chưa hoàn tất                     |
| **RB-013-8** | `SESSIONS.created_by` FK → `TEACHERS.id` | Lưu teacher tạo session                                          |

#### Dữ liệu Đầu vào

```typescript
interface CreateSessionStep1Input {
  student_id: string; // UUID, required
  session_date: string; // YYYY-MM-DD, required
  time_slot: "morning" | "afternoon" | "evening"; // required
  start_time: string; // HH:MM:SS, required
  end_time: string; // HH:MM:SS, required
  location?: string;
  notes?: string;
}
```

#### Dữ liệu Đầu ra

**Success (201 Created):**

```json
{
  "success": true,
  "session": {
    "id": "session-uuid",
    "student_id": "student-uuid",
    "session_date": "2025-11-10",
    "time_slot": "morning",
    "start_time": "09:00:00",
    "end_time": "10:30:00",
    "duration_minutes": 90,
    "location": "Phòng 101",
    "notes": "Buổi học về nhận biết màu sắc",
    "creation_method": "manual",
    "status": "pending",
    "has_evaluation": false,
    "created_at": "2025-11-05T04:48:00Z"
  },
  "next_step": "add_contents"
}
```

#### Xử lý Ngoại lệ

| Tình huống                  | HTTP Code | Error Code           | Xử lý                              |
| --------------------------- | --------- | -------------------- | ---------------------------------- |
| Session date ngoài range    | 400       | `INVALID_DATE_RANGE` | Trả lỗi với range hợp lệ           |
| Duration < 30 phút          | 400       | `INVALID_DURATION`   | Trả lỗi, yêu cầu tối thiểu 30 phút |
| end_time <= start_time      | 400       | `INVALID_TIME_RANGE` | Trả lỗi                            |
| Student không thuộc teacher | 403       | `FORBIDDEN`          | Trả lỗi                            |

#### API Endpoint

```
POST /api/sessions
Authorization: Bearer <access_token>
Content-Type: application/json
```

#### Auto-save Draft

- Client tự động lưu draft mỗi **30 giây** vào local storage hoặc gọi API:

```
PATCH /api/sessions/:session_id/draft
```

#### Ưu tiên

**Must Have**

---

### **FR-014: Tạo Buổi học Thủ công - Bước 2: Thêm Nội dung & Mục tiêu**

#### Mã Chức năng

`FR-014`

#### Mô tả

Giáo viên thêm nội dung (contents) và mục tiêu (goals) cho buổi học. Đây là **Bước 2** của flow tạo session.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Đã hoàn thành FR-013 (Bước 1 - Thông tin cơ bản)
- Session đang ở trạng thái 'pending'

#### Luồng Sự kiện Chính

**Bước 1:** Hệ thống hiển thị form "Thêm Nội dung & Mục tiêu"

**Bước 2:** Giáo viên có thể:

- **Option A:** Chọn template từ `CONTENT_LIBRARY` (nếu đã có)
- **Option B:** Tạo nội dung mới từ đầu

**Option A - Chọn từ Template:**

**Bước 3A:** Giáo viên search/browse `CONTENT_LIBRARY`:

```sql
SELECT * FROM content_library
WHERE (teacher_id = :authenticated_teacher_id OR is_public = TRUE)
  AND (:domain IS NULL OR domain = :domain)
  AND deleted_at IS NULL
ORDER BY usage_count DESC, rating_avg DESC;
```

**Bước 4A:** Giáo viên chọn 1 hoặc nhiều templates

**Bước 5A:** Hệ thống tạo `SESSION_CONTENTS` từ template:

```sql
INSERT INTO session_contents (
  id,
  session_id,              -- từ FR-013
  content_library_id,      -- FK to CONTENT_LIBRARY (optional)
  title,                   -- copy từ template.title
  domain,                  -- copy từ template.domain
  description,             -- copy từ template.description
  materials_needed,        -- copy từ template.materials_needed
  order_index,             -- 1, 2, 3... theo thứ tự thêm
  estimated_duration,      -- copy từ template.estimated_duration
  notes,
  created_at,
  updated_at
) VALUES (...)
RETURNING *;
```

**Bước 6A:** Hệ thống tạo `CONTENT_GOALS` từ template's `default_goals` (JSONB):

```sql
INSERT INTO content_goals (
  id,
  session_content_id,      -- FK to SESSION_CONTENTS vừa tạo
  description,             -- từ template.default_goals[i].description
  goal_type,               -- 'knowledge' | 'skill' | 'behavior'
  is_primary,              -- default TRUE cho goal đầu tiên
  order_index,             -- 1, 2, 3...
  created_at,
  updated_at
) VALUES (...);
```

**Option B - Tạo mới từ đầu:**

**Bước 3B:** Giáo viên nhấn "Thêm Nội dung mới"

**Bước 4B:** Hệ thống hiển thị form với các trường (mapping sang `SESSION_CONTENTS`):

- `title` (string, required) → `SESSION_CONTENTS.title`
- `domain` (enum, required) → `SESSION_CONTENTS.domain`
  - Giá trị: 'cognitive', 'motor', 'language', 'social', 'self_care'
- `description` (text, required) → `SESSION_CONTENTS.description`
- `materials_needed` (text, optional) → `SESSION_CONTENTS.materials_needed`
- `estimated_duration` (int, minutes, optional) → `SESSION_CONTENTS.estimated_duration`
- `notes` (text, optional) → `SESSION_CONTENTS.notes`

**Bước 5B:** Giáo viên nhập và submit

**Bước 6B:** Hệ thống tạo `SESSION_CONTENTS`:

```sql
INSERT INTO session_contents (
  id,
  session_id,
  content_library_id,      -- NULL (không dùng template)
  title,
  domain,
  description,
  materials_needed,
  order_index,             -- auto-increment trong session
  estimated_duration,
  notes,
  created_at,
  updated_at
) VALUES (...)
RETURNING *;
```

**Bước 7B:** Giáo viên thêm Mục tiêu (Goals) cho nội dung vừa tạo

**Bước 8B:** Hệ thống hiển thị form "Thêm Mục tiêu":

- `description` (text, required) → `CONTENT_GOALS.description`
- `goal_type` (enum, required) → `CONTENT_GOALS.goal_type`
  - Giá trị: 'knowledge', 'skill', 'behavior'
- `is_primary` (boolean) → `CONTENT_GOALS.is_primary`

**Bước 9B:** Giáo viên có thể thêm nhiều goals (minimum 1)

**Bước 10B:** Hệ thống tạo `CONTENT_GOALS`:

```sql
INSERT INTO content_goals (
  id,
  session_content_id,
  description,
  goal_type,
  is_primary,
  order_index,
  created_at,
  updated_at
) VALUES (...);
```

**Validation:**

**Bước 7:** Hệ thống validate:

- Session phải có **ít nhất 1 content**
- Mỗi content phải có **ít nhất 1 goal**
- Tổng `estimated_duration` của tất cả contents <= `SESSIONS.duration_minutes` (warning, không block)

**Bước 8:** Hệ thống cho phép:

- **Thêm nhiều contents** (repeat Bước 3-6)
- **Sắp xếp lại thứ tự** (drag & drop → update `order_index`)
- **Chỉnh sửa/Xóa** content hoặc goal

**Bước 9:** Giáo viên nhấn "Tiếp theo" → chuyển sang **Bước 3** (FR-015 - Review)

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                                                      | Mô tả                                                                                        |
| ------------ | --------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| **RB-014-1** | `SESSION_CONTENTS.session_id` FK → `SESSIONS.id`                | Mỗi content phải thuộc 1 session (1-N relationship)                                          |
| **RB-014-2** | `SESSION_CONTENTS.content_library_id` FK → `CONTENT_LIBRARY.id` | Optional FK khi dùng template                                                                |
| **RB-014-3** | `SESSION_CONTENTS.domain` CHECK                                 | Chỉ chấp nhận 5 giá trị: cognitive, motor, language, social, self_care                       |
| **RB-014-4** | `CONTENT_GOALS.session_content_id` FK → `SESSION_CONTENTS.id`   | Mỗi goal phải thuộc 1 content (1-N relationship)                                             |
| **RB-014-5** | `CONTENT_GOALS.goal_type` CHECK                                 | Chỉ chấp nhận: knowledge, skill, behavior                                                    |
| **RB-014-6** | Business Rule                                                   | Session phải có >= 1 content, mỗi content phải có >= 1 goal                                  |
| **RB-014-7** | CASCADE DELETE                                                  | Nếu xóa `SESSION_CONTENTS`, tất cả `CONTENT_GOALS` liên quan cũng bị xóa (ON DELETE CASCADE) |

#### Dữ liệu Đầu vào

**Option B - Tạo mới:**

```typescript
interface CreateContentInput {
  session_id: string;
  title: string;
  domain: "cognitive" | "motor" | "language" | "social" | "self_care";
  description: string;
  materials_needed?: string;
  estimated_duration?: number; // minutes
  notes?: string;
  goals: ContentGoalInput[]; // Array of goals
}

interface ContentGoalInput {
  description: string;
  goal_type: "knowledge" | "skill" | "behavior";
  is_primary?: boolean;
}
```

#### Dữ liệu Đầu ra

**Success (201 Created):**

```json
{
  "success": true,
  "session": {
    "id": "session-uuid",
    "status": "pending",
    "contents": [
      {
        "id": "content-uuid-1",
        "session_id": "session-uuid",
        "title": "Nhận biết màu sắc cơ bản",
        "domain": "cognitive",
        "description": "Dạy trẻ nhận biết 4 màu: đỏ, vàng, xanh lá, xanh dương",
        "materials_needed": "Thẻ màu, đồ chơi nhiều màu",
        "order_index": 1,
        "estimated_duration": 30,
        "goals": [
          {
            "id": "goal-uuid-1",
            "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
            "goal_type": "knowledge",
            "is_primary": true,
            "order_index": 1
          },
          {
            "id": "goal-uuid-2",
            "description": "Trẻ có thể nói tên màu khi được hỏi",
            "goal_type": "skill",
            "is_primary": false,
            "order_index": 2
          }
        ]
      }
    ]
  },
  "next_step": "review"
}
```

#### API Endpoints

**Create new content:**

```
POST /api/sessions/:session_id/contents
Authorization: Bearer <access_token>
Content-Type: application/json
```

**Update content order:**

```
PATCH /api/sessions/:session_id/contents/reorder
Content-Type: application/json
```

#### Ưu tiên

**Must Have**

---

### **FR-015: Tạo Buổi học Thủ công - Bước 3: Xem lại & Xác nhận**

#### Mã Chức năng

`FR-015`

#### Mô tả

Giáo viên xem lại toàn bộ thông tin buổi học trước khi hoàn tất. Đây là **Bước 3 cuối cùng**.

#### Luồng Sự kiện Chính

**Bước 1:** Hệ thống hiển thị trang "Xem lại Buổi học" với:

**Section 1: Thông tin cơ bản**

- Tên học sinh (query từ `STUDENTS.full_name`)
- Ngày, giờ, thời lượng
- Địa điểm
- Ghi chú

**Section 2: Nội dung & Mục tiêu**

- Danh sách tất cả contents (theo `order_index`)
- Với mỗi content: tên, domain, mô tả, danh sách goals

**Section 3: Tổng quan**

```typescript
{
  total_contents: 3,
  total_goals: 8,
  total_estimated_duration: 85, // minutes
  session_duration: 90,
  time_buffer: 5
}
```

**Bước 2:** Giáo viên có thể:

- **Quay lại** Bước 1 hoặc 2 để chỉnh sửa
- **Xác nhận** để hoàn tất

**Bước 3:** Giáo viên nhấn "Xác nhận & Lưu"

**Bước 4:** Hệ thống validate lần cuối:

- Session có >= 1 content
- Mỗi content có >= 1 goal

**Bước 5:** Hệ thống cập nhật trạng thái session:

```sql
UPDATE sessions
SET
  status = 'pending',      -- hoặc giữ nguyên 'pending' (chờ thực hiện)
  updated_at = NOW()
WHERE id = :session_id;
```

**Bước 6:** (Optional) Nếu template được dùng từ `CONTENT_LIBRARY`:

```sql
UPDATE content_library
SET
  usage_count = usage_count + 1,
  last_used_at = NOW()
WHERE id = :content_library_id;
```

**Bước 7:** Hệ thống trả về success

#### API Endpoint

```
POST /api/sessions/:session_id/confirm
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-016: Xem Danh sách Buổi học**

#### Mã Chức năng

`FR-016`

#### Mô tả

Giáo viên xem danh sách tất cả buổi học với filter, search, pagination.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình "Lịch" hoặc "Buổi học"

**Bước 2:** Hệ thống query bảng `SESSIONS` với JOIN `STUDENTS`:

```sql
SELECT
  s.*,
  st.first_name || ' ' || st.last_name AS student_name,
  st.avatar_url AS student_avatar,
  COUNT(DISTINCT sc.id) AS contents_count,
  COUNT(DISTINCT cg.id) AS goals_count,
  CASE WHEN sl.id IS NOT NULL THEN TRUE ELSE FALSE END AS has_log
FROM sessions s
JOIN students st ON s.student_id = st.id
LEFT JOIN session_contents sc ON s.id = sc.session_id
LEFT JOIN content_goals cg ON sc.id = cg.session_content_id
LEFT JOIN session_logs sl ON s.id = sl.session_id
WHERE s.created_by = :authenticated_teacher_id
  AND s.deleted_at IS NULL
  AND st.deleted_at IS NULL
  AND (:student_id IS NULL OR s.student_id = :student_id)
  AND (:status IS NULL OR s.status = :status)
  AND (:date_from IS NULL OR s.session_date >= :date_from)
  AND (:date_to IS NULL OR s.session_date <= :date_to)
GROUP BY s.id, st.id, sl.id
ORDER BY s.session_date DESC, s.start_time DESC
LIMIT :limit OFFSET :offset;
```

#### API Endpoint

```
GET /api/sessions?student_id=...&status=pending&date_from=2025-11-01&page=1
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-017: Xem Chi tiết Buổi học**

#### Mã Chức năng

`FR-017`

#### Mô tả

Giáo viên xem chi tiết đầy đủ của 1 buổi học.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên click vào 1 session từ danh sách (FR-016)

**Bước 2:** Hệ thống query chi tiết session:

```sql
-- Main session
SELECT s.*, st.first_name || ' ' || st.last_name AS student_name, st.avatar_url
FROM sessions s
JOIN students st ON s.student_id = st.id
WHERE s.id = :session_id
  AND s.created_by = :authenticated_teacher_id
  AND s.deleted_at IS NULL;

-- Contents with goals
SELECT
  sc.*,
  json_agg(
    json_build_object(
      'id', cg.id,
      'description', cg.description,
      'goal_type', cg.goal_type,
      'is_primary', cg.is_primary,
      'order_index', cg.order_index
    ) ORDER BY cg.order_index
  ) AS goals
FROM session_contents sc
LEFT JOIN content_goals cg ON sc.id = cg.session_content_id
WHERE sc.session_id = :session_id
GROUP BY sc.id
ORDER BY sc.order_index;
```

#### API Endpoint

```
GET /api/sessions/:session_id
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

```

**✅ PHẦN 4 XONG - Section 2.3 Session Management hoàn tất**

Tiếp tục với **PHẦN 5/10: SESSION LOGGING (FR-018 đến FR-022)**?
```
