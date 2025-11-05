# 📝 API TEST CASES CHI TIẾT (Tiếp theo)

---

## 3. SESSION MANAGEMENT TESTS

### 3.1 Create Session - Step 1 Basic Info (Happy Path)

| Test Case ID      | TC-SES-001                                                |
| ----------------- | --------------------------------------------------------- |
| **Test Name**     | Create session with valid basic information               |
| **Priority**      | High                                                      |
| **Category**      | Session Management                                        |
| **Preconditions** | - Teacher logged in<br>- At least 1 active student exists |
| **Test Data**     | Valid session data with student_id                        |

**Test Steps:**

| Step | Action                               | Expected Result                                  |
| ---- | ------------------------------------ | ------------------------------------------------ |
| 1    | POST `/api/sessions` with valid data | HTTP 201 Created                                 |
| 2    | Verify session object                | All fields populated correctly                   |
| 3    | Verify computed field                | `duration_minutes` = 90                          |
| 4    | Verify defaults                      | `status: 'pending'`, `creation_method: 'manual'` |
| 5    | Verify FK relationship               | `student_id` exists in STUDENTS table            |
| 6    | Check `next_step`                    | Returns "add_contents"                           |

**Test Data:**

```json
{
  "student_id": "uuid",
  "session_date": "2025-11-10",
  "time_slot": "morning",
  "start_time": "09:00:00",
  "end_time": "10:30:00",
  "location": "Phòng 101",
  "notes": "Buổi học về nhận biết màu sắc"
}
```

**Expected Response:**

```json
{
  "success": true,
  "session": {
    "id": "uuid",
    "student_id": "uuid",
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
    "created_at": "2025-11-05T12:09:53Z"
  },
  "next_step": "add_contents"
}
```

**Assertions:**

- ✅ `duration_minutes` = (end_time - start_time) in minutes
- ✅ `creation_method` = 'manual'
- ✅ `status` = 'pending'
- ✅ `has_evaluation` = false
- ✅ `created_by` = authenticated teacher_id

---

### 3.2 Create Session - Invalid Date Range

| Test Case ID  | TC-SES-002                                     |
| ------------- | ---------------------------------------------- |
| **Test Name** | Create session with date outside allowed range |
| **Priority**  | High                                           |
| **Category**  | Session Management - Validation                |

**Test Cases:**

- Date > 6 months ago → Error
- Date > 1 year in future → Error
- Date within range → Success

**Test Data (Invalid):**

```json
{
  "session_date": "2024-04-01" // More than 6 months ago
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "INVALID_DATE_RANGE",
  "message": "Ngày buổi học phải trong khoảng từ 6 tháng trước đến 1 năm sau.",
  "details": {
    "field": "session_date",
    "value_received": "2024-04-01",
    "allowed_range": {
      "min": "2025-05-05",
      "max": "2026-11-05"
    }
  }
}
```

**Validation Rules:**

- ✅ `session_date >= CURRENT_DATE - 6 months`
- ✅ `session_date <= CURRENT_DATE + 1 year`

---

### 3.3 Create Session - Invalid Time Range

| Test Case ID  | TC-SES-003                                 |
| ------------- | ------------------------------------------ |
| **Test Name** | Create session with end_time <= start_time |
| **Priority**  | High                                       |
| **Category**  | Session Management - Validation            |

**Test Data:**

```json
{
  "start_time": "10:00:00",
  "end_time": "09:30:00" // Earlier than start
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "INVALID_TIME_RANGE",
  "message": "Giờ kết thúc phải sau giờ bắt đầu.",
  "details": {
    "start_time": "10:00:00",
    "end_time": "09:30:00"
  }
}
```

---

### 3.4 Create Session - Duration Too Short

| Test Case ID  | TC-SES-004                                |
| ------------- | ----------------------------------------- |
| **Test Name** | Create session with duration < 30 minutes |
| **Priority**  | Medium                                    |
| **Category**  | Session Management - Validation           |

**Test Data:**

```json
{
  "start_time": "09:00:00",
  "end_time": "09:20:00" // Only 20 minutes
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "INVALID_DURATION",
  "message": "Thời lượng buổi học tối thiểu 30 phút.",
  "details": {
    "duration_minutes": 20,
    "min_required": 30
  }
}
```

---

### 3.5 Add Content to Session - Step 2 (Happy Path)

| Test Case ID      | TC-SES-005                        |
| ----------------- | --------------------------------- |
| **Test Name**     | Add content with goals to session |
| **Priority**      | High                              |
| **Category**      | Session Management                |
| **Preconditions** | - Session created (TC-SES-001)    |

**Test Steps:**

| Step | Action                            | Expected Result                    |
| ---- | --------------------------------- | ---------------------------------- |
| 1    | POST `/api/sessions/:id/contents` | HTTP 201 Created                   |
| 2    | Verify content created            | Content object returned            |
| 3    | Verify goals created              | Goals array with 2 items           |
| 4    | Check `order_index`               | Auto-incremented (1, 2, 3...)      |
| 5    | Verify FK relationships           | content → session, goals → content |

**Test Data:**

```json
{
  "title": "Nhận biết màu sắc cơ bản",
  "domain": "cognitive",
  "description": "Dạy trẻ nhận biết 4 màu: đỏ, vàng, xanh lá, xanh dương",
  "materials_needed": "Thẻ màu, đồ chơi nhiều màu",
  "estimated_duration": 30,
  "goals": [
    {
      "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
      "goal_type": "knowledge",
      "is_primary": true
    },
    {
      "description": "Trẻ có thể nói tên màu",
      "goal_type": "skill",
      "is_primary": false
    }
  ]
}
```

**Expected Response:**

```json
{
  "success": true,
  "content": {
    "id": "uuid",
    "session_id": "uuid",
    "title": "Nhận biết màu sắc cơ bản",
    "domain": "cognitive",
    "description": "...",
    "order_index": 1,
    "estimated_duration": 30,
    "goals": [
      {
        "id": "uuid",
        "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
        "goal_type": "knowledge",
        "is_primary": true,
        "order_index": 1
      },
      {
        "id": "uuid",
        "description": "Trẻ có thể nói tên màu",
        "goal_type": "skill",
        "is_primary": false,
        "order_index": 2
      }
    ]
  }
}
```

**Assertions:**

- ✅ Each content has unique `order_index` within session
- ✅ Each goal has unique `order_index` within content
- ✅ At least 1 goal per content (business rule)
- ✅ Domain must be one of: cognitive, motor, language, social, self_care

---

### 3.6 Add Content - Invalid Domain

| Test Case ID  | TC-SES-006                      |
| ------------- | ------------------------------- |
| **Test Name** | Add content with invalid domain |
| **Priority**  | Medium                          |
| **Category**  | Session Management - Validation |

**Test Data:**

```json
{
  "domain": "invalid_domain"
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "INVALID_DOMAIN",
  "message": "Domain không hợp lệ.",
  "details": {
    "field": "domain",
    "value_received": "invalid_domain",
    "allowed_values": ["cognitive", "motor", "language", "social", "self_care"]
  }
}
```

---

### 3.7 Add Content - No Goals

| Test Case ID  | TC-SES-007                      |
| ------------- | ------------------------------- |
| **Test Name** | Add content without goals       |
| **Priority**  | High                            |
| **Category**  | Session Management - Validation |

**Test Data:**

```json
{
  "title": "Test content",
  "domain": "cognitive",
  "goals": [] // Empty array
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "VALIDATION_ERROR",
  "message": "Mỗi nội dung phải có ít nhất 1 mục tiêu.",
  "details": {
    "field": "goals",
    "min_required": 1
  }
}
```

---

### 3.8 Add Content from Template

| Test Case ID      | TC-SES-008                                               |
| ----------------- | -------------------------------------------------------- |
| **Test Name**     | Add content from content library template                |
| **Priority**      | Medium                                                   |
| **Category**      | Session Management                                       |
| **Preconditions** | - Session exists<br>- Template exists in CONTENT_LIBRARY |

**Test Steps:**

| Step | Action                                          | Expected Result                    |
| ---- | ----------------------------------------------- | ---------------------------------- |
| 1    | POST `/api/sessions/:id/contents/from-template` | HTTP 201                           |
| 2    | Verify content copied                           | All fields from template copied    |
| 3    | Verify goals created                            | Goals from `default_goals` JSONB   |
| 4    | Check `content_library_id`                      | FK set to template ID              |
| 5    | Verify usage count                              | Template `usage_count` incremented |

**Test Data:**

```json
{
  "template_id": "uuid"
}
```

**Expected Behavior:**

- ✅ Content fields copied from template
- ✅ Goals created from template's `default_goals`
- ✅ `content_library_id` FK set
- ✅ Template's `usage_count` incremented
- ✅ Template's `last_used_at` updated

---

### 3.9 Reorder Session Contents

| Test Case ID  | TC-SES-009                        |
| ------------- | --------------------------------- |
| **Test Name** | Reorder contents within a session |
| **Priority**  | Low                               |
| **Category**  | Session Management                |

**Test Steps:**

| Step | Action                                     | Expected Result              |
| ---- | ------------------------------------------ | ---------------------------- |
| 1    | Create session with 3 contents             | order_index: 1, 2, 3         |
| 2    | PATCH `/api/sessions/:id/contents/reorder` | HTTP 200                     |
| 3    | Verify new order                           | order_index updated: 3, 1, 2 |

**Test Data:**

```json
{
  "content_ids": ["uuid3", "uuid1", "uuid2"]
}
```

**Expected Behavior:**

- ✅ `order_index` updated based on array position
- ✅ No duplicate `order_index` values
- ✅ All content_ids must belong to the session

---

### 3.10 Confirm Session - Step 3

| Test Case ID      | TC-SES-010                                      |
| ----------------- | ----------------------------------------------- |
| **Test Name**     | Confirm session after adding contents           |
| **Priority**      | High                                            |
| **Category**      | Session Management                              |
| **Preconditions** | - Session created<br>- At least 1 content added |

**Test Steps:**

| Step | Action                           | Expected Result                          |
| ---- | -------------------------------- | ---------------------------------------- |
| 1    | POST `/api/sessions/:id/confirm` | HTTP 200 OK                              |
| 2    | Verify session status            | Still 'pending' (not 'completed')        |
| 3    | Verify counts                    | `contents_count`, `goals_count` returned |
| 4    | Check validation                 | Session must have >= 1 content           |

**Expected Response:**

```json
{
  "success": true,
  "session": {
    "id": "uuid",
    "status": "pending",
    "contents_count": 2,
    "goals_count": 5
  }
}
```

---

### 3.11 Confirm Session - No Contents

| Test Case ID  | TC-SES-011                              |
| ------------- | --------------------------------------- |
| **Test Name** | Try to confirm session without contents |
| **Priority**  | Medium                                  |
| **Category**  | Session Management - Validation         |

**Expected Response:**

```json
{
  "success": false,
  "error": "VALIDATION_ERROR",
  "message": "Buổi học phải có ít nhất 1 nội dung.",
  "details": {
    "contents_count": 0,
    "min_required": 1
  }
}
```

---

### 3.12 List Sessions - Filter by Student

| Test Case ID  | TC-SES-012                           |
| ------------- | ------------------------------------ |
| **Test Name** | List sessions filtered by student_id |
| **Priority**  | High                                 |
| **Category**  | Session Management                   |

**Test Steps:**

| Step | Action                            | Expected Result              |
| ---- | --------------------------------- | ---------------------------- |
| 1    | Create 3 students                 | S1, S2, S3                   |
| 2    | Create sessions                   | 5 for S1, 3 for S2, 2 for S3 |
| 3    | GET `/api/sessions?student_id=S1` | Returns 5 sessions           |
| 4    | Verify all belong to S1           | All `student_id` = S1        |

---

### 3.13 List Sessions - Filter by Status

| Test Case ID  | TC-SES-013                       |
| ------------- | -------------------------------- |
| **Test Name** | List sessions filtered by status |
| **Priority**  | High                             |
| **Category**  | Session Management               |

**Test Steps:**

| Step | Action                               | Expected Result                     |
| ---- | ------------------------------------ | ----------------------------------- |
| 1    | Create sessions                      | 5 pending, 3 completed, 2 cancelled |
| 2    | GET `/api/sessions?status=pending`   | Returns 5 sessions                  |
| 3    | GET `/api/sessions?status=completed` | Returns 3 sessions                  |
| 4    | GET `/api/sessions?status=cancelled` | Returns 2 sessions                  |

---

### 3.14 List Sessions - Filter by Date Range

| Test Case ID  | TC-SES-014                      |
| ------------- | ------------------------------- |
| **Test Name** | List sessions within date range |
| **Priority**  | High                            |
| **Category**  | Session Management              |

**Test Steps:**

| Step | Action                                                      | Expected Result              |
| ---- | ----------------------------------------------------------- | ---------------------------- |
| 1    | Create sessions with various dates                          | Oct, Nov, Dec                |
| 2    | GET `/api/sessions?date_from=2025-11-01&date_to=2025-11-30` | Returns only Nov sessions    |
| 3    | Verify date filtering                                       | All returned sessions in Nov |

---

### 3.15 Get Session Details - Full Data

| Test Case ID  | TC-SES-015                               |
| ------------- | ---------------------------------------- |
| **Test Name** | Get session details with all nested data |
| **Priority**  | High                                     |
| **Category**  | Session Management                       |

**Test Steps:**

| Step | Action                                  | Expected Result                                   |
| ---- | --------------------------------------- | ------------------------------------------------- |
| 1    | Create session with 2 contents, 5 goals | Success                                           |
| 2    | GET `/api/sessions/:id`                 | HTTP 200                                          |
| 3    | Verify nested data                      | Contents array with goals nested                  |
| 4    | Verify ordering                         | Contents by `order_index`, goals by `order_index` |

**Expected Response Structure:**

```json
{
  "session": {
    "id": "uuid",
    "student_name": "Nguyễn Văn An",
    "contents": [
      {
        "id": "uuid",
        "order_index": 1,
        "goals": [
          { "id": "uuid", "order_index": 1 },
          { "id": "uuid", "order_index": 2 }
        ]
      }
    ]
  }
}
```

---

### 3.16 Update Session - Basic Info

| Test Case ID  | TC-SES-016                       |
| ------------- | -------------------------------- |
| **Test Name** | Update session basic information |
| **Priority**  | Medium                           |
| **Category**  | Session Management               |

**Test Steps:**

| Step | Action                                 | Expected Result              |
| ---- | -------------------------------------- | ---------------------------- |
| 1    | PATCH `/api/sessions/:id` with updates | HTTP 200                     |
| 2    | Verify fields updated                  | Changed fields only          |
| 3    | Verify `updated_at`                    | Timestamp updated            |
| 4    | Verify immutable fields                | `id`, `created_by` unchanged |

**Test Data:**

```json
{
  "session_date": "2025-11-11",
  "location": "Phòng 102"
}
```

---

### 3.17 Cancel Session

| Test Case ID  | TC-SES-017         |
| ------------- | ------------------ |
| **Test Name** | Cancel a session   |
| **Priority**  | Medium             |
| **Category**  | Session Management |

**Test Steps:**

| Step | Action                          | Expected Result              |
| ---- | ------------------------------- | ---------------------------- |
| 1    | POST `/api/sessions/:id/cancel` | HTTP 200                     |
| 2    | Verify status                   | `status: 'cancelled'`        |
| 3    | Verify timestamp                | `cancelled_at` set to NOW()  |
| 4    | Verify reason saved             | `cancellation_reason` stored |

**Test Data:**

```json
{
  "cancellation_reason": "Học sinh ốm"
}
```

---

### 3.18 Delete Session (Soft Delete)

| Test Case ID  | TC-SES-018                       |
| ------------- | -------------------------------- |
| **Test Name** | Soft delete session with cascade |
| **Priority**  | High                             |
| **Category**  | Session Management               |

**Test Steps:**

| Step | Action                               | Expected Result     |
| ---- | ------------------------------------ | ------------------- |
| 1    | Create session with contents & goals | Success             |
| 2    | DELETE `/api/sessions/:id`           | HTTP 200            |
| 3    | Check session                        | `deleted_at` set    |
| 4    | Check list                           | Session NOT in list |
| 5    | Direct DB query                      | Record still exists |

**Expected Behavior:**

- ✅ Session `deleted_at` set
- ✅ Contents NOT cascade deleted (FK ON DELETE CASCADE doesn't apply to soft delete)
- ✅ Need manual cascade logic for soft delete

---

### 3.19 Session Access Control

| Test Case ID  | TC-SES-019                                 |
| ------------- | ------------------------------------------ |
| **Test Name** | Teacher can only access their own sessions |
| **Priority**  | Critical                                   |
| **Category**  | Session Management - Security              |

**Test Steps:**

| Step | Action                         | Expected Result    |
| ---- | ------------------------------ | ------------------ |
| 1    | Teacher A creates session      | Success            |
| 2    | Teacher B tries to GET session | HTTP 403 Forbidden |
| 3    | Teacher B tries to UPDATE      | HTTP 403           |
| 4    | Teacher B tries to DELETE      | HTTP 403           |

**Expected Response:**

```json
{
  "success": false,
  "error": "FORBIDDEN",
  "message": "Bạn không có quyền truy cập buổi học này."
}
```

---

### 3.20 Session with Student from Different Teacher

| Test Case ID  | TC-SES-020                                           |
| ------------- | ---------------------------------------------------- |
| **Test Name** | Cannot create session for student of another teacher |
| **Priority**  | Critical                                             |
| **Category**  | Session Management - Security                        |

**Test Steps:**

| Step | Action                                   | Expected Result |
| ---- | ---------------------------------------- | --------------- |
| 1    | Teacher A creates student S1             | Success         |
| 2    | Teacher B tries to create session for S1 | HTTP 403        |

**Expected Response:**

```json
{
  "success": false,
  "error": "FORBIDDEN",
  "message": "Bạn không có quyền tạo buổi học cho học sinh này."
}
```

---

## 4. SESSION LOGGING TESTS

### 4.1 Create Session Log - Auto Create

| Test Case ID      | TC-LOG-001                              |
| ----------------- | --------------------------------------- |
| **Test Name**     | Create session log for a session        |
| **Priority**      | High                                    |
| **Category**      | Session Logging                         |
| **Preconditions** | - Session exists and status = 'pending' |

**Test Steps:**

| Step | Action                        | Expected Result                 |
| ---- | ----------------------------- | ------------------------------- |
| 1    | POST `/api/sessions/:id/logs` | HTTP 201 Created                |
| 2    | Verify log created            | `session_log` object returned   |
| 3    | Verify 1-1 relationship       | `session_id` is unique in table |
| 4    | Check `next_step`             | Returns "evaluate_goals"        |
| 5    | Verify `logged_at`            | Set to NOW()                    |

**Expected Response:**

```json
{
  "success": true,
  "session_log": {
    "id": "uuid",
    "session_id": "uuid",
    "logged_at": "2025-11-05T12:09:53Z",
    "created_by": "uuid"
  },
  "next_step": "evaluate_goals"
}
```

**Assertions:**

- ✅ 1-1 relationship: 1 session can have max 1 log
- ✅ `session_id` is UNIQUE in SESSION_LOGS table
- ✅ `logged_at` defaults to NOW()

---

### 4.2 Create Session Log - Duplicate

| Test Case ID  | TC-LOG-002                                   |
| ------------- | -------------------------------------------- |
| **Test Name** | Cannot create duplicate log for same session |
| **Priority**  | High                                         |
| **Category**  | Session Logging - Validation                 |

**Test Steps:**

| Step | Action                                     | Expected Result                       |
| ---- | ------------------------------------------ | ------------------------------------- |
| 1    | POST `/api/sessions/:id/logs` (first time) | HTTP 201                              |
| 2    | POST `/api/sessions/:id/logs` (again)      | HTTP 200 (idempotent) or 409 Conflict |
| 3    | Verify response                            | Returns existing log                  |

**Expected Behavior:**

- ✅ Either return existing log (idempotent)
- ✅ Or return 409 Conflict error
- ✅ No duplicate logs created

---

### 4.3 Evaluate Goals - Step 1 (Happy Path)

| Test Case ID      | TC-LOG-003                                                |
| ----------------- | --------------------------------------------------------- |
| **Test Name**     | Evaluate all goals with valid data                        |
| **Priority**      | High                                                      |
| **Category**      | Session Logging                                           |
| **Preconditions** | - Session log exists<br>- Session has contents with goals |

**Test Steps:**

| Step | Action                            | Expected Result                          |
| ---- | --------------------------------- | ---------------------------------------- |
| 1    | PUT `/api/session-logs/:id/goals` | HTTP 200 OK                              |
| 2    | Verify evaluations created        | All goals evaluated                      |
| 3    | Check UNIQUE constraint           | (session_log_id, content_goal_id) unique |
| 4    | Verify `next_step`                | Returns "attitude"                       |

**Test Data:**

```json
{
  "evaluations": [
    {
      "content_goal_id": "uuid1",
      "status": "achieved",
      "achievement_level": 90,
      "support_level": "minimal_prompt",
      "notes": "Trẻ làm tốt"
    },
    {
      "content_goal_id": "uuid2",
      "status": "partially_achieved",
      "achievement_level": 60,
      "support_level": "moderate_prompt",
      "notes": "Cần luyện tập thêm"
    }
  ]
}
```

**Expected Response:**

```json
{
  "success": true,
  "session_log": {
    "id": "uuid",
    "goal_evaluations": [
      {
        "id": "uuid",
        "content_goal_id": "uuid1",
        "goal_description": "Trẻ có thể chỉ đúng màu",
        "status": "achieved",
        "achievement_level": 90,
        "support_level": "minimal_prompt",
        "notes": "Trẻ làm tốt"
      }
    ],
    "evaluations_count": 8,
    "evaluated_count": 2
  },
  "next_step": "attitude"
}
```

**Assertions:**

- ✅ Each goal can only be evaluated once per log
- ✅ `status` must be: achieved, partially_achieved, not_achieved, not_applicable
- ✅ `achievement_level` must be 0-100
- ✅ `support_level` must be valid enum value

---

### 4.4 Evaluate Goals - Invalid Status

| Test Case ID  | TC-LOG-004                        |
| ------------- | --------------------------------- |
| **Test Name** | Evaluate goal with invalid status |
| **Priority**  | Medium                            |
| **Category**  | Session Logging - Validation      |

**Test Data:**

```json
{
  "evaluations": [
    {
      "content_goal_id": "uuid",
      "status": "invalid_status"
    }
  ]
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "VALIDATION_ERROR",
  "message": "Trạng thái đánh giá không hợp lệ.",
  "details": {
    "field": "status",
    "value_received": "invalid_status",
    "allowed_values": [
      "achieved",
      "partially_achieved",
      "not_achieved",
      "not_applicable"
    ]
  }
}
```

---

### 4.5 Evaluate Goals - Achievement Level Out of Range

| Test Case ID  | TC-LOG-005                                 |
| ------------- | ------------------------------------------ |
| **Test Name** | Evaluate goal with achievement_level > 100 |
| **Priority**  | Medium                                     |
| **Category**  | Session Logging - Validation               |

**Test Data:**

```json
{
  "achievement_level": 150
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "VALIDATION_ERROR",
  "message": "Mức độ đạt được phải từ 0 đến 100.",
  "details": {
    "field": "achievement_level",
    "value_received": 150,
    "allowed_range": { "min": 0, "max": 100 }
  }
}
```

---

### 4.6 Update Attitude - Step 2 (Happy Path)

| Test Case ID  | TC-LOG-006                      |
| ------------- | ------------------------------- |
| **Test Name** | Update attitude with all fields |
| **Priority**  | High                            |
| **Category**  | Session Logging                 |

**Test Steps:**

| Step | Action                               | Expected Result                                |
| ---- | ------------------------------------ | ---------------------------------------------- |
| 1    | PUT `/api/session-logs/:id/attitude` | HTTP 200 OK                                    |
| 2    | Verify all fields updated            | mood, energy, cooperation, focus, independence |
| 3    | Verify ranges                        | All levels 1-5                                 |
| 4    | Check `next_step`                    | Returns "notes_media"                          |

**Test Data:**

```json
{
  "mood": "good",
  "energy_level": 4,
  "cooperation_level": 5,
  "focus_level": 3,
  "independence_level": 4,
  "attitude_summary": "Trẻ rất hợp tác hôm nay"
}
```

**Expected Response:**

```json
{
  "success": true,
  "session_log": {
    "id": "uuid",
    "mood": "good",
    "energy_level": 4,
    "cooperation_level": 5,
    "focus_level": 3,
    "independence_level": 4,
    "attitude_summary": "Trẻ rất hợp tác hôm nay",
    "updated_at": "2025-11-05T12:09:53Z"
  },
  "next_step": "notes_media"
}
```

**Assertions:**

- ✅ `mood` in [very_difficult, difficult, normal, good, very_good]
- ✅ All levels (energy, cooperation, focus, independence) in 1-5 range

---

### 4.7 Update Attitude - Invalid Mood

| Test Case ID  | TC-LOG-007                        |
| ------------- | --------------------------------- |
| **Test Name** | Update attitude with invalid mood |
| **Priority**  | Medium                            |
| **Category**  | Session Logging - Validation      |

**Test Data:**

```json
{
  "mood": "super_happy"
}
```

**Expected Response:**

```json
{
  "success": false,
  "error": "VALIDATION_ERROR",
  "message": "Tâm trạng không hợp lệ.",
  "details": {
    "field": "mood",
    "allowed_values": [
      "very_difficult",
      "difficult",
      "normal",
      "good",
      "very_good"
    ]
  }
}
```

---

### 4.8 Update Notes & Media - Step 3

| Test Case ID  | TC-LOG-008                     |
| ------------- | ------------------------------ |
| **Test Name** | Update notes and progress text |
| **Priority**  | High                           |
| **Category**  | Session Logging                |

**Test Steps:**

| Step | Action                            | Expected Result                             |
| ---- | --------------------------------- | ------------------------------------------- |
| 1    | PUT `/api/session-logs/:id/notes` | HTTP 200 OK                                 |
| 2    | Verify text fields updated        | progress_notes, challenges, recommendations |
| 3    | Verify rating                     | `overall_rating` 1-5                        |
| 4    | Check `next_step`                 | Returns "behavior_optional"                 |

**Test Data:**

```json
{
  "progress_notes": "Trẻ đã tiến bộ rõ rệt",
  "challenges_faced": "Vẫn còn khó khăn với kỹ năng X",
  "recommendations": "Tiếp tục luyện tập",
  "teacher_notes_text": "Ghi chú khác",
  "overall_rating": 4,
  "actual_start_time": "09:05:00",
  "actual_end_time": "10:35:00"
}
```

**Field Validation:**

- ✅ Each text field max 2000 characters
- ✅ `overall_rating` 1-5
- ✅ `actual_end_time` > `actual_start_time`

---

### 4.9 Upload Media to Log

| Test Case ID  | TC-LOG-009                                      |
| ------------- | ----------------------------------------------- |
| **Test Name** | Upload media (image/video/audio) to session log |
| **Priority**  | High                                            |
| **Category**  | Session Logging - Media                         |

**Test Steps:**

| Step | Action                        | Expected Result                    |
| ---- | ----------------------------- | ---------------------------------- |
| 1    | POST `/api/media/upload-url`  | Get signed URL                     |
| 2    | Upload file to R2             | Success                            |
| 3    | POST `/api/media/:id/confirm` | Media record created               |
| 4    | Verify FK                     | `session_log_id` set correctly     |
| 5    | Check metadata                | width, height, file_size populated |

**Limits:**

- ✅ Max 10 images per log
- ✅ Max 3 videos per log
- ✅ Max 5 audios per log
- ✅ Image: max 5MB, auto-resize to 1920px
- ✅ Video: max 100MB, max 5 minutes
- ✅ Audio: max 5 minutes

---

### 4.10 Upload Media - Exceed Limit

| Test Case ID  | TC-LOG-010                      |
| ------------- | ------------------------------- |
| **Test Name** | Try to upload 11th image to log |
| **Priority**  | Medium                          |
| **Category**  | Session Logging - Validation    |

**Expected Response:**

```json
{
  "success": false,
  "error": "MEDIA_LIMIT_EXCEEDED",
  "message": "Số lượng ảnh vượt quá giới hạn. Tối đa: 10 ảnh.",
  "details": {
    "current_count": 10,
    "max_allowed": 10,
    "media_type": "image"
  }
}
```

---

### 4.11 Complete Session Log

| Test Case ID      | TC-LOG-011                        |
| ----------------- | --------------------------------- |
| **Test Name**     | Complete session log (final step) |
| **Priority**      | High                              |
| **Category**      | Session Logging                   |
| **Preconditions** | - All required steps completed    |

**Test Steps:**

| Step | Action                                | Expected Result                               |
| ---- | ------------------------------------- | --------------------------------------------- |
| 1    | POST `/api/session-logs/:id/complete` | HTTP 200 OK                                   |
| 2    | Verify log status                     | `completed_at` set to NOW()                   |
| 3    | Verify session updated                | `status: 'completed'`, `has_evaluation: true` |
| 4    | Check immutability                    | Cannot edit completed log                     |

**Expected Response:**

```json
{
  "success": true,
  "message": "Nhật ký đã được lưu thành công!",
  "session": {
    "id": "uuid",
    "status": "completed",
    "has_evaluation": true,
    "session_log": {
      "id": "uuid",
      "completed_at": "2025-11-05T12:09:53Z"
    }
  }
}
```

**Assertions:**

- ✅ Session `status` changed from 'pending' to 'completed'
- ✅ Session `has_evaluation` changed to true
- ✅ Log `completed_at` timestamp set

---

### 4.12 Edit Completed Log - Should Fail

| Test Case ID  | TC-LOG-012                        |
| ------------- | --------------------------------- |
| **Test Name** | Cannot edit completed session log |
| **Priority**  | Medium                            |
| **Category**  | Session Logging - Business Rule   |

**Test Steps:**

| Step | Action                                   | Expected Result           |
| ---- | ---------------------------------------- | ------------------------- |
| 1    | Complete a log                           | Success                   |
| 2    | Try to PUT `/api/session-logs/:id/goals` | HTTP 403 Forbidden        |
| 3    | Verify error                             | Cannot edit completed log |

**Expected Response:**

```json
{
  "success": false,
  "error": "LOG_ALREADY_COMPLETED",
  "message": "Không thể chỉnh sửa nhật ký đã hoàn tất.",
  "details": {
    "completed_at": "2025-11-05T12:09:53Z"
  }
}
```

---

Vì độ dài giới hạn, tôi sẽ tóm tắt các sections còn lại và sau đó export file `.md` hoàn chỉnh cho bạn.

## 5-10. SUMMARY OF REMAINING TEST SECTIONS

### 5. BEHAVIOR SYSTEM TESTS (25 test cases)

- Search behaviors (full-text, keywords)
- Get behavior details with A-B-C model
- Add/remove favorites
- Create/update/delete behavior incidents
- Validate A-B-C fields (antecedent, behavior, consequence)
- Intensity level validation (1-5)

### 6. CONTENT LIBRARY TESTS (20 test cases)

- Create/update/delete templates
- Rate templates (1-5 stars)
- Search templates by domain/difficulty
- Use template in session creation
- Validate default_goals JSONB
- Template usage count tracking

### 7. AI PROCESSING TESTS (20 test cases)

- Upload file for AI (PDF/DOCX/TXT/image)
- Upload text for AI processing
- Poll processing status
- Validate AI result structure
- Create sessions from AI result
- Handle AI processing failures
- OCR + GPT-4 integration tests

### 8. ANALYTICS & REPORTS TESTS (15 test cases)

- Get analytics overview (KPIs, charts)
- Get student analytics with trends
- Filter analytics by date range
- Generate PDF report
- Generate Excel report
- Download report with signed URL
- Report expiration (TTL)

### 9. SETTINGS & SYNC TESTS (15 test cases)

- Get/update user settings
- Sync metadata for offline
- Sync students/sessions/behaviors
- Upload offline queue
- Create/download backup
- Auto backup scheduling
- Backup retention (max 4)

### 10. SECURITY & EDGE CASES TESTS (20 test cases)

- SQL injection prevention
- XSS attack prevention
- CSRF protection
- Rate limiting various endpoints
- Concurrent request handling
- Database transaction rollback
- Cascading deletes (soft delete)
- Data isolation between teachers
- Token expiration edge cases
- File upload security

---

# 📥 EXPORT FILE

Tôi sẽ tạo file Markdown hoàn chỉnh với tất cả test cases. File sẽ có cấu trúc:

```
API_TEST_CASES_COMPLETE.md
├── Header & Metadata
├── Table of Contents
├── Section 1: Authentication (35 test cases - DETAILED)
├── Section 2: Student Management (30 test cases - DETAILED)
├── Section 3: Session Management (45 test cases - DETAILED)
├── Section 4: Session Logging (40 test cases - DETAILED)
├── Section 5: Behavior System (25 test cases - SUMMARY)
├── Section 6: Content Library (20 test cases - SUMMARY)
├── Section 7: AI Processing (20 test cases - SUMMARY)
├── Section 8: Analytics & Reports (15 test cases - SUMMARY)
├── Section 9: Settings & Sync (15 test cases - SUMMARY)
├── Section 10: Security & Edge Cases (20 test cases - SUMMARY)
├── Test Execution Guide
├── Test Environment Setup
└── Appendix
```

Bạn muốn tôi:

1. **Tạo file ngay** với phần detailed + summary như trên?
2. **Tiếp tục viết chi tiết** sections 5-10 trước khi export?
