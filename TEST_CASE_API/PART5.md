# 📝 PART 5 - AI PROCESSING TESTS

```markdown
# 📝 API TEST CASES CHI TIẾT - PART 5
**Version:** 1.0  
**Date:** 2025-11-05  
**Author:** tranhaohcmus  
**Test Coverage:** AI Processing (Section 7)

---

## MỤC LỤC PART 5

- [7. AI PROCESSING TESTS](#7-ai-processing-tests)
  - [7.1 File Upload for AI](#71-file-upload-for-ai)
  - [7.2 Text Upload for AI](#72-text-upload-for-ai)
  - [7.3 Processing Status](#73-processing-status)
  - [7.4 AI Results](#74-ai-results)
  - [7.5 Create Sessions from AI](#75-create-sessions-from-ai)
  - [7.6 Error Handling](#76-error-handling)
  - [7.7 File Validation](#77-file-validation)
  - [7.8 Performance & Rate Limiting](#78-performance--rate-limiting)

---

## 7. AI PROCESSING TESTS

### 7.1 Upload PDF File for AI Processing - Happy Path

**Test ID:** `AI-001`  
**Priority:** High  
**Category:** AI Processing

**Test Objective:**  
Verify PDF file upload and AI processing initiation

**Preconditions:**
- Teacher is authenticated
- Student exists
- Valid PDF file (educational plan, IEP, etc.)

**Test Steps:**

1. **Upload PDF File:**
   ```http
   POST /api/ai/process
   Authorization: Bearer {{access_token}}
   Content-Type: multipart/form-data

   student_id: {{student_id}}
   file: @plan.pdf (max 10MB)
   ```

2. **Verify Response:**
   - Status code: `202 Accepted` (async processing)
   - Response structure:
     ```json
     {
       "success": true,
       "processing": {
         "id": "<uuid>",
         "teacher_id": "<uuid>",
         "student_id": "{{student_id}}",
         "file_url": "https://r2.cloudflare.com/.../plan.pdf",
         "file_type": "pdf",
         "file_size": 2457600,
         "processing_status": "pending",
         "progress": 0,
         "created_at": "2025-11-05T13:46:51Z"
       },
       "message": "Đang xử lý file của bạn. Quá trình có thể mất 30-60 giây.",
       "estimated_time": "30-60 seconds"
     }
     ```

3. **Verify File Upload to R2:**
   - File exists at R2 path: `ai-processing/{teacher_id}/{processing_id}/plan.pdf`
   - File accessible via signed URL (temp, expires in 1 hour)

4. **Verify Background Job Started:**
   - Job queued in Bull/BullMQ
   - Job type: `AI_PROCESS_DOCUMENT`
   - Job data includes: processing_id, file_url, student_id

**Expected Result:**
- ✅ File uploaded to R2 successfully
- ✅ AI_PROCESSING record created with status `pending`
- ✅ Background job queued
- ✅ Client receives processing_id to poll status

**Database Validation:**
```sql
SELECT * FROM ai_processing 
WHERE id = :processing_id;

-- Expected fields:
-- processing_status: 'pending'
-- progress: 0
-- file_url: R2 URL
-- result_sessions: NULL (not processed yet)
```

---

### 7.2 Upload DOCX File for AI Processing

**Test ID:** `AI-002`  
**Priority:** High  
**Category:** AI Processing

**Test Steps:**

1. **Upload DOCX:**
   ```http
   POST /api/ai/process
   Content-Type: multipart/form-data

   student_id: {{student_id}}
   file: @educational_plan.docx
   ```

2. **Verify:**
   - Status: `202 Accepted`
   - `file_type: "docx"`
   - Background job uses different parser (docx → text extraction)

**File Processing Flow:**
- DOCX → Extract text (mammoth library)
- Text → Send to GPT-4
- GPT-4 response → Parse to sessions JSON

---

### 7.3 Upload Text Content for AI Processing

**Test ID:** `AI-003`  
**Priority:** Medium  
**Category:** AI Processing

**Test Objective:**  
Verify direct text input (no file upload)

**Test Steps:**

1. **Send text content:**
   ```http
   POST /api/ai/process
   Content-Type: application/json

   {
     "student_id": "{{student_id}}",
     "text_content": "Kế hoạch giáo dục cá nhân cho trẻ tự kỷ:\n\nMục tiêu 1: Nhận biết màu sắc\n- Tuần 1-2: Giới thiệu 4 màu cơ bản\n- Tuần 3-4: Thực hành chỉ màu\n\nMục tiêu 2: Kỹ năng giao tiếp..."
   }
   ```

2. **Verify:**
   - Status: `202 Accepted`
   - `file_url: null` (no file)
   - `file_type: "text"`
   - Text stored in `text_content` field (TEXT column)

**Validation:**
- ✅ `text_content` max 5000 characters
- ✅ Either `file` OR `text_content`, not both

---

### 7.4 Upload Image File (JPG/PNG) with OCR

**Test ID:** `AI-004`  
**Priority:** Medium  
**Category:** AI Processing - OCR

**Test Objective:**  
Verify image upload with OCR text extraction

**Test Steps:**

1. **Upload image:**
   ```http
   POST /api/ai/process
   Content-Type: multipart/form-data

   student_id: {{student_id}}
   file: @handwritten_plan.jpg
   ```

2. **Verify Processing Flow:**
   - Image uploaded to R2
   - OCR service called (Tesseract.js or Cloud Vision API)
   - Extracted text → GPT-4
   - Response parsed to sessions

3. **Expected:**
   - `file_type: "image"`
   - Processing may take longer (OCR + AI)
   - `estimated_time: "60-90 seconds"`

**OCR Quality Considerations:**
- ⚠️ Handwritten text may have lower accuracy
- ✅ Typed/printed text has higher accuracy
- ⚠️ Image quality affects OCR results

---

### 7.5 Poll Processing Status - Pending

**Test ID:** `AI-005`  
**Priority:** High  
**Category:** AI Processing

**Test Steps:**

1. **After upload (AI-001), poll status:**
   ```http
   GET /api/ai/process/{{processing_id}}/status
   Authorization: Bearer {{access_token}}
   ```

2. **Expected Response (while processing):**
   ```json
   {
     "success": true,
     "processing_status": "processing",
     "progress": 45,
     "message": "Đang phân tích nội dung với AI..."
   }
   ```

**Progress Stages:**
| Progress % | Stage |
|-----------|-------|
| 0-20 | Đang đọc file |
| 20-40 | Đang trích xuất văn bản (OCR if image) |
| 40-70 | Đang phân tích với AI (GPT-4) |
| 70-90 | Đang tạo cấu trúc buổi học |
| 90-100 | Hoàn tất |

**Polling Recommendation:**
- Poll every 2-3 seconds
- Max 30 polls (60 seconds timeout)
- Exponential backoff if needed

---

### 7.6 Poll Processing Status - Completed

**Test ID:** `AI-006`  
**Priority:** High  
**Category:** AI Processing

**Test Steps:**

1. **Poll after completion:**
   ```http
   GET /api/ai/process/{{processing_id}}/status
   ```

2. **Expected Response:**
   ```json
   {
     "success": true,
     "processing_status": "completed",
     "progress": 100,
     "message": "Xử lý hoàn tất! Bạn có thể xem kết quả."
   }
   ```

3. **Now fetch full result:**
   ```http
   GET /api/ai/process/{{processing_id}}
   ```

---

### 7.7 Get AI Processing Result - Success

**Test ID:** `AI-007`  
**Priority:** High  
**Category:** AI Processing

**Test Objective:**  
Verify AI-generated sessions structure

**Test Steps:**

1. **Get result:**
   ```http
   GET /api/ai/process/{{processing_id}}
   Authorization: Bearer {{access_token}}
   ```

2. **Verify Response:**
   ```json
   {
     "success": true,
     "processing": {
       "id": "{{processing_id}}",
       "teacher_id": "<uuid>",
       "student_id": "{{student_id}}",
       "file_url": "https://r2.../plan.pdf",
       "file_type": "pdf",
       "processing_status": "completed",
       "progress": 100,
       "result_sessions": {
         "metadata": {
           "total_sessions": 3,
           "total_weeks": 4,
           "domains_covered": ["cognitive", "language", "social"]
         },
         "sessions": [
           {
             "session_date": "2025-11-12",
             "time_slot": "morning",
             "start_time": "09:00",
             "end_time": "10:30",
             "location": "Phòng học số 1",
             "notes": "Tuần 1 - Buổi 1: Giới thiệu màu sắc",
             "contents": [
               {
                 "title": "Nhận biết màu sắc cơ bản",
                 "domain": "cognitive",
                 "description": "Dạy trẻ nhận biết 4 màu: đỏ, vàng, xanh lá, xanh dương",
                 "materials_needed": "Thẻ màu, đồ chơi, hình ảnh",
                 "estimated_duration": 20,
                 "goals": [
                   {
                     "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
                     "goal_type": "knowledge"
                   },
                   {
                     "description": "Trẻ có thể nói tên màu",
                     "goal_type": "skill"
                   }
                 ]
               },
               {
                 "title": "Luyện tập phân loại theo màu",
                 "domain": "cognitive",
                 "description": "Trẻ phân loại đồ vật theo màu sắc",
                 "estimated_duration": 15,
                 "goals": [
                   {
                     "description": "Trẻ sắp xếp đồ vật đúng màu",
                     "goal_type": "skill"
                   }
                 ]
               }
             ]
           },
           {
             "session_date": "2025-11-14",
             "time_slot": "morning",
             "contents": [...]
           },
           {
             "session_date": "2025-11-16",
             "time_slot": "afternoon",
             "contents": [...]
           }
         ]
       },
       "completed_at": "2025-11-05T13:48:15Z",
       "processing_time_seconds": 42
     }
   }
   ```

3. **Verify Result Structure:**
   - ✅ `result_sessions` is valid JSONB
   - ✅ Each session has valid date (future dates)
   - ✅ Each content has valid domain
   - ✅ Each goal has description + goal_type
   - ✅ Total sessions count matches metadata

**GPT-4 Prompt Engineering:**
```
System: You are an educational planner for children with autism.

User: Parse this educational plan and generate a structured JSON with sessions.

Output format:
{
  "sessions": [
    {
      "session_date": "YYYY-MM-DD",
      "time_slot": "morning|afternoon",
      "contents": [
        {
          "title": "...",
          "domain": "cognitive|motor|language|social|self_care",
          "goals": [{"description": "...", "goal_type": "knowledge|skill|behavior"}]
        }
      ]
    }
  ]
}

Plan content: {{extracted_text}}
```

---

### 7.8 Create Sessions from AI Result - Success

**Test ID:** `AI-008`  
**Priority:** High  
**Category:** AI Processing - Integration

**Test Objective:**  
Verify converting AI result to actual database sessions

**Test Steps:**

1. **Create sessions from AI:**
   ```http
   POST /api/ai/process/{{processing_id}}/create-sessions
   Authorization: Bearer {{access_token}}
   Content-Type: application/json

   {
     "sessions": [
       {
         "session_date": "2025-11-12",
         "time_slot": "morning",
         "start_time": "09:00:00",
         "end_time": "10:30:00",
         "location": "Phòng học số 1",
         "notes": "Tuần 1 - Buổi 1",
         "contents": [
           {
             "title": "Nhận biết màu sắc cơ bản",
             "domain": "cognitive",
             "description": "...",
             "materials_needed": "...",
             "estimated_duration": 20,
             "goals": [
               {
                 "description": "Trẻ có thể chỉ đúng màu",
                 "goal_type": "knowledge"
               }
             ]
           }
         ]
       }
     ]
   }
   ```

2. **Verify Response:**
   ```json
   {
     "success": true,
     "message": "Đã tạo thành công 3 buổi học từ AI",
     "sessions": [
       {
         "id": "<uuid>",
         "student_id": "{{student_id}}",
         "session_date": "2025-11-12",
         "creation_method": "ai",
         "status": "pending",
         "contents_count": 2,
         "goals_count": 5
       }
     ],
     "stats": {
       "total_sessions": 3,
       "total_contents": 7,
       "total_goals": 16
     }
   }
   ```

3. **Database Validation:**
   ```sql
   -- Check sessions created
   SELECT * FROM sessions 
   WHERE student_id = :student_id 
     AND creation_method = 'ai'
   ORDER BY session_date;
   
   -- Should return 3 sessions
   
   -- Check contents and goals
   SELECT 
     s.session_date,
     COUNT(DISTINCT sc.id) AS contents_count,
     COUNT(scg.id) AS goals_count
   FROM sessions s
   LEFT JOIN session_contents sc ON s.id = sc.session_id
   LEFT JOIN session_content_goals scg ON sc.id = scg.session_content_id
   WHERE s.student_id = :student_id 
     AND s.creation_method = 'ai'
   GROUP BY s.id, s.session_date;
   ```

4. **Verify `creation_method`:**
   - All sessions have `creation_method = 'ai'`
   - Distinguished from manual sessions

**Expected Behavior:**
- ✅ Batch insert (transaction for data integrity)
- ✅ If any session fails validation → rollback all
- ✅ All sessions linked to same student
- ✅ `created_by` = authenticated teacher

---

### 7.9 Create Sessions - Validation: Invalid Date

**Test ID:** `AI-009`  
**Priority:** Medium  
**Category:** AI Processing - Validation

**Test Steps:**

1. **Try to create with past date:**
   ```json
   {
     "sessions": [
       {
         "session_date": "2024-01-01"
       }
     ]
   }
   ```

2. **Expected Error:**
   ```json
   {
     "success": false,
     "error": "INVALID_DATE",
     "message": "Ngày buổi học phải trong tương lai hoặc trong vòng 6 tháng trước",
     "details": {
       "session_index": 0,
       "session_date": "2024-01-01"
     }
   }
   ```

---

### 7.10 Processing Failed - Error Handling

**Test ID:** `AI-010`  
**Priority:** High  
**Category:** AI Processing - Error

**Test Objective:**  
Verify error handling when AI processing fails

**Test Steps:**

1. **Simulate AI failure** (e.g., GPT-4 timeout, quota exceeded)

2. **Poll status:**
   ```http
   GET /api/ai/process/{{processing_id}}/status
   ```

3. **Expected Response:**
   ```json
   {
     "success": false,
     "processing_status": "failed",
     "progress": 60,
     "error_message": "AI processing failed: GPT-4 request timeout",
     "message": "Xử lý thất bại. Vui lòng thử lại."
   }
   ```

4. **Database:**
   ```sql
   SELECT processing_status, error_message, failed_at 
   FROM ai_processing 
   WHERE id = :processing_id;
   
   -- processing_status: 'failed'
   -- error_message: error details
   -- failed_at: timestamp
   ```

**Retry Behavior:**
- ✅ User can retry by uploading again
- ✅ Failed processing record kept for debugging
- ✅ No automatic retry (user-initiated only)

---

### 7.11 File Upload - Validation: File Too Large

**Test ID:** `AI-011`  
**Priority:** High  
**Category:** AI Processing - Validation

**Test Steps:**

1. **Upload file > 10MB:**
   ```http
   POST /api/ai/process
   Content-Type: multipart/form-data

   file: @large_file.pdf (15MB)
   ```

2. **Expected Error:**
   ```json
   {
     "success": false,
     "error": "FILE_TOO_LARGE",
     "message": "File quá lớn. Kích thước tối đa: 10MB",
     "details": {
       "file_size": 15728640,
       "max_allowed": 10485760
     }
   }
   ```
   - Status: `400 Bad Request`

**Validation:**
- ✅ Check file size before R2 upload
- ✅ Reject at API level (don't waste R2 bandwidth)

---

### 7.12 File Upload - Validation: Unsupported Format

**Test ID:** `AI-012`  
**Priority:** High  
**Category:** AI Processing - Validation

**Test Steps:**

1. **Upload unsupported file:**
   ```http
   POST /api/ai/process

   file: @file.mp4 (video file)
   ```

2. **Expected Error:**
   ```json
   {
     "success": false,
     "error": "UNSUPPORTED_FILE_TYPE",
     "message": "Định dạng file không được hỗ trợ",
     "details": {
       "file_type": "video/mp4",
       "allowed_types": ["application/pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "text/plain", "image/jpeg", "image/png"]
     }
   }
   ```

**Supported Formats:**
- ✅ PDF: `application/pdf`
- ✅ DOCX: `application/vnd.openxmlformats-officedocument.wordprocessingml.document`
- ✅ TXT: `text/plain`
- ✅ JPG: `image/jpeg`
- ✅ PNG: `image/png`

---

### 7.13 File Upload - Both File and Text

**Test ID:** `AI-013`  
**Priority:** Medium  
**Category:** AI Processing - Validation

**Test Steps:**

1. **Send both file and text:**
   ```http
   POST /api/ai/process
   Content-Type: multipart/form-data

   file: @plan.pdf
   text_content: "Some text..."
   ```

2. **Expected Error:**
   ```json
   {
     "success": false,
     "error": "VALIDATION_ERROR",
     "message": "Chỉ được gửi file HOẶC text, không được cả hai"
   }
   ```

**Business Rule:**
- Either `file` OR `text_content`, not both

---

### 7.14 Text Content - Max Length Validation

**Test ID:** `AI-014`  
**Priority:** Medium  
**Category:** AI Processing - Validation

**Test Steps:**

1. **Send text > 5000 chars:**
   ```json
   {
     "text_content": "Lorem ipsum... (6000 characters)"
   }
   ```

2. **Expected Error:**
   ```json
   {
     "success": false,
     "error": "TEXT_TOO_LONG",
     "message": "Nội dung văn bản quá dài. Tối đa: 5000 ký tự",
     "details": {
       "text_length": 6000,
       "max_allowed": 5000
     }
   }
   ```

---

### 7.15 Rate Limiting - AI Processing

**Test ID:** `AI-015`  
**Priority:** High  
**Category:** AI Processing - Rate Limit

**Test Steps:**

1. **Send 6 AI processing requests within 1 hour:**
   ```http
   POST /api/ai/process (request 1)
   POST /api/ai/process (request 2)
   ...
   POST /api/ai/process (request 6)
   ```

2. **Expected on 6th request:**
   ```json
   {
     "success": false,
     "error": "RATE_LIMIT_EXCEEDED",
     "message": "Bạn đã vượt quá giới hạn xử lý AI. Vui lòng thử lại sau 1 giờ.",
     "details": {
       "limit": 5,
       "window": "1 hour",
       "retry_after": 3600
     }
   }
   ```
   - Status: `429 Too Many Requests`
   - Header: `Retry-After: 3600`

**Rate Limit:**
- ✅ 5 AI processing requests per hour per teacher
- ✅ Stored in Redis with TTL
- ✅ Key: `ratelimit:ai:{teacher_id}`

---

### 7.16 Delete AI Processing Record

**Test ID:** `AI-016`  
**Priority:** Low  
**Category:** AI Processing

**Test Steps:**

1. **Delete processing:**
   ```http
   DELETE /api/ai/process/{{processing_id}}
   Authorization: Bearer {{access_token}}
   ```

2. **Verify:**
   - Status: `200 OK`
   - Record deleted from database
   - File deleted from R2 (cleanup)

**Business Rule:**
- ✅ Can delete completed/failed processing
- ⚠️ Cannot delete while `processing_status = 'processing'`

---

### 7.17 Access Control - AI Processing

**Test ID:** `AI-017`  
**Priority:** High  
**Category:** AI Processing - Security

**Test Steps:**

1. **Teacher A creates AI processing**
2. **Teacher B tries to access:**
   ```http
   GET /api/ai/process/{{processing_id}}
   Authorization: Bearer {{teacher_b_token}}
   ```

3. **Expected:**
   ```json
   {
     "success": false,
     "error": "FORBIDDEN",
     "message": "Bạn không có quyền truy cập AI processing này"
   }
   ```
   - Status: `403 Forbidden`

---

### 7.18 GPT-4 Prompt Quality Test

**Test ID:** `AI-018`  
**Priority:** Medium  
**Category:** AI Processing - Quality

**Test Objective:**  
Verify quality of GPT-4 generated sessions

**Test Steps:**

1. **Upload sample educational plan**

2. **Verify AI output quality:**
   - ✅ Sessions have logical date progression
   - ✅ Contents are age-appropriate
   - ✅ Goals are measurable and specific
   - ✅ Domains correctly identified
   - ✅ No hallucinated information

**Quality Metrics:**
- Session dates in chronological order
- Reasonable session duration (30-120 min)
- Goals align with content descriptions
- Appropriate difficulty progression

---

### 7.19 OCR Accuracy Test (Image Processing)

**Test ID:** `AI-019`  
**Priority:** Low  
**Category:** AI Processing - OCR

**Test Steps:**

1. **Upload high-quality typed text image**
2. **Upload handwritten text image**
3. **Compare OCR accuracy:**
   - Typed text: > 95% accuracy expected
   - Handwritten: > 70% accuracy expected

**Acceptance Criteria:**
- ✅ Typed text extraction > 95% accurate
- ✅ Handwritten text extraction > 70% accurate
- ⚠️ Low-quality images may require manual correction

---

### 7.20 AI Processing Timeout Test

**Test ID:** `AI-020`  
**Priority:** Medium  
**Category:** AI Processing - Performance

**Test Steps:**

1. **Upload large document (near 10MB)**

2. **Monitor processing time:**
   - Expected: < 90 seconds
   - Timeout: 120 seconds

3. **If timeout:**
   ```json
   {
     "processing_status": "failed",
     "error_message": "Processing timeout after 120 seconds"
   }
   ```

**Performance Targets:**
- ✅ PDF (< 5 pages): 30-45 seconds
- ✅ PDF (5-20 pages): 45-90 seconds
- ✅ Image with OCR: 60-90 seconds
- ⚠️ Timeout at 120 seconds

---

## 📊 TEST SUMMARY - SECTION 7

| Category | Test Cases | Priority |
|----------|-----------|----------|
| File Upload | 5 | High |
| Text Upload | 2 | Medium |
| Processing Status | 3 | High |
| AI Results | 3 | High |
| Create Sessions | 2 | High |
| Error Handling | 2 | High |
| Validation | 5 | High/Medium |
| Performance | 3 | Medium/Low |
| **Total** | **20** | - |

### Coverage Metrics

- ✅ **API Endpoints:** 5/5 (100%)
- ✅ **File Types:** 5/5 (PDF, DOCX, TXT, JPG, PNG)
- ✅ **AI Integration:** GPT-4 + OCR tested
- ✅ **Error Scenarios:** 100% covered
- ✅ **Rate Limiting:** Tested
- ✅ **Access Control:** Tested

### Critical Paths Tested

1. ✅ Upload File → Process (OCR if needed) → GPT-4 → Parse JSON → Create Sessions
2. ✅ Upload Text → GPT-4 → Parse JSON → Create Sessions
3. ✅ Processing Failed → Error Handling → User Retry
4. ✅ Rate Limit → Prevent Abuse
5. ✅ Access Control → Teacher Isolation

### AI Processing Flow

```
Upload → Validate → Store R2 → Queue Job
  ↓
Background Worker:
  1. Extract text (OCR if image, parse if PDF/DOCX)
  2. Call GPT-4 with prompt
  3. Parse response to JSON
  4. Validate structure
  5. Store in result_sessions (JSONB)
  6. Update status to 'completed'
  ↓
User Polls Status → Get Result → Create Sessions
```

---

## 🔄 NEXT STEPS

Continue to **PART 6**:
- Section 8: Analytics & Reports Tests (15 test cases)
- Section 9: Settings & Sync Tests (15 test cases)
- Section 10: Security & Edge Cases Tests (20 test cases)

**File:** `TEST_CASE_API/PART6.md`

---

**✅ PART 5 COMPLETED**  
**Test Cases:** 20  
**Coverage:** AI Processing (100%)
```

---

Tiếp tục với **PART 6** trong phần tiếp theo...
