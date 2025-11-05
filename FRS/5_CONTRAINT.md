# PHẦN 5/10: FUNCTIONAL REQUIREMENTS - SESSION LOGGING

````markdown
## 2.4 Ghi nhật ký Buổi học

### **FR-018: Ghi Nhật ký - Bước 1: Đánh giá Mục tiêu Toàn bộ**

#### Mã Chức năng

`FR-018`

#### Mô tả

Giáo viên đánh giá tất cả mục tiêu (goals) của buổi học sau khi hoàn tất. Đây là **Bước 1** của flow ghi nhật ký.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Session tồn tại và `status = 'pending'` hoặc 'completed'
- Session đã diễn ra (session_date <= today)
- Session thuộc teacher (qua `created_by`)

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập "Ghi nhật ký" từ màn hình Chi tiết buổi học (FR-017)

**Bước 2:** Hệ thống kiểm tra xem đã có `SESSION_LOGS` chưa:

```sql
SELECT * FROM session_logs WHERE session_id = :session_id;
```
````

**Bước 3:** Nếu chưa có, tạo `SESSION_LOGS` draft:

```sql
INSERT INTO session_logs (
  id,
  session_id,              -- FK, UNIQUE (1-1 relationship)
  logged_at,               -- NOW()
  created_by,              -- authenticated_teacher_id
  created_at,
  updated_at
) VALUES (...)
RETURNING *;
```

**Bước 4:** Hệ thống query tất cả goals của session (grouped by content):

```sql
SELECT
  sc.id AS content_id,
  sc.title AS content_title,
  sc.domain,
  sc.order_index AS content_order,
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
JOIN content_goals cg ON sc.id = cg.session_content_id
WHERE sc.session_id = :session_id
GROUP BY sc.id
ORDER BY sc.order_index;
```

**Bước 5:** Client hiển thị UI với:

- **Sticky headers**: Domain + Content title (vẫn visible khi scroll)
- **Quick navigation**: Jump links đến mỗi content section
- **Goal evaluation form** cho mỗi goal:
  - Goal description (read-only)
  - Radio buttons (mapping to `GOAL_EVALUATIONS.status`):
    - ✅ **Đạt** (achieved)
    - ⚠️ **Chưa đạt hoàn toàn** (partially_achieved)
    - ❌ **Chưa đạt** (not_achieved)
    - ➖ **Không áp dụng** (not_applicable)
  - (Optional) Achievement level slider: 0-100% → `GOAL_EVALUATIONS.achievement_level`
  - (Optional) Support level dropdown → `GOAL_EVALUATIONS.support_level`:
    - 'independent' (Tự lập)
    - 'minimal_prompt' (Nhắc nhở tối thiểu)
    - 'moderate_prompt' (Nhắc nhở vừa phải)
    - 'full_prompt' (Nhắc nhở hoàn toàn)
    - 'hand_over_hand' (Hỗ trợ tay-qua-tay)
  - Text field: Notes → `GOAL_EVALUATIONS.notes`

**Bước 6:** Giáo viên đánh giá từng goal

**Bước 7:** Hệ thống **auto-save mỗi 2 phút**:

```sql
INSERT INTO goal_evaluations (
  id,
  session_log_id,          -- FK to SESSION_LOGS
  content_goal_id,         -- FK to CONTENT_GOALS
  status,                  -- enum
  achievement_level,       -- int 0-100
  support_level,           -- enum
  notes,
  created_at,
  updated_at
) VALUES (...)
ON CONFLICT (session_log_id, content_goal_id)  -- UNIQUE constraint
DO UPDATE SET
  status = EXCLUDED.status,
  achievement_level = EXCLUDED.achievement_level,
  support_level = EXCLUDED.support_level,
  notes = EXCLUDED.notes,
  updated_at = NOW();
```

**Bước 8:** Giáo viên nhấn "Tiếp theo" → chuyển sang **Bước 2** (FR-019 - Thái độ)

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                                                 | Mô tả                                                         |
| ------------ | ---------------------------------------------------------- | ------------------------------------------------------------- |
| **RB-018-1** | `SESSION_LOGS.session_id` FK → `SESSIONS.id`               | 1-1 relationship: Mỗi session chỉ có 1 log                    |
| **RB-018-2** | `SESSION_LOGS.session_id` UNIQUE                           | Đảm bảo 1-1 constraint                                        |
| **RB-018-3** | `GOAL_EVALUATIONS.session_log_id` FK → `SESSION_LOGS.id`   | 1-N relationship                                              |
| **RB-018-4** | `GOAL_EVALUATIONS.content_goal_id` FK → `CONTENT_GOALS.id` | 1-N relationship                                              |
| **RB-018-5** | `UNIQUE (session_log_id, content_goal_id)`                 | Mỗi goal chỉ được đánh giá 1 lần trong 1 log                  |
| **RB-018-6** | `GOAL_EVALUATIONS.status` CHECK                            | Chỉ chấp nhận 4 giá trị enum                                  |
| **RB-018-7** | `GOAL_EVALUATIONS.achievement_level` CHECK                 | 0-100                                                         |
| **RB-018-8** | `GOAL_EVALUATIONS.support_level` CHECK                     | Chỉ chấp nhận 5 giá trị enum                                  |
| **RB-018-9** | CASCADE DELETE                                             | Nếu xóa `SESSION_LOGS`, tất cả `GOAL_EVALUATIONS` cũng bị xóa |

#### Dữ liệu Đầu vào

```typescript
interface EvaluateGoalsInput {
  session_id: string;
  evaluations: GoalEvaluationInput[];
}

interface GoalEvaluationInput {
  content_goal_id: string;
  status: "achieved" | "partially_achieved" | "not_achieved" | "not_applicable";
  achievement_level?: number; // 0-100
  support_level?:
    | "independent"
    | "minimal_prompt"
    | "moderate_prompt"
    | "full_prompt"
    | "hand_over_hand";
  notes?: string;
}
```

#### Dữ liệu Đầu ra

**Success (200 OK):**

```json
{
  "success": true,
  "session_log": {
    "id": "log-uuid",
    "session_id": "session-uuid",
    "logged_at": "2025-11-05T05:00:00Z",
    "goal_evaluations": [
      {
        "id": "eval-uuid-1",
        "content_goal_id": "goal-uuid-1",
        "goal_description": "Trẻ chỉ đúng màu",
        "status": "achieved",
        "achievement_level": 90,
        "support_level": "minimal_prompt",
        "notes": "Trẻ làm tốt, chỉ cần nhắc 1-2 lần"
      }
    ],
    "evaluations_count": 8,
    "evaluated_count": 8
  },
  "next_step": "attitude"
}
```

#### API Endpoints

**Create/Get session log:**

```
POST /api/sessions/:session_id/logs
Authorization: Bearer <access_token>
```

**Save goal evaluations:**

```
PUT /api/session-logs/:log_id/goals
Authorization: Bearer <access_token>
Content-Type: application/json
```

#### Ưu tiên

**Must Have**

---

### **FR-019: Ghi Nhật ký - Bước 2: Đánh giá Thái độ**

#### Mã Chức năng

`FR-019`

#### Mô tả

Giáo viên đánh giá tâm trạng (mood) và các chỉ số thái độ của học sinh. Đây là **Bước 2**.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Đã hoàn thành FR-018 (Bước 1 - Đánh giá mục tiêu)
- `SESSION_LOGS` đã tồn tại

#### Luồng Sự kiện Chính

**Bước 1:** Hệ thống hiển thị form "Đánh giá Thái độ" với các trường (mapping sang `SESSION_LOGS`):

**Field 1: Tâm trạng (Mood)**

- Radio buttons với emoji → `SESSION_LOGS.mood`:
  - 😫 Rất khó khăn (very_difficult)
  - 😐 Khó khăn (difficult)
  - 😊 Bình thường (normal)
  - 😄 Tốt (good)
  - 🌟 Rất tốt (very_good)

**Field 2-5: Sliders (1-5)** → `SESSION_LOGS`:

- **Năng lượng** (Energy level) → `energy_level`
  - 1 = Rất mệt, 5 = Rất tràn đầy năng lượng
- **Hợp tác** (Cooperation) → `cooperation_level`
  - 1 = Không hợp tác, 5 = Hợp tác rất tốt
- **Tập trung** (Focus) → `focus_level`
  - 1 = Không tập trung, 5 = Tập trung cao
- **Tự lập** (Independence) → `independence_level`
  - 1 = Phụ thuộc hoàn toàn, 5 = Rất tự lập

**Field 6: Tổng quan Thái độ (Optional)**

- Text area → `SESSION_LOGS.attitude_summary`

**Bước 2:** Giáo viên điền thông tin

**Bước 3:** Hệ thống validate:

- `mood`: phải thuộc 1 trong 5 giá trị enum
- `energy_level`, `cooperation_level`, `focus_level`, `independence_level`: phải từ 1-5

**Bước 4:** Hệ thống update `SESSION_LOGS`:

```sql
UPDATE session_logs
SET
  mood = :mood,
  energy_level = :energy_level,
  cooperation_level = :cooperation_level,
  focus_level = :focus_level,
  independence_level = :independence_level,
  attitude_summary = :attitude_summary,
  updated_at = NOW()
WHERE id = :session_log_id;
```

**Bước 5:** Giáo viên nhấn "Tiếp theo" → chuyển sang **Bước 3** (FR-020 - Ghi chú & Media)

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                              | Mô tả                                                                       |
| ------------ | --------------------------------------- | --------------------------------------------------------------------------- |
| **RB-019-1** | `SESSION_LOGS.mood` CHECK               | Chỉ chấp nhận 5 giá trị: very_difficult, difficult, normal, good, very_good |
| **RB-019-2** | `SESSION_LOGS.energy_level` CHECK       | 1-5                                                                         |
| **RB-019-3** | `SESSION_LOGS.cooperation_level` CHECK  | 1-5                                                                         |
| **RB-019-4** | `SESSION_LOGS.focus_level` CHECK        | 1-5                                                                         |
| **RB-019-5** | `SESSION_LOGS.independence_level` CHECK | 1-5                                                                         |

#### Dữ liệu Đầu vào

```typescript
interface UpdateAttitudeInput {
  mood: "very_difficult" | "difficult" | "normal" | "good" | "very_good";
  energy_level: number; // 1-5
  cooperation_level: number; // 1-5
  focus_level: number; // 1-5
  independence_level: number; // 1-5
  attitude_summary?: string;
}
```

#### Dữ liệu Đầu ra

**Success (200 OK):**

```json
{
  "success": true,
  "session_log": {
    "id": "log-uuid",
    "mood": "good",
    "energy_level": 4,
    "cooperation_level": 5,
    "focus_level": 3,
    "independence_level": 4,
    "attitude_summary": "Trẻ rất hợp tác hôm nay, tập trung tốt hơn tuần trước.",
    "updated_at": "2025-11-05T05:10:00Z"
  },
  "next_step": "notes_media"
}
```

#### API Endpoint

```
PUT /api/session-logs/:log_id/attitude
Authorization: Bearer <access_token>
Content-Type: application/json
```

#### Ưu tiên

**Must Have**

---

### **FR-020: Ghi Nhật ký - Bước 3: Ghi chú, Tiến độ & Media**

#### Mã Chức năng

`FR-020`

#### Mô tả

Giáo viên thêm ghi chú tổng quan, đánh giá tiến độ, và đính kèm media (ảnh/video/audio). Đây là **Bước 3**.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Đã hoàn thành FR-019 (Bước 2 - Thái độ)
- `SESSION_LOGS` đã tồn tại

#### Luồng Sự kiện Chính

**Bước 1:** Hệ thống hiển thị form với các trường (mapping sang `SESSION_LOGS`):

**Section 1: Ghi chú Văn bản**

- **Tiến độ** (Progress Notes) → `SESSION_LOGS.progress_notes` (max 2000 chars)
- **Thách thức** (Challenges Faced) → `SESSION_LOGS.challenges_faced` (max 2000 chars)
- **Khuyến nghị** (Recommendations) → `SESSION_LOGS.recommendations` (max 2000 chars)
- **Ghi chú Giáo viên** (Teacher Notes) → `SESSION_LOGS.teacher_notes_text` (max 2000 chars)
- **Đánh giá Tổng thể** (Overall Rating) → `SESSION_LOGS.overall_rating` (1-5 ⭐)

**Section 2: Thời gian Thực tế**

- **Giờ bắt đầu thực tế** → `SESSION_LOGS.actual_start_time`
- **Giờ kết thúc thực tế** → `SESSION_LOGS.actual_end_time`

**Section 3: Media Đính kèm**

Giáo viên có thể đính kèm (mapping sang `LOG_MEDIA_ATTACHMENTS`):

**3.1 Ảnh (Photos)**

- Max 10 ảnh / log
- Max 5MB / ảnh
- Format: JPG, PNG, HEIC
- Auto-resize: max 1920px, generate thumbnail 300x300px

**3.2 Video**

- Max 3 videos / log
- Max 100MB / video
- Format: MP4, MOV
- Duration: max 5 phút
- Auto-compress nếu > 50MB

**3.3 Audio (Voice Notes)**

- Max 5 audio files / log
- Max 5 phút / file
- Format: M4A, MP3

**Bước 2:** Giáo viên nhập ghi chú và đánh giá

**Bước 3:** Giáo viên upload media:

**Upload Flow:**

**Bước 3.1:** Client validate file (size, format, count)

**Bước 3.2:** Client request signed upload URL:

```
POST /api/media/upload-url
{
  "session_log_id": "uuid",
  "media_type": "image",
  "filename": "photo1.jpg",
  "file_size": 3145728,
  "mime_type": "image/jpeg"
}
```

**Bước 3.3:** Server tạo signed URL (Cloudflare R2) và trả về

**Bước 3.4:** Client upload file directly to R2 với progress bar

**Bước 3.5:** Sau khi upload thành công, client gọi API confirm

**Bước 3.6:** Server tạo record trong `LOG_MEDIA_ATTACHMENTS`:

```sql
INSERT INTO log_media_attachments (
  id,
  session_log_id,          -- FK to SESSION_LOGS
  media_type,              -- 'image' | 'video' | 'audio'
  url,                     -- final R2 URL
  thumbnail_url,           -- (for images/videos)
  filename,
  file_size,               -- bytes
  mime_type,
  duration,                -- seconds (for audio/video)
  width,                   -- px (for images/videos)
  height,                  -- px (for images/videos)
  caption,                 -- optional text
  uploaded_by,             -- authenticated_teacher_id
  created_at
) VALUES (...);
```

**Bước 4:** Hệ thống update `SESSION_LOGS`:

```sql
UPDATE session_logs
SET
  progress_notes = :progress_notes,
  challenges_faced = :challenges_faced,
  recommendations = :recommendations,
  teacher_notes_text = :teacher_notes_text,
  overall_rating = :overall_rating,
  actual_start_time = :actual_start_time,
  actual_end_time = :actual_end_time,
  updated_at = NOW()
WHERE id = :session_log_id;
```

**Bước 5:** Giáo viên nhấn "Tiếp theo" → chuyển sang **Bước 4** (FR-021 - Hành vi A-B-C) hoặc "Bỏ qua" nếu không có behavior incidents

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                                                    | Mô tả                                                                              |
| ------------ | ------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| **RB-020-1** | `LOG_MEDIA_ATTACHMENTS.session_log_id` FK → `SESSION_LOGS.id` | 1-N relationship                                                                   |
| **RB-020-2** | `LOG_MEDIA_ATTACHMENTS.media_type` CHECK                      | Chỉ chấp nhận 'image', 'video', 'audio'                                            |
| **RB-020-3** | File Limits                                                   | Max 10 images, 3 videos, 5 audios per log                                          |
| **RB-020-4** | File Size                                                     | Image: 5MB, Video: 100MB, Audio: ~10MB (5min @ 320kbps)                            |
| **RB-020-5** | Storage                                                       | Đường dẫn R2: `session-logs/{teacher_id}/{session_log_id}/{media_type}/{filename}` |
| **RB-020-6** | `SESSION_LOGS.overall_rating` CHECK                           | 1-5                                                                                |
| **RB-020-7** | Text fields                                                   | Max 2000 chars mỗi field                                                           |
| **RB-020-8** | CASCADE DELETE                                                | Nếu xóa `SESSION_LOGS`, tất cả `LOG_MEDIA_ATTACHMENTS` cũng bị xóa                 |

#### Dữ liệu Đầu vào

```typescript
interface UpdateNotesMediaInput {
  progress_notes?: string; // max 2000 chars
  challenges_faced?: string;
  recommendations?: string;
  teacher_notes_text?: string;
  overall_rating?: number; // 1-5
  actual_start_time?: string; // HH:MM:SS
  actual_end_time?: string;
}

interface UploadMediaRequest {
  session_log_id: string;
  media_type: "image" | "video" | "audio";
  filename: string;
  file_size: number;
  mime_type: string;
  caption?: string;
}
```

#### API Endpoints

```
PUT /api/session-logs/:log_id/notes
POST /api/media/upload-url
POST /api/media/:media_id/confirm
DELETE /api/media/:media_id
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Should Have**

---

### **FR-021: Ghi Nhật ký - Bước 4: Ghi nhận Hành vi A-B-C (Optional)**

#### Mã Chức năng

`FR-021`

#### Mô tả

Giáo viên ghi nhận các sự cố hành vi (behavior incidents) theo mô hình A-B-C (Antecedent-Behavior-Consequence). Đây là **Bước 4 (tuỳ chọn)**.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Đã hoàn thành FR-020 (Bước 3)
- `SESSION_LOGS` đã tồn tại

#### Luồng Sự kiện Chính

**Bước 1:** Hệ thống hiển thị màn hình "Ghi nhận Hành vi"

**Bước 2:** Giáo viên chọn:

- **"Không có hành vi đặc biệt"** → Bỏ qua, chuyển sang FR-022 (Hoàn tất)
- **"Thêm Hành vi"** → Tiếp tục

**Bước 3:** Giáo viên chọn hành vi:

**Option A: Chọn từ Thư viện (`BEHAVIOR_LIBRARY`)**

**Bước 3A:** Hệ thống hiển thị search/browse interface với favorites ở đầu

**Bước 3B:** Giáo viên search/browse:

```sql
SELECT
  bl.*,
  bg.name_vn AS group_name,
  CASE WHEN tf.id IS NOT NULL THEN TRUE ELSE FALSE END AS is_favorite
FROM behavior_library bl
JOIN behavior_groups bg ON bl.behavior_group_id = bg.id
LEFT JOIN teacher_favorites tf ON bl.id = tf.behavior_library_id
  AND tf.teacher_id = :authenticated_teacher_id
WHERE bl.is_active = TRUE
  AND (
    :query IS NULL OR
    LOWER(bl.name_vn) LIKE LOWER('%' || :query || '%') OR
    bl.keywords_vn @> jsonb_build_array(:query)
  )
ORDER BY
  (CASE WHEN tf.id IS NOT NULL THEN 0 ELSE 1 END),
  bl.usage_count DESC
LIMIT 20;
```

**Bước 3C:** Giáo viên chọn 1 behavior từ kết quả

**Option B: Tạo Custom Behavior**

**Bước 3D:** Giáo viên nhập tên hành vi tự do (không lưu vào `BEHAVIOR_LIBRARY`)

**Bước 4:** Hệ thống hiển thị form A-B-C (mapping sang `BEHAVIOR_INCIDENTS`):

**Field: A-B-C Model**

- **Antecedent** (Tình huống kích hoạt) → `BEHAVIOR_INCIDENTS.antecedent` (required, max 1000 chars)
- **Behavior** (Hành vi) → `BEHAVIOR_INCIDENTS.behavior_description` (required, max 1000 chars)
- **Consequence** (Kết quả) → `BEHAVIOR_INCIDENTS.consequence` (required, max 1000 chars)

**Field: Mức độ & Chi tiết**

- **Thời lượng** → `duration_minutes` (optional)
- **Cường độ** → `intensity_level` (1-5, required)
- **Tần suất** → `frequency_count` (optional)

**Field: Can thiệp**

- **Can thiệp sử dụng** → `intervention_used` (optional, max 1000 chars)
- **Can thiệp có hiệu quả?** → `intervention_effective` (boolean)

**Field: Ngữ cảnh**

- **Yếu tố môi trường** → `environmental_factors` (optional, max 500 chars)
- **Thời điểm xảy ra** → `occurred_at` (time picker)

**Bước 5:** Giáo viên điền form và submit

**Bước 6:** Hệ thống validate và tạo record:

```sql
INSERT INTO behavior_incidents (
  id,
  session_log_id,
  behavior_library_id,     -- nullable
  incident_number,         -- auto-increment trong log
  antecedent,
  behavior_description,
  consequence,
  duration_minutes,
  intensity_level,
  frequency_count,
  intervention_used,
  intervention_effective,
  environmental_factors,
  occurred_at,
  notes,
  requires_followup,
  followup_notes,
  recorded_by,
  created_at,
  updated_at
) VALUES (...);
```

**Bước 7:** Nếu dùng behavior từ `BEHAVIOR_LIBRARY`:

```sql
UPDATE behavior_library
SET
  usage_count = usage_count + 1,
  last_used_at = NOW()
WHERE id = :behavior_library_id;
```

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                                                          | Mô tả                                                           |
| ------------ | ------------------------------------------------------------------- | --------------------------------------------------------------- |
| **RB-021-1** | `BEHAVIOR_INCIDENTS.session_log_id` FK → `SESSION_LOGS.id`          | 1-N relationship                                                |
| **RB-021-2** | `BEHAVIOR_INCIDENTS.behavior_library_id` FK → `BEHAVIOR_LIBRARY.id` | Optional FK (nullable cho custom)                               |
| **RB-021-3** | `BEHAVIOR_INCIDENTS.intensity_level` CHECK                          | 1-5                                                             |
| **RB-021-4** | Required Fields                                                     | antecedent, behavior_description, consequence phải có           |
| **RB-021-5** | CASCADE DELETE                                                      | Nếu xóa `SESSION_LOGS`, tất cả `BEHAVIOR_INCIDENTS` cũng bị xóa |

#### Dữ liệu Đầu vào

```typescript
interface CreateBehaviorIncidentInput {
  session_log_id: string;
  behavior_library_id?: string; // optional
  antecedent: string; // required, max 1000
  behavior_description: string; // required, max 1000
  consequence: string; // required, max 1000
  duration_minutes?: number;
  intensity_level: number; // 1-5, required
  frequency_count?: number;
  intervention_used?: string;
  intervention_effective?: boolean;
  environmental_factors?: string;
  occurred_at?: string;
  notes?: string;
  requires_followup?: boolean;
  followup_notes?: string;
}
```

#### API Endpoints

```
GET /api/behaviors?q=ăn vạ
POST /api/behavior-incidents
PATCH /api/behavior-incidents/:incident_id
DELETE /api/behavior-incidents/:incident_id
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-022: Hoàn tất Ghi Nhật ký**

#### Mã Chức năng

`FR-022`

#### Mô tả

Giáo viên xem lại toàn bộ nhật ký và hoàn tất ghi nhật ký.

#### Luồng Sự kiện Chính

**Bước 1:** Hệ thống hiển thị trang "Xem lại Nhật ký" với tất cả thông tin

**Bước 2:** Giáo viên xem lại và nhấn "Hoàn tất & Lưu"

**Bước 3:** Hệ thống update:

```sql
UPDATE session_logs
SET
  completed_at = NOW(),
  updated_at = NOW()
WHERE id = :session_log_id;

UPDATE sessions
SET
  status = 'completed',
  has_evaluation = TRUE,
  updated_at = NOW()
WHERE id = :session_id;
```

#### API Endpoint

```
POST /api/session-logs/:log_id/complete
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

```

**✅ PHẦN 5 XONG - Section 2.4 Session Logging hoàn tất**

Tiếp tục với **PHẦN 6/10: BEHAVIOR SYSTEM, CONTENT LIBRARY, AI (FR-023 đến FR-030)**?
```
