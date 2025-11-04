# ERD & Database Relationship Diagram - Educare Connect

Sơ đồ quan hệ cơ sở dữ liệu chi tiết với visualization đầy đủ.

---

## 📊 COMPLETE ERD DIAGRAM

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                        EDUCARE CONNECT DATABASE SCHEMA                          │
│                                  16 TABLES                                      │
└────────────────────────────────────────────────────────────────────────────────┘


┌─────────────────────────┐
│       TEACHERS          │
│ ─────────────────────── │
│ 🔑 id (UUID)            │
│    email (unique)       │
│    full_name            │
│    phone                │
│    school               │
│    avatar_url           │
│    password (hashed)    │
│    is_verified          │
│    two_fa               │
│    created_at           │
│    updated_at           │
│    last_login           │
└────┬────────────────────┘
     │ 1
     │ manages
     │ N
     ▼
┌─────────────────────────┐
│       STUDENTS          │
│ ─────────────────────── │
│ 🔑 id (UUID)            │
│ 🔗 teacher_id (FK)      │
│    full_name            │
│    nickname             │
│    age                  │
│    gender               │
│    avatar_url           │
│    status ✓             │ (active, paused, archived)
│    notes                │
│    created_at           │
│    updated_at           │
└────┬────────────────────┘
     │ 1
     │ has
     │ N
     ▼
┌───────────────────────────────┐
│         SESSIONS              │
│ ───────────────────────────── │
│ 🔑 id (UUID)                  │
│ 🔗 student_id (FK)            │
│    date                       │
│    time_slot ✓                │ (morning, afternoon, evening)
│    start_time                 │
│    end_time                   │
│    notes                      │
│    creation_method ✓          │ (manual, ai)
│    status ✓                   │ (pending, completed)
│    has_evaluation             │
│    created_at                 │
│    updated_at                 │
└───┬───────────────────────┬───┘
    │ 1                     │ 1
    │ contains              │ has (optional)
    │ N                     │ 1
    ▼                       ▼
┌─────────────────────────┐ ┌────────────────────────────┐
│   SESSION_CONTENTS      │ │      SESSION_LOGS          │
│ ─────────────────────── │ │ ────────────────────────── │
│ 🔑 id (UUID)            │ │ 🔑 id (UUID)               │
│ 🔗 session_id (FK)      │ │ 🔗 session_id (FK, unique) │
│ 🔗 content_library_id   │ │    logged_at               │
│    name                 │ │    completed_at            │
│    domain ✓             │ │    mood ✓                  │
│    description          │ │    cooperation_level (1-5) │
│    order_index          │ │    focus_level (1-5)       │
│    notes                │ │    independence_level(1-5) │
│    created_at           │ │    attitude_notes          │
│    updated_at           │ │    teacher_notes_text      │
└───┬─────────────────────┘ │    created_at              │
    │ 1                     │    updated_at              │
    │ has                   └────┬───────────────┬───────┘
    │ N                          │ 1             │ 1
    ▼                            │ has           │ evaluates
┌─────────────────────────┐      │ N             │ N
│    CONTENT_GOALS        │      ▼               ▼
│ ─────────────────────── │ ┌────────────────────────────┐
│ 🔑 id (UUID)            │ │  LOG_MEDIA_ATTACHMENTS     │
│ 🔗 session_content_id   │ │ ────────────────────────── │
│    description          │ │ 🔑 id (UUID)               │
│    order_index          │ │ 🔗 session_log_id (FK)     │
│    created_at           │ │    type ✓ (image/video/audio)|
│    updated_at           │ │    url                     │
└───┬─────────────────────┘ │    filename                │
    │ 1                     │    file_size               │
    │ evaluated by          │    duration                │
    │ 1                     │    created_at              │
    ▼                       └────────────────────────────┘
┌─────────────────────────┐
│   GOAL_EVALUATIONS      │      ┌────────────────────────────┐
│ ─────────────────────── │      │   BEHAVIOR_INCIDENTS       │
│ 🔑 id (UUID)            │      │ ────────────────────────── │
│ 🔗 session_log_id (FK)  │◄─┐   │ 🔑 id (UUID)               │
│ 🔗 content_goal_id (FK) │  │   │ 🔗 session_log_id (FK)     │
│    status ✓             │  │   │ 🔗 behavior_library_id(FK) │
│    notes                │  │   │    antecedent              │
│    created_at           │  │   │    behavior_description    │
│    updated_at           │  │   │    consequence             │
└─────────────────────────┘  └───┤    severity_level (1-5)    │
                                 │    occurred_at             │
                                 │    notes                   │
                                 │    created_at              │
                                 │    updated_at              │
                                 └────┬───────────────────────┘
                                      │ N
                                      │ references
                                      │ 1
                                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    BEHAVIOR SYSTEM (NEW)                    │
└─────────────────────────────────────────────────────────────┘

┌──────────────────────────────┐
│     BEHAVIOR_GROUPS          │
│ ──────────────────────────── │
│ 🔑 id (UUID)                 │
│    name_vn ⭐                │ "CHỐNG ĐỐI & BƯỚNG BỈNH"
│    name_en                   │ "Opposition & Defiance"
│    description               │
│    icon                      │ 😤, 👊, 👂
│    common_tips 📋 (JSON)     │ Array of tips
│    order_index               │
│    is_active                 │
│    created_at                │
│    updated_at                │
└───┬──────────────────────────┘
    │ 1
    │ contains
    │ N
    ▼
┌──────────────────────────────────────────────────────────┐
│            BEHAVIOR_LIBRARY (Enhanced)                   │
│ ──────────────────────────────────────────────────────── │
│ 🔑 id (UUID)                                             │
│ 🔗 behavior_group_id (FK)                                │
│    behavior_id ⭐ (unique)   "1.1", "1.2", "2.1"         │
│    name_vn                   "Ăn vạ"                     │
│    name_en                   "Tantrums"                  │
│ ─────────────────────────────────────────────────────── │
│ 🔍 keywords 📋 (JSON)         [10-15 Vietnamese keywords]│
│    ↳ Backend search only, not displayed in UI           │
│ ─────────────────────────────────────────────────────── │
│ 📄 manifestation (TEXT)      Clinical description       │
│    ↳ Observable behavior presentation                   │
│ ─────────────────────────────────────────────────────── │
│ 🔍 explanation 📋 (JSON)      [{title, description}]    │
│    ↳ 2-4 theoretical frameworks explaining WHY          │
│    ↳ Example: "Nhu cầu Giao tiếp", "Giới hạn Sinh lý"   │
│ ─────────────────────────────────────────────────────── │
│ 💡 solutions 📋 (JSON)        [{title, description}]    │
│    ↳ 4-5 evidence-based intervention strategies         │
│    ↳ Example: "Giữ bình tĩnh", "Phớt lờ có kế hoạch"    │
│ ─────────────────────────────────────────────────────── │
│ 📚 sources 📋 (JSON)          [Academic citations]      │
│    ↳ 2+ peer-reviewed research (APA format)             │
│ ─────────────────────────────────────────────────────── │
│    icon                      Emoji representation        │
│    is_active                 Display flag                │
│    usage_count               Auto-increment on use       │
│    created_at                                            │
│    updated_at                                            │
└────┬────────────────────────────────────────────┬────────┘
     │ N                                          │ N
     │ favorited by                               │ used in
     │ N                                          │ N
     ▼                                            │
┌─────────────────────────────┐                  │
│   TEACHER_FAVORITES         │                  │
│ ─────────────────────────── │                  │
│ 🔑 id (UUID)                │                  │
│ 🔗 teacher_id (FK)          │◄─────────────────┘
│ 🔗 behavior_library_id (FK) │
│    created_at               │
└─────────────────────────────┘


┌─────────────────────────────────────────────────────────────┐
│                    SUPPORTING TABLES                         │
└─────────────────────────────────────────────────────────────┘

┌──────────────────────────┐  ┌─────────────────────────────┐
│   CONTENT_LIBRARY        │  │     USER_SETTINGS           │
│ ──────────────────────── │  │ ─────────────────────────── │
│ 🔑 id (UUID)             │  │ 🔑 id (UUID)                │
│ 🔗 teacher_id (FK)       │  │ 🔗 teacher_id (FK)          │
│    name                  │  │    key (unique with teacher)│
│    domain ✓              │  │    value (JSON)             │
│    description           │  │    created_at               │
│    default_goals 📋(JSON)│  │    updated_at               │
│    is_template           │  └─────────────────────────────┘
│    usage_count           │
│    created_at            │  ┌─────────────────────────────┐
│    updated_at            │  │    BACKUP_HISTORY           │
└──────────────────────────┘  │ ─────────────────────────── │
                              │ 🔑 id (UUID)                │
┌──────────────────────────┐  │ 🔗 teacher_id (FK)          │
│    AI_PROCESSING         │  │    backup_type ✓            │
│ ──────────────────────── │  │    file_url                 │
│ 🔑 id (UUID)             │  │    file_size                │
│ 🔗 teacher_id (FK)       │  │    status ✓                 │
│ 🔗 student_id (FK)       │  │    created_at               │
│    file_url              │  └─────────────────────────────┘
│    file_type             │
│    text_content          │
│    processing_status ✓   │
│    progress (0-100)      │
│    result_sessions 📋    │
│    error_message         │
│    created_at            │
│    completed_at          │
└──────────────────────────┘


LEGEND:
─────────────────────────────────────────────────────────────
🔑 = Primary Key (UUID)
🔗 = Foreign Key
✓  = ENUM/CHECK constraint
📋 = JSON/JSONB field
⭐ = Unique constraint
1  = One (relationship)
N  = Many (relationship)
```

---

## 📋 TABLE RELATIONSHIPS SUMMARY

### Core Data Flow

```
TEACHER
  └─► STUDENT (1:N)
        └─► SESSION (1:N)
              ├─► SESSION_CONTENT (1:N)
              │     └─► CONTENT_GOAL (1:N)
              │           └─► GOAL_EVALUATION (1:1 via session_log)
              │
              └─► SESSION_LOG (1:1)
                    ├─► LOG_MEDIA_ATTACHMENT (1:N)
                    ├─► GOAL_EVALUATION (1:N)
                    └─► BEHAVIOR_INCIDENT (1:N)
```

### Behavior System Flow

```
BEHAVIOR_GROUP (3 groups)
  └─► BEHAVIOR_LIBRARY (127+ behaviors)
        ├─► BEHAVIOR_INCIDENT (used in sessions)
        └─► TEACHER_FAVORITE (bookmarked by teachers)
```

### Supporting Systems

```
TEACHER
  ├─► CONTENT_LIBRARY (templates)
  ├─► USER_SETTINGS (preferences)
  ├─► BACKUP_HISTORY (data exports)
  ├─► AI_PROCESSING (AI sessions)
  └─► TEACHER_FAVORITE (bookmarks)
```

---

## 🔗 DETAILED RELATIONSHIPS

### 1. One-to-Many (1:N)

| Parent Table        | Child Table           | Relationship                          |
| ------------------- | --------------------- | ------------------------------------- |
| TEACHERS            | STUDENTS              | 1 teacher manages N students          |
| STUDENTS            | SESSIONS              | 1 student has N sessions              |
| SESSIONS            | SESSION_CONTENTS      | 1 session contains N contents         |
| SESSION_CONTENTS    | CONTENT_GOALS         | 1 content has N goals                 |
| SESSION_LOGS        | LOG_MEDIA_ATTACHMENTS | 1 log has N media files               |
| SESSION_LOGS        | GOAL_EVALUATIONS      | 1 log evaluates N goals               |
| SESSION_LOGS        | BEHAVIOR_INCIDENTS    | 1 log records N behavior incidents    |
| **BEHAVIOR_GROUPS** | **BEHAVIOR_LIBRARY**  | 1 group contains N behaviors          |
| BEHAVIOR_LIBRARY    | BEHAVIOR_INCIDENTS    | 1 behavior used in N incidents        |
| TEACHERS            | CONTENT_LIBRARY       | 1 teacher creates N content templates |
| TEACHERS            | BACKUP_HISTORY        | 1 teacher has N backups               |
| TEACHERS            | AI_PROCESSING         | 1 teacher has N AI processing jobs    |

### 2. One-to-One (1:1)

| Table 1  | Table 2      | Relationship                          |
| -------- | ------------ | ------------------------------------- |
| SESSIONS | SESSION_LOGS | 1 session has 1 log (or none/pending) |

**Note:** This is actually optional 1:1 since not all sessions have been evaluated yet.

### 3. Many-to-Many (N:N)

| Table 1          | Junction Table    | Table 2          | Relationship                             |
| ---------------- | ----------------- | ---------------- | ---------------------------------------- |
| TEACHERS         | TEACHER_FAVORITES | BEHAVIOR_LIBRARY | Teachers can favorite N behaviors        |
| BEHAVIOR_LIBRARY | TEACHER_FAVORITES | TEACHERS         | Behaviors can be favorited by N teachers |

---

## 🎯 KEY DATABASE FEATURES

### 1. Hierarchical Behavior ID System

```
Group 1: CHỐNG ĐỐI & BƯỚNG BỈNH
  ├─ 1.1 Ăn vạ (Tantrums)
  └─ 1.2 Từ chối làm theo yêu cầu (Non-compliance)

Group 2: HÀNH VI GÂY HẤN
  └─ 2.1 Đánh bạn (Physical Aggression)

Group 3: VẤN ĐỀ VỀ GIÁC QUAN
  └─ 3.1 Nhạy cảm với âm thanh (Auditory Hypersensitivity)
```

**Benefits:**

- Clear organization and navigation
- Scales well (can add 1.3, 1.4, etc.)
- Human-readable IDs
- Supports wireframe 18.5 (group list view)

### 2. Evidence-Based Behavior Structure

```json
{
  "behavior_id": "1.1",
  "keywords": ["ăn vạ", "la hét", ...],        // 10-15 for search
  "manifestation": "Trẻ bộc phát...",          // Clinical description
  "explanation": [                              // 2-4 frameworks
    {"title": "Nhu cầu Giao tiếp", "description": "..."},
    {"title": "Giới hạn Sinh lý", "description": "..."}
  ],
  "solutions": [                                // 4-5 strategies
    {"title": "Giữ bình tĩnh", "description": "..."},
    {"title": "Phớt lờ có kế hoạch", "description": "..."}
  ],
  "sources": [                                  // 2+ citations
    "Potegal, M., & Davidson, R. J. (2003)...",
    "Sroufe, L. A. (2000)..."
  ]
}
```

**Benefits:**

- Supports wireframe 19 detail view
- Evidence-based practice
- Multiple theoretical perspectives
- Academic credibility

### 3. Full-Text Search on Keywords

```sql
-- PostgreSQL GIN index on keywords JSON array
CREATE INDEX idx_behavior_keywords ON behavior_library USING GIN (keywords);

-- Search query
SELECT * FROM behavior_library
WHERE keywords::text ILIKE '%la hét%'
  OR keywords::text ILIKE '%khóc%';
```

**Benefits:**

- Fast keyword search (10-15 keywords per behavior)
- Supports Vietnamese language
- No need to display keywords in UI
- Backend-only filtering

### 4. Usage Tracking

```sql
-- Auto-increment usage_count when behavior is used
CREATE OR REPLACE FUNCTION update_behavior_usage_count()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE behavior_library
  SET usage_count = usage_count + 1
  WHERE id = NEW.behavior_library_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_behavior_usage
  AFTER INSERT ON behavior_incidents
  FOR EACH ROW
  EXECUTE FUNCTION update_behavior_usage_count();
```

**Benefits:**

- Trending behaviors (wireframe 18)
- Popularity ranking
- Data-driven insights

### 5. Group Statistics

```sql
-- Get group stats with aggregation
SELECT
  bg.id,
  bg.name_vn,
  bg.icon,
  COUNT(DISTINCT b.id) as total_behaviors,
  SUM(b.usage_count) as total_usage
FROM behavior_groups bg
LEFT JOIN behavior_library b ON bg.id = b.behavior_group_id
WHERE bg.is_active = true
  AND b.is_active = true
GROUP BY bg.id, bg.name_vn, bg.icon
ORDER BY bg.order_index;
```

**Benefits:**

- Supports wireframe 18.5 (group list)
- Real-time statistics
- Group-level insights

---

## 📐 NORMALIZATION LEVEL

### Current Schema: **3NF (Third Normal Form)**

**Characteristics:**

- ✅ No repeating groups (1NF)
- ✅ All non-key attributes depend on primary key (2NF)
- ✅ No transitive dependencies (3NF)

**JSON Fields:**

- `keywords`, `explanation`, `solutions`, `sources` are intentionally denormalized for:
  - Performance (avoid multiple joins)
  - Flexibility (schema evolution)
  - JSON query capabilities (PostgreSQL/Supabase)

---

## 🔍 INDEXES OVERVIEW

### Primary Indexes (PK)

Every table has UUID primary key with automatic index.

### Foreign Key Indexes

```sql
-- All foreign keys have indexes
idx_students_teacher_id
idx_sessions_student_id
idx_session_contents_session_id
idx_content_goals_session_content_id
idx_session_logs_session_id
idx_media_log_id
idx_goal_eval_log_id
idx_goal_eval_goal_id
idx_incidents_log_id
idx_incidents_behavior_id
idx_behavior_group_id          -- NEW
idx_favorites_teacher
idx_favorites_behavior
idx_content_lib_teacher
idx_settings_teacher_key
idx_backup_teacher
idx_ai_teacher
```

### Search/Filter Indexes

```sql
-- Email search
idx_teachers_email

-- Status filters
idx_students_status
idx_sessions_status

-- Date queries
idx_sessions_date
idx_sessions_student_date (composite)

-- Behavior system (NEW)
idx_behavior_id
idx_behavior_groups_order
idx_behavior_groups_active
idx_behavior_active
idx_behavior_usage

-- Full-text search (PostgreSQL)
idx_behavior_keywords (GIN)
```

### Performance Indexes

```sql
-- Sorting
idx_sessions_date DESC
idx_behavior_usage DESC
idx_backup_created DESC
idx_ai_created DESC

-- Composite
idx_sessions_student_date (student_id, date)
idx_settings_teacher_key (teacher_id, key)
```

---

## 🔐 CONSTRAINTS

### Unique Constraints

```sql
teachers.email
behavior_library.behavior_id
goal_evaluations(session_log_id, content_goal_id)
teacher_favorites(teacher_id, behavior_library_id)
user_settings(teacher_id, key)
```

### Check Constraints

```sql
-- ENUMs
students.gender IN ('male', 'female')
students.status IN ('active', 'paused', 'archived')
sessions.time_slot IN ('morning', 'afternoon', 'evening')
sessions.creation_method IN ('manual', 'ai')
sessions.status IN ('pending', 'completed')
session_logs.mood IN ('very_difficult', 'difficult', 'normal', 'good', 'very_good')
session_contents.domain IN ('cognitive', 'motor', 'language', 'social', 'self_care')
goal_evaluations.status IN ('achieved', 'not_achieved', 'not_applicable')

-- Ranges
session_logs.cooperation_level BETWEEN 1 AND 5
session_logs.focus_level BETWEEN 1 AND 5
session_logs.independence_level BETWEEN 1 AND 5
behavior_incidents.severity_level BETWEEN 1 AND 5
ai_processing.progress BETWEEN 0 AND 100

-- Logic
sessions.end_time > sessions.start_time
```

### Foreign Key Constraints

```sql
-- CASCADE on delete (data cleanup)
students.teacher_id ON DELETE CASCADE
sessions.student_id ON DELETE CASCADE
session_contents.session_id ON DELETE CASCADE
content_goals.session_content_id ON DELETE CASCADE
session_logs.session_id ON DELETE CASCADE
log_media_attachments.session_log_id ON DELETE CASCADE
goal_evaluations.session_log_id ON DELETE CASCADE
behavior_incidents.session_log_id ON DELETE CASCADE
teacher_favorites.teacher_id ON DELETE CASCADE

-- SET NULL (preserve data)
ai_processing.student_id ON DELETE SET NULL
content_library.teacher_id ON DELETE SET NULL (for system templates)

-- RESTRICT (prevent deletion if used)
behavior_library.behavior_group_id ON DELETE RESTRICT
behavior_incidents.behavior_library_id ON DELETE RESTRICT
```

---

## 📊 SAMPLE QUERIES

### 1. Get Behavior with Full Details

```sql
SELECT
  b.*,
  bg.name_vn as group_name,
  bg.name_en as group_name_en,
  bg.icon as group_icon,
  bg.common_tips as group_tips
FROM behavior_library b
JOIN behavior_groups bg ON b.behavior_group_id = bg.id
WHERE b.behavior_id = '1.1'
  AND b.is_active = true;
```

### 2. Search Behaviors by Keyword

```sql
SELECT
  b.behavior_id,
  b.name_vn,
  b.name_en,
  bg.name_vn as group_name,
  b.usage_count
FROM behavior_library b
JOIN behavior_groups bg ON b.behavior_group_id = bg.id
WHERE b.keywords::text ILIKE '%ăn vạ%'
  AND b.is_active = true
ORDER BY b.usage_count DESC;
```

### 3. Get Group with Behaviors

```sql
SELECT
  bg.*,
  json_agg(
    json_build_object(
      'behavior_id', b.behavior_id,
      'name_vn', b.name_vn,
      'name_en', b.name_en,
      'manifestation', b.manifestation,
      'usage_count', b.usage_count
    ) ORDER BY b.behavior_id
  ) as behaviors
FROM behavior_groups bg
LEFT JOIN behavior_library b ON bg.id = b.behavior_group_id
WHERE bg.id = 'group_1'
  AND bg.is_active = true
  AND (b.is_active = true OR b.id IS NULL)
GROUP BY bg.id;
```

### 4. Trending Behaviors (Weekly)

```sql
SELECT
  b.behavior_id,
  b.name_vn,
  bg.name_vn as group_name,
  COUNT(*) as count,
  ROUND(
    (COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY b.behavior_id)) * 100.0 /
    NULLIF(LAG(COUNT(*)) OVER (ORDER BY b.behavior_id), 0),
    0
  ) as trend_percentage
FROM behavior_incidents bi
JOIN behavior_library b ON bi.behavior_library_id = b.id
JOIN behavior_groups bg ON b.behavior_group_id = bg.id
WHERE bi.occurred_at >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY b.id, b.behavior_id, b.name_vn, bg.name_vn
ORDER BY count DESC
LIMIT 5;
```

### 5. Teacher's Favorite Behaviors

```sql
SELECT
  b.behavior_id,
  b.name_vn,
  b.name_en,
  bg.name_vn as group_name,
  b.manifestation,
  COUNT(DISTINCT bi.id) as usage_count_system,
  COUNT(DISTINCT CASE
    WHEN sl.session_id IN (
      SELECT id FROM sessions WHERE student_id IN (
        SELECT id FROM students WHERE teacher_id = :teacher_id
      )
    ) THEN bi.id
  END) as usage_count_personal
FROM teacher_favorites tf
JOIN behavior_library b ON tf.behavior_library_id = b.id
JOIN behavior_groups bg ON b.behavior_group_id = bg.id
LEFT JOIN behavior_incidents bi ON b.id = bi.behavior_library_id
LEFT JOIN session_logs sl ON bi.session_log_id = sl.id
WHERE tf.teacher_id = :teacher_id
  AND b.is_active = true
GROUP BY b.id, b.behavior_id, b.name_vn, b.name_en, bg.name_vn, b.manifestation
ORDER BY tf.created_at DESC;
```

---

_Complete ERD documentation for Educare Connect with enhanced behavior system based on wireframes 18, 18.5, 19 and data.md structure._
