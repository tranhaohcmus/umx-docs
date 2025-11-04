# Product Requirements Document (PRD)

# Educare Connect - Mobile Application

**Document Version:** 1.0  
**Date:** November 4, 2025  
**Product Owner:** Product Management Team  
**Target Release:** Month 8 (July 2026)

---

## 📋 TABLE OF CONTENTS

1. [Product Overview](#product-overview)
2. [User Personas](#user-personas)
3. [User Stories](#user-stories)
4. [Feature List (MoSCoW)](#feature-list-moscow)
5. [Acceptance Criteria](#acceptance-criteria)
6. [Assumptions & Constraints](#assumptions--constraints)
7. [Dependencies](#dependencies)
8. [Open Questions](#open-questions)

---

## 1. PRODUCT OVERVIEW

### 1.1 Product Vision

**Educare Connect** là trợ lý số thông minh giúp giáo viên giáo dục đặc biệt (GDĐB) ghi nhật ký, phân tích hành vi và báo cáo tiến độ học sinh một cách khoa học, nhanh chóng và dễ dàng.

### 1.2 Product Scope

**In Scope (MVP - 8 months):**

- ✅ Mobile app (iOS 13+, Android 8+)
- ✅ Teacher authentication & profile management
- ✅ Student management (CRUD)
- ✅ Session creation (Manual + AI-powered)
- ✅ Session logging (4-step flow)
- ✅ ABC behavior tracking
- ✅ Behavior Dictionary (127+ evidence-based behaviors)
- ✅ Analytics & Reports (PDF/Excel export)
- ✅ Offline-first architecture

**Out of Scope (Future releases):**

- ❌ Web dashboard (Year 2)
- ❌ Parent portal (Year 2)
- ❌ Team collaboration features (Year 2)
- ❌ Video behavior detection (Future)
- ❌ Multi-language support (Year 2)

---

### 1.3 Key Features Summary

| Feature Category       | Features                                                                                |
| ---------------------- | --------------------------------------------------------------------------------------- |
| **User Management**    | Register, Login, 2FA, Profile, Settings                                                 |
| **Student Management** | Add/Edit/Archive students, Quick stats, Search & filter                                 |
| **Session Management** | Manual creation (3 steps), AI upload, Edit, Delete, View calendar                       |
| **Session Logging**    | 4-step flow (Goals, Attitude, Notes, Behaviors), ABC tracking, Media upload             |
| **Behavior System**    | 127+ behaviors in 3 groups, Evidence-based content, Keyword search, Favorites, Trending |
| **Analytics**          | Dashboard, Behavior trends, Goal completion rate, Export reports                        |
| **Offline Mode**       | Cache data, Queue sync, Conflict resolution                                             |

---

## 2. USER PERSONAS

### Persona 1: Cô Mai - Experienced SPED Teacher

**Demographics:**

- Age: 28-35
- Experience: 3-7 years
- Location: Private SPED center, Ho Chi Minh City
- Tech Proficiency: High

**Context:**

- Manages 5-8 students per week
- Each session: 2-3 hours
- Works 6 days/week
- Currently uses Excel + paper notes

**Goals:**

1. Reduce logging time from 45 min → 15 min
2. Generate professional reports for parents
3. Track student progress over time
4. Access evidence-based intervention strategies

**Frustrations:**

- Excel is slow and error-prone
- Hard to remember details after multiple sessions
- Parents ask "Is my child improving?" - hard to quantify
- Lack of scientific references for interventions

**Behaviors:**

- Logs sessions same day (within 4 hours)
- Reviews analytics weekly
- Shares reports with parents monthly
- Searches for new intervention ideas frequently

---

### Persona 2: Thầy Minh - Novice SPED Teacher

**Demographics:**

- Age: 22-26
- Experience: < 2 years
- Location: Public special school, Hanoi
- Tech Proficiency: Medium

**Context:**

- Manages 3-5 students
- Just graduated, needs guidance
- Uncertain about what to log
- Fears missing important details

**Goals:**

1. Learn proper logging standards
2. Use templates to get started quickly
3. Understand common behaviors and interventions
4. Build confidence in reporting to parents

**Frustrations:**

- Doesn't know what's "important" to log
- Overwhelmed by many behaviors - which to track?
- Supervisor asks for "evidence" - unsure what that means
- Paper notes are messy and unorganized

**Behaviors:**

- Needs step-by-step guidance
- Copies from templates initially
- Refers to behavior dictionary often
- Asks colleagues for help

---

## 3. USER STORIES

### 3.1 Epic 1: User Authentication & Onboarding

#### US-001: Teacher Registration

**As a** new teacher,  
**I want to** create an account with email and password,  
**So that** I can securely access the app and store my data.

**Acceptance Criteria:**

- [ ] Email format validation (RFC 5322)
- [ ] Password strength: min 8 chars, 1 uppercase, 1 number
- [ ] Email verification link sent within 1 minute
- [ ] Error messages clear and actionable
- [ ] Privacy policy and terms acceptance checkbox

**Priority:** Must-Have  
**Story Points:** 3  
**Screen:** Not in wireframes (standard auth)

---

#### US-002: Teacher Login

**As a** returning teacher,  
**I want to** log in with my email and password,  
**So that** I can access my students and session data.

**Acceptance Criteria:**

- [ ] Login with email + password
- [ ] "Remember me" checkbox (30-day session)
- [ ] "Forgot password" link
- [ ] Biometric login (Face ID / Fingerprint) after first login
- [ ] Wrong password shows clear error after 3 attempts

**Priority:** Must-Have  
**Story Points:** 3  
**Screen:** Not in wireframes

---

#### US-003: Onboarding Flow

**As a** first-time user,  
**I want to** see a quick tutorial (3 screens),  
**So that** I understand key features before starting.

**Acceptance Criteria:**

- [ ] 3 swipeable onboarding screens
- [ ] Skip button on every screen
- [ ] "Get Started" button on last screen
- [ ] Show only once (don't repeat on next login)
- [ ] Covers: Easy logging, AI creation, Analytics

**Priority:** Should-Have  
**Story Points:** 2  
**Screen:** 29-onboarding.md

---

### 3.2 Epic 2: Student Management

#### US-004: Add New Student

**As a** teacher,  
**I want to** add a new student with basic info,  
**So that** I can start creating sessions for them.

**Acceptance Criteria:**

- [ ] Required fields: Full name, Age
- [ ] Optional fields: Nickname, Gender, Avatar, Notes
- [ ] Avatar: Upload photo or use initials fallback
- [ ] Age validation: 2-18 years old
- [ ] Success confirmation toast
- [ ] Auto-navigate to student detail after creation

**Priority:** Must-Have  
**Story Points:** 3  
**Screen:** Modal (not in wireframes)

---

#### US-005: View Student List

**As a** teacher,  
**I want to** see all my students in one list,  
**So that** I can quickly access their details.

**Acceptance Criteria:**

- [ ] Show student cards with: Avatar, Name, Age, Gender
- [ ] Show weekly stats: "Tuần này: X buổi", "Y/X buổi đã ghi"
- [ ] Search bar filters by name (real-time)
- [ ] Filter tabs: All, Active, Paused
- [ ] Empty state: "Chưa có học sinh. Thêm học sinh đầu tiên!"
- [ ] Pull-to-refresh updates data

**Priority:** Must-Have  
**Story Points:** 5  
**Screen:** 01-dashboard.md

---

#### US-006: View Student Detail & Calendar

**As a** teacher,  
**I want to** see a student's session calendar and stats,  
**So that** I can track their schedule and progress.

**Acceptance Criteria:**

- [ ] Header: Avatar, Full name, Age, Gender
- [ ] Stats: Completion %, Total sessions, Behaviors, Hours
- [ ] Week calendar: T2-CN with status icons
  - ✅ Completed (evaluated)
  - ⏰ Scheduled (not started)
  - ⚠️ Overdue (past date, not started)
  - ⭕ No session
- [ ] Today's sessions section
- [ ] Upcoming sessions section
- [ ] Swipe calendar left/right to change week
- [ ] Tap date to jump to that day

**Priority:** Must-Have  
**Story Points:** 8  
**Screen:** 02-student-detail.md

---

### 3.3 Epic 3: Session Creation (Manual)

#### US-007: Create Session - Step 1 (Basic Info)

**As a** teacher,  
**I want to** specify session date, time slot, and time range,  
**So that** I can plan the session details.

**Acceptance Criteria:**

- [ ] Date picker (default: today)
- [ ] Session type toggle: Sáng (8:00-11:30) / Chiều (14:00-17:00)
- [ ] Time range auto-fills based on session type
- [ ] Manual time override allowed
- [ ] Validation: End time > Start time, min 30 min
- [ ] Optional notes field (max 500 chars)
- [ ] Progress bar: 33% (Step 1/3)
- [ ] "TIẾP TỤC (1/3)" button enabled only when valid

**Priority:** Must-Have  
**Story Points:** 5  
**Screen:** 04-manual-step1.md

---

#### US-008: Create Session - Step 2 (Content)

**As a** teacher,  
**I want to** add teaching content and goals,  
**So that** I know what to teach and evaluate later.

**Acceptance Criteria:**

- [ ] Add content button opens modal
- [ ] Modal: Content name, Domain dropdown, Description
- [ ] Domain options: Nhận thức, Vận động, Ngôn ngữ, Xã hội, Tự phục vụ
- [ ] Each content has multiple goals (min 1, max 10)
- [ ] Drag-to-reorder content items
- [ ] Delete content with confirmation
- [ ] Content Library button shows saved templates
- [ ] Progress bar: 66% (Step 2/3)
- [ ] "TIẾP TỤC (2/3)" enabled when >= 1 content

**Priority:** Must-Have  
**Story Points:** 8  
**Screen:** 05-manual-step2.md, 06-modal-add-content.md

---

#### US-009: Create Session - Step 3 (Review & Confirm)

**As a** teacher,  
**I want to** review all session info before saving,  
**So that** I can catch errors and confirm details.

**Acceptance Criteria:**

- [ ] Show summary: Date, Time, Content count, Goal count
- [ ] List all content with goals (collapsed)
- [ ] Edit button for each section (goes back to that step)
- [ ] "TẠO BUỔI HỌC" button saves and navigates to student detail
- [ ] Success toast: "Đã tạo buổi học thành công!"
- [ ] Progress bar: 100% (Step 3/3)

**Priority:** Must-Have  
**Story Points:** 5  
**Screen:** 07-manual-step3.md

---

### 3.4 Epic 4: Session Creation (AI-Powered)

#### US-010: AI Upload Lesson Plan

**As a** teacher,  
**I want to** upload a lesson plan file or paste text,  
**So that** AI can auto-create sessions for me.

**Acceptance Criteria:**

- [ ] Upload options: Camera (document scan) or Gallery
- [ ] Supported formats: PDF, DOCX, TXT, JPG, PNG
- [ ] Max file size: 10MB
- [ ] Alternative: Paste text (max 5000 chars)
- [ ] Show benefits list: "AI sẽ giúp bạn..."
- [ ] "PHÂN TÍCH NGAY" button enabled when file/text provided
- [ ] Error: "File quá lớn (>10MB)" or "Định dạng không hỗ trợ"

**Priority:** Should-Have  
**Story Points:** 8  
**Screen:** 08-ai-upload.md

---

#### US-011: AI Processing & Preview

**As a** teacher,  
**I want to** see AI processing status and preview results,  
**So that** I know when it's done and can review before saving.

**Acceptance Criteria:**

- [ ] Processing screen: Progress bar, "Đang phân tích..." (0-100%)
- [ ] Average processing time: 30-60 seconds
- [ ] Preview screen shows extracted sessions (multiple)
- [ ] Each session: Date, Time slot, Content list, Goals
- [ ] Edit button to modify any field
- [ ] Delete session if incorrect
- [ ] "LƯU TẤT CẢ" creates all sessions at once
- [ ] Error fallback: "AI không thể phân tích. Vui lòng tạo thủ công."

**Priority:** Should-Have  
**Story Points:** 13  
**Screen:** 09-ai-processing.md, 10-ai-preview.md

---

### 3.5 Epic 5: Session Logging

#### US-012: Select Session to Log

**As a** teacher,  
**I want to** choose which session to log,  
**So that** I can evaluate the correct one.

**Acceptance Criteria:**

- [ ] Show today's sessions first (grouped by date)
- [ ] Session card shows: Student, Time slot, Status
- [ ] Status: "Chưa bắt đầu đánh giá" or "Đã hoàn thành đánh giá"
- [ ] Button: "BẮT ĐẦU GHI →" (not started) or "XEM CHI TIẾT" (completed)
- [ ] Previous days section (expandable)
- [ ] Calendar view button to jump to specific date
- [ ] Search by student name

**Priority:** Must-Have  
**Story Points:** 5  
**Screen:** 11-session-selector.md

---

#### US-013: Log Overview (2 States)

**As a** teacher,  
**I want to** see session overview before and after logging,  
**So that** I understand what to evaluate or review results.

**Acceptance Criteria:**

**State 1: Not Evaluated**

- [ ] Show content list (collapsed by default)
- [ ] Tap to expand and preview goals
- [ ] "BẮT ĐẦU ĐÁNH GIÁ →" button starts 4-step flow

**State 2: Completed**

- [ ] Summary card: X/Y goals achieved, Mood, Photos, Behaviors
- [ ] Content list with status (✅ all achieved, ⚠️ partial)
- [ ] Tap to expand and see goal status (✅/❌)
- [ ] Attitude & Mood section (collapsible)
- [ ] Teacher Notes section (text, audio, photos)
- [ ] Behavior Incidents section (ABC summary)
- [ ] Edit and Share buttons

**Priority:** Must-Have  
**Story Points:** 13  
**Screen:** 12-log-overview.md

---

#### US-014: Logging Step 1 - Evaluate ALL Goals

**As a** teacher,  
**I want to** evaluate all goals of all content in one screen,  
**So that** I can log quickly without switching screens.

**Acceptance Criteria:**

- [ ] Long scrollable list of all content sections
- [ ] Sticky headers: Content name stays visible when scrolling
- [ ] Quick nav sidebar: [1] [2] [3] [4] [5] to jump between content
- [ ] Each goal has radio buttons: Đạt / Chưa đạt / N/A
- [ ] Optional notes field per content (max 500 chars)
- [ ] Auto-save every 2 minutes (show last save time)
- [ ] Progress bar: 25% (Step 1/4)
- [ ] "TIẾP TỤC (1/4) →" enabled when all goals evaluated

**Priority:** Must-Have  
**Story Points:** 13  
**Screen:** 13-log-detail.md

---

#### US-015: Logging Step 2 - Attitude & Mood

**As a** teacher,  
**I want to** record student's attitude and mood,  
**So that** I can track social-emotional development.

**Acceptance Criteria:**

- [ ] Mood selector: 5 emojis (Very difficult → Very good)
- [ ] 3 sliders (1-5):
  - Cooperation level
  - Focus level
  - Independence level
- [ ] Attitude notes field (optional, max 500 chars)
- [ ] Progress bar: 50% (Step 2/4)
- [ ] "TIẾP TỤC (2/4) →" button

**Priority:** Must-Have  
**Story Points:** 5  
**Screen:** 14-log-attitude.md

---

#### US-016: Logging Step 3 - Teacher Notes

**As a** teacher,  
**I want to** add text, voice, photos, and videos,  
**So that** I can document the session richly.

**Acceptance Criteria:**

- [ ] Text notes: Multi-line, max 2000 chars
- [ ] Voice recording: Tap to record (max 5 min), playback
- [ ] Photo upload: Camera or gallery, max 10 photos
- [ ] Video upload: Camera or gallery, max 3 videos, max 100MB each
- [ ] All fields optional
- [ ] Preview media before saving
- [ ] Delete media option
- [ ] Progress bar: 75% (Step 3/4)
- [ ] "TIẾP TỤC (3/4) →" button (no validation)

**Priority:** Should-Have  
**Story Points:** 8  
**Screen:** 15-log-notes.md

---

#### US-017: Logging Step 4 - Behavior Incidents (ABC)

**As a** teacher,  
**I want to** record behaviors using ABC model,  
**So that** I can analyze patterns and interventions.

**Acceptance Criteria:**

- [ ] "THÊM HÀNH VI MỚI" opens bottom sheet
- [ ] Bottom sheet (17-abc-sheet.md):
  - Search behavior library
  - Recent behaviors quick select
  - Favorites quick select
  - Or create custom behavior
- [ ] ABC fields:
  - Antecedent (Tình huống): Text field
  - Behavior (Hành vi): Auto-filled from dictionary or manual
  - Consequence (Kết quả): Text field
  - Severity level: 1-5 slider
  - Time occurred: Time picker (default: now)
- [ ] Behavior card shows: Icon, Name, A-B-C summary, Severity, Time
- [ ] Edit/Delete behavior buttons
- [ ] Multiple behaviors allowed
- [ ] Progress bar: 100% (Step 4/4)
- [ ] "HOÀN TẤT & LƯU" saves and navigates to Log Overview (State 2)
- [ ] "Bỏ qua bước" allowed (behaviors optional)

**Priority:** Must-Have  
**Story Points:** 13  
**Screen:** 16-log-behavior.md, 17-abc-sheet.md

---

### 3.6 Epic 6: Behavior Dictionary

#### US-018: Browse Behavior Dictionary

**As a** teacher,  
**I want to** browse 127+ behaviors organized by theoretical groups,  
**So that** I can learn about common behaviors and interventions.

**Acceptance Criteria:**

- [ ] Header: "Từ điển Hành vi • 127 hành vi • 🎓 Evidence-based"
- [ ] Search bar with keyword placeholder
- [ ] Filter buttons: Nhóm, Sắp xếp, Yêu thích
- [ ] Sections:
  1. Favorites (if any)
  2. Trending behaviors (weekly)
  3. Behavior groups (3 cards)
- [ ] Each behavior card shows:
  - Hierarchical ID (1.1, 1.2, 2.1)
  - Vietnamese & English name
  - Group classification
  - Usage count (system + personal)
  - Evidence-based badge 🎓
  - Star icon (toggle favorite)
- [ ] Tap card → Navigate to detail (19-dictionary-detail.md)
- [ ] Tap group card → Navigate to group list (18.5-dictionary-group.md)

**Priority:** Must-Have  
**Story Points:** 8  
**Screen:** 18-dictionary-home.md

---

#### US-019: Search Behaviors by Keywords

**As a** teacher,  
**I want to** search behaviors using Vietnamese keywords,  
**So that** I can quickly find relevant behaviors.

**Acceptance Criteria:**

- [ ] Search bar at top (always visible)
- [ ] Auto-suggest as typing (debounced 300ms)
- [ ] Search in:
  - Vietnamese behavior names
  - English behavior names
  - 10-15 keywords per behavior (backend only, not displayed)
- [ ] Fuzzy matching for typos
- [ ] Search results show matching behaviors
- [ ] Highlight matched text
- [ ] No results: "Không tìm thấy. Thử từ khóa khác?"
- [ ] Clear search (X button)

**Priority:** Must-Have  
**Story Points:** 5  
**Screen:** 18-dictionary-home.md

---

#### US-020: View Behavior Detail (Evidence-Based)

**As a** teacher,  
**I want to** see clinical description, explanations, solutions, and research sources,  
**So that** I can understand the behavior scientifically and intervene appropriately.

**Acceptance Criteria:**

- [ ] Header: Behavior ID, Vietnamese & English name, Group
- [ ] Sections (all collapsible):
  1. **Manifestation** (Biểu hiện): Clinical description of observable behavior
  2. **Explanation** (Tại sao xảy ra?): 2-4 theoretical frameworks (title + description)
  3. **Solutions** (Can thiệp Evidence-based): 4-5 strategies (title + description)
  4. **Sources** (Nghiên cứu & Nguồn): Academic citations (APA format)
- [ ] Usage stats: System-wide + personal count
- [ ] Favorite button (star icon, toggle)
- [ ] Share button (copy link or PDF export)
- [ ] "Sử dụng trong nhật ký" button → Quick add to current log

**Priority:** Must-Have  
**Story Points:** 8  
**Screen:** 19-dictionary-detail.md

---

### 3.7 Epic 7: Analytics & Reports

#### US-021: View Analytics Dashboard

**As a** teacher,  
**I want to** see visual charts of behavior trends,  
**So that** I can identify patterns and track progress.

**Acceptance Criteria:**

- [ ] Date range selector: Tuần này, Tháng này, 3 tháng, 6 tháng, Tùy chọn
- [ ] Summary stats: Completion %, Sessions, Behaviors, Students
- [ ] Behavior trend chart:
  - Line graph (daily or weekly)
  - Average line
  - Change percentage
- [ ] Top 5 behaviors:
  - Ranked by frequency
  - Count + percentage
  - Progress bar visualization
  - Tap → View detail (21-analytics-detail.md)
- [ ] Function analysis grid (4 categories):
  - Attention, Escape, Sensory, Tangible
  - Count + percentage per category
- [ ] "Xem báo cáo đầy đủ" → Export PDF/Excel

**Priority:** Must-Have  
**Story Points:** 13  
**Screen:** 20-analytics-overview.md

---

#### US-022: Export Reports (PDF/Excel)

**As a** teacher,  
**I want to** export session logs and analytics,  
**So that** I can share with parents, supervisors, or keep records.

**Acceptance Criteria:**

- [ ] Export options:
  - Single session (from Log Overview)
  - Date range (from Analytics)
  - Student summary (from Student Detail)
- [ ] Formats: PDF (formatted) and Excel (raw data)
- [ ] PDF includes:
  - Student info
  - Session details
  - Goal evaluations with status
  - Attitude & mood charts
  - Teacher notes
  - Photos (embedded)
  - Behavior incidents (ABC table)
- [ ] Excel includes:
  - All data in structured columns
  - One row per goal evaluation
  - Separate sheet for behaviors
- [ ] Download to device
- [ ] Share via email, messaging apps
- [ ] Processing time: < 5 seconds for PDF, < 3 seconds for Excel

**Priority:** Should-Have  
**Story Points:** 13  
**Screen:** Share buttons throughout app

---

### 3.8 Epic 8: Offline Mode & Sync

#### US-023: Offline Data Access

**As a** teacher,  
**I want to** view cached data when offline,  
**So that** I can access student info even without internet.

**Acceptance Criteria:**

- [ ] Cache on first load:
  - Student list
  - Session list (last 30 days)
  - Behavior dictionary (all 127 behaviors)
  - Content library templates
- [ ] Offline indicator: Banner at top "Đang ngoại tuyến"
- [ ] Read-only mode for most screens
- [ ] Can still log sessions (queued for sync)
- [ ] Clear cache option in settings

**Priority:** Should-Have  
**Story Points:** 8  
**Screen:** All screens (offline banner)

---

#### US-024: Offline Session Logging & Queue Sync

**As a** teacher,  
**I want to** log sessions offline and auto-sync when online,  
**So that** I don't lose data in poor connectivity areas.

**Acceptance Criteria:**

- [ ] Log sessions offline (saved to local DB)
- [ ] "Chưa đồng bộ" badge on offline sessions
- [ ] Auto-sync when internet detected
- [ ] Sync queue: Shows pending items count
- [ ] Conflict resolution:
  - If same session edited online by another device → Show warning
  - Manual merge UI with side-by-side comparison
- [ ] Sync success toast: "Đã đồng bộ 3 phiên học"

**Priority:** Should-Have  
**Story Points:** 13  
**Screen:** Throughout app (sync indicator)

---

## 4. FEATURE LIST (MoSCoW)

### 4.1 Must-Have (MVP - Month 8 Launch)

| Feature ID | Feature Name                     | User Story IDs                         | Priority  | Complexity |
| ---------- | -------------------------------- | -------------------------------------- | --------- | ---------- |
| F-001      | User Authentication              | US-001, US-002                         | Must-Have | Medium     |
| F-002      | Student Management (CRUD)        | US-004, US-005, US-006                 | Must-Have | Medium     |
| F-003      | Manual Session Creation          | US-007, US-008, US-009                 | Must-Have | High       |
| F-004      | Session Selector                 | US-012                                 | Must-Have | Low        |
| F-005      | Session Logging (4 steps)        | US-013, US-014, US-015, US-016, US-017 | Must-Have | Very High  |
| F-006      | ABC Behavior Tracking            | US-017                                 | Must-Have | High       |
| F-007      | Behavior Dictionary (Browse)     | US-018, US-019                         | Must-Have | Medium     |
| F-008      | Behavior Detail (Evidence-based) | US-020                                 | Must-Have | Medium     |
| F-009      | Analytics Dashboard              | US-021                                 | Must-Have | High       |
| F-010      | Bottom Navigation                | N/A                                    | Must-Have | Low        |

**Total Must-Have:** 10 features

---

### 4.2 Should-Have (Nice to Have in MVP)

| Feature ID | Feature Name               | User Story IDs    | Priority    | Complexity |
| ---------- | -------------------------- | ----------------- | ----------- | ---------- |
| F-011      | Onboarding Flow            | US-003            | Should-Have | Low        |
| F-012      | AI Session Creation        | US-010, US-011    | Should-Have | Very High  |
| F-013      | Teacher Notes Media        | US-016            | Should-Have | Medium     |
| F-014      | Export Reports (PDF/Excel) | US-022            | Should-Have | High       |
| F-015      | Offline Mode               | US-023, US-024    | Should-Have | High       |
| F-016      | Content Library Templates  | Implied in US-008 | Should-Have | Medium     |
| F-017      | Behavior Favorites         | US-018, US-020    | Should-Have | Low        |
| F-018      | Behavior Trending          | US-018            | Should-Have | Medium     |

**Total Should-Have:** 8 features

---

### 4.3 Could-Have (Post-Launch Improvements)

| Feature ID | Feature Name                   | Priority   | Complexity | Target   |
| ---------- | ------------------------------ | ---------- | ---------- | -------- |
| F-019      | Biometric Login (Face ID)      | Could-Have | Low        | Month 9  |
| F-020      | Push Notifications (Reminders) | Could-Have | Medium     | Month 9  |
| F-021      | Dark Mode                      | Could-Have | Low        | Month 10 |
| F-022      | Backup & Restore               | Could-Have | Medium     | Month 10 |
| F-023      | Advanced Analytics Filters     | Could-Have | Medium     | Month 11 |
| F-024      | Multi-Behavior Comparison      | Could-Have | High       | Month 11 |
| F-025      | Behavior Intervention Library  | Could-Have | High       | Month 12 |

**Total Could-Have:** 7 features

---

### 4.4 Won't-Have (Future Releases)

| Feature ID | Feature Name                  | Reason                            | Target  |
| ---------- | ----------------------------- | --------------------------------- | ------- |
| F-026      | Parent Portal                 | Out of scope for teacher-only MVP | Year 2  |
| F-027      | Web Dashboard                 | Resource constraint               | Year 2  |
| F-028      | Team Collaboration            | Complex, low priority             | Year 2  |
| F-029      | Video Behavior Detection (AI) | Technically complex, requires R&D | Year 3+ |
| F-030      | Multi-language Support        | Focus on Vietnamese first         | Year 2  |

---

## 5. ACCEPTANCE CRITERIA

### 5.1 Feature-Level Acceptance Criteria

Each feature must meet the following **general criteria** in addition to user story-specific criteria:

#### Performance

- [ ] App load time: < 2 seconds (cold start)
- [ ] Screen transition: < 300ms
- [ ] API response time: < 500ms (p95)
- [ ] Image loading: Lazy load with shimmer placeholder
- [ ] List scrolling: 60fps smooth scrolling (no jank)

#### Accessibility

- [ ] VoiceOver support (iOS) / TalkBack (Android)
- [ ] Minimum touch target: 44x44pt
- [ ] Color contrast: WCAG AA (4.5:1 for text)
- [ ] Dynamic type support (font scaling)
- [ ] Focus indicators for keyboard navigation

#### Error Handling

- [ ] Network errors: Clear message + retry button
- [ ] Validation errors: Inline, specific, actionable
- [ ] Server errors: Graceful degradation
- [ ] Crash recovery: Auto-save drafts

#### Design Consistency

- [ ] Matches wireframes (32 screens)
- [ ] Uses design system (colors, typography, spacing)
- [ ] Follows platform guidelines (iOS HIG, Material Design)
- [ ] Consistent iconography

---

### 5.2 Epic-Level Acceptance Criteria

#### Epic 1: User Authentication

- [ ] **Security:**
  - Passwords hashed with bcrypt (cost 12)
  - JWT tokens expire after 1 hour
  - Refresh tokens stored securely (iOS Keychain / Android KeyStore)
  - Rate limiting: 5 login attempts per 15 minutes
- [ ] **Email Verification:**
  - Email sent within 1 minute
  - Verification link valid for 24 hours
  - Resend option available
- [ ] **Password Reset:**
  - Email sent within 1 minute
  - Reset link valid for 1 hour
  - Old password invalidated after reset

---

#### Epic 2: Student Management

- [ ] **Data Validation:**
  - Full name: 2-50 characters, letters only
  - Age: 2-18 years
  - Gender: Male/Female/Other (optional)
- [ ] **Avatar Handling:**
  - Max file size: 5MB
  - Supported formats: JPG, PNG, HEIC
  - Auto-resize to 512x512px
  - Fallback: Initials avatar (2 chars, uppercase)
- [ ] **List Performance:**
  - Virtualized list (FlatList) for 100+ students
  - Search debounced (300ms)
  - Filter instant (client-side)

---

#### Epic 3: Session Creation (Manual)

- [ ] **Step Flow:**
  - Back button preserves state (no data loss)
  - Progress bar accurate (33%, 66%, 100%)
  - Close button shows confirmation dialog if data entered
- [ ] **Data Persistence:**
  - Auto-save draft every 30 seconds
  - Restore draft on app restart
  - Clear draft after successful creation
- [ ] **Content & Goals:**
  - Min 1 content, max 20 contents
  - Min 1 goal per content, max 10 goals
  - Goals can be reordered (drag-and-drop)

---

#### Epic 4: Session Creation (AI)

- [ ] **AI Processing:**
  - OCR accuracy: > 80% for printed text
  - Processing time: < 60 seconds for 10-page document
  - Fallback to manual if AI fails
- [ ] **File Upload:**
  - Streaming upload (chunked)
  - Progress indicator (0-100%)
  - Cancel upload option
- [ ] **Preview & Edit:**
  - All AI-generated fields editable
  - Delete session option
  - Save all or save individually

---

#### Epic 5: Session Logging

- [ ] **Auto-Save:**
  - Save draft every 2 minutes
  - Show last save timestamp
  - Warning if unsaved changes on exit
- [ ] **Goal Evaluation:**
  - Quick nav sidebar functional
  - Sticky headers work correctly
  - Radio buttons single-select
- [ ] **Attitude & Mood:**
  - Sliders snap to integer values (1-5)
  - Visual feedback on selection
- [ ] **Media Upload:**
  - Photo: Max 10 photos, 5MB each
  - Video: Max 3 videos, 100MB each
  - Audio: Max 5 minutes
  - Compress before upload
- [ ] **ABC Behaviors:**
  - Multiple behaviors allowed (no limit)
  - Each behavior has A, B, C required
  - Severity and time required

---

#### Epic 6: Behavior Dictionary

- [ ] **Data Structure:**
  - 127+ behaviors (3 groups)
  - Each behavior has:
    - ID (hierarchical: 1.1, 1.2, 2.1)
    - Vietnamese & English name
    - 10-15 keywords (backend only)
    - Manifestation (TEXT)
    - Explanation (2-4 items)
    - Solutions (4-5 items)
    - Sources (2+ citations)
- [ ] **Search Performance:**
  - Full-text search with GIN index
  - Results in < 200ms
  - Fuzzy matching with Levenshtein distance
- [ ] **Favorites:**
  - Toggle star icon
  - Persist to database
  - Show in separate section

---

#### Epic 7: Analytics

- [ ] **Charts:**
  - Line chart: react-native-chart-kit or Victory Native
  - Smooth animations (300ms)
  - Touch interactions (show values on tap)
- [ ] **Date Range:**
  - Preset ranges working
  - Custom date picker functional
  - Update all charts on change
- [ ] **Export:**
  - PDF: Formatted with charts and tables
  - Excel: Raw data in columns
  - File size: < 5MB
  - Generation time: < 5 seconds

---

#### Epic 8: Offline Mode

- [ ] **Caching Strategy:**
  - Cache-first for reads
  - Network-first for writes (with queue)
- [ ] **Sync Queue:**
  - FIFO order
  - Retry on failure (exponential backoff)
  - Max 3 retries
  - Show sync status
- [ ] **Conflict Resolution:**
  - Last-write-wins (default)
  - Manual merge for important data (sessions)

---

## 6. ASSUMPTIONS & CONSTRAINTS

### 6.1 Assumptions

#### User Assumptions

1. **Device Ownership:**

   - Teachers have personal smartphone (iOS 13+ or Android 8+)
   - At least 2GB RAM, 500MB free storage
   - Camera available (for photos/AI upload)

2. **Connectivity:**

   - Internet available most of the time (3G or better)
   - Can tolerate occasional offline periods (< 24 hours)

3. **Digital Literacy:**

   - Comfortable using messaging apps (Zalo, Facebook)
   - Can type Vietnamese on mobile keyboard
   - Understands basic app navigation (swipe, tap, scroll)

4. **Behavior Tracking:**
   - Teachers can recall session details within 4 hours
   - Teachers understand ABC behavior model (or willing to learn)

---

#### Technical Assumptions

1. **Third-Party Services:**

   - Supabase uptime: > 99.5%
   - OpenAI API uptime: > 99%
   - Cloudflare CDN uptime: > 99.9%

2. **Platform Support:**

   - React Native compatible with iOS 13-17, Android 8-14
   - No breaking changes in React Native core
   - Expo SDK stable and supported

3. **AI Performance:**
   - OCR accuracy: 80-90% for Vietnamese printed text
   - NLP extraction: 70-80% accuracy for session structure
   - Acceptable error rate: Teachers will review all AI output

---

### 6.2 Constraints

#### Business Constraints

1. **Budget:** 2.2B VND total (Year 1)
2. **Team Size:** 5.5 FTE developers
3. **Timeline:** 8 months to launch (aggressive)
4. **Revenue Target:** 500M VND ARR by end of Year 1

---

#### Technical Constraints

1. **Mobile-Only:** No web app in MVP
2. **Single Language:** Vietnamese only (English in Year 2)
3. **File Size:** APK < 50MB, IPA < 100MB (for fast downloads)
4. **API Rate Limits:**
   - OpenAI: 3,500 requests/min (paid tier)
   - Supabase: 500 requests/sec

---

#### Regulatory Constraints

1. **Data Privacy:**

   - GDPR compliance (EU users if any)
   - COPPA compliance (no direct child data collection)
   - Vietnam Personal Data Protection Decree 13/2023

2. **Accessibility:**

   - WCAG 2.1 Level AA (for government contracts)

3. **App Store Guidelines:**
   - Apple App Store Review Guidelines
   - Google Play Store Policies

---

#### Design Constraints

1. **Platform Consistency:**

   - Must feel native on both iOS and Android
   - Follow HIG (iOS) and Material Design (Android) where applicable

2. **Backward Compatibility:**
   - Support iOS 13+ (covers 95% of iOS devices)
   - Support Android 8+ (covers 90% of Android devices)

---

## 7. DEPENDENCIES

### 7.1 External Dependencies

| Dependency       | Purpose                 | Risk Level | Mitigation                                  |
| ---------------- | ----------------------- | ---------- | ------------------------------------------- |
| **Supabase**     | Backend, Database, Auth | Medium     | Self-host option if needed, PostgreSQL dump |
| **OpenAI API**   | AI text extraction      | Medium     | Google Cloud Vision API fallback            |
| **Cloudflare**   | CDN, Image optimization | Low        | AWS S3 + CloudFront fallback                |
| **Expo**         | React Native framework  | Low        | Can eject to bare React Native if needed    |
| **Firebase**     | Analytics, Crashlytics  | Low        | Mixpanel + Sentry fallback                  |
| **Apple/Google** | App Store distribution  | High       | Web PWA fallback (future)                   |

---

### 7.2 Internal Dependencies

| Dependency                  | Owner          | Status      | Due Date |
| --------------------------- | -------------- | ----------- | -------- |
| **Design System**           | UI/UX Designer | In Progress | Month 2  |
| **API Specification**       | Backend Dev    | Complete    | Month 1  |
| **Database Schema**         | Backend Dev    | Complete    | Month 1  |
| **Behavior Data (127+)**    | Content Team   | In Progress | Month 3  |
| **Vietnamese Localization** | Content Team   | Not Started | Month 5  |

---

### 7.3 Cross-Feature Dependencies

```
Session Creation (Manual) → Session Logging
  ↓
Session Logging → Behavior Dictionary
  ↓
Behavior Dictionary → Analytics
```

**Critical Path:**

1. User Auth (Month 3)
2. Student Management (Month 3)
3. Session Creation Manual (Month 4)
4. Session Logging (Month 4-5)
5. Behavior Dictionary (Month 5)
6. Analytics (Month 5)
7. AI Session Creation (Month 6)
8. Offline Mode (Month 7)
9. Polish & Testing (Month 7-8)

---

## 8. OPEN QUESTIONS

### 8.1 Product Questions

| Question                                                                 | Owner | Priority | Status      |
| ------------------------------------------------------------------------ | ----- | -------- | ----------- |
| Should we allow teachers to share templates with each other (community)? | PM    | Medium   | Open        |
| Should we add a "Report Abuse" feature for behavior library?             | PM    | Low      | Open        |
| Should we support team accounts (multiple teachers per school)?          | PM    | High     | Deferred Y2 |
| Should parents have read-only access to reports?                         | PM    | High     | Deferred Y2 |
| Should we allow teachers to customize behavior dictionary?               | PM    | Medium   | Open        |

---

### 8.2 Technical Questions

| Question                                                         | Owner       | Priority | Status        |
| ---------------------------------------------------------------- | ----------- | -------- | ------------- |
| Can we achieve 80% OCR accuracy for handwritten Vietnamese text? | Backend Dev | High     | Testing       |
| Should we use React Native or Flutter?                           | CTO         | Critical | Resolved (RN) |
| Should we self-host Supabase for data residency?                 | Backend Dev | Medium   | Open          |
| Should we use Redux or Context API for state management?         | Mobile Dev  | Medium   | Open          |
| Should we use CodePush for over-the-air updates?                 | Mobile Dev  | Low      | Open          |

---

### 8.3 Business Questions

| Question                                                              | Owner | Priority | Status      |
| --------------------------------------------------------------------- | ----- | -------- | ----------- |
| Should we offer annual subscription discount (2 months free)?         | CFO   | Medium   | Open        |
| Should we partner with universities for research access to data?      | CEO   | Low      | Open        |
| Should we apply for government grants (Vietnam STEM Innovation Fund)? | CEO   | High     | In Progress |
| Should we white-label for large institutions?                         | CEO   | Low      | Open        |

---

## 9. SUCCESS CRITERIA

### 9.1 MVP Launch Readiness (Month 8)

**Go/No-Go Checklist:**

- [ ] All 10 Must-Have features complete and tested
- [ ] At least 5/8 Should-Have features complete
- [ ] Crash-free rate > 98% in beta
- [ ] Beta user satisfaction > 4.0/5.0
- [ ] App Store & Play Store approval received
- [ ] Privacy policy and terms of service finalized
- [ ] Customer support process established
- [ ] Marketing website live

---

### 9.2 Post-Launch Success Metrics (Month 12)

- [ ] 1,000+ active users
- [ ] 200+ premium subscribers
- [ ] 60% D7 retention rate
- [ ] > 4.0 App Store rating
- [ ] Revenue positive (MRR > Burn rate)

---

## APPENDIX

### A. Glossary

- **SPED**: Special Education
- **ABC Model**: Antecedent-Behavior-Consequence
- **Evidence-Based**: Backed by peer-reviewed research
- **MoSCoW**: Must-have, Should-have, Could-have, Won't-have (prioritization)
- **MVP**: Minimum Viable Product
- **PRD**: Product Requirements Document
- **FTE**: Full-Time Equivalent

---

### B. Related Documents

- [BRD.md](./BRD.md) - Business Requirements Document
- [DATABASE_DESIGN.md](./DATABASE_DESIGN.md) - Database schema
- [API_SPECIFICATION.md](./API_SPECIFICATION.md) - API endpoints
- [design-specs.md](./design-specs.md) - Design system
- [ux-guidelines.md](./ux-guidelines.md) - UX best practices

---

### C. Document History

| Version | Date         | Author       | Changes                   |
| ------- | ------------ | ------------ | ------------------------- |
| 0.1     | Oct 20, 2025 | Product Team | Initial draft             |
| 0.5     | Oct 30, 2025 | Product Team | User stories added        |
| 1.0     | Nov 4, 2025  | Product Team | Final review and approval |

---

**Approval Signatures:**

- **Product Owner**: ************\_************ Date: ****\_\_\_****
- **Engineering Lead**: **********\_\_********** Date: ****\_\_\_****
- **Design Lead**: ************\_\_\_************ Date: ****\_\_\_****

---

**Next Steps:**

1. ✅ PRD Approved → Create FRS (Functional Requirements Specification)
2. ✅ Break down user stories into technical tasks
3. ✅ Sprint planning (2-week sprints)
4. ✅ Development kick-off
