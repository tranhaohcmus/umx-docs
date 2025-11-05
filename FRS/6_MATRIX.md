# PHẦN 6/10: FUNCTIONAL REQUIREMENTS - BEHAVIOR SYSTEM, CONTENT LIBRARY & AI

````markdown
## 2.5 Hệ thống Hành vi

### **FR-023: Xem Thư viện Hành vi**

#### Mã Chức năng

`FR-023`

#### Mô tả

Giáo viên browse/search thư viện 127+ hành vi evidence-based.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Giáo viên đã đăng nhập

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình "Thư viện Hành vi"

**Bước 2:** Hệ thống hiển thị 3 nhóm hành vi từ `BEHAVIOR_GROUPS`:

```sql
SELECT * FROM behavior_groups
WHERE is_active = TRUE
ORDER BY order_index;
```
````

**Kết quả:**

1. 😤 **CHỐNG ĐỐI & BƯỚNG BỈNH** (Opposition & Defiance)
2. 👊 **HÀNH VI GÂY HẤN** (Aggression)
3. 👂 **VẤN ĐỀ VỀ GIÁC QUAN** (Sensory Issues)

**Bước 3:** Giáo viên có thể:

- **Option A: Browse theo nhóm** - Click vào 1 nhóm → hiển thị danh sách behaviors trong nhóm
- **Option B: Search toàn bộ** - Nhập keyword vào search bar (debounce 300ms)

**Search Query:**

```sql
SELECT
  bl.*,
  bg.name_vn AS group_name,
  bg.icon AS group_icon,
  bg.color_code,
  CASE WHEN tf.id IS NOT NULL THEN TRUE ELSE FALSE END AS is_favorite
FROM behavior_library bl
JOIN behavior_groups bg ON bl.behavior_group_id = bg.id
LEFT JOIN teacher_favorites tf ON bl.id = tf.behavior_library_id
  AND tf.teacher_id = :authenticated_teacher_id
WHERE bl.is_active = TRUE
  AND (
    :query IS NULL OR
    LOWER(bl.name_vn) LIKE LOWER('%' || :query || '%') OR
    LOWER(bl.name_en) LIKE LOWER('%' || :query || '%') OR
    EXISTS (
      SELECT 1 FROM jsonb_array_elements_text(bl.keywords_vn) kw
      WHERE LOWER(kw) LIKE LOWER('%' || :query || '%')
    )
  )
  AND (:group_id IS NULL OR bl.behavior_group_id = :group_id)
ORDER BY
  (CASE WHEN tf.id IS NOT NULL THEN 0 ELSE 1 END),  -- favorites first
  bl.usage_count DESC,
  bl.name_vn
LIMIT 50;
```

**Performance Target:** < 200ms

**Bước 4:** Client hiển thị danh sách behaviors với:

- Icon + Tên (VN + EN)
- Group badge
- Favorite star icon (gold nếu is_favorite)
- Usage count badge

**Bước 5:** Giáo viên click vào 1 behavior → FR-024 (Chi tiết)

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                     | Mô tả                                        |
| ------------ | ------------------------------ | -------------------------------------------- |
| **RB-023-1** | `BEHAVIOR_LIBRARY.keywords_vn` | JSONB array, indexed với GIN                 |
| **RB-023-2** | Search Performance             | < 200ms với GIN index                        |
| **RB-023-3** | Favorites                      | Query qua `TEACHER_FAVORITES` junction table |

#### API Endpoint

```
GET /api/behaviors?q=ăn vạ&group_id=uuid&favorites_only=false
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-024: Xem Chi tiết Hành vi**

#### Mã Chức năng

`FR-024`

#### Mô tả

Giáo viên xem chi tiết đầy đủ của 1 hành vi với giải thích, giải pháp, nguồn tham khảo.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên click vào 1 behavior từ danh sách (FR-023)

**Bước 2:** Hệ thống query chi tiết:

```sql
SELECT
  bl.*,
  bg.name_vn AS group_name,
  bg.icon AS group_icon,
  bg.color_code,
  bg.common_tips,
  CASE WHEN tf.id IS NOT NULL THEN TRUE ELSE FALSE END AS is_favorite
FROM behavior_library bl
JOIN behavior_groups bg ON bl.behavior_group_id = bg.id
LEFT JOIN teacher_favorites tf ON bl.id = tf.behavior_library_id
  AND tf.teacher_id = :authenticated_teacher_id
WHERE bl.id = :behavior_id
  AND bl.is_active = TRUE;
```

**Bước 3:** Client hiển thị:

**Section 1: Header**

- Icon (emoji) + Tên VN + EN
- Group badge
- Favorite button (toggle)
- Age range badge
- Usage count

**Section 2: Biểu hiện (Manifestation)**

- `manifestation_vn`: Mô tả lâm sàng chi tiết về hành vi

**Section 3: Giải thích (Explanation)**

- Parse `explanation` JSONB array và hiển thị dạng accordion

**Section 4: Giải pháp (Solutions)**

- Parse `solutions` JSONB array và hiển thị dạng numbered list

**Section 5: Chiến lược Phòng ngừa (Prevention)**

- Parse `prevention_strategies` JSONB

**Section 6: Nguồn Tham khảo (Sources)**

- Parse `sources` JSONB array và hiển thị dạng citations

**Section 7: Hành vi Liên quan (Related)**

- Parse `related_behaviors` JSONB array (behavior IDs) và query + hiển thị links

**Section 8: Actions**

- Button "Sử dụng trong Nhật ký"
- Button "Chia sẻ" (optional)

#### API Endpoint

```
GET /api/behaviors/:behavior_id
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-025: Toggle Yêu thích Hành vi**

#### Mã Chức năng

`FR-025`

#### Mô tả

Giáo viên có thể đánh dấu/bỏ đánh dấu hành vi yêu thích.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên click vào star icon

**Bước 2:** Hệ thống check và toggle:

```sql
-- Nếu chưa favorite → Add
INSERT INTO teacher_favorites (
  id,
  teacher_id,
  behavior_library_id,
  created_at
) VALUES (...)
ON CONFLICT (teacher_id, behavior_library_id) DO NOTHING;

-- Nếu đã favorite → Remove
DELETE FROM teacher_favorites
WHERE teacher_id = :authenticated_teacher_id
  AND behavior_library_id = :behavior_id;
```

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                                 | Mô tả                                     |
| ------------ | ------------------------------------------ | ----------------------------------------- |
| **RB-025-1** | `TEACHER_FAVORITES`                        | N-M junction table                        |
| **RB-025-2** | `UNIQUE (teacher_id, behavior_library_id)` | Mỗi teacher chỉ favorite 1 behavior 1 lần |

#### API Endpoint

```
POST /api/teachers/me/favorites
DELETE /api/teachers/me/favorites/:behavior_id
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Should Have**

---

## 2.6 Thư viện Nội dung

### **FR-026: Tạo Content Template**

#### Mã Chức năng

`FR-026`

#### Mô tả

Giáo viên tạo content template để tái sử dụng trong các buổi học sau.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập "Thư viện Nội dung" → "Tạo Template mới"

**Bước 2:** Hệ thống hiển thị form (mapping sang `CONTENT_LIBRARY`):

- `title` (string, required)
- `domain` (enum, required): cognitive/motor/language/social/self_care
- `description` (text, required)
- `target_age_min` (int, optional): 2-18
- `target_age_max` (int, optional): 2-18
- `difficulty_level` (enum, optional): beginner/intermediate/advanced
- `materials_needed` (text, optional)
- `estimated_duration` (int, minutes, optional)
- `instructions` (text, optional)
- `tips` (text, optional)
- `default_goals` (array, required): Danh sách goals mặc định
- `tags` (array of strings, optional)
- `is_public` (boolean, default false): Chia sẻ với giáo viên khác?

**Bước 3:** Giáo viên nhập thông tin

**Bước 4:** Giáo viên thêm Default Goals (minimum 1)

**Bước 5:** Hệ thống tạo record:

```sql
INSERT INTO content_library (
  id,
  teacher_id,              -- authenticated_teacher_id (NULL = system template)
  code,                    -- auto-generate: CTL_{teacher_initials}_{number}
  title,
  domain,
  description,
  target_age_min,
  target_age_max,
  difficulty_level,
  default_goals,           -- JSONB array
  materials_needed,
  estimated_duration,
  instructions,
  tips,
  is_template,             -- TRUE
  is_public,
  usage_count,             -- 0
  rating_avg,              -- 0
  rating_count,            -- 0
  tags,                    -- JSONB array
  created_at,
  updated_at
) VALUES (...)
RETURNING *;
```

**Example `default_goals` JSONB:**

```json
[
  {
    "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
    "order": 1
  },
  {
    "description": "Trẻ có thể nói tên màu",
    "order": 2
  }
]
```

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                      | Mô tả                                        |
| ------------ | ------------------------------- | -------------------------------------------- |
| **RB-026-1** | `CONTENT_LIBRARY.teacher_id`    | NULL = system template, UUID = user template |
| **RB-026-2** | `CONTENT_LIBRARY.is_template`   | TRUE cho templates                           |
| **RB-026-3** | `CONTENT_LIBRARY.default_goals` | JSONB array, ít nhất 1 goal                  |
| **RB-026-4** | `CONTENT_LIBRARY.domain` CHECK  | 5 giá trị enum                               |
| **RB-026-5** | `CONTENT_LIBRARY.tags`          | JSONB array, indexed với GIN                 |

#### API Endpoint

```
POST /api/content-library
Authorization: Bearer <access_token>
Content-Type: application/json
```

#### Ưu tiên

**Should Have**

---

### **FR-027: Đánh giá Content Template**

#### Mã Chức năng

`FR-027`

#### Mô tả

Giáo viên có thể đánh giá (rate & review) các public templates.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên xem chi tiết template

**Bước 2:** Giáo viên nhấn "Đánh giá"

**Bước 3:** Hệ thống hiển thị form:

- Star rating: 1-5
- Review text (optional, max 500 chars)

**Bước 4:** Hệ thống tạo/update:

```sql
INSERT INTO content_library_ratings (
  id,
  content_library_id,
  teacher_id,
  rating,               -- 1-5
  review,
  created_at,
  updated_at
) VALUES (...)
ON CONFLICT (content_library_id, teacher_id)  -- UNIQUE
DO UPDATE SET
  rating = EXCLUDED.rating,
  review = EXCLUDED.review,
  updated_at = NOW();
```

**Bước 5:** Trigger function update `CONTENT_LIBRARY`:

```sql
UPDATE content_library
SET
  rating_avg = (
    SELECT AVG(rating)::DECIMAL(3,2) FROM content_library_ratings
    WHERE content_library_id = :content_library_id
  ),
  rating_count = (
    SELECT COUNT(*) FROM content_library_ratings
    WHERE content_library_id = :content_library_id
  )
WHERE id = :content_library_id;
```

#### API Endpoint

```
POST /api/content-library/:template_id/ratings
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Could Have**

---

## 2.7 Xử lý AI

### **FR-028: Upload File/Text cho AI Processing**

#### Mã Chức năng

`FR-028`

#### Mô tả

Giáo viên upload file (PDF/DOCX/TXT/image) hoặc paste text để AI tự động tạo sessions.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Giáo viên đã đăng nhập
- Giáo viên đã có ít nhất 1 học sinh

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập "Tạo Buổi học" → chọn "Tạo bằng AI"

**Bước 2:** Hệ thống hiển thị 2 options:

- **Option A: Upload File** (PDF, DOCX, TXT, JPG, PNG - max 10MB)
- **Option B: Paste Text** (max 5000 characters)

**Bước 3:** Giáo viên chọn học sinh từ dropdown

**Bước 4:** Giáo viên upload file hoặc paste text và submit

**Bước 5:** Hệ thống validate:

- File: size <= 10MB, format hợp lệ
- Text: length <= 5000 chars
- Student ID hợp lệ

**Bước 6:** Hệ thống tạo record trong `AI_PROCESSING`:

```sql
INSERT INTO ai_processing (
  id,
  teacher_id,
  student_id,
  file_url,                -- R2 URL (nếu upload file)
  file_type,               -- 'pdf', 'docx', 'txt', 'jpg', 'png'
  text_content,            -- nếu paste text
  processing_status,       -- 'pending'
  progress,                -- 0
  result_sessions,         -- NULL (JSONB)
  created_at
) VALUES (...)
RETURNING *;
```

**Bước 7:** Nếu upload file: Upload file lên R2: `ai-uploads/{teacher_id}/{timestamp}_{filename}`

**Bước 8:** Hệ thống enqueue background job để xử lý AI

**Bước 9:** Hệ thống trả về processing object với status 'pending'

**Bước 10:** Client poll hoặc subscribe WebSocket để nhận updates

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                                    | Mô tả                                  |
| ------------ | --------------------------------------------- | -------------------------------------- |
| **RB-028-1** | `AI_PROCESSING.teacher_id` FK → `TEACHERS.id` | Chỉ teacher tạo mới xem được           |
| **RB-028-2** | `AI_PROCESSING.student_id` FK → `STUDENTS.id` | Optional (có thể chọn student sau)     |
| **RB-028-3** | File Limits                                   | PDF/DOCX/TXT/JPG/PNG, max 10MB         |
| **RB-028-4** | Text Limit                                    | Max 5000 chars                         |
| **RB-028-5** | `AI_PROCESSING.processing_status` CHECK       | pending, processing, completed, failed |
| **RB-028-6** | `AI_PROCESSING.progress` CHECK                | 0-100                                  |

#### Dữ liệu Đầu vào

```typescript
interface UploadForAIInput {
  student_id: string;
  file?: File; // PDF/DOCX/TXT/JPG/PNG, max 10MB
  text_content?: string; // max 5000 chars (XOR with file)
}
```

#### API Endpoint

```
POST /api/ai/process
Authorization: Bearer <access_token>
Content-Type: multipart/form-data
```

#### Ưu tiên

**Should Have**

---

### **FR-029: AI Processing Background Job**

#### Mã Chức năng

`FR-029`

#### Mô tả

Background job xử lý file/text bằng AI (OCR + GPT-4) để extract sessions.

#### Tác nhân

- **Background Worker** (automated)

#### Luồng Sự kiện Chính

**Bước 1:** Worker dequeue job từ queue

**Bước 2:** Worker update status = 'processing', progress = 5

**Bước 3:** Nếu là image file (JPG/PNG):

- Gọi **Google Vision API** (OCR) để extract text
- Update progress = 25

**Bước 4:** Nếu là PDF/DOCX/TXT:

- Extract text bằng library (pdf-parse, mammoth.js)
- Update progress = 25

**Bước 5:** Gọi **OpenAI GPT-4** để extract structured data:

**Prompt Template:**

```
Bạn là chuyên gia phân tích kế hoạch giảng dạy. Hãy phân tích văn bản sau và extract thông tin về các buổi học (sessions).

Với mỗi buổi học, hãy trích xuất:
- session_date (YYYY-MM-DD)
- time_slot (morning/afternoon/evening)
- start_time, end_time (HH:MM)
- location
- notes
- contents: Array of {
    title,
    domain (cognitive/motor/language/social/self_care),
    description,
    materials_needed,
    estimated_duration,
    goals: Array of {
      description,
      goal_type (knowledge/skill/behavior)
    }
  }

Trả về JSON format: {"sessions": [...]}

Văn bản:
---
{text_content}
---
```

**GPT-4 API Call:**

```javascript
const response = await openai.chat.completions.create({
  model: "gpt-4-turbo",
  messages: [
    { role: "system", content: systemPrompt },
    { role: "user", content: userPrompt },
  ],
  response_format: { type: "json_object" },
  timeout: 60000,
  max_tokens: 4000,
});
```

**Bước 6:** Update progress = 75

**Bước 7:** Validate extracted data:

- Mỗi session phải có ít nhất 1 content
- Mỗi content phải có ít nhất 1 goal

**Bước 8:** Update `AI_PROCESSING`:

```sql
UPDATE ai_processing
SET
  processing_status = 'completed',
  progress = 100,
  result_sessions = :result_json,  -- JSONB
  completed_at = NOW()
WHERE id = :processing_id;
```

**Xử lý Lỗi:**

- Retry 3 lần với exponential backoff (5s, 10s, 20s)
- Nếu fail: update status = 'failed' với error_message

#### Ưu tiên

**Should Have**

---

### **FR-030: Xem Preview & Tạo Sessions từ AI Result**

#### Mã Chức năng

`FR-030`

#### Mô tả

Giáo viên xem preview sessions được AI extract và có thể chỉnh sửa trước khi lưu.

#### Luồng Sự kiện Chính

**Bước 1:** Client nhận notification hoặc poll để biết AI đã xong

**Bước 2:** Client gọi API get processing result

**Bước 3:** Hệ thống trả về processing object với `result_sessions`

**Bước 4:** Client parse `result_sessions` JSONB và hiển thị preview:

- Danh sách sessions (expandable cards)
- Với mỗi session: editable fields, contents list, goals list
- Actions: "Bỏ qua session này", "Chỉnh sửa"

**Bước 5:** Giáo viên review và có thể chỉnh sửa

**Bước 6:** Giáo viên nhấn "Tạo tất cả Buổi học"

**Bước 7:** Hệ thống validate data (giống FR-013, FR-014)

**Bước 8:** Hệ thống tạo records trong DB (với mỗi session):

```sql
-- Transaction START
-- 1. Tạo SESSION
INSERT INTO sessions (...) VALUES (...) RETURNING id;

-- 2. Tạo SESSION_CONTENTS
INSERT INTO session_contents (...) VALUES (...) RETURNING id;

-- 3. Tạo CONTENT_GOALS
INSERT INTO content_goals (...) VALUES (...);
-- Transaction COMMIT
```

**Bước 9:** Hệ thống trả về danh sách sessions đã tạo

**Fallback nếu AI fail:**

- Hiển thị error message
- Button "Thử lại" hoặc "Tạo thủ công"

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                 | Mô tả                                                                |
| ------------ | -------------------------- | -------------------------------------------------------------------- |
| **RB-030-1** | `SESSIONS.creation_method` | Phải là 'ai' để phân biệt với manual                                 |
| **RB-030-2** | Transaction                | Tạo SESSION + CONTENTS + GOALS trong 1 transaction (atomicity)       |
| **RB-030-3** | Rollback                   | Nếu 1 session fail → rollback session đó, tiếp tục với sessions khác |

#### API Endpoints

```
GET /api/ai/process/:processing_id
POST /api/ai/process/:processing_id/create-sessions
GET /api/ai/process/:processing_id/status
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Should Have**

---

```

**✅ PHẦN 6 XONG - Sections 2.5, 2.6, 2.7 hoàn tất**

Tiếp tục với **PHẦN 7/10: ANALYTICS, REPORTS, OFFLINE (FR-031 đến FR-035)**?
```
