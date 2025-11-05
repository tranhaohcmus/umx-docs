Vâng, tôi sẽ viết nội dung đầy đủ cho các file PART4, PART5, và PART6. Bạn có thể tự tạo file và copy nội dung vào.

---

# 📝 PART 4 - CONTENT LIBRARY & TEMPLATES TESTS

```markdown
# 📝 API TEST CASES CHI TIẾT - PART 4
**Version:** 1.0  
**Date:** 2025-11-05  
**Author:** tranhaohcmus  
**Test Coverage:** Content Library & Templates (Section 6)

---

## MỤC LỤC PART 4

- [6. CONTENT LIBRARY & TEMPLATES TESTS](#6-content-library--templates-tests)
  - [6.1 Create Template](#61-create-template)
  - [6.2 List Templates](#62-list-templates)
  - [6.3 Template Details](#63-template-details)
  - [6.4 Update Template](#64-update-template)
  - [6.5 Delete Template](#65-delete-template)
  - [6.6 Ratings Management](#66-ratings-management)
  - [6.7 Search & Filters](#67-search--filters)
  - [6.8 Template Usage](#68-template-usage)
  - [6.9 Integration Tests](#69-integration-tests)

---

## 6. CONTENT LIBRARY & TEMPLATES TESTS

### 6.1 Create Template - Happy Path with Default Goals

**Test ID:** `CTL-001`  
**Priority:** High  
**Category:** Content Library

**Test Objective:**  
Verify creation of content template with default goals stored in JSONB

**Preconditions:**
- Teacher is authenticated
- Valid domain and difficulty level

**Test Steps:**

1. **Send Request:**
   ```http
   POST /api/content-library
   Authorization: Bearer {{access_token}}
   Content-Type: application/json

   {
     "title": "Nhận biết màu sắc cơ bản",
     "domain": "cognitive",
     "description": "Dạy trẻ nhận biết 4 màu: đỏ, vàng, xanh lá, xanh dương",
     "target_age_min": 3,
     "target_age_max": 6,
     "difficulty_level": "beginner",
     "materials_needed": "Thẻ màu, đồ chơi nhiều màu, tranh vẽ",
     "estimated_duration": 30,
     "instructions": "Bước 1: Giới thiệu từng màu một...\nBước 2: Cho trẻ thực hành chỉ màu...",
     "tips": "Sử dụng đồ vật quen thuộc với trẻ",
     "default_goals": [
       {
         "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
         "order": 1
       },
       {
         "description": "Trẻ có thể nói tên màu",
         "order": 2
       },
       {
         "description": "Trẻ có thể phân loại đồ vật theo màu",
         "order": 3
       }
     ],
     "tags": ["màu sắc", "nhận biết", "cognitive"],
     "is_public": false
   }
   ```

2. **Verify Response:**
   - Status code: `201 Created`
   - Response structure:
     ```json
     {
       "success": true,
       "template": {
         "id": "<uuid>",
         "teacher_id": "<uuid>",
         "code": "CTL_TH_001",
         "title": "Nhận biết màu sắc cơ bản",
         "domain": "cognitive",
         "description": "Dạy trẻ nhận biết 4 màu...",
         "target_age_min": 3,
         "target_age_max": 6,
         "difficulty_level": "beginner",
         "materials_needed": "Thẻ màu, đồ chơi nhiều màu, tranh vẽ",
         "estimated_duration": 30,
         "instructions": "Bước 1: Giới thiệu từng màu một...",
         "tips": "Sử dụng đồ vật quen thuộc với trẻ",
         "default_goals": [
           {
             "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
             "order": 1
           },
           {
             "description": "Trẻ có thể nói tên màu",
             "order": 2
           },
           {
             "description": "Trẻ có thể phân loại đồ vật theo màu",
             "order": 3
           }
         ],
         "tags": ["màu sắc", "nhận biết", "cognitive"],
         "is_template": true,
         "is_public": false,
         "usage_count": 0,
         "rating_avg": 0,
         "rating_count": 0,
         "created_at": "2025-11-05T13:40:45Z",
         "updated_at": "2025-11-05T13:40:45Z"
       }
     }
     ```

**Expected Result:**
- ✅ Template created with auto-generated code (CTL_TH_XXX)
- ✅ `default_goals` stored as JSONB array
- ✅ `tags` stored as JSONB array
- ✅ `is_template` = true
- ✅ `usage_count` = 0 initially
- ✅ `teacher_id` = authenticated user

**Database Validation:**
```sql
SELECT * FROM content_library 
WHERE id = :template_id;

-- Verify JSONB structure
SELECT 
  jsonb_array_length(default_goals) AS goals_count,
  jsonb_array_length(tags) AS tags_count
FROM content_library 
WHERE id = :template_id;
-- Should return: goals_count = 3, tags_count = 3
```

---

### 6.2 Create Template - Validation: Invalid Domain

**Test ID:** `CTL-002`  
**Priority:** High  
**Category:** Content Library - Validation

**Test Steps:**

1. **Send with invalid domain:**
   ```http
   POST /api/content-library
   Content-Type: application/json

   {
     "title": "Test Template",
     "domain": "invalid_domain",
     "difficulty_level": "beginner"
   }
   ```

2. **Expected Error:**
   ```json
   {
     "success": false,
     "error": "VALIDATION_ERROR",
     "message": "Domain không hợp lệ",
     "details": {
       "field": "domain",
       "value_received": "invalid_domain",
       "allowed_values": ["cognitive", "motor", "language", "social", "self_care"]
     }
   }
   ```
   - Status: `400 Bad Request`

**Database Constraint:**
```sql
ALTER TABLE content_library 
ADD CONSTRAINT chk_content_domain 
CHECK (domain IN ('cognitive', 'motor', 'language', 'social', 'self_care'));
```

---

### 6.3 Create Template - Validation: Invalid Age Range

**Test ID:** `CTL-003`  
**Priority:** Medium  
**Category:** Content Library - Validation

**Test Cases:**

| Test Data | Expected Result |
|-----------|----------------|
| `target_age_min: 1` | Error: Age < 2 |
| `target_age_max: 19` | Error: Age > 18 |
| `target_age_min: 7, target_age_max: 5` | Error: min > max |
| `target_age_min: 3, target_age_max: 6` | Success |

**Expected Error (min > max):**
```json
{
  "success": false,
  "error": "INVALID_AGE_RANGE",
  "message": "Độ tuổi tối thiểu phải nhỏ hơn hoặc bằng độ tuổi tối đa",
  "details": {
    "target_age_min": 7,
    "target_age_max": 5
  }
}
```

---

### 6.4 Create Template - Validation: Invalid Difficulty

**Test ID:** `CTL-004`  
**Priority:** Medium  
**Category:** Content Library - Validation

**Test Steps:**

1. **Invalid difficulty:**
   ```json
   {
     "difficulty_level": "super_hard"
   }
   ```

2. **Expected Error:**
   ```json
   {
     "success": false,
     "error": "VALIDATION_ERROR",
     "details": {
       "field": "difficulty_level",
       "allowed_values": ["beginner", "intermediate", "advanced"]
     }
   }
   ```

---

### 6.5 List Templates - Pagination

**Test ID:** `CTL-005`  
**Priority:** High  
**Category:** Content Library

**Test Steps:**

1. **Create 25 templates** (setup)

2. **Request page 1:**
   ```http
   GET /api/content-library?page=1&limit=20
   Authorization: Bearer {{access_token}}
   ```

3. **Verify Response:**
   ```json
   {
     "success": true,
     "data": [...], // 20 templates
     "pagination": {
       "page": 1,
       "limit": 20,
       "total": 25,
       "total_pages": 2,
       "has_next": true,
       "has_prev": false
     }
   }
   ```

4. **Request page 2:**
   ```http
   GET /api/content-library?page=2&limit=20
   ```
   - Should return 5 templates
   - `has_next: false, has_prev: true`

---

### 6.6 List Templates - Filter by Domain

**Test ID:** `CTL-006`  
**Priority:** High  
**Category:** Content Library - Search

**Test Steps:**

1. **Create templates:**
   - 5 templates with `domain: "cognitive"`
   - 3 templates with `domain: "motor"`
   - 2 templates with `domain: "language"`

2. **Filter by cognitive:**
   ```http
   GET /api/content-library?domain=cognitive&limit=50
   ```

3. **Verify:**
   - Returns only 5 templates
   - All have `domain: "cognitive"`

**SQL Query:**
```sql
SELECT * FROM content_library 
WHERE teacher_id = :teacher_id 
  AND domain = 'cognitive'
  AND deleted_at IS NULL
ORDER BY created_at DESC;
```

---

### 6.7 List Templates - Filter by Difficulty

**Test ID:** `CTL-007`  
**Priority:** Medium  
**Category:** Content Library - Search

**Test Steps:**

1. **Filter by difficulty:**
   ```http
   GET /api/content-library?difficulty=beginner&limit=50
   ```

2. **Verify:**
   - All results have `difficulty_level: "beginner"`

---

### 6.8 List Templates - Filter by Public Status

**Test ID:** `CTL-008`  
**Priority:** Medium  
**Category:** Content Library - Search

**Test Steps:**

1. **Create templates:**
   - 3 private (`is_public: false`)
   - 2 public (`is_public: true`)

2. **Get public only:**
   ```http
   GET /api/content-library?public_only=true
   ```
   - Returns 2 templates

3. **Get all (default):**
   ```http
   GET /api/content-library
   ```
   - Returns 5 templates (own private + public)

**Business Rule:**
- `public_only=false`: Returns user's private + all public templates
- `public_only=true`: Returns only public templates

---

### 6.9 List Templates - Filter by Tags

**Test ID:** `CTL-009`  
**Priority:** Low  
**Category:** Content Library - Search

**Test Steps:**

1. **Filter by tags:**
   ```http
   GET /api/content-library?tags=màu%20sắc,nhận%20biết
   ```

2. **Verify:**
   - Returns templates containing ANY of the specified tags
   - Uses JSONB `@>` operator

**SQL Query:**
```sql
SELECT * FROM content_library 
WHERE tags @> jsonb_build_array('màu sắc')
   OR tags @> jsonb_build_array('nhận biết');
```

---

### 6.10 Get Template Details - Full JSONB Parsing

**Test ID:** `CTL-010`  
**Priority:** High  
**Category:** Content Library

**Test Steps:**

1. **Request:**
   ```http
   GET /api/content-library/{{template_id}}
   Authorization: Bearer {{access_token}}
   ```

2. **Verify Response includes:**
   - All template fields
   - `default_goals` parsed as array of objects
   - `tags` parsed as array of strings
   - `rating_avg` computed from TEMPLATE_RATINGS table
   - `rating_count` computed
   - `last_used_at` from latest session using this template

**Expected Response:**
```json
{
  "success": true,
  "template": {
    "id": "<uuid>",
    "code": "CTL_TH_001",
    "title": "Nhận biết màu sắc cơ bản",
    "domain": "cognitive",
    "default_goals": [
      {
        "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
        "order": 1
      }
    ],
    "tags": ["màu sắc", "nhận biết", "cognitive"],
    "usage_count": 15,
    "rating_avg": 4.5,
    "rating_count": 8,
    "last_used_at": "2025-11-03T10:00:00Z",
    "created_at": "2025-11-05T13:40:45Z"
  }
}
```

**SQL for Rating Aggregation:**
```sql
SELECT 
  cl.*, 
  COALESCE(AVG(tr.rating), 0) AS rating_avg,
  COUNT(tr.id) AS rating_count
FROM content_library cl
LEFT JOIN template_ratings tr ON cl.id = tr.content_library_id
WHERE cl.id = :template_id
GROUP BY cl.id;
```

---

### 6.11 Update Template - Partial Update

**Test ID:** `CTL-011`  
**Priority:** High  
**Category:** Content Library

**Test Steps:**

1. **Update specific fields:**
   ```http
   PATCH /api/content-library/{{template_id}}
   Content-Type: application/json

   {
     "title": "Nhận biết màu sắc cơ bản (Updated)",
     "is_public": true
   }
   ```

2. **Verify:**
   - Only `title` and `is_public` updated
   - Other fields unchanged
   - `updated_at` timestamp changed

3. **Database Check:**
   ```sql
   SELECT title, is_public, updated_at 
   FROM content_library 
   WHERE id = :template_id;
   ```

---

### 6.12 Update Template - Modify Default Goals (JSONB)

**Test ID:** `CTL-012`  
**Priority:** Medium  
**Category:** Content Library - JSONB

**Test Steps:**

1. **Update default_goals:**
   ```http
   PATCH /api/content-library/{{template_id}}
   Content-Type: application/json

   {
     "default_goals": [
       {
         "description": "Updated goal 1",
         "order": 1
       },
       {
         "description": "New goal 2",
         "order": 2
       }
     ]
   }
   ```

2. **Verify:**
   - JSONB field completely replaced (not merged)
   - New array has 2 items

**Important:** JSONB update is **full replacement**, not merge

---

### 6.13 Delete Template - Soft Delete

**Test ID:** `CTL-013`  
**Priority:** High  
**Category:** Content Library

**Test Steps:**

1. **Create template**
2. **Use template in 3 sessions** (creates FK relationships)
3. **Delete template:**
   ```http
   DELETE /api/content-library/{{template_id}}
   Authorization: Bearer {{access_token}}
   ```

4. **Verify:**
   - Status: `200 OK`
   - `deleted_at` timestamp set
   - Template NOT in list results
   - Existing sessions using this template still work

**Database:**
```sql
-- Check soft delete
SELECT deleted_at FROM content_library 
WHERE id = :template_id;
-- Should NOT be NULL

-- Check sessions still linked
SELECT COUNT(*) FROM session_contents 
WHERE content_library_id = :template_id;
-- Should return: 3 (FK preserved)
```

**Cascade Rule:**
- Soft delete template → sessions using it remain intact
- FK `session_contents.content_library_id` allows NULL

---

### 6.14 Rate Template - Create Rating

**Test ID:** `CTL-014`  
**Priority:** High  
**Category:** Template Ratings

**Test Steps:**

1. **Submit rating:**
   ```http
   POST /api/content-library/{{template_id}}/ratings
   Authorization: Bearer {{access_token}}
   Content-Type: application/json

   {
     "rating": 5,
     "review": "Template rất hữu ích, trẻ học rất tốt!"
   }
   ```

2. **Verify Response:**
   ```json
   {
     "success": true,
     "rating": {
       "id": "<uuid>",
       "content_library_id": "{{template_id}}",
       "teacher_id": "<uuid>",
       "rating": 5,
       "review": "Template rất hữu ích...",
       "created_at": "2025-11-05T13:40:45Z"
     },
     "template_stats": {
       "rating_avg": 4.75,
       "rating_count": 12
     }
   }
   ```

3. **Database:**
   ```sql
   SELECT * FROM template_ratings 
   WHERE content_library_id = :template_id 
     AND teacher_id = :teacher_id;
   
   -- Check unique constraint
   -- (content_library_id, teacher_id) should be UNIQUE
   ```

**Business Rule:**
- Each teacher can rate a template only once
- UNIQUE constraint on (content_library_id, teacher_id)

---

### 6.15 Rate Template - Validation: Rating Out of Range

**Test ID:** `CTL-015`  
**Priority:** Medium  
**Category:** Template Ratings - Validation

**Test Cases:**

| Rating Value | Expected Result |
|--------------|----------------|
| 0 | Error: Min = 1 |
| 6 | Error: Max = 5 |
| 3 | Success |

**Expected Error:**
```json
{
  "success": false,
  "error": "VALIDATION_ERROR",
  "message": "Đánh giá phải từ 1 đến 5 sao",
  "details": {
    "field": "rating",
    "value_received": 6,
    "allowed_range": {"min": 1, "max": 5}
  }
}
```

**Database Constraint:**
```sql
ALTER TABLE template_ratings 
ADD CONSTRAINT chk_rating_value 
CHECK (rating BETWEEN 1 AND 5);
```

---

### 6.16 Rate Template - Duplicate Rating (Idempotency)

**Test ID:** `CTL-016`  
**Priority:** Medium  
**Category:** Template Ratings

**Test Steps:**

1. **Submit first rating** (CTL-014)
2. **Submit second rating for same template:**
   ```http
   POST /api/content-library/{{template_id}}/ratings
   {
     "rating": 4,
     "review": "Changed my mind..."
   }
   ```

3. **Expected Behavior:**
   - Option A: Update existing rating (idempotent)
   - Option B: Return 409 Conflict

**Recommended:** Use `ON CONFLICT (content_library_id, teacher_id) DO UPDATE`

---

### 6.17 Update Rating

**Test ID:** `CTL-017`  
**Priority:** Low  
**Category:** Template Ratings

**Test Steps:**

1. **Update existing rating:**
   ```http
   PATCH /api/content-library/{{template_id}}/ratings
   Content-Type: application/json

   {
     "rating": 4,
     "review": "Updated review after more usage..."
   }
   ```

2. **Verify:**
   - Rating updated
   - `updated_at` timestamp changed
   - Template `rating_avg` recalculated

---

### 6.18 Get Template Ratings - List with Pagination

**Test ID:** `CTL-018`  
**Priority:** Medium  
**Category:** Template Ratings

**Test Steps:**

1. **Get ratings:**
   ```http
   GET /api/content-library/{{template_id}}/ratings?page=1&limit=10
   Authorization: Bearer {{access_token}}
   ```

2. **Verify Response:**
   ```json
   {
     "success": true,
     "ratings": [
       {
         "id": "<uuid>",
         "teacher": {
           "id": "<uuid>",
           "name": "Trần Hảo",
           "avatar_url": "https://..."
         },
         "rating": 5,
         "review": "Template rất hữu ích...",
         "created_at": "2025-11-05T13:40:45Z",
         "updated_at": "2025-11-05T13:40:45Z"
       }
     ],
     "stats": {
       "rating_avg": 4.75,
       "rating_count": 12,
       "rating_distribution": {
         "5": 8,
         "4": 3,
         "3": 1,
         "2": 0,
         "1": 0
       }
     },
     "pagination": {
       "page": 1,
       "limit": 10,
       "total": 12
     }
   }
   ```

**SQL for Rating Distribution:**
```sql
SELECT 
  rating,
  COUNT(*) AS count
FROM template_ratings 
WHERE content_library_id = :template_id
GROUP BY rating
ORDER BY rating DESC;
```

---

### 6.19 Delete Rating

**Test ID:** `CTL-019`  
**Priority:** Low  
**Category:** Template Ratings

**Test Steps:**

1. **Delete rating:**
   ```http
   DELETE /api/content-library/{{template_id}}/ratings
   Authorization: Bearer {{access_token}}
   ```

2. **Verify:**
   - Rating deleted from database
   - Template `rating_avg` and `rating_count` updated

---

### 6.20 Use Template in Session Creation

**Test ID:** `CTL-020`  
**Priority:** High  
**Category:** Content Library - Integration

**Test Objective:**
Verify template usage in session content creation and usage tracking

**Test Steps:**

1. **Create template** (CTL-001)

2. **Use template in session:**
   ```http
   POST /api/sessions/{{session_id}}/contents/from-template
   Content-Type: application/json

   {
     "template_id": "{{template_id}}"
   }
   ```

3. **Verify:**
   - Session content created with template data
   - Goals created from `default_goals` JSONB
   - `content_library_id` FK set
   - Template `usage_count` incremented
   - Template `last_used_at` updated

4. **Database Validation:**
   ```sql
   -- Check session content
   SELECT * FROM session_contents 
   WHERE content_library_id = :template_id;
   
   -- Check usage tracking
   SELECT usage_count, last_used_at 
   FROM content_library 
   WHERE id = :template_id;
   -- usage_count should be +1
   -- last_used_at should be NOW()
   ```

5. **Re-fetch template:**
   ```http
   GET /api/content-library/{{template_id}}
   ```
   - Verify `usage_count` incremented
   - Verify `last_used_at` updated

**Trigger Function:**
```sql
CREATE TRIGGER trigger_increment_template_usage
  AFTER INSERT ON session_contents
  FOR EACH ROW
  WHEN (NEW.content_library_id IS NOT NULL)
  EXECUTE FUNCTION increment_template_usage();
```

---

## 📊 TEST SUMMARY - SECTION 6

| Category | Test Cases | Priority |
|----------|-----------|----------|
| Template CRUD | 5 | High |
| Validation | 4 | High/Medium |
| List & Search | 5 | High/Medium |
| Ratings | 6 | High/Medium/Low |
| **Total** | **20** | - |

### Coverage Metrics

- ✅ **API Endpoints:** 9/9 (100%)
- ✅ **Database Tables:** 2/2 (CONTENT_LIBRARY, TEMPLATE_RATINGS)
- ✅ **JSONB Operations:** 100% covered (default_goals, tags)
- ✅ **Business Rules:** 100% covered
  - Template usage tracking (trigger)
  - Rating aggregation
  - Soft delete with FK preservation
  - Public/Private templates

### Critical Paths Tested

1. ✅ Create Template → Use in Session → Usage Count +1
2. ✅ Create Template → Rate → Rating Avg Calculated
3. ✅ Search Templates → Filter by Domain/Difficulty/Tags
4. ✅ Update Template (JSONB) → Verify Replacement
5. ✅ Delete Template (Soft) → Sessions Preserved

---

## 🔄 NEXT STEPS

Continue to **PART 5**:
- Section 7: AI Processing Tests (20 test cases)

**File:** `TEST_CASE_API/PART5.md`

---

**✅ PART 4 COMPLETED**  
**Test Cases:** 20  
**Coverage:** Content Library & Templates (100%)
```

---

Tôi sẽ tiếp tục với PART 5 và PART 6 trong phần trả lời tiếp theo.
