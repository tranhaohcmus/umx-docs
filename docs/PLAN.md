# 📅 LỘ TRÌNH CHI TIẾT THEO NGÀY - EDUCARE CONNECT API

**Version:** 1.0  
**Start Date:** 2025-11-05  
**Duration:** 8 weeks (40 working days)  
**Developer:** tranhaohcmus

---

## 🗓️ TUẦN 1: FOUNDATION & AUTHENTICATION (05/11 - 09/11)

### **NGÀY 1 - Thứ Hai 05/11: Project Setup & Infrastructure**

**Morning (4h):**
- [ ] Tạo repository GitHub `educare-api`
- [ ] Initialize Node.js project với TypeScript
- [ ] Cài đặt dependencies chính: Express, Prisma, bcryptjs, JWT, dotenv, cors, helmet
- [ ] Cài đặt dev dependencies: nodemon, ts-node-dev, eslint, prettier
- [ ] Setup TypeScript config (tsconfig.json)
- [ ] Setup ESLint + Prettier config
- [ ] Tạo cấu trúc thư mục theo mô-đun

**Afternoon (4h):**
- [ ] Initialize Prisma với PostgreSQL
- [ ] Tạo database schema đầy đủ (20 tables):
  - TEACHERS
  - STUDENTS
  - SESSIONS
  - SESSION_CONTENTS
  - SESSION_CONTENT_GOALS
  - SESSION_LOGS
  - GOAL_EVALUATIONS
  - MEDIA_ATTACHMENTS
  - BEHAVIOR_GROUPS
  - BEHAVIOR_LIBRARY
  - BEHAVIOR_INCIDENTS
  - TEACHER_FAVORITES
  - CONTENT_LIBRARY
  - TEMPLATE_RATINGS
  - AI_PROCESSING
  - REPORTS
  - BACKUPS
- [ ] Chạy migration đầu tiên
- [ ] Setup .env file với tất cả biến môi trường
- [ ] Test database connection

**Deliverables:**
- Repository có cấu trúc thư mục hoàn chỉnh
- Database schema migration thành công
- Prisma Client generate thành công

---

### **NGÀY 2 - Thứ Ba 06/11: Core Configuration & Auth Module (Part 1)**

**Morning (4h):**
- [ ] Tạo `src/config/database.ts` - Prisma client singleton
- [ ] Tạo `src/config/redis.ts` - Redis connection
- [ ] Tạo `src/utils/logger.ts` - Winston logger với file rotation
- [ ] Tạo `src/middlewares/errorHandler.ts` - Global error handling middleware
- [ ] Tạo custom AppError class với error codes
- [ ] Tạo `src/utils/jwt.ts`:
  - Function generateTokens (access + refresh)
  - Function verifyAccessToken
  - Function verifyRefreshToken

**Afternoon (4h):**
- [ ] Tạo `src/modules/auth/auth.validation.ts`:
  - registerSchema (Joi validation)
  - loginSchema
  - refreshTokenSchema
  - forgotPasswordSchema
  - resetPasswordSchema
- [ ] Tạo `src/middlewares/validate.ts` - Request validation middleware
- [ ] Tạo `src/utils/password.ts`:
  - Function hashPassword (bcrypt)
  - Function comparePassword
  - Function validatePasswordStrength
- [ ] Test tất cả utils functions

**Deliverables:**
- Core config files hoàn chỉnh
- Validation middleware hoạt động
- Logger ghi logs ra file

---

### **NGÀY 3 - Thứ Tư 07/11: Auth Module (Part 2) & Email Service**

**Morning (4h):**
- [ ] Tạo `src/modules/auth/auth.service.ts`:
  - Method register (hash password, create user, NOT verified)
  - Method login (check credentials, verify email, generate tokens, update last_login_at)
  - Method refreshToken (verify refresh token, generate new access token)
  - Method verifyEmail (verify JWT token, update is_verified)
  - Method forgotPassword (generate reset token, send email)
  - Method resetPassword (verify token, update password)
- [ ] Tạo `src/utils/email.ts`:
  - Setup nodemailer hoặc SendGrid
  - Function sendVerificationEmail
  - Function sendPasswordResetEmail
  - Email templates (HTML)

**Afternoon (4h):**
- [ ] Tạo `src/modules/auth/auth.controller.ts`:
  - POST /register
  - POST /login
  - POST /refresh
  - GET /verify-email?token=xxx
  - POST /forgot-password
  - POST /reset-password
- [ ] Tạo `src/modules/auth/auth.routes.ts`
- [ ] Tạo `src/middlewares/auth.ts` - JWT verification middleware
- [ ] Mount auth routes vào app

**Deliverables:**
- 6 auth endpoints hoạt động
- Email verification flow hoàn chỉnh
- Password reset flow hoàn chỉnh

---

### **NGÀY 4 - Thứ Năm 08/11: User Management & Rate Limiting**

**Morning (4h):**
- [ ] Tạo `src/modules/teachers/teachers.service.ts`:
  - Method getProfile (get authenticated user info)
  - Method updateProfile (update first_name, last_name, phone, school, timezone, language)
  - Method uploadAvatar (upload to R2, resize to 512x512)
  - Method changePassword (verify current, update new)
  - Method deleteAccount (soft delete, cascade to students/sessions)
- [ ] Tạo `src/config/r2.ts` - Cloudflare R2 S3 client
- [ ] Tạo `src/utils/upload.ts`:
  - Function uploadToR2 (image, document, video)
  - Function generateSignedUrl
  - Function deleteFromR2
  - Function resizeImage (sharp library)

**Afternoon (4h):**
- [ ] Tạo `src/modules/teachers/teachers.controller.ts`:
  - GET /api/teachers/me
  - PATCH /api/teachers/me
  - POST /api/teachers/me/avatar (multipart upload)
  - DELETE /api/account
- [ ] Tạo `src/middlewares/rateLimit.ts`:
  - General API rate limit (100/min)
  - Login rate limit (5 failed attempts/15min)
  - File upload rate limit (10/min)
- [ ] Tạo `src/middlewares/upload.ts` - Multer config
- [ ] Mount teachers routes

**Deliverables:**
- 4 user management endpoints
- Avatar upload working
- Rate limiting active

---

### **NGÀY 5 - Thứ Sáu 09/11: Authentication Testing**

**Morning (4h):**
- [ ] Setup Jest + Supertest
- [ ] Tạo `tests/helpers/testDb.ts` - Test database utilities
- [ ] Tạo `tests/helpers/authHelpers.ts` - Helper functions (register, login, getToken)
- [ ] Viết unit tests cho `auth.service.ts`:
  - Test register success
  - Test register duplicate email
  - Test register weak password
  - Test login success
  - Test login invalid credentials
  - Test login unverified email
  - Test refresh token success
  - Test refresh token expired

**Afternoon (4h):**
- [ ] Viết integration tests cho auth endpoints:
  - POST /auth/register (TC-AUTH-001 đến 004)
  - POST /auth/login (TC-AUTH-005 đến 007)
  - POST /auth/refresh (TC-AUTH-008, 009)
  - POST /auth/logout (TC-AUTH-010)
  - GET /auth/verify-email (TC-AUTH-011, 012, 013)
- [ ] Viết tests cho rate limiting
- [ ] Chạy coverage report (target: >90% cho auth module)
- [ ] Fix bugs nếu có

**Deliverables:**
- 35 test cases pass
- Coverage auth module >90%
- CI/CD pipeline setup (GitHub Actions)

---

## 🗓️ TUẦN 2: STUDENT MANAGEMENT (12/11 - 16/11)

### **NGÀY 6 - Thứ Hai 12/11: Student CRUD (Part 1)**

**Morning (4h):**
- [ ] Tạo `src/modules/students/students.validation.ts`:
  - createStudentSchema (validate age 2-18, required fields)
  - updateStudentSchema
  - changeStatusSchema
- [ ] Tạo `src/modules/students/students.service.ts`:
  - Method create:
    - Validate age from date_of_birth
    - Upload avatar nếu có
    - Create student với teacher_id
  - Method list:
    - Search by first_name/last_name/nickname (case insensitive)
    - Filter by status
    - Pagination
    - Sort by created_at DESC

**Afternoon (4h):**
- [ ] Continue `students.service.ts`:
  - Method getById:
    - Get student details
    - Calculate stats (total_sessions, completed_sessions, pending_sessions)
  - Method update:
    - Partial update
    - Handle avatar update
  - Method changeStatus (active/paused/archived)
  - Method softDelete:
    - Set deleted_at
    - Cascade soft delete sessions (app logic)

**Deliverables:**
- StudentsService hoàn chỉnh
- Avatar upload working
- Soft delete logic

---

### **NGÀY 7 - Thứ Ba 13/11: Student CRUD (Part 2) & Access Control**

**Morning (4h):**
- [ ] Tạo `src/modules/students/students.controller.ts`:
  - POST /api/students (multipart form-data)
  - GET /api/students?search=&status=&page=&limit=
  - GET /api/students/:student_id
  - PATCH /api/students/:student_id (multipart)
  - DELETE /api/students/:student_id
  - PATCH /api/students/:student_id/status
- [ ] Tạo `src/middlewares/ownership.ts`:
  - Middleware checkStudentOwnership (verify student belongs to teacher)
  - Apply to update/delete/get endpoints

**Afternoon (4h):**
- [ ] Tạo `src/modules/students/students.routes.ts`
- [ ] Mount students routes
- [ ] Test manual với Postman:
  - Create student with valid data
  - Create student with age <2 (should fail)
  - Create student with age >18 (should fail)
  - Upload avatar (max 5MB)
  - Upload avatar >5MB (should fail)
  - List students with search
  - List students with pagination
  - Update student
  - Change status
  - Soft delete

**Deliverables:**
- 6 student endpoints working
- Access control working
- Avatar upload validated

---

### **NGÀY 8 - Thứ Tư 14/11: Student Testing**

**Morning (4h):**
- [ ] Viết unit tests cho `students.service.ts`:
  - Test create success (TC-STU-001)
  - Test create invalid age (TC-STU-002)
  - Test create with avatar (TC-STU-003)
  - Test create avatar too large (TC-STU-004)
  - Test list with pagination (TC-STU-005)
  - Test list with search (TC-STU-006)
  - Test list with filters (TC-STU-007)

**Afternoon (4h):**
- [ ] Viết integration tests:
  - Test get student details with stats (TC-STU-008)
  - Test update student (TC-STU-009)
  - Test soft delete (TC-STU-010)
  - Test change status (TC-STU-011)
  - Test access control (student of another teacher) (TC-STU-019)
- [ ] Coverage report
- [ ] Fix bugs

**Deliverables:**
- 30 test cases pass
- Coverage >85%

---

### **NGÀY 9 - Thứ Năm 15/11: Session Schema & Basic CRUD**

**Morning (4h):**
- [ ] Review Prisma schema cho sessions:
  - SESSION table
  - SESSION_CONTENTS table
  - SESSION_CONTENT_GOALS table
  - Relationships (CASCADE on delete)
- [ ] Tạo `src/modules/sessions/sessions.validation.ts`:
  - createSessionSchema (validate date range, time range, duration)
  - addContentSchema
  - addContentFromTemplateSchema
  - reorderContentsSchema
- [ ] Tạo helper functions:
  - calculateDuration(start_time, end_time)
  - validateDateRange(session_date)
  - validateTimeRange(start_time, end_time)

**Afternoon (4h):**
- [ ] Tạo `src/modules/sessions/sessions.service.ts`:
  - Method create (Step 1):
    - Verify student ownership
    - Validate date (6 months ago to 1 year future)
    - Validate time (end > start, duration >= 30 min)
    - Calculate duration_minutes
    - Create session with status='pending'
    - Return next_step='add_contents'
  - Method addContent (Step 2):
    - Verify session ownership
    - Validate domain
    - Auto-increment order_index
    - Create content with goals (nested)
  - Method addContentFromTemplate (Step 2 alternative):
    - Fetch template
    - Copy to session_contents
    - Create goals from default_goals JSONB
    - Increment template usage_count (trigger)

**Deliverables:**
- Session creation Step 1, 2 working
- Template usage working

---

### **NGÀY 10 - Thứ Sáu 16/11: Session Management Complete**

**Morning (4h):**
- [ ] Continue `sessions.service.ts`:
  - Method reorderContents:
    - Update order_index for multiple contents
    - Transaction
  - Method confirmSession (Step 3):
    - Validate has >= 1 content
    - Count contents and goals
    - Return summary
  - Method list:
    - Filter by student_id, status, date_range
    - Pagination
  - Method getById:
    - Include contents (nested)
    - Include goals (nested)
    - Order by order_index

**Afternoon (4h):**
- [ ] Continue `sessions.service.ts`:
  - Method update (basic info only)
  - Method cancel:
    - Set status='cancelled'
    - Set cancellation_reason
    - Set cancelled_at
  - Method softDelete:
    - Set deleted_at
    - NOT cascade (FK preserved)
- [ ] Tạo `src/modules/sessions/sessions.controller.ts`:
  - POST /api/sessions (Step 1)
  - POST /api/sessions/:id/contents (Step 2)
  - POST /api/sessions/:id/contents/from-template (Step 2)
  - PATCH /api/sessions/:id/contents/reorder (Step 2)
  - POST /api/sessions/:id/confirm (Step 3)
  - GET /api/sessions
  - GET /api/sessions/:id
  - PATCH /api/sessions/:id
  - POST /api/sessions/:id/cancel
  - DELETE /api/sessions/:id

**Deliverables:**
- 10 session endpoints working
- 3-step creation flow complete

---

## 🗓️ TUẦN 3: SESSION LOGGING & MEDIA (19/11 - 23/11)

### **NGÀY 11 - Thứ Hai 19/11: Session Logging (Part 1)**

**Morning (4h):**
- [ ] Tạo `src/modules/session-logs/session-logs.validation.ts`:
  - evaluateGoalsSchema
  - updateAttitudeSchema
  - updateNotesSchema
- [ ] Tạo `src/modules/session-logs/session-logs.service.ts`:
  - Method create:
    - Check 1-1 relationship (session can have max 1 log)
    - Create SESSION_LOGS record
    - Set logged_at = NOW()
    - Return next_step='evaluate_goals'
  - Method evaluateGoals (Step 1):
    - Validate all goals evaluated
    - Validate status enum
    - Validate achievement_level (0-100)
    - Validate support_level enum
    - Create GOAL_EVALUATIONS records
    - Use UNIQUE constraint (session_log_id, content_goal_id)

**Afternoon (4h):**
- [ ] Continue `session-logs.service.ts`:
  - Method updateAttitude (Step 2):
    - Validate mood enum
    - Validate levels (1-5)
    - Update SESSION_LOGS
    - Return next_step='notes_media'
  - Method updateNotes (Step 3):
    - Validate text length (max 2000 chars each)
    - Validate overall_rating (1-5)
    - Validate actual_end_time > actual_start_time
    - Update SESSION_LOGS
    - Return next_step='behavior_optional'

**Deliverables:**
- Session log creation working
- 3 logging steps working

---

### **NGÀY 12 - Thứ Ba 20/11: Session Logging (Part 2) & Media Upload**

**Morning (4h):**
- [ ] Continue `session-logs.service.ts`:
  - Method complete:
    - Validate all required steps done
    - Set completed_at = NOW()
    - Update SESSION status='completed'
    - Set SESSION has_evaluation=true
  - Method getById:
    - Include goal_evaluations
    - Include media_attachments
    - Include behavior_incidents
- [ ] Tạo `src/modules/media/media.service.ts`:
  - Method requestUploadUrl:
    - Validate file type (image/video/audio)
    - Validate file size
    - Generate signed upload URL (R2 presigned)
    - Create MEDIA_ATTACHMENTS record (status='pending')
    - Return upload_url, file_url, media_id

**Afternoon (4h):**
- [ ] Continue `media.service.ts`:
  - Method confirmUpload:
    - Update status='uploaded'
    - Extract metadata (width, height for images)
    - Generate thumbnail for images
    - Update MEDIA_ATTACHMENTS
  - Method list (by session_log_id)
  - Method delete (delete from R2 + DB)
- [ ] Validate limits:
  - Max 10 images per log
  - Max 3 videos per log
  - Max 5 audios per log

**Deliverables:**
- Session log complete flow
- Media upload working (presigned URL)

---

### **NGÀY 13 - Thứ Tư 21/11: Session Logging Controllers & Routes**

**Morning (4h):**
- [ ] Tạo `src/modules/session-logs/session-logs.controller.ts`:
  - POST /api/sessions/:session_id/logs
  - PUT /api/session-logs/:log_id/goals
  - PUT /api/session-logs/:log_id/attitude
  - PUT /api/session-logs/:log_id/notes
  - POST /api/session-logs/:log_id/complete
  - GET /api/session-logs/:log_id
- [ ] Tạo `src/modules/media/media.controller.ts`:
  - POST /api/media/upload-url
  - POST /api/media/:media_id/confirm
  - GET /api/media/:media_id
  - DELETE /api/media/:media_id

**Afternoon (4h):**
- [ ] Mount routes
- [ ] Test manual với Postman:
  - Complete flow: Create log → Evaluate goals → Attitude → Notes → Upload media → Complete
  - Test goal evaluation validation
  - Test media upload limits
  - Test cannot edit completed log
- [ ] Fix bugs

**Deliverables:**
- 10 logging + media endpoints
- Complete logging flow tested

---

### **NGÀY 14 - Thứ Năm 22/11: Session & Logging Testing**

**Morning (4h):**
- [ ] Viết unit tests cho `sessions.service.ts`:
  - Test create session success (TC-SES-001)
  - Test invalid date range (TC-SES-002)
  - Test invalid time range (TC-SES-003)
  - Test duration too short (TC-SES-004)
  - Test add content (TC-SES-005)
  - Test add content invalid domain (TC-SES-006)
  - Test add content no goals (TC-SES-007)
  - Test use template (TC-SES-008)
  - Test reorder contents (TC-SES-009)
  - Test confirm session (TC-SES-010)
  - Test confirm no contents (TC-SES-011)

**Afternoon (4h):**
- [ ] Viết tests cho `session-logs.service.ts`:
  - Test create log (TC-LOG-001)
  - Test duplicate log (TC-LOG-002)
  - Test evaluate goals (TC-LOG-003, 004, 005)
  - Test update attitude (TC-LOG-006, 007)
  - Test update notes (TC-LOG-008)
  - Test upload media (TC-LOG-009, 010)
  - Test complete log (TC-LOG-011)
  - Test cannot edit completed (TC-LOG-012)

**Deliverables:**
- 40 test cases pass
- Coverage >85%

---

### **NGÀY 15 - Thứ Sáu 23/11: Session Testing Complete**

**Morning (4h):**
- [ ] Viết integration tests:
  - Test list sessions with filters (TC-SES-012, 013, 014)
  - Test get session details (TC-SES-015)
  - Test update session (TC-SES-016)
  - Test cancel session (TC-SES-017)
  - Test soft delete (TC-SES-018)
  - Test access control (TC-SES-019, 020)

**Afternoon (4h):**
- [ ] Performance tests:
  - Test session with 10 contents, 100 goals
  - Test query performance
- [ ] Coverage report
- [ ] Fix bugs
- [ ] Update API documentation

**Deliverables:**
- 45 session test cases pass
- Performance acceptable

---

## 🗓️ TUẦN 4: BEHAVIOR SYSTEM (26/11 - 30/11)

### **NGÀY 16 - Thứ Hai 26/11: Behavior Library Seeding**

**Morning (4h):**
- [ ] Tạo `prisma/seeds/behavior-groups.ts`:
  - Seed 3 BEHAVIOR_GROUPS:
    - GROUP_01: CHỐNG ĐỐI & BƯỚNG BỈNH (😤, #FF5733)
    - GROUP_02: HÀNH VI GÂY HẤN (👊, #DC3545)
    - GROUP_03: VẤN ĐỀ VỀ GIÁC QUAN (👂, #FFC107)
- [ ] Tạo `prisma/seeds/behavior-library.ts`:
  - Seed 127 behaviors với full JSONB data:
    - keywords_vn, keywords_en
    - explanation (array of objects)
    - solutions (array of steps)
    - prevention_strategies (array of categories)
    - sources (array of citations)
    - related_behaviors (array of UUIDs)

**Afternoon (4h):**
- [ ] Chạy seed script
- [ ] Tạo GIN indexes:
  - CREATE INDEX idx_behavior_keywords_vn ON behavior_library USING GIN (keywords_vn);
  - CREATE INDEX idx_behavior_keywords_en ON behavior_library USING GIN (keywords_en);
- [ ] Verify data:
  - Count behaviors per group
  - Test JSONB queries
- [ ] Export seed file to repository

**Deliverables:**
- 3 groups + 127 behaviors seeded
- GIN indexes created
- Seed script in repo

---

### **NGÀY 17 - Thứ Ba 27/11: Behavior Search & Details**

**Morning (4h):**
- [ ] Tạo `src/modules/behaviors/behaviors.service.ts`:
  - Method listGroups:
    - Get all groups with behaviors_count (aggregate)
    - Order by order_index
  - Method search:
    - Full-text search on name_vn, name_en
    - JSONB search on keywords_vn, keywords_en (GIN index)
    - Filter by group_id
    - Filter by favorites_only
    - Order by: favorites first, then usage_count DESC
    - Pagination

**Afternoon (4h):**
- [ ] Continue `behaviors.service.ts`:
  - Method getById:
    - Get behavior with full JSONB parsing
    - Join BEHAVIOR_GROUPS
    - Check if favorite (TEACHER_FAVORITES)
    - Get usage_count, last_used_at
    - Parse related_behaviors (fetch details)
- [ ] Optimize queries:
  - Use Prisma select to reduce data
  - Index on behavior_group_id
  - Index on usage_count

**Deliverables:**
- Behavior search working
- Full-text search optimized
- JSONB parsing correct

---

### **NGÀY 18 - Thứ Tư 28/11: Behavior Incidents & Favorites**

**Morning (4h):**
- [ ] Tạo `src/modules/behaviors/incidents.service.ts`:
  - Method create:
    - Validate session_log_id ownership
    - Validate A-B-C fields (antecedent, behavior, consequence)
    - Validate intensity_level (1-5)
    - Validate frequency_count > 0
    - Create BEHAVIOR_INCIDENTS
    - Trigger: increment usage_count, update last_used_at
  - Method update (partial)
  - Method delete

**Afternoon (4h):**
- [ ] Tạo `src/modules/behaviors/favorites.service.ts`:
  - Method add:
    - Check unique (teacher_id, behavior_library_id)
    - Use ON CONFLICT DO NOTHING (idempotent)
  - Method remove
  - Method list (get all favorites with full behavior details)
- [ ] Tạo database trigger:
  - CREATE TRIGGER increment_behavior_usage AFTER INSERT ON behavior_incidents
  - Function updates usage_count and last_used_at

**Deliverables:**
- Incidents CRUD working
- Favorites working
- Trigger working

---

### **NGÀY 19 - Thứ Năm 29/11: Behavior Controllers & Routes**

**Morning (4h):**
- [ ] Tạo `src/modules/behaviors/behaviors.controller.ts`:
  - GET /api/behavior-groups
  - GET /api/behaviors?q=&group_id=&favorites_only=&limit=
  - GET /api/behaviors/:behavior_id
- [ ] Tạo `src/modules/behaviors/incidents.controller.ts`:
  - POST /api/behavior-incidents
  - PATCH /api/behavior-incidents/:incident_id
  - DELETE /api/behavior-incidents/:incident_id
- [ ] Tạo `src/modules/behaviors/favorites.controller.ts`:
  - POST /api/teachers/me/favorites
  - DELETE /api/teachers/me/favorites/:behavior_id
  - GET /api/teachers/me/favorites

**Afternoon (4h):**
- [ ] Mount routes
- [ ] Test manual:
  - Search behaviors (Vietnamese, English, keywords)
  - Get behavior details (check JSONB parsing)
  - Create incident with A-B-C model
  - Verify usage_count incremented
  - Add/remove favorites
  - List favorites (should appear first in search)
- [ ] Fix bugs

**Deliverables:**
- 9 behavior endpoints working
- Search performance good (<200ms)

---

### **NGÀY 20 - Thứ Sáu 30/11: Behavior Testing**

**Morning (4h):**
- [ ] Viết unit tests:
  - Test list groups (BEH-001)
  - Test search Vietnamese (BEH-002)
  - Test search English (BEH-003)
  - Test filter by group (BEH-004)
  - Test get details (BEH-005)
  - Test JSONB parsing

**Afternoon (4h):**
- [ ] Viết integration tests:
  - Test add to favorites (BEH-006, 007)
  - Test list favorites (BEH-008, 009)
  - Test remove favorites (BEH-010)
  - Test create incident (BEH-011, 012)
  - Test incident validation (BEH-013, 014)
  - Test update incident (BEH-015)
  - Test delete incident (BEH-016)
  - Test access control (BEH-017)
  - Test search performance (BEH-018)
  - Test cascade delete (BEH-019)
- [ ] Coverage report

**Deliverables:**
- 25 test cases pass
- Coverage >80%

---

## 🗓️ TUẦN 5: CONTENT LIBRARY & TEMPLATES (03/12 - 07/12)

### **NGÀY 21 - Thứ Hai 03/12: Template CRUD**

**Morning (4h):**
- [ ] Tạo `src/modules/content-library/templates.validation.ts`:
  - createTemplateSchema
  - updateTemplateSchema
  - rateTemplateSchema
- [ ] Tạo `src/modules/content-library/templates.service.ts`:
  - Method create:
    - Generate code (CTL_TH_XXX)
    - Validate domain, difficulty_level
    - Validate age range (2-18, min <= max)
    - Store default_goals as JSONB
    - Store tags as JSONB
    - Set is_template=true

**Afternoon (4h):**
- [ ] Continue `templates.service.ts`:
  - Method list:
    - Filter by domain, difficulty, public_only
    - Filter by tags (JSONB @> operator)
    - Include rating_avg, rating_count (aggregate)
    - Pagination
  - Method getById:
    - Include rating stats
    - Parse JSONB fields
  - Method update:
    - Partial update
    - JSONB update is full replacement (not merge)

**Deliverables:**
- Template CRUD working
- JSONB storage working

---

### **NGÀY 22 - Thứ Ba 04/12: Template Usage & Ratings**

**Morning (4h):**
- [ ] Continue `templates.service.ts`:
  - Method softDelete:
    - Set deleted_at
    - Sessions using template still work (FK nullable)
  - Method useInSession:
    - Copy template to session_contents
    - Create goals from default_goals JSONB
    - Set content_library_id (FK)
    - Trigger: increment usage_count, update last_used_at
- [ ] Tạo trigger:
  - CREATE TRIGGER increment_template_usage AFTER INSERT ON session_contents
  - Function updates usage_count and last_used_at

**Afternoon (4h):**
- [ ] Tạo `src/modules/content-library/ratings.service.ts`:
  - Method create:
    - Validate rating (1-5)
    - UNIQUE constraint (content_library_id, teacher_id)
    - Use ON CONFLICT DO UPDATE
  - Method update
  - Method delete
  - Method list:
    - Get all ratings for template
    - Include teacher info
    - Calculate rating_distribution (1-5 stars count)
    - Pagination

**Deliverables:**
- Template usage tracking working
- Ratings CRUD working

---

### **NGÀY 23 - Thứ Tư 05/12: Template Controllers & Testing**

**Morning (4h):**
- [ ] Tạo `src/modules/content-library/templates.controller.ts`:
  - POST /api/content-library
  - GET /api/content-library?domain=&difficulty=&public_only=&tags=&page=&limit=
  - GET /api/content-library/:template_id
  - PATCH /api/content-library/:template_id
  - DELETE /api/content-library/:template_id
- [ ] Tạo `src/modules/content-library/ratings.controller.ts`:
  - POST /api/content-library/:template_id/ratings
  - PATCH /api/content-library/:template_id/ratings
  - GET /api/content-library/:template_id/ratings
  - DELETE /api/content-library/:template_id/ratings
- [ ] Mount routes

**Afternoon (4h):**
- [ ] Test manual:
  - Create template with default_goals JSONB
  - List templates with filters
  - Update template (test JSONB replacement)
  - Delete template (soft delete)
  - Use template in session → verify usage_count +1
  - Rate template
  - Get ratings with distribution
- [ ] Fix bugs

**Deliverables:**
- 9 template endpoints working
- Usage tracking working

---

### **NGÀY 24 - Thứ Năm 06/12: Template Testing**

**Morning (4h):**
- [ ] Viết unit tests:
  - Test create template (CTL-001)
  - Test invalid domain (CTL-002)
  - Test invalid age range (CTL-003)
  - Test invalid difficulty (CTL-004)
  - Test list pagination (CTL-005)
  - Test filter by domain (CTL-006)
  - Test filter by difficulty (CTL-007)
  - Test filter public (CTL-008)
  - Test filter tags (CTL-009)

**Afternoon (4h):**
- [ ] Viết integration tests:
  - Test get details (CTL-010)
  - Test update (CTL-011)
  - Test JSONB update (CTL-012)
  - Test soft delete (CTL-013)
  - Test rate template (CTL-014, 015, 016)
  - Test update rating (CTL-017)
  - Test get ratings (CTL-018)
  - Test delete rating (CTL-019)
  - Test use in session (CTL-020)
- [ ] Coverage report

**Deliverables:**
- 20 test cases pass
- Coverage >85%

---

### **NGÀY 25 - Thứ Sáu 07/12: Buffer Day & Code Review**

**Morning (4h):**
- [ ] Review code quality:
  - Run ESLint
  - Run Prettier
  - Fix warnings
- [ ] Optimize database queries:
  - Add missing indexes
  - Optimize N+1 queries
- [ ] Update Prisma schema comments

**Afternoon (4h):**
- [ ] Update API documentation (Swagger/OpenAPI):
  - Document all endpoints so far (42 endpoints)
  - Add request/response examples
  - Add error codes
- [ ] Merge feature branches
- [ ] Tag release v0.5.0

**Deliverables:**
- Code clean
- Documentation updated
- Release tagged

---

## 🗓️ TUẦN 6: AI PROCESSING (10/12 - 14/12)

### **NGÀY 26 - Thứ Hai 10/12: AI Infrastructure & File Upload**

**Morning (4h):**
- [ ] Install dependencies:
  - openai (GPT-4)
  - pdf-parse (PDF text extraction)
  - tesseract.js (OCR)
  - mammoth (DOCX parsing)
  - bull / bullmq (background jobs)
- [ ] Tạo `src/config/openai.ts` - OpenAI client
- [ ] Tạo `src/config/queue.ts` - Bull queue config
- [ ] Tạo `src/utils/pdf.ts`:
  - Function extractTextFromPDF
- [ ] Tạo `src/utils/ocr.ts`:
  - Function extractTextFromImage (Tesseract.js)
- [ ] Tạo `src/utils/docx.ts`:
  - Function extractTextFromDOCX (mammoth)

**Afternoon (4h):**
- [ ] Tạo `src/modules/ai-processing/ai-processing.service.ts`:
  - Method uploadFile:
    - Validate file type (PDF/DOCX/TXT/JPG/PNG)
    - Validate file size (max 10MB)
    - Upload to R2 (path: ai-processing/{teacher_id}/{id}/)
    - Create AI_PROCESSING record (status='pending')
    - Queue background job
    - Return processing_id
  - Method uploadText:
    - Validate text length (max 5000 chars)
    - Create AI_PROCESSING record
    - Queue job

**Deliverables:**
- File upload working
- Text extraction working
- Background queue setup

---

### **NGÀY 27 - Thứ Ba 11/12: GPT-4 Integration**

**Morning (4h):**
- [ ] Tạo `src/utils/openai.ts`:
  - Function buildPrompt:
    - System message: "You are an educational planner for children with autism"
    - User message: "Parse this plan and generate sessions JSON"
    - Output format: sessions array with contents and goals
  - Function callGPT4:
    - Use GPT-4 Turbo model
    - Max tokens: 4000
    - Temperature: 0.3 (deterministic)
    - Parse response JSON
- [ ] Test GPT-4:
  - Send sample educational plan
  - Verify JSON structure
  - Validate sessions format

**Afternoon (4h):**
- [ ] Tạo `src/utils/ai-parser.ts`:
  - Function parseGPT4Response:
    - Parse JSON string
    - Validate structure
  - Function validateSessionsStructure:
    - Check required fields
    - Validate dates (future dates)
    - Validate domains
    - Validate goal_types
- [ ] Handle GPT-4 errors:
  - Timeout
  - Rate limit
  - Invalid JSON response
  - Retry logic (max 2 retries)

**Deliverables:**
- GPT-4 integration working
- Response parsing working
- Error handling complete

---

### **NGÀY 28 - Thứ Tư 12/12: AI Processing Job & Status**

**Morning (4h):**
- [ ] Tạo `src/jobs/ai-processing.job.ts`:
  - Process function:
    - Update progress 20%: "Đang đọc file"
    - Extract text based on file_type
    - Update progress 40%: "Đang phân tích với AI"
    - Call GPT-4
    - Update progress 70%: "Đang tạo cấu trúc buổi học"
    - Parse response
    - Validate structure
    - Update progress 90%: "Hoàn tất"
    - Save result_sessions (JSONB)
    - Update status='completed'
  - Handle errors:
    - Update status='failed'
    - Save error_message
    - Set failed_at

**Afternoon (4h):**
- [ ] Tạo `src/modules/ai-processing/ai-processing.service.ts`:
  - Method getStatus:
    - Return processing_status, progress, message
  - Method getResult:
    - Return full result_sessions JSONB
    - Include metadata
  - Method createSessions:
    - Validate sessions data
    - Batch insert (transaction)
    - Set creation_method='ai'
    - Return created sessions with stats
  - Method delete

**Deliverables:**
- Background job working
- Progress tracking working
- Status polling working

---

### **NGÀY 29 - Thứ Năm 13/12: AI Controllers & Testing**

**Morning (4h):**
- [ ] Tạo `src/modules/ai-processing/ai-processing.controller.ts`:
  - POST /api/ai/process (multipart or JSON)
  - GET /api/ai/process/:processing_id/status
  - GET /api/ai/process/:processing_id
  - POST /api/ai/process/:processing_id/create-sessions
  - DELETE /api/ai/process/:processing_id
- [ ] Mount routes
- [ ] Setup rate limiting:
  - Max 5 AI requests per hour per teacher
  - Store in Redis

**Afternoon (4h):**
- [ ] Test manual:
  - Upload PDF → extract text → GPT-4 → parse → sessions
  - Upload DOCX
  - Upload image → OCR → GPT-4
  - Upload text content
  - Poll status (progress updates)
  - Get result
  - Create sessions from result
  - Test file too large
  - Test unsupported format
  - Test rate limiting
- [ ] Fix bugs

**Deliverables:**
- 5 AI endpoints working
- End-to-end flow working
- Rate limiting active

---

### **NGÀY 30 - Thứ Sáu 14/12: AI Testing**

**Morning (4h):**
- [ ] Viết unit tests:
  - Test upload file (AI-001)
  - Test upload DOCX (AI-002)
  - Test upload text (AI-003)
  - Test upload image OCR (AI-004)
  - Test file too large (AI-011)
  - Test unsupported format (AI-012)
  - Test both file and text (AI-013)
  - Test text too long (AI-014)

**Afternoon (4h):**
- [ ] Viết integration tests:
  - Test poll status pending (AI-005)
  - Test poll status completed (AI-006)
  - Test get result (AI-007)
  - Test create sessions (AI-008, 009)
  - Test processing failed (AI-010)
  - Test rate limiting (AI-015)
  - Test delete (AI-016)
  - Test access control (AI-017)
- [ ] Mock GPT-4 in tests (avoid real API calls)
- [ ] Coverage report

**Deliverables:**
- 20 test cases pass
- Coverage >80%

---

## 🗓️ TUẦN 7: ANALYTICS & REPORTS (17/12 - 21/12)

### **NGÀY 31 - Thứ Hai 17/12: Analytics Queries**

**Morning (4h):**
- [ ] Tạo `src/modules/analytics/analytics.service.ts`:
  - Method getOverview:
    - Calculate KPIs:
      - total_sessions, completed_sessions, pending, cancelled
      - completion_rate
      - avg_duration_minutes
      - total_goals_evaluated
      - goal_achievement_rate
      - avg_achievement_level
      - total_incidents, unique_behaviors, avg_incident_intensity
    - Use Prisma aggregations (count, avg, sum)
    - Filter by date_from, date_to, student_id (optional)

**Afternoon (4h):**
- [ ] Continue analytics:
  - Method getSessionsTrend:
    - Group by week (DATE_TRUNC)
    - Count sessions, completed_sessions
    - Order by week ASC
  - Method getGoalDistribution:
    - Count by status (achieved, partially, not, n/a)
  - Method getDomainDistribution:
    - Count goals by domain
  - Method getMoodTrend:
    - Get avg mood levels over time
  - Method getTopBehaviors:
    - Count incidents by behavior
    - Include avg_intensity
    - Limit 10

**Deliverables:**
- Analytics overview working
- Charts data working

---

### **NGÀY 32 - Thứ Ba 18/12: Student Analytics & Reports Setup**

**Morning (4h):**
- [ ] Tạo `src/modules/analytics/student-analytics.service.ts`:
  - Method getStudentAnalytics:
    - Filter all data by student_id
    - Calculate progress_over_time:
      - achievement_trend (by week)
      - mood_trend
      - behavior_trend (incidents decrease over time)
    - Calculate domain_breakdown:
      - Goals per domain
      - Achievement rate per domain
    - Calculate top_challenges:
      - Goals with lowest achievement rate
    - Calculate top_strengths:
      - Goals with highest achievement rate

**Afternoon (4h):**
- [ ] Install dependencies:
  - puppeteer (PDF generation)
  - exceljs (Excel generation)
- [ ] Setup Puppeteer:
  - Install Chrome/Chromium
  - Configure headless mode
- [ ] Tạo `src/modules/reports/reports.service.ts`:
  - Method create:
    - Validate format (pdf/excel)
    - Validate report_type (individual/summary)
    - Create REPORTS record (status='pending')
    - Queue background job
    - Return report_job_id

**Deliverables:**
- Student analytics working
- Report job queued

---

### **NGÀY 33 - Thứ Tư 19/12: PDF Report Generation**

**Morning (4h):**
- [ ] Tạo `src/utils/report-templates.ts`:
  - Function renderIndividualReportHTML:
    - HTML template with charts
    - Use Chart.js (embedded in HTML)
    - Include student info, KPIs, charts, session list
  - Function renderSummaryReportHTML:
    - Multi-student summary
- [ ] Tạo `src/jobs/report-generation.job.ts`:
  - For PDF:
    - Launch Puppeteer
    - Generate HTML
    - Set content
    - Generate PDF (A4, printBackground)
    - Close browser
    - Upload PDF to R2
    - Update REPORTS record

**Afternoon (4h):**
- [ ] Continue report job:
  - For Excel:
    - Create workbook (ExcelJS)
    - Create sheets: KPIs, Sessions, Goals, Behaviors
    - Add data
    - Style cells (colors, borders)
    - Generate buffer
    - Upload to R2
  - Set expires_at (24 hours)
  - Update status='completed'

**Deliverables:**
- PDF generation working
- Excel generation working

---

### **NGÀY 34 - Thứ Năm 20/12: Reports Controllers & Testing**

**Morning (4h):**
- [ ] Tạo `src/modules/analytics/analytics.controller.ts`:
  - GET /api/analytics/overview?student_id=&date_from=&date_to=
  - GET /api/analytics/student/:student_id?date_from=&date_to=
- [ ] Tạo `src/modules/reports/reports.controller.ts`:
  - POST /api/reports
  - GET /api/reports/:job_id
  - GET /api/reports/:job_id/download
- [ ] Mount routes

**Afternoon (4h):**
- [ ] Test manual:
  - Get overview analytics (all students)
  - Get overview analytics (single student)
  - Get student analytics
  - Generate PDF report
  - Poll status
  - Download PDF
  - Generate Excel report
  - Test report expiration (mock time)
  - Test access control
- [ ] Fix bugs

**Deliverables:**
- 5 analytics/reports endpoints working
- PDF/Excel download working

---

### **NGÀY 35 - Thứ Sáu 21/12: Analytics Testing**

**Morning (4h):**
- [ ] Viết unit tests:
  - Test get overview all students (ANA-001)
  - Test get overview single student (ANA-002)
  - Test get student analytics (ANA-003)
  - Test invalid date range (ANA-004)

**Afternoon (4h):**
- [ ] Viết integration tests:
  - Test generate PDF (REP-001)
  - Test generate Excel (REP-002)
  - Test download report (REP-003)
  - Test access control (REP-004)
  - Test expiration (REP-005)
- [ ] Mock Puppeteer in tests
- [ ] Coverage report

**Deliverables:**
- 9 test cases pass
- Coverage >80%

---

## 🗓️ TUẦN 8: SETTINGS, SYNC, BACKUP & FINAL (24/12 - 28/12)

### **NGÀY 36 - Thứ Hai 24/12: Settings & Sync Metadata**

**Morning (4h):**
- [ ] Tạo `src/modules/settings/settings.service.ts`:
  - Method get:
    - Return user info + settings object
  - Method update:
    - Update user fields (timezone, language)
    - Update settings (stored in separate table or JSONB)
  - Method changePassword:
    - Verify current password
    - Hash new password
    - Update
- [ ] Tạo SETTINGS table hoặc add settings JSONB to TEACHERS

**Afternoon (4h):**
- [ ] Tạo `src/modules/sync/sync.service.ts`:
  - Method getMetadata:
    - Return last_sync_at
    - Return data_versions (hash or timestamp per table)
    - Return server_time
  - Method syncStudents:
    - GET /api/students?all=true&sync=true&updated_since=
    - Include soft-deleted records (deleted_at NOT NULL)
    - Return sync_metadata
  - Method syncSessions:
    - Similar to students
    - Include full nested data (contents, goals)

**Deliverables:**
- Settings CRUD working
- Sync metadata working

---

### **NGÀY 37 - Thứ Ba 25/12: Offline Queue & Conflict Resolution**

**Morning (4h):**
- [ ] Tạo `src/modules/sync/offline-queue.service.ts`:
  - Method uploadQueue:
    - Process actions in order
    - For CREATE: create record, return server_id
    - For UPDATE: check if modified by another user (compare updated_at)
    - For DELETE: soft delete
    - Handle conflicts:
      - If conflict: return status='conflict' with server_version and your_version
      - If no conflict: apply changes
    - Return results array

**Afternoon (4h):**
- [ ] Implement conflict resolution strategies:
  - Last-write-wins (default)
  - OR manual resolution (return conflict to client)
- [ ] Test conflict scenarios:
  - User A updates offline
  - User B updates online
  - User A syncs → detect conflict
- [ ] Optimize batch operations (transaction)

**Deliverables:**
- Offline queue upload working
- Conflict detection working

---

### **NGÀY 38 - Thứ Tư 26/12: Backup System**

**Morning (4h):**
- [ ] Tạo `src/modules/backups/backups.service.ts`:
  - Method create:
    - Create BACKUPS record (status='pending')
    - Queue background job
    - Return backup_job_id
  - Method list:
    - Get all backups for teacher
    - Order by created_at DESC
    - Limit 4 (max retention)
- [ ] Tạo `src/jobs/backup.job.ts`:
  - Export all data to JSON:
    - students.json
    - sessions.json (with contents, goals, logs)
    - behaviors.json (favorites, incidents)
    - content_library.json
  - Download media files from R2 (if include_media=true)
  - Create ZIP archive
  - Upload ZIP to R2
  - Update BACKUPS record

**Afternoon (4h):**
- [ ] Continue backup:
  - Set expires_at (7 days)
  - Cleanup old backups (delete 5th oldest)
- [ ] Tạo auto backup cron:
  - Use node-cron
  - Run weekly (Sunday 2am)
  - If user enabled auto_backup
- [ ] Method download:
  - Generate signed URL
  - Redirect or return URL

**Deliverables:**
- Manual backup working
- Auto backup cron working

---

### **NGÀY 39 - Thứ Năm 27/12: Security & Testing**

**Morning (4h):**
- [ ] Implement security measures:
  - SQL injection prevention (Prisma handles this)
  - XSS prevention:
    - Sanitize input (validator library)
    - Escape output (React handles this)
  - CSRF protection:
    - Set SameSite=Strict on cookies
    - OR use CSRF tokens
  - Content-Security-Policy headers
- [ ] Tạo `src/middlewares/security.ts`:
  - Helmet middleware
  - CORS config
  - Rate limiting (already done)

**Afternoon (4h):**
- [ ] Viết security tests:
  - Test SQL injection (SEC-001, 002)
  - Test XSS (SEC-003, 004)
  - Test rate limiting (SEC-005)
  - Test CSRF (SEC-006)
- [ ] Viết edge case tests:
  - Test concurrent requests (EDG-001)
  - Test transaction rollback (EDG-002)
  - Test cascade delete (EDG-003)
  - Test large batch insert (EDG-004)
  - Test null/empty values (EDG-005)
  - Test Unicode (EDG-006)
  - Test very long text (EDG-007)
  - Test timezone edge cases (EDG-009)

**Deliverables:**
- Security tests pass
- Edge cases handled

---

### **NGÀY 40 - Thứ Sáu 28/12: Final Testing & Documentation**

**Morning (4h):**
- [ ] Run full test suite:
  - All 195 test cases
  - Coverage report (target >80%)
  - Fix failing tests
- [ ] Performance testing:
  - Load test with Artillery (100 concurrent users)
  - Check response times (<500ms p95)
  - Check database connection pool
  - Optimize slow queries
- [ ] Memory leak testing:
  - Run server for extended period
  - Monitor memory usage

**Afternoon (4h):**
- [ ] Complete API documentation:
  - Swagger/OpenAPI spec for all 82 endpoints
  - Add examples
  - Add error codes
  - Generate Postman collection
- [ ] Write README.md:
  - Setup instructions
  - Environment variables
  - Running migrations
  - Running seeds
  - Running tests
  - Deployment guide
- [ ] Update CHANGELOG.md
- [ ] Tag release v1.0.0

**Deliverables:**
- All tests pass (195/195)
- Coverage >80%
- Documentation complete
- Production ready

---

## 📊 TỔNG KẾT

### Thống kê công việc

| Tuần | Endpoints | Test Cases | Focus |
|------|-----------|-----------|-------|
| 1 | 10 | 35 | Authentication & User |
| 2 | 6 | 30 | Students |
| 3 | 10 | 40 | Sessions & Logging |
| 4 | 9 | 25 | Behaviors |
| 5 | 9 | 20 | Content Library |
| 6 | 5 | 20 | AI Processing |
| 7 | 5 | 9 | Analytics & Reports |
| 8 | 14 | 16 | Settings, Sync, Backup |
| **Total** | **82** | **195** | **8 weeks** |

### Deliverables cuối cùng

- ✅ 82 API endpoints hoàn chỉnh
- ✅ 195 test cases (coverage >80%)
- ✅ Prisma schema với 20 tables
- ✅ Background jobs (AI, Reports, Backups)
- ✅ File upload to Cloudflare R2
- ✅ GPT-4 integration
- ✅ Email service
- ✅ Rate limiting
- ✅ Security measures
- ✅ API documentation (Swagger)
- ✅ Docker deployment
- ✅ CI/CD pipeline

### Công cụ cần thiết

**Development:**
- VS Code / WebStorm
- Node.js 18+
- PostgreSQL 15+
- Redis 7+
- Postman / Insomnia

**Testing:**
- Jest
- Supertest
- Artillery (load testing)

**Deployment:**
- Docker
- GitHub Actions
- Cloudflare R2
- Vercel / Railway / Fly.io

---

**🎯 Mục tiêu: Production-ready API trong 8 tuần (40 ngày làm việc)**

Bạn có muốn tôi chi tiết hóa thêm phần nào không?
