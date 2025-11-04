# Functional Requirements Specification (FRS)

# Educare Connect - Technical Specification

**Document Version:** 1.0  
**Date:** November 4, 2025  
**Technical Lead:** Engineering Team  
**Target Release:** Month 8 (July 2026)

---

## 📋 TABLE OF CONTENTS

1. [Functional Requirements](#functional-requirements)
2. [Non-Functional Requirements](#non-functional-requirements)
3. [Performance Requirements](#performance-requirements)
4. [Security Requirements](#security-requirements)
5. [Compliance Requirements](#compliance-requirements)
6. [Data Requirements](#data-requirements)
7. [Integration Requirements](#integration-requirements)
8. [Testing Requirements](#testing-requirements)

---

## 1. FUNCTIONAL REQUIREMENTS

### 1.1 Authentication & User Management

#### FR-001: User Registration

**Description:** System shall allow teachers to create accounts with email and password.

**Requirements:**

- FR-001.1: System **SHALL** validate email format per RFC 5322 standard
- FR-001.2: System **SHALL** enforce password requirements:
  - Minimum 8 characters
  - At least 1 uppercase letter
  - At least 1 lowercase letter
  - At least 1 number
  - At least 1 special character (!@#$%^&\*)
- FR-001.3: System **SHALL** send verification email within 60 seconds of registration
- FR-001.4: System **SHALL** require email verification before allowing login
- FR-001.5: System **SHALL** hash passwords using bcrypt with cost factor 12
- FR-001.6: System **SHALL** prevent duplicate email registrations (unique constraint)

**Input:**

- Email: String (max 255 chars)
- Password: String (max 128 chars)
- Full Name: String (max 100 chars)
- Phone: String (optional, max 20 chars)
- School: String (optional, max 255 chars)

**Output:**

- Success: HTTP 201, user ID, verification email sent confirmation
- Error: HTTP 400 (validation), 409 (duplicate email), 500 (server error)

**Dependencies:** Email service (SendGrid or SMTP)

**Priority:** Must-Have

---

#### FR-002: User Login

**Description:** System shall authenticate teachers using email and password.

**Requirements:**

- FR-002.1: System **SHALL** validate credentials against database
- FR-002.2: System **SHALL** issue JWT access token (expiry: 1 hour) and refresh token (expiry: 7 days)
- FR-002.3: System **SHALL** implement rate limiting: max 5 failed attempts per 15 minutes per IP
- FR-002.4: System **SHALL** lock account after 10 failed attempts within 1 hour
- FR-002.5: System **SHALL** return user profile data on successful login
- FR-002.6: System **SHALL** log last login timestamp

**Input:**

- Email: String
- Password: String
- Remember Me: Boolean (optional)

**Output:**

- Success: HTTP 200, access_token, refresh_token, user object
- Error: HTTP 401 (invalid credentials), 429 (rate limit), 423 (locked account)

**Dependencies:** JWT library, Redis (for rate limiting)

**Priority:** Must-Have

---

#### FR-003: Biometric Authentication

**Description:** System shall support Face ID (iOS) and Fingerprint (Android) authentication.

**Requirements:**

- FR-003.1: System **SHALL** offer biometric setup after first successful login
- FR-003.2: System **SHALL** store biometric token in device secure storage (iOS Keychain / Android KeyStore)
- FR-003.3: System **SHALL** fallback to password login if biometric fails
- FR-003.4: System **SHALL** allow users to disable biometric in settings

**Input:** Biometric scan (device-level)

**Output:** Auto-login or fallback to password screen

**Dependencies:** react-native-biometrics library

**Priority:** Could-Have

---

### 1.2 Student Management

#### FR-004: Create Student

**Description:** System shall allow teachers to add new students.

**Requirements:**

- FR-004.1: System **SHALL** require full_name and age
- FR-004.2: System **SHALL** validate age between 2-18 years
- FR-004.3: System **SHALL** generate unique student ID (UUID)
- FR-004.4: System **SHALL** link student to authenticated teacher (foreign key)
- FR-004.5: System **SHALL** generate avatar from initials if no photo uploaded
- FR-004.6: System **SHALL** support avatar upload (max 5MB, JPG/PNG/HEIC)
- FR-004.7: System **SHALL** auto-resize avatar to 512x512px

**Input:**

- Full Name: String (required, 2-100 chars)
- Nickname: String (optional, 2-50 chars)
- Age: Integer (required, 2-18)
- Gender: Enum (male, female, other) (optional)
- Avatar: File (optional, max 5MB)
- Notes: Text (optional, max 1000 chars)

**Output:**

- Success: HTTP 201, student object with ID
- Error: HTTP 400 (validation), 413 (file too large)

**Dependencies:** Image processing library (sharp or react-native-image-resizer)

**Priority:** Must-Have

---

#### FR-005: List Students

**Description:** System shall display all students for authenticated teacher.

**Requirements:**

- FR-005.1: System **SHALL** return students ordered by created_at DESC
- FR-005.2: System **SHALL** include weekly stats: total sessions, completed sessions
- FR-005.3: System **SHALL** support search by full_name or nickname (case-insensitive)
- FR-005.4: System **SHALL** support filtering by status (active, paused, archived)
- FR-005.5: System **SHALL** paginate results (20 per page)
- FR-005.6: System **SHALL** return empty array if no students

**Input:**

- Search query: String (optional)
- Status filter: Enum (optional)
- Page: Integer (default: 1)
- Limit: Integer (default: 20)

**Output:**

- Success: HTTP 200, array of student objects, pagination metadata
- Error: HTTP 500

**Dependencies:** PostgreSQL full-text search

**Priority:** Must-Have

---

### 1.3 Session Management

#### FR-006: Create Session (Manual)

**Description:** System shall allow teachers to create sessions manually in 3 steps.

**Requirements:**

- FR-006.1: System **SHALL** validate date not more than 6 months in past or 1 year in future
- FR-006.2: System **SHALL** validate end_time > start_time
- FR-006.3: System **SHALL** validate minimum session duration 30 minutes
- FR-006.4: System **SHALL** require at least 1 content with at least 1 goal
- FR-006.5: System **SHALL** auto-fill default times based on time_slot (morning: 8:00-11:30, afternoon: 14:00-17:00)
- FR-006.6: System **SHALL** save draft every 30 seconds during creation
- FR-006.7: System **SHALL** restore draft if user returns before completion
- FR-006.8: System **SHALL** clear draft after successful session creation

**Input:**

**Step 1:**

- Date: Date (required)
- Time Slot: Enum (morning, afternoon, evening)
- Start Time: Time (required)
- End Time: Time (required)
- Notes: Text (optional, max 500 chars)

**Step 2:**

- Contents: Array (min 1, max 20)
  - Name: String (required, max 200 chars)
  - Domain: Enum (cognitive, motor, language, social, self_care)
  - Description: Text (optional, max 500 chars)
  - Goals: Array (min 1, max 10 per content)
    - Description: String (required, max 200 chars)

**Step 3:** Review and confirm

**Output:**

- Success: HTTP 201, session object with nested contents and goals
- Error: HTTP 400 (validation), 500

**Dependencies:** AsyncStorage (for draft saving)

**Priority:** Must-Have

---

#### FR-007: Create Session (AI-Powered)

**Description:** System shall extract session structure from uploaded lesson plan using AI.

**Requirements:**

- FR-007.1: System **SHALL** accept file upload (PDF, DOCX, TXT, JPG, PNG) max 10MB
- FR-007.2: System **SHALL** accept text paste (max 5000 characters)
- FR-007.3: System **SHALL** use OCR for image files (Google Cloud Vision API)
- FR-007.4: System **SHALL** extract text from PDF/DOCX using pdf-parse / mammoth
- FR-007.5: System **SHALL** send extracted text to OpenAI GPT-4 with structured prompt
- FR-007.6: System **SHALL** parse AI response into session objects (date, time_slot, contents, goals)
- FR-007.7: System **SHALL** return processing progress (0-100%)
- FR-007.8: System **SHALL** complete processing within 60 seconds for 10-page document
- FR-007.9: System **SHALL** allow manual editing of AI-generated sessions before saving
- FR-007.10: System **SHALL** fallback to manual creation if AI fails (with error message)

**Input:**

- File: Binary (optional, max 10MB)
- Text: String (optional, max 5000 chars)
- Student ID: UUID (required)

**Output:**

- Success: HTTP 200, array of session objects (may be multiple sessions from one plan)
- Error: HTTP 400 (validation), 413 (file too large), 500, 503 (AI service unavailable)

**Dependencies:**

- Google Cloud Vision API (OCR)
- OpenAI GPT-4 API (text extraction)
- pdf-parse, mammoth (document parsing)

**Priority:** Should-Have

**AI Prompt Template:**

```
Extract teaching sessions from the following lesson plan.
Return JSON array with format:
[
  {
    "date": "YYYY-MM-DD",
    "time_slot": "morning|afternoon|evening",
    "contents": [
      {
        "name": "Activity name",
        "domain": "cognitive|motor|language|social|self_care",
        "description": "Brief description",
        "goals": ["Goal 1", "Goal 2", ...]
      }
    ]
  }
]

Lesson plan:
{extracted_text}
```

---

### 1.4 Session Logging

#### FR-008: Session Logging - Step 1 (Evaluate Goals)

**Description:** System shall allow evaluation of all goals in all content sections.

**Requirements:**

- FR-008.1: System **SHALL** display all content sections with sticky headers
- FR-008.2: System **SHALL** provide quick navigation sidebar to jump between content sections
- FR-008.3: System **SHALL** require evaluation for each goal: achieved, not_achieved, not_applicable
- FR-008.4: System **SHALL** allow optional notes per content section (max 500 chars)
- FR-008.5: System **SHALL** auto-save draft every 2 minutes
- FR-008.6: System **SHALL** show last save timestamp
- FR-008.7: System **SHALL** validate all goals evaluated before allowing proceed

**Input:**

- Session ID: UUID
- Goal Evaluations: Array
  - Goal ID: UUID
  - Status: Enum (achieved, not_achieved, not_applicable)
- Content Notes: Object (content_id: notes_text)

**Output:**

- Success: HTTP 200, save confirmation
- Error: HTTP 400 (validation), 404 (session not found)

**Dependencies:** N/A

**Priority:** Must-Have

---

#### FR-009: Session Logging - Step 2 (Attitude)

**Description:** System shall record student's attitude and mood.

**Requirements:**

- FR-009.1: System **SHALL** require mood selection: very_difficult, difficult, normal, good, very_good
- FR-009.2: System **SHALL** require 3 slider values (1-5):
  - Cooperation level
  - Focus level
  - Independence level
- FR-009.3: System **SHALL** allow optional attitude notes (max 500 chars)
- FR-009.4: System **SHALL** auto-save draft

**Input:**

- Session Log ID: UUID
- Mood: Enum (required)
- Cooperation Level: Integer 1-5 (required)
- Focus Level: Integer 1-5 (required)
- Independence Level: Integer 1-5 (required)
- Attitude Notes: Text (optional, max 500 chars)

**Output:**

- Success: HTTP 200
- Error: HTTP 400 (validation)

**Priority:** Must-Have

---

#### FR-010: Session Logging - Step 3 (Teacher Notes)

**Description:** System shall allow text, voice, photo, and video notes.

**Requirements:**

- FR-010.1: System **SHALL** allow text notes (max 2000 chars)
- FR-010.2: System **SHALL** allow voice recording (max 5 minutes, M4A format)
- FR-010.3: System **SHALL** allow photo upload (max 10 photos, 5MB each, JPG/PNG)
- FR-010.4: System **SHALL** allow video upload (max 3 videos, 100MB each, MP4/MOV)
- FR-010.5: System **SHALL** compress media before upload
- FR-010.6: System **SHALL** show upload progress (0-100%)
- FR-010.7: System **SHALL** allow delete media before saving
- FR-010.8: System **SHALL** store media URLs in database

**Input:**

- Session Log ID: UUID
- Teacher Notes Text: Text (optional, max 2000 chars)
- Voice Recordings: Array of Files (optional)
- Photos: Array of Files (optional)
- Videos: Array of Files (optional)

**Output:**

- Success: HTTP 200, array of media URLs
- Error: HTTP 400, 413 (file too large)

**Dependencies:** Cloudflare R2 / AWS S3 (media storage)

**Priority:** Should-Have

---

#### FR-011: Session Logging - Step 4 (Behavior Incidents)

**Description:** System shall record behaviors using ABC model.

**Requirements:**

- FR-011.1: System **SHALL** allow selecting behavior from library or creating custom
- FR-011.2: System **SHALL** require Antecedent, Behavior, Consequence text fields
- FR-011.3: System **SHALL** require severity level (1-5)
- FR-011.4: System **SHALL** require time occurred (default: current time)
- FR-011.5: System **SHALL** allow multiple behavior incidents per session
- FR-011.6: System **SHALL** allow edit/delete behavior before saving
- FR-011.7: System **SHALL** update behavior usage_count on save
- FR-011.8: System **SHALL** allow skipping this step (behaviors optional)

**Input:**

- Session Log ID: UUID
- Behavior Incidents: Array (optional)
  - Behavior Library ID: UUID (optional if custom)
  - Antecedent: Text (required, max 500 chars)
  - Behavior Description: Text (required, max 500 chars)
  - Consequence: Text (required, max 500 chars)
  - Severity Level: Integer 1-5 (required)
  - Occurred At: Timestamp (required)
  - Notes: Text (optional, max 500 chars)

**Output:**

- Success: HTTP 200
- Error: HTTP 400 (validation)

**Dependencies:** Behavior Library database

**Priority:** Must-Have

---

### 1.5 Behavior Dictionary

#### FR-012: Behavior Library Database

**Description:** System shall store 127+ evidence-based behaviors with rich metadata.

**Requirements:**

- FR-012.1: System **SHALL** organize behaviors into 3 groups:
  - Group 1: Chống đối & Bướng bỉnh (Opposition & Defiance)
  - Group 2: Hành vi Gây hấn (Aggression)
  - Group 3: Vấn đề về Giác quan (Sensory Issues)
- FR-012.2: System **SHALL** assign hierarchical IDs (1.1, 1.2, 2.1, 3.1)
- FR-012.3: System **SHALL** store bilingual names (Vietnamese & English)
- FR-012.4: System **SHALL** store 10-15 Vietnamese keywords per behavior (JSON array)
- FR-012.5: System **SHALL** store manifestation (TEXT - clinical description)
- FR-012.6: System **SHALL** store explanations (JSON array of {title, description}, min 2)
- FR-012.7: System **SHALL** store solutions (JSON array of {title, description}, min 4)
- FR-012.8: System **SHALL** store sources (JSON array of academic citations, min 2)
- FR-012.9: System **SHALL** track usage_count (incremented on use)
- FR-012.10: System **SHALL** create GIN index on keywords for full-text search

**Database Schema:**

```sql
CREATE TABLE behavior_groups (
  id UUID PRIMARY KEY,
  name_vn VARCHAR(200) NOT NULL,
  name_en VARCHAR(200) NOT NULL,
  description TEXT,
  icon VARCHAR(10),
  common_tips JSONB, -- Array of tips
  order_index INTEGER,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE behavior_library (
  id UUID PRIMARY KEY,
  behavior_group_id UUID REFERENCES behavior_groups(id) ON DELETE RESTRICT,
  behavior_id VARCHAR(10) UNIQUE NOT NULL, -- "1.1", "1.2", etc.
  name_vn VARCHAR(200) NOT NULL,
  name_en VARCHAR(200) NOT NULL,
  keywords JSONB NOT NULL, -- Array of 10-15 keywords
  manifestation TEXT NOT NULL, -- Clinical description
  explanation JSONB NOT NULL, -- [{title, description}]
  solutions JSONB NOT NULL, -- [{title, description}]
  sources JSONB NOT NULL, -- [citations]
  icon VARCHAR(10),
  is_active BOOLEAN DEFAULT true,
  usage_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_behavior_keywords ON behavior_library USING GIN (keywords);
CREATE INDEX idx_behavior_id ON behavior_library (behavior_id);
CREATE INDEX idx_behavior_group ON behavior_library (behavior_group_id);
```

**Priority:** Must-Have

---

#### FR-013: Search Behaviors

**Description:** System shall search behaviors by keywords.

**Requirements:**

- FR-013.1: System **SHALL** search in Vietnamese name, English name, and keywords array
- FR-013.2: System **SHALL** use full-text search with GIN index
- FR-013.3: System **SHALL** support fuzzy matching (Levenshtein distance)
- FR-013.4: System **SHALL** return results ordered by relevance score
- FR-013.5: System **SHALL** highlight matched text in results
- FR-013.6: System **SHALL** return results within 200ms
- FR-013.7: System **SHALL** debounce search input (300ms)

**Input:**

- Search query: String (min 2 chars)
- Filter by group: UUID (optional)
- Limit: Integer (default: 20)

**Output:**

- Success: HTTP 200, array of behavior objects
- Error: HTTP 400 (query too short)

**SQL Query:**

```sql
SELECT *
FROM behavior_library
WHERE (
  name_vn ILIKE '%' || $1 || '%'
  OR name_en ILIKE '%' || $1 || '%'
  OR keywords::text ILIKE '%' || $1 || '%'
)
AND is_active = true
ORDER BY usage_count DESC
LIMIT $2;
```

**Priority:** Must-Have

---

#### FR-014: Behavior Favorites

**Description:** System shall allow teachers to favorite behaviors.

**Requirements:**

- FR-014.1: System **SHALL** store favorites in junction table (teacher_favorites)
- FR-014.2: System **SHALL** toggle favorite on/off (idempotent)
- FR-014.3: System **SHALL** show favorites in separate section on dictionary home
- FR-014.4: System **SHALL** prevent duplicate favorites (unique constraint)

**Input:**

- Behavior ID: UUID

**Output:**

- Success: HTTP 200 (added) or HTTP 204 (removed)
- Error: HTTP 404 (behavior not found)

**Priority:** Should-Have

---

### 1.6 Analytics & Reports

#### FR-015: Analytics Dashboard

**Description:** System shall display behavior trends and statistics.

**Requirements:**

- FR-015.1: System **SHALL** support date range filters: Week, Month, 3 months, 6 months, Custom
- FR-015.2: System **SHALL** calculate:
  - Completion rate: (Completed sessions / Total sessions) × 100
  - Total sessions
  - Total behaviors recorded
  - Active students count
- FR-015.3: System **SHALL** generate behavior trend chart:
  - Line graph with daily or weekly data points
  - Show trend percentage (increase/decrease)
  - Average line overlay
- FR-015.4: System **SHALL** calculate top 5 behaviors by frequency
- FR-015.5: System **SHALL** categorize behaviors by function (Attention, Escape, Sensory, Tangible)
- FR-015.6: System **SHALL** cache analytics data (refresh every 5 minutes)

**Input:**

- Teacher ID: UUID (from auth token)
- Date range: Start date, End date
- Student ID: UUID (optional, filter by student)

**Output:**

- Success: HTTP 200, analytics object with charts data
- Error: HTTP 400 (invalid date range)

**SQL Queries:**

```sql
-- Behavior trend (daily)
SELECT
  DATE(occurred_at) as date,
  COUNT(*) as count
FROM behavior_incidents bi
JOIN session_logs sl ON bi.session_log_id = sl.id
JOIN sessions s ON sl.session_id = s.id
WHERE s.student_id IN (SELECT id FROM students WHERE teacher_id = $1)
  AND occurred_at BETWEEN $2 AND $3
GROUP BY DATE(occurred_at)
ORDER BY date;

-- Top 5 behaviors
SELECT
  b.behavior_id,
  b.name_vn,
  COUNT(*) as count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM behavior_incidents bi
JOIN behavior_library b ON bi.behavior_library_id = b.id
JOIN session_logs sl ON bi.session_log_id = sl.id
JOIN sessions s ON sl.session_id = s.id
WHERE s.student_id IN (SELECT id FROM students WHERE teacher_id = $1)
  AND occurred_at BETWEEN $2 AND $3
GROUP BY b.id, b.behavior_id, b.name_vn
ORDER BY count DESC
LIMIT 5;
```

**Priority:** Must-Have

---

#### FR-016: Export Reports

**Description:** System shall export session logs and analytics to PDF/Excel.

**Requirements:**

- FR-016.1: System **SHALL** generate PDF reports with:
  - Student info
  - Session details
  - Goal evaluations table
  - Attitude charts (horizontal bar charts)
  - Teacher notes
  - Embedded photos (resized)
  - Behavior incidents table (ABC columns)
  - Page numbers and footer
- FR-016.2: System **SHALL** generate Excel reports with:
  - Sheet 1: Session summary
  - Sheet 2: Goal evaluations (one row per goal)
  - Sheet 3: Behavior incidents (one row per behavior)
  - Formatted headers and borders
- FR-016.3: System **SHALL** complete generation within 5 seconds for PDF, 3 seconds for Excel
- FR-016.4: System **SHALL** return file URL or base64 data
- FR-016.5: System **SHALL** allow download to device
- FR-016.6: System **SHALL** allow share via email/messaging apps

**Input:**

- Session Log ID: UUID (for single session report)
- Date range: Start, End (for analytics report)
- Format: Enum (pdf, excel)

**Output:**

- Success: HTTP 200, file URL or base64 string
- Error: HTTP 400, 500

**Dependencies:**

- PDF: puppeteer or pdfkit
- Excel: exceljs

**Priority:** Should-Have

---

### 1.7 Offline Mode

#### FR-017: Offline Data Caching

**Description:** System shall cache data for offline access.

**Requirements:**

- FR-017.1: System **SHALL** cache on first load:
  - Student list
  - Session list (last 30 days)
  - Behavior dictionary (all 127+ behaviors)
  - Content library templates
- FR-017.2: System **SHALL** use SQLite for local storage (react-native-sqlite-storage)
- FR-017.3: System **SHALL** show offline banner when internet unavailable
- FR-017.4: System **SHALL** allow read-only access to cached data
- FR-017.5: System **SHALL** allow session logging offline (queued for sync)
- FR-017.6: System **SHALL** store cache expiry timestamp (24 hours)

**Dependencies:** react-native-sqlite-storage, @react-native-community/netinfo

**Priority:** Should-Have

---

#### FR-018: Offline Sync Queue

**Description:** System shall sync offline-created data when online.

**Requirements:**

- FR-018.1: System **SHALL** queue all write operations when offline
- FR-018.2: System **SHALL** auto-sync when internet detected
- FR-018.3: System **SHALL** sync in FIFO order
- FR-018.4: System **SHALL** retry failed syncs (exponential backoff, max 3 attempts)
- FR-018.5: System **SHALL** show sync status: "Chưa đồng bộ" badge
- FR-018.6: System **SHALL** handle conflicts:
  - Last-write-wins for simple data
  - Manual merge UI for sessions (side-by-side comparison)
- FR-018.7: System **SHALL** show toast on successful sync: "Đã đồng bộ X phiên học"

**Dependencies:** Redux Offline or custom sync queue

**Priority:** Should-Have

---

## 2. NON-FUNCTIONAL REQUIREMENTS

### 2.1 Usability (NFR-U)

#### NFR-U-001: Mobile-First Design

- System **SHALL** be optimized for mobile devices (portrait orientation)
- System **SHALL** support one-handed operation (bottom navigation)
- System **SHALL** use minimum touch target size 44x44pt
- System **SHALL** provide haptic feedback on important actions (iOS)

---

#### NFR-U-002: Accessibility

- System **SHALL** support VoiceOver (iOS) and TalkBack (Android)
- System **SHALL** meet WCAG 2.1 Level AA standards
- System **SHALL** support dynamic type (font scaling 100%-200%)
- System **SHALL** provide text alternatives for all images
- System **SHALL** ensure minimum color contrast 4.5:1 for text

---

#### NFR-U-003: Localization

- System **SHALL** display all UI text in Vietnamese (Year 1)
- System **SHALL** use proper Vietnamese diacritics
- System **SHALL** format dates as DD/MM/YYYY
- System **SHALL** use 24-hour time format or 12-hour with AM/PM
- System **SHALL** support English localization (Year 2)

---

### 2.2 Reliability (NFR-R)

#### NFR-R-001: Availability

- System **SHALL** achieve 99.5% uptime (excluding scheduled maintenance)
- System **SHALL** schedule maintenance during off-peak hours (2-4 AM Vietnam time)
- System **SHALL** notify users 48 hours before scheduled maintenance

---

#### NFR-R-002: Data Integrity

- System **SHALL** implement database constraints (foreign keys, unique, not null)
- System **SHALL** validate all input data before database write
- System **SHALL** use database transactions for multi-table operations
- System **SHALL** implement soft delete for critical data (students, sessions)
- System **SHALL** maintain audit logs for data modifications

---

#### NFR-R-003: Error Handling

- System **SHALL** catch and log all exceptions
- System **SHALL** display user-friendly error messages
- System **SHALL** provide retry mechanism for failed operations
- System **SHALL** implement circuit breaker for external API calls

---

### 2.3 Maintainability (NFR-M)

#### NFR-M-001: Code Quality

- System **SHALL** follow ESLint rules (Airbnb style guide)
- System **SHALL** maintain > 80% code coverage for unit tests
- System **SHALL** use TypeScript for type safety
- System **SHALL** document all public APIs with JSDoc comments
- System **SHALL** use version control (Git) with semantic commit messages

---

#### NFR-M-002: Modularity

- System **SHALL** use component-based architecture (React Native)
- System **SHALL** separate business logic from UI components
- System **SHALL** use Redux or Context API for state management
- System **SHALL** implement API client as separate module

---

## 3. PERFORMANCE REQUIREMENTS

### 3.1 Response Time (NFR-P-001)

| Operation           | Target Response Time | Measurement Point              |
| ------------------- | -------------------- | ------------------------------ |
| App cold start      | < 2 seconds          | Launch to dashboard visible    |
| App warm start      | < 1 second           | Resume to dashboard visible    |
| Screen transition   | < 300ms              | Tap to new screen visible      |
| API call (GET)      | < 500ms (p95)        | Request to response received   |
| API call (POST/PUT) | < 1 second (p95)     | Request to confirmation        |
| Search query        | < 200ms              | Keystroke to results displayed |
| Chart rendering     | < 500ms              | Data loaded to chart visible   |
| Image loading       | < 1 second           | Placeholder to image displayed |

---

### 3.2 Throughput (NFR-P-002)

- System **SHALL** support 500 concurrent users
- System **SHALL** handle 100 requests/second (API)
- System **SHALL** process 50 AI session creations per hour

---

### 3.3 Resource Utilization (NFR-P-003)

- App **SHALL** consume < 200MB RAM on average
- App **SHALL** consume < 50MB storage for cache
- App **SHALL** use < 10MB network data per session log (without media)
- App **SHALL** drain < 5% battery per hour of active use

---

### 3.4 Scalability (NFR-P-004)

- System **SHALL** scale horizontally (add more servers)
- Database **SHALL** support up to 100,000 users
- Database **SHALL** support up to 10,000,000 session logs
- CDN **SHALL** cache static assets (images, fonts)

---

## 4. SECURITY REQUIREMENTS

### 4.1 Authentication & Authorization (NFR-S-001)

- System **SHALL** use JWT for stateless authentication
- System **SHALL** rotate refresh tokens on use (sliding expiration)
- System **SHALL** implement role-based access control (RBAC):
  - Teacher: Full access to own students and sessions
  - Admin: Read access to all data (future)
- System **SHALL** invalidate all tokens on password change
- System **SHALL** implement brute-force protection (rate limiting)

---

### 4.2 Data Encryption (NFR-S-002)

- System **SHALL** encrypt data in transit using TLS 1.3
- System **SHALL** encrypt data at rest (database encryption)
- System **SHALL** hash passwords with bcrypt (cost 12)
- System **SHALL** store sensitive tokens in secure storage:
  - iOS: Keychain
  - Android: KeyStore

---

### 4.3 Input Validation (NFR-S-003)

- System **SHALL** sanitize all user input to prevent XSS
- System **SHALL** use parameterized queries to prevent SQL injection
- System **SHALL** validate file uploads:
  - Check file type (magic bytes, not just extension)
  - Limit file size (10MB max)
  - Scan for malware (future)

---

### 4.4 Privacy (NFR-S-004)

- System **SHALL** anonymize data for analytics
- System **SHALL** allow users to export their data (GDPR Article 20)
- System **SHALL** allow users to delete their account and all data
- System **SHALL** not share user data with third parties without consent
- System **SHALL** display privacy policy on registration

---

### 4.5 Audit Logging (NFR-S-005)

- System **SHALL** log all authentication events (login, logout, failed attempts)
- System **SHALL** log all data modifications (create, update, delete)
- System **SHALL** log all admin actions (future)
- Logs **SHALL** include: timestamp, user ID, IP address, action, result

---

## 5. COMPLIANCE REQUIREMENTS

### 5.1 Data Protection (NFR-C-001)

#### GDPR Compliance (if applicable)

- System **SHALL** obtain explicit consent for data collection
- System **SHALL** provide data access/export functionality
- System **SHALL** provide data deletion functionality
- System **SHALL** implement "right to be forgotten"
- System **SHALL** notify users of data breaches within 72 hours

---

#### COPPA Compliance (NFR-C-002)

- System **SHALL** not collect personal data from children < 13
- System **SHALL** collect data about children only through teachers (parental role)
- System **SHALL** not use child data for advertising
- System **SHALL** delete child data upon teacher's request

---

#### Vietnam Personal Data Protection Decree 13/2023 (NFR-C-003)

- System **SHALL** store data in Vietnam or compliant regions
- System **SHALL** obtain consent for data processing
- System **SHALL** implement data breach notification process

---

### 5.2 Accessibility Compliance (NFR-C-004)

- System **SHALL** meet WCAG 2.1 Level AA standards
- System **SHALL** pass automated accessibility testing (Axe, WAVE)
- System **SHALL** support screen readers

---

### 5.3 App Store Compliance (NFR-C-005)

#### Apple App Store (NFR-C-005a)

- App **SHALL** comply with Apple Human Interface Guidelines
- App **SHALL** use Apple's standard UI components where appropriate
- App **SHALL** request permissions with clear explanations
- App **SHALL** not access private APIs

#### Google Play Store (NFR-C-005b)

- App **SHALL** comply with Material Design guidelines
- App **SHALL** target Android API 33+ (Android 13)
- App **SHALL** request runtime permissions appropriately
- App **SHALL** not contain deceptive behavior

---

## 6. DATA REQUIREMENTS

### 6.1 Data Models

#### 6.1.1 Core Entities

**TEACHERS**

```typescript
interface Teacher {
  id: string; // UUID
  email: string; // Unique, max 255
  full_name: string; // max 100
  phone?: string; // max 20
  school?: string; // max 255
  avatar_url?: string; // URL
  password_hash: string; // bcrypt hash
  is_verified: boolean; // Default false
  two_fa_enabled: boolean; // Default false
  created_at: Date;
  updated_at: Date;
  last_login?: Date;
}
```

---

**STUDENTS**

```typescript
interface Student {
  id: string; // UUID
  teacher_id: string; // FK -> teachers.id
  full_name: string; // max 100
  nickname?: string; // max 50
  age: number; // 2-18
  gender?: "male" | "female" | "other";
  avatar_url?: string;
  status: "active" | "paused" | "archived"; // Default active
  notes?: string; // max 1000
  created_at: Date;
  updated_at: Date;
}
```

---

**SESSIONS**

```typescript
interface Session {
  id: string; // UUID
  student_id: string; // FK -> students.id
  date: Date;
  time_slot: "morning" | "afternoon" | "evening";
  start_time: string; // HH:MM format
  end_time: string; // HH:MM format
  notes?: string; // max 500
  creation_method: "manual" | "ai";
  status: "pending" | "completed";
  has_evaluation: boolean; // Default false
  created_at: Date;
  updated_at: Date;
}
```

---

**SESSION_CONTENTS**

```typescript
interface SessionContent {
  id: string; // UUID
  session_id: string; // FK -> sessions.id
  content_library_id?: string; // FK -> content_library.id (optional)
  name: string; // max 200
  domain: "cognitive" | "motor" | "language" | "social" | "self_care";
  description?: string; // max 500
  order_index: number; // For sorting
  notes?: string; // max 500
  created_at: Date;
  updated_at: Date;
}
```

---

**CONTENT_GOALS**

```typescript
interface ContentGoal {
  id: string; // UUID
  session_content_id: string; // FK -> session_contents.id
  description: string; // max 200
  order_index: number;
  created_at: Date;
  updated_at: Date;
}
```

---

**SESSION_LOGS**

```typescript
interface SessionLog {
  id: string; // UUID
  session_id: string; // FK -> sessions.id (unique)
  logged_at: Date;
  completed_at?: Date;
  mood: "very_difficult" | "difficult" | "normal" | "good" | "very_good";
  cooperation_level: number; // 1-5
  focus_level: number; // 1-5
  independence_level: number; // 1-5
  attitude_notes?: string; // max 500
  teacher_notes_text?: string; // max 2000
  created_at: Date;
  updated_at: Date;
}
```

---

**GOAL_EVALUATIONS**

```typescript
interface GoalEvaluation {
  id: string; // UUID
  session_log_id: string; // FK -> session_logs.id
  content_goal_id: string; // FK -> content_goals.id
  status: "achieved" | "not_achieved" | "not_applicable";
  notes?: string; // max 500
  created_at: Date;
  updated_at: Date;
}
```

---

**LOG_MEDIA_ATTACHMENTS**

```typescript
interface LogMediaAttachment {
  id: string; // UUID
  session_log_id: string; // FK -> session_logs.id
  type: "image" | "video" | "audio";
  url: string; // CDN URL
  filename: string;
  file_size: number; // bytes
  duration?: number; // seconds (for audio/video)
  created_at: Date;
}
```

---

**BEHAVIOR_GROUPS**

```typescript
interface BehaviorGroup {
  id: string; // UUID
  name_vn: string; // max 200
  name_en: string; // max 200
  description?: string;
  icon: string; // Emoji
  common_tips: string[]; // JSON array
  order_index: number;
  is_active: boolean;
  created_at: Date;
  updated_at: Date;
}
```

---

**BEHAVIOR_LIBRARY**

```typescript
interface BehaviorLibrary {
  id: string; // UUID
  behavior_group_id: string; // FK -> behavior_groups.id
  behavior_id: string; // Unique, e.g., "1.1", "1.2"
  name_vn: string; // max 200
  name_en: string; // max 200
  keywords: string[]; // JSON array, 10-15 keywords
  manifestation: string; // TEXT
  explanation: { title: string; description: string }[]; // JSON array
  solutions: { title: string; description: string }[]; // JSON array
  sources: string[]; // JSON array, academic citations
  icon?: string; // Emoji
  is_active: boolean;
  usage_count: number; // Default 0
  created_at: Date;
  updated_at: Date;
}
```

---

**BEHAVIOR_INCIDENTS**

```typescript
interface BehaviorIncident {
  id: string; // UUID
  session_log_id: string; // FK -> session_logs.id
  behavior_library_id?: string; // FK -> behavior_library.id (optional)
  antecedent: string; // max 500
  behavior_description: string; // max 500
  consequence: string; // max 500
  severity_level: number; // 1-5
  occurred_at: Date;
  notes?: string; // max 500
  created_at: Date;
  updated_at: Date;
}
```

---

### 6.2 Data Validation Rules

| Field                    | Validation Rule                                         |
| ------------------------ | ------------------------------------------------------- |
| **Email**                | RFC 5322 format, unique, max 255 chars                  |
| **Password**             | Min 8 chars, 1 uppercase, 1 number, 1 special           |
| **Phone**                | E.164 format (optional), max 20 chars                   |
| **Age**                  | Integer between 2-18                                    |
| **Date**                 | ISO 8601 format, not > 6 months past or > 1 year future |
| **Time**                 | HH:MM format, end_time > start_time                     |
| **URLs**                 | Valid HTTP/HTTPS, max 2048 chars                        |
| **File uploads**         | Allowed extensions, max size, virus scan (future)       |
| **Text fields (short)**  | Max 200-500 chars, sanitize HTML                        |
| **Text fields (long)**   | Max 2000 chars, sanitize HTML                           |
| **Enum fields**          | Must match predefined values                            |
| **Integer fields (1-5)** | Between 1 and 5, integer only                           |
| **JSON fields**          | Valid JSON, enforce schema validation                   |

---

### 6.3 Data Retention Policy

| Data Type          | Retention Period           | Action After Retention            |
| ------------------ | -------------------------- | --------------------------------- |
| **User accounts**  | Until account deletion     | Soft delete + 30-day grace period |
| **Student data**   | Until teacher deletes      | Soft delete + 30-day recovery     |
| **Session logs**   | Indefinite (user controls) | Export option before delete       |
| **Media files**    | Linked to session log      | Delete when log deleted           |
| **Audit logs**     | 2 years                    | Archive to cold storage           |
| **Crash reports**  | 90 days                    | Permanent delete                  |
| **Analytics data** | 1 year (anonymized)        | Aggregate and archive             |

---

## 7. INTEGRATION REQUIREMENTS

### 7.1 Third-Party Service Integrations

#### 7.1.1 Supabase (Backend as a Service)

**Purpose:** Database, Authentication, Storage, Realtime

**Requirements:**

- INT-001.1: System **SHALL** use Supabase PostgreSQL for all relational data
- INT-001.2: System **SHALL** use Supabase Auth for user authentication
- INT-001.3: System **SHALL** use Supabase Storage for media files
- INT-001.4: System **SHALL** implement Row-Level Security (RLS) policies
- INT-001.5: System **SHALL** use Supabase Realtime for live updates (future)

**Configuration:**

```javascript
const supabase = createClient("https://[project-id].supabase.co", "[anon-key]");
```

**SLA:** 99.5% uptime

---

#### 7.1.2 OpenAI GPT-4 (AI Text Extraction)

**Purpose:** Extract session structure from lesson plans

**Requirements:**

- INT-002.1: System **SHALL** use GPT-4 API for text extraction
- INT-002.2: System **SHALL** implement retry logic (max 3 attempts)
- INT-002.3: System **SHALL** set timeout of 60 seconds per request
- INT-002.4: System **SHALL** implement cost monitoring (track tokens)
- INT-002.5: System **SHALL** fallback to manual creation if AI fails

**API Endpoint:** `https://api.openai.com/v1/chat/completions`

**Rate Limit:** 3,500 requests/min (paid tier)

---

#### 7.1.3 Google Cloud Vision (OCR)

**Purpose:** Extract text from images (AI upload feature)

**Requirements:**

- INT-003.1: System **SHALL** use Vision API for document text detection
- INT-003.2: System **SHALL** support Vietnamese language
- INT-003.3: System **SHALL** implement retry logic
- INT-003.4: System **SHALL** compress images before sending (max 4MB)

**API Endpoint:** `https://vision.googleapis.com/v1/images:annotate`

**Rate Limit:** 1,800 requests/min

---

#### 7.1.4 Cloudflare R2 (Media Storage)

**Purpose:** Store photos, videos, audio recordings

**Requirements:**

- INT-004.1: System **SHALL** upload media to Cloudflare R2
- INT-004.2: System **SHALL** use signed URLs for secure access
- INT-004.3: System **SHALL** compress images (WebP format, 80% quality)
- INT-004.4: System **SHALL** implement multipart upload for large files (> 5MB)

**CDN URL:** `https://media.educare.vn/[file-path]`

---

#### 7.1.5 Firebase (Analytics & Crashlytics)

**Purpose:** Track user behavior, crashes

**Requirements:**

- INT-005.1: System **SHALL** log screen views, button taps, feature usage
- INT-005.2: System **SHALL** log all crashes with stack traces
- INT-005.3: System **SHALL** anonymize user identifiers in analytics
- INT-005.4: System **SHALL** set up custom events for key actions

**Events to Track:**

- `user_registered`
- `student_created`
- `session_created_manual`
- `session_created_ai`
- `session_logged`
- `behavior_added`
- `report_exported`

---

### 7.2 Platform SDKs

#### 7.2.1 React Native Libraries

| Library                           | Purpose               | Version |
| --------------------------------- | --------------------- | ------- |
| `react-native`                    | Core framework        | 0.72+   |
| `@react-navigation/native`        | Navigation            | 6.x     |
| `react-native-reanimated`         | Animations            | 3.x     |
| `react-native-gesture-handler`    | Gestures              | 2.x     |
| `react-native-vector-icons`       | Icons                 | Latest  |
| `react-native-chart-kit`          | Charts                | Latest  |
| `react-native-pdf`                | PDF generation        | Latest  |
| `react-native-sqlite-storage`     | Offline database      | Latest  |
| `@react-native-community/netinfo` | Network status        | Latest  |
| `react-native-biometrics`         | Face ID / Fingerprint | Latest  |
| `react-native-image-picker`       | Camera & gallery      | Latest  |
| `react-native-audio-recorder`     | Voice recording       | Latest  |

---

### 7.3 API Design Standards

#### 7.3.1 RESTful Principles

- Use HTTP methods correctly: GET (read), POST (create), PUT (update), DELETE (delete)
- Use plural nouns for endpoints: `/api/students`, `/api/sessions`
- Use resource nesting: `/api/sessions/:sessionId/logs`
- Return appropriate status codes

#### 7.3.2 Status Codes

| Code | Meaning               | Usage                              |
| ---- | --------------------- | ---------------------------------- |
| 200  | OK                    | Successful GET/PUT                 |
| 201  | Created               | Successful POST                    |
| 204  | No Content            | Successful DELETE                  |
| 400  | Bad Request           | Validation error                   |
| 401  | Unauthorized          | Missing/invalid auth token         |
| 403  | Forbidden             | Insufficient permissions           |
| 404  | Not Found             | Resource doesn't exist             |
| 409  | Conflict              | Duplicate resource (e.g., email)   |
| 413  | Payload Too Large     | File upload exceeds limit          |
| 422  | Unprocessable Entity  | Semantic validation error          |
| 429  | Too Many Requests     | Rate limit exceeded                |
| 500  | Internal Server Error | Unexpected server error            |
| 503  | Service Unavailable   | Third-party service down (AI, OCR) |

---

## 8. TESTING REQUIREMENTS

### 8.1 Unit Testing (TEST-001)

**Requirements:**

- TEST-001.1: System **SHALL** have > 80% code coverage
- TEST-001.2: All business logic functions **SHALL** have unit tests
- TEST-001.3: All utility functions **SHALL** have unit tests
- TEST-001.4: Tests **SHALL** run in < 30 seconds (CI pipeline)

**Tools:** Jest, React Native Testing Library

---

### 8.2 Integration Testing (TEST-002)

**Requirements:**

- TEST-002.1: All API endpoints **SHALL** have integration tests
- TEST-002.2: Database transactions **SHALL** be tested
- TEST-002.3: Third-party integrations **SHALL** have mock tests
- TEST-002.4: Tests **SHALL** run against staging database

**Tools:** Supertest, Supabase local instance

---

### 8.3 End-to-End Testing (TEST-003)

**Requirements:**

- TEST-003.1: Critical user flows **SHALL** have E2E tests:
  - User registration → Login
  - Create student → Create session → Log session
  - Search behavior → Add to log
- TEST-003.2: Tests **SHALL** run on both iOS and Android simulators
- TEST-003.3: Tests **SHALL** run nightly in CI

**Tools:** Detox or Appium

---

### 8.4 Performance Testing (TEST-004)

**Requirements:**

- TEST-004.1: API response time **SHALL** be tested under load (100 concurrent users)
- TEST-004.2: App launch time **SHALL** be measured on low-end devices
- TEST-004.3: Memory leaks **SHALL** be detected using profiling tools
- TEST-004.4: List scrolling **SHALL** maintain 60fps

**Tools:** JMeter (API), Xcode Instruments, Android Profiler

---

### 8.5 Security Testing (TEST-005)

**Requirements:**

- TEST-005.1: Input validation **SHALL** be tested for XSS vulnerabilities
- TEST-005.2: SQL injection **SHALL** be tested with malicious inputs
- TEST-005.3: Authentication **SHALL** be tested for JWT vulnerabilities
- TEST-005.4: File uploads **SHALL** be tested for malicious files

**Tools:** OWASP ZAP, Burp Suite

---

### 8.6 Accessibility Testing (TEST-006)

**Requirements:**

- TEST-006.1: App **SHALL** pass automated accessibility tests (Axe)
- TEST-006.2: VoiceOver/TalkBack **SHALL** be manually tested
- TEST-006.3: Color contrast **SHALL** be verified (WCAG AA)
- TEST-006.4: Dynamic type **SHALL** be tested at 200% scale

**Tools:** Axe DevTools, iOS Accessibility Inspector, Android Accessibility Scanner

---

### 8.7 User Acceptance Testing (TEST-007)

**Requirements:**

- TEST-007.1: Beta program with 50 teachers for 2 weeks
- TEST-007.2: User satisfaction survey (target > 4.0/5.0)
- TEST-007.3: Bug reporting process via in-app feedback
- TEST-007.4: Weekly feedback review meetings

---

## APPENDIX

### A. Acronyms

- **API**: Application Programming Interface
- **CRUD**: Create, Read, Update, Delete
- **FRS**: Functional Requirements Specification
- **JWT**: JSON Web Token
- **RBAC**: Role-Based Access Control
- **REST**: Representational State Transfer
- **SQL**: Structured Query Language
- **TLS**: Transport Layer Security
- **UUID**: Universally Unique Identifier
- **WCAG**: Web Content Accessibility Guidelines
- **XSS**: Cross-Site Scripting

---

### B. References

1. **API Specification**: [API_SPECIFICATION.md](./API_SPECIFICATION.md)
2. **Database Design**: [DATABASE_DESIGN.md](./DATABASE_DESIGN.md)
3. **Wireframes**: [01-dashboard.md](./01-dashboard.md) through [32-edit-session.md](./32-edit-session.md)
4. **Design System**: [design-specs.md](./design-specs.md)
5. **UX Guidelines**: [ux-guidelines.md](./ux-guidelines.md)

---

### C. Document History

| Version | Date         | Author           | Changes                          |
| ------- | ------------ | ---------------- | -------------------------------- |
| 0.1     | Oct 25, 2025 | Engineering Team | Initial draft                    |
| 0.5     | Nov 1, 2025  | Engineering Team | Functional requirements complete |
| 1.0     | Nov 4, 2025  | Engineering Team | All requirements finalized       |

---

**Approval Signatures:**

- **CTO**: ************\_************ Date: ****\_\_\_****
- **Engineering Lead**: **********\_\_********** Date: ****\_\_\_****
- **QA Lead**: ************\_\_\_************ Date: ****\_\_\_****
- **Security Lead**: **********\_\_********** Date: ****\_\_\_****

---

**Next Steps:**

1. ✅ FRS Approved → Begin technical architecture design
2. ✅ Set up development environment (React Native, Supabase)
3. ✅ Create database schema in Supabase
4. ✅ Implement authentication flow
5. ✅ Sprint 1 kick-off (Student Management module)
