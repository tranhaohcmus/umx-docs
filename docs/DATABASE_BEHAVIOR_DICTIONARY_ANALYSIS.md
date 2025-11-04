# Phân Tích Database Design - Behavior Dictionary Feature

**Ngày đánh giá:** 2025-11-04  
**Phạm vi:** Kiểm tra thiết kế database cho tính năng Từ điển Hành vi (Behavior Dictionary)  
**Tham chiếu:**

- Wireframes: 18-dictionary-home.md, 18.5-dictionary-group.md, 19-dictionary-detail.md
- Data model: data.md
- Database schema: DATABASE_DESIGN.md, ERD_MERMAID.md

---

## 📊 TÓM TẮT ĐÁNH GIÁ

| Tiêu chí                                 | Điểm   | Trạng thái            |
| ---------------------------------------- | ------ | --------------------- |
| **Cấu trúc bảng phù hợp với wireframes** | 9.5/10 | ✅ Xuất sắc           |
| **JSON schema đáp ứng yêu cầu data.md**  | 10/10  | ✅ Hoàn hảo           |
| **Indexes hỗ trợ search & performance**  | 8/10   | ⚠️ Tốt, cần cải thiện |
| **Business logic & constraints**         | 9/10   | ✅ Tốt                |
| **Scalability cho 127+ behaviors**       | 9/10   | ✅ Tốt                |

**Kết luận tổng thể:** ✅ **Database design RẤT HỢP LÝ** - Chỉ cần một số cải thiện nhỏ về performance và validation.

---

## ✅ ĐIỂM MẠNH

### 1. **Cấu trúc 2 bảng rất hợp lý**

```
BEHAVIOR_GROUPS (3 groups)
    ↓ 1:N
BEHAVIOR_LIBRARY (127+ behaviors)
```

**Ưu điểm:**

- ✅ Tách biệt rõ ràng group metadata và behavior details
- ✅ Dễ query behaviors theo group (frame 18.5)
- ✅ Dễ tính thống kê per group (total behaviors, trends)
- ✅ Hỗ trợ thêm groups trong tương lai mà không ảnh hưởng data

**Mapping với wireframes:**

| Wireframe                      | Database Support                                             |
| ------------------------------ | ------------------------------------------------------------ |
| **Frame 18** - Group cards     | `SELECT * FROM BEHAVIOR_GROUPS ORDER BY order_index`         |
| **Frame 18.5** - Group detail  | `SELECT * FROM BEHAVIOR_LIBRARY WHERE behavior_group_id = ?` |
| **Frame 19** - Behavior detail | `SELECT * FROM BEHAVIOR_LIBRARY WHERE id = ?`                |

---

### 2. **JSON Schema Hoàn Hảo cho Complex Data**

Database design sử dụng JSON fields cho đúng mục đích:

#### ✅ **keywords_vn/keywords_en (JSON array)**

```json
["ăn vạ", "la hét", "nằm lăn ra đất", "gào khóc", ...]
```

**Lý do hợp lý:**

- Backend-only, không hiển thị UI → JSON array tối ưu
- Full-text search với PostgreSQL GIN index
- 10-15 keywords/behavior phù hợp với yêu cầu

**Hỗ trợ wireframe 18:**

```sql
-- Search "la hét" → find matching behaviors
SELECT * FROM BEHAVIOR_LIBRARY
WHERE keywords_vn @> '["la hét"]'::jsonb;
```

#### ✅ **explanation (JSON array of objects)**

```json
[
  {
    "title": "Nhu cầu Giao tiếp",
    "description": "Với trẻ nhỏ, đặc biệt..."
  },
  {
    "title": "Nhu cầu Tự chủ & Độc lập",
    "description": "Từ 18 tháng đến 3 tuổi..."
  }
]
```

**Lý do hợp lý:**

- Số lượng explanations không cố định (2-4 frameworks)
- Mỗi explanation có structure nhất quán (title + description)
- Dễ render expandable sections trong wireframe 19
- Không cần normalize vì không query riêng explanations

#### ✅ **solutions (JSON array of objects)**

```json
[
  {
    "title": "Giữ bình tĩnh & Đảm bảo an toàn",
    "description": "Phản ứng của người lớn..."
  },
  ...
]
```

**Lý do hợp lý:**

- Giống explanation, số lượng linh hoạt (4-5 solutions)
- Ordered list (thứ tự quan trọng: 1️⃣, 2️⃣, 3️⃣...)
- Expandable UI trong wireframe 19

#### ✅ **sources (JSON array of strings)**

```json
["Potegal, M., & Davidson, R. J. (2003)...", "Sroufe, L. A. (2000)..."]
```

**Lý do hợp lý:**

- Ít khi query riêng sources
- Chỉ hiển thị khi user xem detail
- Simple array đủ dùng

#### ✅ **severity_indicators, related_behaviors, prevention_strategies**

- Đều là JSON arrays
- Phù hợp vì không query thường xuyên
- Flexible schema cho future enhancements

---

### 3. **Indexes Tốt cho Search & Filtering**

Database đã có:

```sql
-- Full-text search on keywords_vn
CREATE INDEX ON BEHAVIOR_LIBRARY USING GIN(keywords_vn);

-- Filter by group
CREATE INDEX idx_behavior_group ON (behavior_group_id);

-- Sort by usage
CREATE INDEX idx_behavior_usage ON (usage_count DESC);

-- Filter active behaviors
CREATE INDEX idx_behavior_active ON (is_active);
```

**Hỗ trợ các use cases:**

| Wireframe Feature      | Index Support                 |
| ---------------------- | ----------------------------- |
| 🔍 Search "ăn vạ"      | GIN index on keywords_vn ✅   |
| 🏷️ Filter by group     | idx_behavior_group ✅         |
| 📊 Sort by popularity  | idx_behavior_usage ✅         |
| ⭐ Show favorites only | Via TEACHER_FAVORITES join ✅ |

---

### 4. **BEHAVIOR_GROUPS Table Well-Designed**

```sql
BEHAVIOR_GROUPS {
    code UK           -- "GROUP_01", "GROUP_02", "GROUP_03"
    name_vn          -- "CHỐNG ĐỐI & BƯỚNG BỈNH"
    name_en          -- "Opposition & Defiance"
    description_vn   -- Mô tả nhóm
    icon             -- "😤", "👊", "👂"
    color_code       -- "#FF5733"
    common_tips JSON -- Mẹo chung cho nhóm
    order_index      -- Thứ tự hiển thị
}
```

**Ưu điểm:**

- ✅ `common_tips` JSON array hỗ trợ wireframe 18.5 (Mẹo chung cho nhóm)
- ✅ `icon` + `color_code` cho UI theming
- ✅ `order_index` control display order
- ✅ Bilingual (VN + EN) cho i18n

**Phù hợp 100% với data:**

```json
// Example từ wireframe 18.5
{
  "group_name": "CHỐNG ĐỐI & BƯỚNG BỈNH",
  "common_tips": [
    "Giữ bình tĩnh, kiên nhẫn",
    "Đưa ra yêu cầu rõ ràng, ngắn gọn",
    "Công nhận cảm xúc của trẻ",
    "Tránh đối đầu trực tiếp"
  ]
}
```

---

### 5. **BEHAVIOR_LIBRARY Table Comprehensive**

```sql
BEHAVIOR_LIBRARY {
    behavior_code UK      -- "BH_01_01", "BH_01_02"...
    name_vn, name_en      -- Bilingual
    keywords_vn JSON      -- 10-15 keywords
    manifestation_vn TEXT -- Clinical description
    age_range_min/max     -- Target age groups
    explanation JSON      -- 2-4 frameworks
    solutions JSON        -- 4-5 strategies
    sources JSON          -- Academic citations
    usage_count          -- Auto-increment on use
    last_used_at         -- Track recency
}
```

**Ưu điểm:**

- ✅ `behavior_code` format "BH_01_01" maps trực tiếp với wireframe IDs "1.1", "1.2"
- ✅ `age_range_min/max` hỗ trợ filter behaviors theo độ tuổi học sinh
- ✅ `usage_count` + `last_used_at` cho trending (frame 18: "🔥 Xu hướng tuần này")
- ✅ `manifestation_vn` separate field → dễ preview trong lists

---

### 6. **TEACHER_FAVORITES Junction Table**

```sql
TEACHER_FAVORITES {
    teacher_id FK
    behavior_library_id FK
    created_at
}
```

**Ưu điểm:**

- ✅ Đơn giản, hiệu quả cho many-to-many
- ✅ Hỗ trợ wireframe 18: "⭐ Yêu thích của bạn (3)"
- ✅ Easy toggle favorite với INSERT/DELETE

**Query example:**

```sql
-- Get teacher's favorites
SELECT bl.*
FROM BEHAVIOR_LIBRARY bl
JOIN TEACHER_FAVORITES tf ON bl.id = tf.behavior_library_id
WHERE tf.teacher_id = ?
ORDER BY tf.created_at DESC;
```

---

### 7. **Business Rules Validation**

Database có constraints hợp lý:

```sql
-- From DATABASE_DESIGN.md
CHECK constraints:
- keywords_vn phải có ít nhất 10 từ khóa
- explanation phải có ít nhất 2 frameworks
- solutions phải có ít nhất 4 strategies
- sources phải có ít nhất 2 academic citations
```

**Đảm bảo data quality:**

- ✅ Không có behavior thiếu thông tin quan trọng
- ✅ Enforce evidence-based approach (min 2 sources)
- ✅ Đủ solutions cho giáo viên chọn lựa

---

## ⚠️ CẦN CẢI THIỆN

### 1. **Missing Composite Index for Common Query**

**Vấn đề:** Wireframe 18 cần query:

- Active behaviors
- Của một group cụ thể
- Sorted by usage

**Current indexes:**

```sql
idx_behavior_group ON (behavior_group_id)
idx_behavior_active ON (is_active)
idx_behavior_usage ON (usage_count DESC)
```

**❌ Không optimal** vì PostgreSQL phải combine 3 indexes riêng lẻ.

**✅ Cải thiện:**

```sql
-- Composite index cho query phổ biến nhất
CREATE INDEX idx_behavior_group_active_usage
ON BEHAVIOR_LIBRARY(behavior_group_id, is_active, usage_count DESC)
WHERE is_active = TRUE;

-- Use case:
SELECT * FROM BEHAVIOR_LIBRARY
WHERE behavior_group_id = ?
AND is_active = TRUE
ORDER BY usage_count DESC;
```

---

### 2. **GIN Index on Keywords Cần Optimize**

**Current:**

```sql
CREATE INDEX ON BEHAVIOR_LIBRARY USING GIN(keywords_vn);
```

**⚠️ Vấn đề:**

- GIN index tốt cho exact match: `keywords_vn @> '["ăn vạ"]'`
- Nhưng không support fuzzy search cho typos
- Không support partial match ("ăn" → find "ăn vạ")

**✅ Cải thiện - Thêm Full-text Search:**

```sql
-- Tạo computed column cho full-text search
ALTER TABLE BEHAVIOR_LIBRARY
ADD COLUMN keywords_tsvector TSVECTOR;

-- Update trigger để tự động sync
CREATE OR REPLACE FUNCTION update_behavior_keywords_tsvector()
RETURNS TRIGGER AS $$
BEGIN
  NEW.keywords_tsvector :=
    to_tsvector('vietnamese',
      array_to_string(
        ARRAY(SELECT jsonb_array_elements_text(NEW.keywords_vn)),
        ' '
      )
    );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_keywords_tsvector
BEFORE INSERT OR UPDATE OF keywords_vn ON BEHAVIOR_LIBRARY
FOR EACH ROW EXECUTE FUNCTION update_behavior_keywords_tsvector();

-- GIN index cho full-text search
CREATE INDEX idx_behavior_keywords_fts
ON BEHAVIOR_LIBRARY USING GIN(keywords_tsvector);

-- Query với fuzzy search:
SELECT * FROM BEHAVIOR_LIBRARY
WHERE keywords_tsvector @@ to_tsquery('vietnamese', 'ăn | vạ');
```

**Lợi ích:**

- ✅ Support typo tolerance
- ✅ Support partial match
- ✅ Ranking search results by relevance
- ✅ Faster search với large dataset (127+ behaviors)

---

### 3. **Missing Statistics Fields on BEHAVIOR_GROUPS**

**Vấn đề:** Wireframe 18.5 cần thống kê:

```
📊 THỐNG KÊ NHÓM
2 hành vi trong nhóm
77 lần ghi nhận (hệ thống)
13 lần (học sinh của bạn)
📈 Xu hướng: ↗️ +18% tuần
```

**Current schema:** Không có cached statistics trong BEHAVIOR_GROUPS.

**❌ Phải aggregate mỗi lần query:**

```sql
-- Slow query mỗi lần load group
SELECT
  COUNT(DISTINCT bl.id) as total_behaviors,
  COUNT(bi.id) as system_occurrences,
  -- ... complex aggregation
FROM BEHAVIOR_GROUPS bg
JOIN BEHAVIOR_LIBRARY bl ON bg.id = bl.behavior_group_id
LEFT JOIN BEHAVIOR_INCIDENTS bi ON bl.id = bi.behavior_library_id
WHERE bg.id = ?
GROUP BY bg.id;
```

**✅ Cải thiện - Denormalize Statistics:**

```sql
ALTER TABLE BEHAVIOR_GROUPS
ADD COLUMN total_behaviors INTEGER DEFAULT 0,
ADD COLUMN total_incidents_all_time INTEGER DEFAULT 0,
ADD COLUMN total_incidents_this_week INTEGER DEFAULT 0,
ADD COLUMN total_incidents_last_week INTEGER DEFAULT 0,
ADD COLUMN updated_stats_at TIMESTAMP;

-- Trigger để update khi có behavior mới
CREATE OR REPLACE FUNCTION update_group_stats()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE BEHAVIOR_GROUPS
    SET total_behaviors = total_behaviors + 1
    WHERE id = NEW.behavior_group_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE BEHAVIOR_GROUPS
    SET total_behaviors = total_behaviors - 1
    WHERE id = OLD.behavior_group_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Scheduled job để update incident stats (daily)
CREATE OR REPLACE FUNCTION refresh_group_incident_stats()
RETURNS void AS $$
BEGIN
  UPDATE BEHAVIOR_GROUPS bg
  SET
    total_incidents_all_time = (
      SELECT COUNT(*) FROM BEHAVIOR_INCIDENTS bi
      JOIN BEHAVIOR_LIBRARY bl ON bi.behavior_library_id = bl.id
      WHERE bl.behavior_group_id = bg.id
    ),
    total_incidents_this_week = (
      SELECT COUNT(*) FROM BEHAVIOR_INCIDENTS bi
      JOIN BEHAVIOR_LIBRARY bl ON bi.behavior_library_id = bl.id
      WHERE bl.behavior_group_id = bg.id
      AND bi.occurred_at >= NOW() - INTERVAL '7 days'
    ),
    total_incidents_last_week = (
      SELECT COUNT(*) FROM BEHAVIOR_INCIDENTS bi
      JOIN BEHAVIOR_LIBRARY bl ON bi.behavior_library_id = bl.id
      WHERE bl.behavior_group_id = bg.id
      AND bi.occurred_at >= NOW() - INTERVAL '14 days'
      AND bi.occurred_at < NOW() - INTERVAL '7 days'
    ),
    updated_stats_at = NOW();
END;
$$ LANGUAGE plpgsql;
```

**Computed trend trong application:**

```javascript
const trend = (((thisWeek - lastWeek) / lastWeek) * 100).toFixed(0);
// +18% hoặc -5%
```

---

### 4. **behavior_code Format Mismatch**

**Vấn đề:**

- Database: `behavior_code = "BH_01_01"`
- Wireframe: Display as `"1.1"`
- data.md: Uses `"id": "1.1"`

**⚠️ Không nhất quán** giữa database và UI.

**✅ Hai phương án:**

**Phương án A: Thay đổi database (Breaking change)**

```sql
ALTER TABLE BEHAVIOR_LIBRARY
ALTER COLUMN behavior_code TYPE VARCHAR(10);

-- Update data: "BH_01_01" → "1.1"
UPDATE BEHAVIOR_LIBRARY
SET behavior_code = SUBSTRING(behavior_code FROM 4);
-- BH_01_01 → 01_01 → 1.1
```

**Phương án B: Transform trong application (Recommended)**

```javascript
// Backend trả về cả 2 formats
{
  "behavior_code": "BH_01_01",  // Database ID
  "display_id": "1.1",            // UI display
  "name_vn": "Ăn vạ"
}

// Hoặc parse trong frontend:
const displayId = behaviorCode.replace(/^BH_0?(\d+)_0?(\d+)$/, '$1.$2');
// "BH_01_01" → "1.1"
// "BH_02_03" → "2.3"
```

**Khuyến nghị:** Giữ nguyên database format "BH_01_01" (unique, searchable), transform sang "1.1" ở presentation layer.

---

### 5. **Missing Validation for JSON Schema**

**Vấn đề:** Database chỉ check:

```sql
-- keywords_vn phải có ít nhất 10 từ khóa
-- explanation phải có ít nhất 2 frameworks
-- solutions phải có ít nhất 4 strategies
```

Nhưng KHÔNG validate **structure** của JSON objects.

**❌ Có thể insert invalid JSON:**

```json
{
  "title": "..."
  // Missing "description" field!
}
```

**✅ Cải thiện - Add CHECK constraints:**

```sql
-- Validate explanation structure
ALTER TABLE BEHAVIOR_LIBRARY
ADD CONSTRAINT chk_explanation_structure
CHECK (
  jsonb_array_length(explanation) >= 2
  AND (
    SELECT bool_and(
      elem ? 'title' AND elem ? 'description'
      AND jsonb_typeof(elem->'title') = 'string'
      AND jsonb_typeof(elem->'description') = 'string'
    )
    FROM jsonb_array_elements(explanation) elem
  )
);

-- Validate solutions structure
ALTER TABLE BEHAVIOR_LIBRARY
ADD CONSTRAINT chk_solutions_structure
CHECK (
  jsonb_array_length(solutions) >= 4
  AND (
    SELECT bool_and(
      elem ? 'title' AND elem ? 'description'
    )
    FROM jsonb_array_elements(solutions) elem
  )
);

-- Validate keywords_vn is array of strings
ALTER TABLE BEHAVIOR_LIBRARY
ADD CONSTRAINT chk_keywords_vn_array
CHECK (
  jsonb_typeof(keywords_vn) = 'array'
  AND jsonb_array_length(keywords_vn) >= 10
  AND (
    SELECT bool_and(jsonb_typeof(elem) = 'string')
    FROM jsonb_array_elements(keywords_vn) elem
  )
);
```

---

### 6. **Performance Issue: N+1 Queries**

**Vấn đề:** Khi load wireframe 18 (Dictionary Home), cần:

1. List all groups
2. Count behaviors per group
3. Get favorite behaviors
4. Get trending behaviors

**❌ Có thể dẫn đến multiple queries:**

```javascript
// Bad: N+1 query problem
const groups = await db.query("SELECT * FROM BEHAVIOR_GROUPS");
for (let group of groups) {
  group.behaviorCount = await db.query(
    "SELECT COUNT(*) FROM BEHAVIOR_LIBRARY WHERE behavior_group_id = ?",
    [group.id]
  );
}
```

**✅ Cải thiện - Single query với JOIN:**

```sql
-- Efficient query cho wireframe 18
SELECT
  bg.*,
  COUNT(DISTINCT bl.id) as behavior_count,
  COUNT(DISTINCT tf.id) FILTER (WHERE tf.teacher_id = ?) as favorited_count
FROM BEHAVIOR_GROUPS bg
LEFT JOIN BEHAVIOR_LIBRARY bl ON bg.id = bl.behavior_group_id AND bl.is_active = TRUE
LEFT JOIN TEACHER_FAVORITES tf ON bl.id = tf.behavior_library_id
GROUP BY bg.id
ORDER BY bg.order_index;
```

---

## 💡 KHUYẾN NGHỊ BỔ SUNG

### 1. **Thêm Materialized View cho Analytics**

**Use case:** Wireframe 20-21 (Analytics) cần query phức tạp về behavior trends.

```sql
CREATE MATERIALIZED VIEW mv_behavior_analytics AS
SELECT
  bl.id,
  bl.behavior_code,
  bl.name_vn,
  bg.name_vn as group_name,
  COUNT(DISTINCT bi.id) as total_incidents,
  COUNT(DISTINCT sl.session_id) as total_sessions,
  COUNT(DISTINCT s.student_id) as affected_students,
  AVG(bi.intensity_level) as avg_intensity,
  COUNT(DISTINCT bi.id) FILTER (
    WHERE bi.occurred_at >= NOW() - INTERVAL '7 days'
  ) as incidents_this_week,
  COUNT(DISTINCT bi.id) FILTER (
    WHERE bi.occurred_at >= NOW() - INTERVAL '14 days'
    AND bi.occurred_at < NOW() - INTERVAL '7 days'
  ) as incidents_last_week
FROM BEHAVIOR_LIBRARY bl
JOIN BEHAVIOR_GROUPS bg ON bl.behavior_group_id = bg.id
LEFT JOIN BEHAVIOR_INCIDENTS bi ON bl.id = bi.behavior_library_id
LEFT JOIN SESSION_LOGS sl ON bi.session_log_id = sl.id
LEFT JOIN SESSIONS s ON sl.session_id = s.id
GROUP BY bl.id, bl.behavior_code, bl.name_vn, bg.name_vn;

-- Refresh daily via cron
CREATE INDEX ON mv_behavior_analytics(behavior_code);
CREATE INDEX ON mv_behavior_analytics(total_incidents DESC);
```

---

### 2. **Thêm Audit Trail cho Behavior Changes**

**Use case:** Track khi nào behavior được updated (solutions, explanations thay đổi).

```sql
CREATE TABLE BEHAVIOR_LIBRARY_HISTORY (
  id UUID PRIMARY KEY,
  behavior_library_id UUID NOT NULL,
  field_changed VARCHAR(100),
  old_value JSONB,
  new_value JSONB,
  changed_by UUID,
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (behavior_library_id) REFERENCES BEHAVIOR_LIBRARY(id),
  FOREIGN KEY (changed_by) REFERENCES TEACHERS(id)
);

CREATE INDEX idx_behavior_history_behavior ON BEHAVIOR_LIBRARY_HISTORY(behavior_library_id);
CREATE INDEX idx_behavior_history_changed_at ON BEHAVIOR_LIBRARY_HISTORY(changed_at DESC);
```

---

### 3. **Thêm Search Ranking/Relevance**

**Use case:** Khi search "ăn", hiển thị "Ăn vạ" trước "Nhạy cảm với âm thanh" (dù cả 2 đều match).

```sql
-- Add ranking column
ALTER TABLE BEHAVIOR_LIBRARY
ADD COLUMN search_rank INTEGER DEFAULT 0;

-- Update based on usage
UPDATE BEHAVIOR_LIBRARY
SET search_rank = usage_count * 10 +
  CASE
    WHEN last_used_at > NOW() - INTERVAL '7 days' THEN 50
    WHEN last_used_at > NOW() - INTERVAL '30 days' THEN 20
    ELSE 0
  END;

-- Search query with ranking
SELECT *,
  ts_rank(keywords_tsvector, query) as relevance
FROM BEHAVIOR_LIBRARY,
  to_tsquery('vietnamese', 'ăn') as query
WHERE keywords_tsvector @@ query
ORDER BY relevance DESC, search_rank DESC, usage_count DESC;
```

---

## 📋 CHECKLIST TRIỂN KHAI

### Priority 1 - Critical (Trước khi launch)

- [ ] Add composite index `idx_behavior_group_active_usage`
- [ ] Implement full-text search với `keywords_tsvector`
- [ ] Add JSON structure validation constraints
- [ ] Optimize N+1 queries trong API endpoints

### Priority 2 - Important (Sprint tiếp theo)

- [ ] Denormalize group statistics vào `BEHAVIOR_GROUPS`
- [ ] Create scheduled job refresh stats daily
- [ ] Add materialized view cho analytics
- [ ] Implement behavior_code → display_id transform

### Priority 3 - Enhancement (Future)

- [ ] Add audit trail table `BEHAVIOR_LIBRARY_HISTORY`
- [ ] Implement search ranking algorithm
- [ ] Add A/B testing infrastructure cho solutions effectiveness
- [ ] Multi-language support (currently VN + EN, có thể thêm languages khác)

---

## 🎯 KẾT LUẬN

### ✅ Database Design Overall Rating: **9.2/10**

**Điểm mạnh:**

- ✅ Cấu trúc 2-tier (Groups → Behaviors) hoàn hảo
- ✅ JSON schema phù hợp 100% với yêu cầu
- ✅ Indexes đầy đủ cho basic operations
- ✅ Business logic validation tốt
- ✅ Scalable cho 127+ behaviors và future growth

**Cần cải thiện:**

- ⚠️ Performance optimization (composite indexes, denormalization)
- ⚠️ Full-text search enhancement
- ⚠️ JSON validation stricter

**Recommendation:**
Database design hiện tại **ĐÃ SẴN SÀNG** cho development với một số điều chỉnh nhỏ ở Priority 1. Có thể bắt đầu implement API ngay, apply improvements incrementally.

---

## 📚 APPENDIX: Sample Queries

### Query 1: Dictionary Home (Wireframe 18)

```sql
-- Get all groups with behavior counts
SELECT
  bg.*,
  COUNT(DISTINCT bl.id) as total_behaviors,
  COUNT(DISTINCT tf.id) FILTER (WHERE tf.teacher_id = $1) as favorited_count
FROM BEHAVIOR_GROUPS bg
LEFT JOIN BEHAVIOR_LIBRARY bl ON bg.id = bl.behavior_group_id AND bl.is_active = TRUE
LEFT JOIN TEACHER_FAVORITES tf ON bl.id = tf.behavior_library_id
GROUP BY bg.id
ORDER BY bg.order_index;

-- Get teacher's favorites
SELECT bl.*, bg.name_vn as group_name
FROM BEHAVIOR_LIBRARY bl
JOIN TEACHER_FAVORITES tf ON bl.id = tf.behavior_library_id
JOIN BEHAVIOR_GROUPS bg ON bl.behavior_group_id = bg.id
WHERE tf.teacher_id = $1 AND bl.is_active = TRUE
ORDER BY tf.created_at DESC
LIMIT 3;

-- Get trending behaviors (this week vs last week)
WITH weekly_stats AS (
  SELECT
    bl.id,
    COUNT(*) FILTER (WHERE bi.occurred_at >= NOW() - INTERVAL '7 days') as this_week,
    COUNT(*) FILTER (WHERE bi.occurred_at >= NOW() - INTERVAL '14 days'
                     AND bi.occurred_at < NOW() - INTERVAL '7 days') as last_week
  FROM BEHAVIOR_LIBRARY bl
  LEFT JOIN BEHAVIOR_INCIDENTS bi ON bl.id = bi.behavior_library_id
  GROUP BY bl.id
)
SELECT bl.*, ws.this_week, ws.last_week,
  CASE
    WHEN ws.last_week > 0 THEN
      ROUND((ws.this_week - ws.last_week)::numeric / ws.last_week * 100)
    ELSE 0
  END as trend_percentage
FROM BEHAVIOR_LIBRARY bl
JOIN weekly_stats ws ON bl.id = ws.id
WHERE bl.is_active = TRUE AND ws.this_week > 0
ORDER BY trend_percentage DESC, ws.this_week DESC
LIMIT 5;
```

### Query 2: Group Detail (Wireframe 18.5)

```sql
-- Get group with statistics
SELECT
  bg.*,
  COUNT(DISTINCT bl.id) as total_behaviors,
  COUNT(DISTINCT bi.id) as total_incidents_all_time,
  COUNT(DISTINCT bi.id) FILTER (WHERE bi.occurred_at >= NOW() - INTERVAL '7 days') as incidents_this_week,
  COUNT(DISTINCT bi.id) FILTER (WHERE bi.occurred_at >= NOW() - INTERVAL '14 days'
                                 AND bi.occurred_at < NOW() - INTERVAL '7 days') as incidents_last_week
FROM BEHAVIOR_GROUPS bg
LEFT JOIN BEHAVIOR_LIBRARY bl ON bg.id = bl.behavior_group_id
LEFT JOIN BEHAVIOR_INCIDENTS bi ON bl.id = bi.behavior_library_id
WHERE bg.id = $1
GROUP BY bg.id;

-- Get behaviors in group
SELECT
  bl.*,
  EXISTS(
    SELECT 1 FROM TEACHER_FAVORITES tf
    WHERE tf.behavior_library_id = bl.id AND tf.teacher_id = $2
  ) as is_favorite,
  COUNT(DISTINCT bi.id) as system_usage,
  COUNT(DISTINCT bi.id) FILTER (
    WHERE bi.recorded_by = $2
  ) as personal_usage
FROM BEHAVIOR_LIBRARY bl
LEFT JOIN BEHAVIOR_INCIDENTS bi ON bl.id = bi.behavior_library_id
WHERE bl.behavior_group_id = $1 AND bl.is_active = TRUE
GROUP BY bl.id
ORDER BY system_usage DESC;
```

### Query 3: Behavior Detail (Wireframe 19)

```sql
-- Get full behavior details
SELECT
  bl.*,
  bg.name_vn as group_name,
  bg.icon as group_icon,
  EXISTS(
    SELECT 1 FROM TEACHER_FAVORITES tf
    WHERE tf.behavior_library_id = bl.id AND tf.teacher_id = $2
  ) as is_favorite,
  COUNT(DISTINCT bi.id) as system_occurrences,
  COUNT(DISTINCT bi.id) FILTER (WHERE bi.recorded_by = $2) as personal_occurrences,
  COUNT(DISTINCT s.student_id) FILTER (
    WHERE s.teacher_id = $2
  ) as affected_students_count
FROM BEHAVIOR_LIBRARY bl
JOIN BEHAVIOR_GROUPS bg ON bl.behavior_group_id = bg.id
LEFT JOIN BEHAVIOR_INCIDENTS bi ON bl.id = bi.behavior_library_id
LEFT JOIN SESSION_LOGS sl ON bi.session_log_id = sl.id
LEFT JOIN SESSIONS se ON sl.session_id = se.id
LEFT JOIN STUDENTS s ON se.student_id = s.id
WHERE bl.id = $1
GROUP BY bl.id, bg.name_vn, bg.icon;
```

### Query 4: Search Behaviors

```sql
-- Full-text search with ranking
SELECT
  bl.*,
  bg.name_vn as group_name,
  ts_rank(keywords_tsvector, query) as relevance,
  EXISTS(
    SELECT 1 FROM TEACHER_FAVORITES tf
    WHERE tf.behavior_library_id = bl.id AND tf.teacher_id = $2
  ) as is_favorite
FROM BEHAVIOR_LIBRARY bl
JOIN BEHAVIOR_GROUPS bg ON bl.behavior_group_id = bg.id,
  to_tsquery('vietnamese', $1) as query
WHERE bl.is_active = TRUE
  AND bl.keywords_tsvector @@ query
ORDER BY relevance DESC, bl.usage_count DESC
LIMIT 20;
```

---

**Người đánh giá:** GitHub Copilot  
**Ngày:** 2025-11-04
