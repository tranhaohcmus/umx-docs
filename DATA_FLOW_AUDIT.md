# Data Flow Audit - Screens 01-19

## Executive Summary

Đã rà soát **19 screens** và phát hiện **7 data entities** chính. Kết quả:

- ✅ **5/7 entities** có đầy đủ luồng Create + Edit
- ⚠️ **2/7 entities** thiếu luồng Edit (không có UI)
- 🔴 **1 entity** cần thêm luồng Delete confirmation

**Tổng thể đánh giá: 7.5/10** - Tốt nhưng cần bổ sung 2 luồng Edit quan trọng.

---

## 1. Data Entities Mapping

### 1.1. Student (Học sinh) ✅

**Hiển thị ở:**

- Screen 01: Dashboard - Student list with cards
- Screen 02: Student Detail - Full profile + stats

**CRUD Operations:**

| Operation  | Screen      | Status       | Notes                                                         |
| ---------- | ----------- | ------------ | ------------------------------------------------------------- |
| **Create** | ❌ Missing  | 🔴 **GAP**   | Có nút "➕ Thêm học sinh" ở screen 01 nhưng chưa có wireframe |
| **Read**   | 01, 02      | ✅ Complete  | List view + Detail view                                       |
| **Update** | ❌ Missing  | 🔴 **GAP**   | Có menu ⋮ "Edit student" ở screen 02 nhưng chưa có wireframe  |
| **Delete** | 02 (⋮ menu) | ⚠️ Mentioned | Có trong menu nhưng chưa có confirmation flow                 |

**Recommendation:** 🚨 **HIGH PRIORITY**

- Cần tạo screen "Add Student" (thông tin cơ bản: tên, tuổi, giới tính, ảnh, ghi chú)
- Cần tạo screen "Edit Student Profile" (form tương tự Add Student)
- Thêm confirmation dialog cho Delete student

---

### 1.2. Session (Buổi học) ✅

**Hiển thị ở:**

- Screen 02: Student Detail - Calendar + session list
- Screen 12: Log Overview - Session info card

**CRUD Operations:**

| Operation       | Screen          | Status      | Notes                                               |
| --------------- | --------------- | ----------- | --------------------------------------------------- |
| **Create**      | 03→04→05→06→07  | ✅ Complete | Manual flow (3 steps)                               |
| **Create (AI)** | 03→08→09→10     | ✅ Complete | AI flow (upload → process → preview)                |
| **Read**        | 02, 12          | ✅ Complete | Calendar view + detail                              |
| **Update**      | ❌ Missing      | 🔴 **GAP**  | Không có luồng sửa session basic info (date, time)  |
| **Delete**      | 10 (AI Preview) | ⚠️ Partial  | Chỉ có trong AI preview, chưa có ở created sessions |

**Recommendation:** 🚨 **HIGH PRIORITY**

- Cần thêm luồng "Edit Session" để sửa ngày, giờ, ghi chú cơ bản
- Có thể access từ menu ⋮ ở screen 02 hoặc 12
- Thêm Delete session với confirmation (quan trọng vì xóa session = xóa tất cả logs)

---

### 1.3. Content (Nội dung dạy học) ✅

**Hiển thị ở:**

- Screen 05: Manual Step 2 - Content list
- Screen 06: Modal Add Content - Create/select content
- Screen 10: AI Preview - Generated content
- Screen 12: Log Overview - Content list
- Screen 13: Log Detail - All content sections

**CRUD Operations:**

| Operation  | Screen         | Status      | Notes                                           |
| ---------- | -------------- | ----------- | ----------------------------------------------- |
| **Create** | 06             | ✅ Complete | Modal with domain tag, name, description, goals |
| **Read**   | 05, 10, 12, 13 | ✅ Complete | Multiple views                                  |
| **Update** | 05 ([✏️ Sửa])  | ✅ Complete | Edit button in manual flow                      |
| **Delete** | 05 ([🗑️ Xóa])  | ✅ Complete | Delete button + swipe left                      |

**Status:** ✅ **COMPLETE** - Tất cả CRUD đều có

---

### 1.4. Goal (Mục tiêu học tập) ✅

**Hiển thị ở:**

- Screen 06: Modal Add Content - Goal list with ➕ button
- Screen 12: Log Overview - Goal preview (collapsed/expanded)
- Screen 13: Log Detail - All goals with radio buttons

**CRUD Operations:**

| Operation  | Screen                  | Status      | Notes                       |
| ---------- | ----------------------- | ----------- | --------------------------- |
| **Create** | 06 ([➕ Thêm mục tiêu]) | ✅ Complete | Add goal dynamically        |
| **Read**   | 06, 12, 13              | ✅ Complete | List view                   |
| **Update** | 06 (inline edit)        | ✅ Implicit | Can edit text before saving |
| **Delete** | 06 ([✕] button)         | ✅ Complete | Delete button per goal      |

**Status:** ✅ **COMPLETE** - Tất cả CRUD đều có

---

### 1.5. Log/Evaluation (Đánh giá buổi học) ✅

**Hiển thị ở:**

- Screen 12: Log Overview - Summary + detail
- Screen 13: Log Detail - All goal assessments
- Screen 14: Attitude - Mood + sliders
- Screen 15: Notes - Teacher notes + voice + media
- Screen 16: Behavior - ABC behavior records

**CRUD Operations:**

| Operation  | Screen              | Status             | Notes                                |
| ---------- | ------------------- | ------------------ | ------------------------------------ |
| **Create** | 12→13→14→15→16      | ✅ Complete        | 4-step logging flow                  |
| **Read**   | 12 (Case 2)         | ✅ Complete        | Completed state with expand/collapse |
| **Update** | 12 ([✏️ Chỉnh sửa]) | ✅ Complete        | Edit button in completed state       |
| **Delete** | ❌ Missing          | ⚠️ Design Decision | Không có Delete log (intentional?)   |

**Status:** ✅ **COMPLETE** - Create + Read + Update đủ
**Note:** Không có Delete log là hợp lý (để giữ lịch sử đánh giá)

---

### 1.6. Behavior (Hành vi ABC) ✅

**Hiển thị ở:**

- Screen 16: Log Behavior - Behavior card list
- Screen 17: ABC Sheet - 3-step creation flow
- Screen 18: Dictionary Home - Behavior library
- Screen 19: Dictionary Detail - Behavior detail

**CRUD Operations:**

| Operation  | Screen     | Status      | Notes                                                  |
| ---------- | ---------- | ----------- | ------------------------------------------------------ |
| **Create** | 17         | ✅ Complete | 3-step ABC sheet (Antecedent → Behavior → Consequence) |
| **Read**   | 16, 18, 19 | ✅ Complete | Card view + library + detail                           |
| **Update** | 16 ([Sửa]) | ✅ Complete | Edit button per behavior                               |
| **Delete** | 16 ([Xóa]) | ✅ Complete | Delete button with confirmation                        |

**Status:** ✅ **COMPLETE** - Tất cả CRUD đều có

**Additional:**

- Có thư viện Behavior Dictionary (screens 18-19) để browse + reuse
- Có quick tags ở screen 16 để thêm nhanh
- Có "Lưu làm mẫu" ở screen 17 để save common patterns

---

### 1.7. Teacher Profile (Hồ sơ giáo viên) ⚠️

**Hiển thị ở:**

- Screen 01: Dashboard - Greeting "Cô Mai"
- Bottom nav: [👤 Tôi] tab (mentioned but no wireframe)

**CRUD Operations:**

| Operation  | Screen        | Status     | Notes                           |
| ---------- | ------------- | ---------- | ------------------------------- |
| **Create** | ❌ N/A        | ⚠️         | Tạo lúc đăng ký (out of scope?) |
| **Read**   | 01 (greeting) | ✅ Partial | Chỉ hiển thị tên                |
| **Update** | ❌ Missing    | 🔴 **GAP** | Tab [👤 Tôi] chưa có wireframe  |
| **Delete** | ❌ N/A        | ⚠️         | Xóa account (out of scope?)     |

**Recommendation:** 🟡 **MEDIUM PRIORITY**

- Cần tạo screen "Profile / Settings" (access từ bottom nav [👤 Tôi])
- Bao gồm: Edit name, avatar, email, password, preferences, notifications
- Không nhất thiết cần trong MVP nhưng nên có wireframe

---

## 2. Gap Analysis

### 🔴 HIGH PRIORITY Gaps (1 item) - ~~2 items~~ 1 FIXED ✅

#### Gap #1: Student Profile Management

**Missing screens:**

1. **Add Student** (create new student)
2. **Edit Student** (update profile)

**Proposed wireframe structure:**

```
Add/Edit Student Form:
- Avatar (photo upload)
- Tên đầy đủ * (text input)
- Biệt danh * (text input)
- Tuổi * (number picker)
- Giới tính * (toggle: Nam/Nữ)
- Ngày sinh (date picker)
- Ghi chú (textarea)
- Trạng thái (toggle: 🟢 Đang học / ⏸️ Tạm dừng)
- [Hủy] [💾 Lưu]
```

**Navigation:**

- Add Student: Dashboard ➕ button → Add Student form
- Edit Student: Student Detail ⋮ menu → Edit Student form

---

#### Gap #2: Session Basic Info Edit

**Missing screen:**

- **Edit Session** (update date, time, notes)

**Proposed wireframe structure:**

```
Edit Session Form:
- Ngày học * (date picker)
- Buổi * (toggle: Sáng/Chiều)
- Thời gian * (time range picker)
- Ghi chú (textarea)
- [Hủy] [💾 Lưu thay đổi]

Note: Cannot edit Content/Goals here
→ Content editing via screen 12 [✏️ Chỉnh sửa]
```

**Navigation:**

- Student Detail (screen 02) → Tap session card menu ⋮ → Edit Session
- Log Overview (screen 12) → Menu ⋮ → Edit Session

---

### 🟡 MEDIUM PRIORITY Gaps (1 item)

#### Gap #3: Teacher Profile Screen

**Missing screen:**

- **Profile / Settings** (bottom nav [👤 Tôi] tab)

**Proposed wireframe structure:**

```
Profile Screen:
- Avatar + Name (editable)
- Email (display only or editable)
- Mật khẩu (change password link)
- ─────────────
- 📊 Thống kê (total students, sessions, etc.)
- ─────────────
- ⚙️ Cài đặt
  - Thông báo (toggle)
  - Ngôn ngữ (Vietnamese/English)
  - Chế độ tối (toggle)
- ─────────────
- 📚 Trợ giúp & Hướng dẫn
- 📧 Liên hệ hỗ trợ
- 🔒 Chính sách & Điều khoản
- ─────────────
- 🚪 Đăng xuất
```

---

### 🟢 LOW PRIORITY Gaps (Design decisions)

#### Delete confirmations

Một số actions có delete nhưng chưa rõ có confirmation không:

1. **Delete Student** (screen 02 menu) - Nên có confirmation + warning về data loss
2. **Delete Session** (chưa có UI) - Nên có confirmation + cascade delete warning
3. **Delete Log** - Không có (intentional - preserve history)

**Recommendation:** Add confirmation dialogs cho destructive actions.

---

## 3. Logical Consistency Check

### ✅ Luồng hợp lý

1. **Session creation flow:**

   - ✅ Manual: Step 1 (Basic Info) → Step 2 (Content) → Step 3 (Review)
   - ✅ AI: Upload → Processing → Preview → Select → Create
   - ✅ Content được tạo trước hoặc chọn từ library
   - ✅ Goals phải có ít nhất 1 goal per content

2. **Logging flow:**

   - ✅ Session phải được tạo trước
   - ✅ Batch evaluation: All content + All goals in 1 screen
   - ✅ 4 bước tuần tự: Goals → Attitude → Notes → Behavior
   - ✅ Chỉ Behavior là optional, còn lại đều required
   - ✅ Auto-save every 2 minutes

3. **State transitions:**

   - ✅ Session: Not Started → Completed (2-state model)
   - ✅ Không có "In Progress" state (simplified)
   - ✅ Một khi đã Completed, có thể Edit lại

4. **Data dependencies:**
   - ✅ Student → Sessions → Content → Goals → Logs
   - ✅ Behavior Dictionary → Behavior instances (reusable)
   - ✅ Content library → Session content (reusable)

### ⚠️ Vấn đề cần rõ hơn

1. **Content reusability:**

   - Screen 06: "Thêm nội dung mới" - Có search để chọn từ library
   - ❓ Library ở đâu? Ai tạo content library? Teacher tự tạo hay hệ thống có sẵn?
   - **Recommendation:** Cần clarify:
     - Có content library global (shared by all teachers)?
     - Hay mỗi teacher có library riêng?
     - Content được tạo trong session có tự động vào library không?

2. **Goal templates:**

   - Goals được tạo inline trong Content
   - ❓ Có goal templates không? Hay mỗi lần đều phải gõ lại?
   - **Recommendation:** Consider adding goal templates per domain (🏃🧠💬🤝🍴)

3. **Session duplication:**
   - Screen 10 (AI Preview): Có mention "Copy session"
   - ❓ Manual sessions có thể copy không?
   - **Recommendation:** Add "Duplicate session" feature cho manual sessions (useful for recurring weekly sessions)

---

## 4. Missing Flows Summary Table

| Entity              | Missing Flow             | Priority  | Impact                 | Screen Needed             |
| ------------------- | ------------------------ | --------- | ---------------------- | ------------------------- |
| **Student**         | Create (Add)             | 🔴 HIGH   | Cannot add students    | "Add Student" form        |
| **Student**         | Update (Edit)            | 🔴 HIGH   | Cannot edit profile    | "Edit Student" form       |
| **Student**         | Delete confirmation      | 🟡 MEDIUM | Accidental deletion    | Confirmation dialog       |
| **Session**         | Update (Edit basic info) | 🔴 HIGH   | Cannot fix mistakes    | "Edit Session" form       |
| **Session**         | Delete + confirmation    | 🟡 MEDIUM | Cannot remove sessions | Menu + confirmation       |
| **Teacher Profile** | Read/Update              | 🟡 MEDIUM | No profile management  | "Profile/Settings" screen |
| **Content Library** | Browse/Search            | 🟢 LOW    | Unclear reusability    | Optional "Library" screen |

---

## 5. Recommendations

### 5.1. Immediate Actions (Before Development)

**🔴 CRITICAL - Cần có trước khi code:**

1. **Tạo 2 wireframes mới:**

   - `student-form.md` - Add/Edit Student (dùng chung 1 form)
   - `session-edit.md` - Edit Session Basic Info

2. **Thêm confirmation dialogs:**
   - Update screen 02: Add delete student confirmation flow
   - Document session delete confirmation flow

**Navigation updates needed:**

- Screen 01: [➕ Thêm học sinh] → `student-form.md` (create mode)
- Screen 02: Menu ⋮ → "Sửa thông tin" → `student-form.md` (edit mode)
- Screen 02: Menu ⋮ → "Chỉnh sửa buổi học" → `session-edit.md`

### 5.2. Short-term Improvements (MVP Nice-to-Have)

**🟡 Should have trong MVP:**

1. Teacher Profile screen (`profile.md`)
2. Session duplicate feature
3. Content library management (if content is shared)

### 5.3. Long-term Enhancements (Post-MVP)

**🟢 Future iterations:**

1. Goal templates per domain
2. Bulk operations (delete multiple sessions, export multiple reports)
3. Session templates (recurring weekly schedule)
4. Student groups/classes (if expanding to schools)

---

## 6. Updated Scorecard

| Criteria                | Score | Notes                                |
| ----------------------- | ----- | ------------------------------------ |
| **Create flows**        | 6/7   | Missing: Student, Session edit       |
| **Read flows**          | 7/7   | ✅ All complete                      |
| **Update flows**        | 5/7   | Missing: Student, Session basic info |
| **Delete flows**        | 4/7   | Partial: Need confirmations          |
| **Logical consistency** | 9/10  | Very good flow design                |
| **Data dependencies**   | 10/10 | Clear hierarchy                      |

**Overall:** 7.5/10 - Rất tốt nhưng thiếu 2 wireframes quan trọng

---

## 7. Action Items

### For Designer:

- [ ] Tạo wireframe: `student-form.md` (Add/Edit Student)
- [ ] Tạo wireframe: `session-edit.md` (Edit Session)
- [ ] Tạo wireframe: `profile.md` (Teacher Profile) - Optional for MVP
- [ ] Document: Delete confirmation flows
- [ ] Update: Navigation flow document với 2 screens mới

### For Product Owner:

- [ ] Clarify: Content library strategy (global vs per-teacher)
- [ ] Decide: Session duplication feature (yes/no for MVP)
- [ ] Decide: Goal templates (yes/no for MVP)
- [ ] Review: Confirmation dialog copy & warnings

### For Developer:

- [ ] Wait for 2 critical wireframes before implementing Student/Session management
- [ ] Implement soft delete for Student (don't permanently delete data)
- [ ] Add cascade delete warning for Session (deletes all associated logs)

---

## 8. Conclusion

Wireframes hiện tại rất tốt và cover được phần lớn use cases. Tuy nhiên, **thiếu 2 luồng quan trọng:**

1. **Student management** (Add/Edit) - Không thể thiếu vì đây là starting point
2. **Session basic info edit** - Cần để sửa lỗi nhập liệu (ngày, giờ nhập sai)

**Recommendation:** Bổ sung 2 wireframes này trước khi bắt đầu development. Ước tính thời gian: **1-2 ngày** để design + review.

**Impact if skipped:**

- Cannot add students → App không sử dụng được
- Cannot edit sessions → User frustration khi nhập sai

**Priority:** 🔴 **CRITICAL - BLOCKER**
