# 📝 API TEST CASES CHI TIẾT - EDUCARE CONNECT

**Version:** 2.0  
**Date:** 2025-11-05  
**Author:** tranhaohcmus  
**Total Test Cases:** 250+

---

## MỤC LỤC TEST CASES

1. [Authentication & User Management Tests](#1-authentication--user-management-tests) (35 test cases)
2. [Student Management Tests](#2-student-management-tests) (30 test cases)
3. [Session Management Tests](#3-session-management-tests) (45 test cases)
4. [Session Logging Tests](#4-session-logging-tests) (40 test cases)
5. [Behavior System Tests](#5-behavior-system-tests) (25 test cases)
6. [Content Library Tests](#6-content-library-tests) (20 test cases)
7. [AI Processing Tests](#7-ai-processing-tests) (20 test cases)
8. [Analytics & Reports Tests](#8-analytics--reports-tests) (15 test cases)
9. [Settings & Sync Tests](#9-settings--sync-tests) (15 test cases)
10. [Security & Edge Cases Tests](#10-security--edge-cases-tests) (20 test cases)

---

## 1. AUTHENTICATION & USER MANAGEMENT TESTS

### 1.1 Register Teacher - Happy Path

| Test Case ID      | TC-AUTH-001                                                                                                            |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **Test Name**     | Register new teacher with valid data                                                                                   |
| **Priority**      | High                                                                                                                   |
| **Category**      | Authentication                                                                                                         |
| **Preconditions** | - Email chưa tồn tại trong hệ thống                                                                                    |
| **Test Data**     | `email`: "teacher_test_001@educare.test"<br>`password`: "SecurePass123!"<br>`first_name`: "Trần"<br>`last_name`: "Hảo" |

**Test Steps:**

| Step | Action                                    | Expected Result                                           |
| ---- | ----------------------------------------- | --------------------------------------------------------- |
| 1    | Send POST `/auth/register` với valid data | HTTP 201 Created                                          |
| 2    | Verify response structure                 | `success: true`, `user` object exists                     |
| 3    | Verify user fields                        | `id` is UUID, `email` matches input, `is_verified: false` |
| 4    | Check database                            | Record exists in `TEACHERS` table                         |
| 5    | Verify password                           | Password is hashed with bcrypt                            |
| 6    | Check email sent                          | Verification email sent to inbox                          |

**Expected Response:**

```json
{
  "success": true,
  "message": "Đăng ký thành công. Vui lòng kiểm tra email để xác thực tài khoản.",
  "user": {
    "id": "uuid",
    "email": "teacher_test_001@educare.test",
    "first_name": "Trần",
    "last_name": "Hảo",
    "is_verified": false,
    "created_at": "2025-11-05T12:06:54Z"
  }
}
```

**Assertions:**

- ✅ Status code is 201
- ✅ Response has `success: true`
- ✅ User ID is valid UUID format
- ✅ Email matches input
- ✅ `is_verified` is false
- ✅ `created_at` is valid ISO timestamp
- ✅ Database has new record with matching ID

---

### 1.2 Register Teacher - Duplicate Email

| Test Case ID      | TC-AUTH-002                                      |
| ----------------- | ------------------------------------------------ |
| **Test Name**     | Register with existing email should fail         |
| **Priority**      | High                                             |
| **Category**      | Authentication - Negative                        |
| **Preconditions** | - Email đã tồn tại trong DB                      |
| **Test Data**     | `email`: "existing@educare.test" (already in DB) |

**Test Steps:**

| Step | Action                                            | Expected Result                 |
| ---- | ------------------------------------------------- | ------------------------------- |
| 1    | Create teacher with email "existing@educare.test" | Success                         |
| 2    | Try to register again with same email             | HTTP 400 Bad Request            |
| 3    | Verify error response                             | `error: "EMAIL_ALREADY_EXISTS"` |
| 4    | Check database                                    | Only 1 record exists            |

**Expected Response:**

```json
{
  "success": false,
  "error": "EMAIL_ALREADY_EXISTS",
  "message": "Email đã được sử dụng. Vui lòng đăng nhập hoặc sử dụng email khác."
}
```

**Assertions:**

- ✅ Status code is 400
- ✅ `success: false`
- ✅ Error code is "EMAIL_ALREADY_EXISTS"
- ✅ Message is in Vietnamese
- ✅ Database still has only 1 record

---

### 1.3 Register Teacher - Invalid Email Format

| Test Case ID  | TC-AUTH-003                                                           |
| ------------- | --------------------------------------------------------------------- |
| **Test Name** | Register with invalid email format                                    |
| **Priority**  | Medium                                                                |
| **Category**  | Authentication - Validation                                           |
| **Test Data** | Invalid emails: "notanemail", "@test.com", "test@", "test..@test.com" |

**Test Steps:**

| Step | Action                               | Expected Result                 |
| ---- | ------------------------------------ | ------------------------------- |
| 1    | Send POST with `email: "notanemail"` | HTTP 400                        |
| 2    | Verify error                         | `error: "INVALID_EMAIL_FORMAT"` |
| 3    | Repeat with other invalid formats    | Same error for all              |

**Expected Response:**

```json
{
  "success": false,
  "error": "INVALID_EMAIL_FORMAT",
  "message": "Email không hợp lệ. Vui lòng nhập đúng định dạng email.",
  "details": {
    "field": "email",
    "value_received": "notanemail"
  }
}
```

---

### 1.4 Register Teacher - Weak Password

| Test Case ID  | TC-AUTH-004                                 |
| ------------- | ------------------------------------------- |
| **Test Name** | Register with weak password                 |
| **Priority**  | High                                        |
| **Category**  | Authentication - Security                   |
| **Test Data** | Weak passwords: "123", "password", "abc123" |

**Test Steps:**

| Step | Action                                 | Expected Result                               |
| ---- | -------------------------------------- | --------------------------------------------- |
| 1    | Send POST with `password: "123"`       | HTTP 400                                      |
| 2    | Verify error                           | `error: "WEAK_PASSWORD"`                      |
| 3    | Check password requirements in message | Min 8 chars, 1 uppercase, 1 number, 1 special |

**Password Requirements:**

- ✅ Min 8 characters
- ✅ At least 1 uppercase letter
- ✅ At least 1 number
- ✅ At least 1 special character

**Expected Response:**

```json
{
  "success": false,
  "error": "WEAK_PASSWORD",
  "message": "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, số và ký tự đặc biệt.",
  "details": {
    "requirements": {
      "min_length": 8,
      "uppercase": true,
      "number": true,
      "special_char": true
    }
  }
}
```

---

### 1.5 Login - Success

| Test Case ID      | TC-AUTH-005                                                     |
| ----------------- | --------------------------------------------------------------- |
| **Test Name**     | Login with valid credentials                                    |
| **Priority**      | High                                                            |
| **Category**      | Authentication                                                  |
| **Preconditions** | - User exists and is verified                                   |
| **Test Data**     | `email`: "teacher@educare.test"<br>`password`: "SecurePass123!" |

**Test Steps:**

| Step | Action                  | Expected Result                                   |
| ---- | ----------------------- | ------------------------------------------------- |
| 1    | Send POST `/auth/login` | HTTP 200 OK                                       |
| 2    | Verify tokens           | `access_token` and `refresh_token` exist          |
| 3    | Verify token format     | Both are valid JWT strings                        |
| 4    | Decode access token     | Contains `teacher_id`, `email`, `role: 'teacher'` |
| 5    | Check expiry            | Access token exp = 1 hour, refresh = 7 days       |
| 6    | Verify user object      | Full user details returned                        |
| 7    | Check database          | `last_login_at` updated                           |

**Expected Response:**

```json
{
  "success": true,
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expires_in": 3600,
  "user": {
    "id": "uuid",
    "email": "teacher@educare.test",
    "first_name": "Trần",
    "last_name": "Hảo",
    "is_verified": true,
    "avatar_url": "https://..."
  }
}
```

**Assertions:**

- ✅ Status code is 200
- ✅ `access_token` is valid JWT
- ✅ `refresh_token` is valid JWT
- ✅ `expires_in` equals 3600 (1 hour)
- ✅ User object contains all expected fields
- ✅ `last_login_at` in DB is updated to current timestamp

---

### 1.6 Login - Invalid Credentials

| Test Case ID      | TC-AUTH-006                                                        |
| ----------------- | ------------------------------------------------------------------ |
| **Test Name**     | Login with wrong password                                          |
| **Priority**      | High                                                               |
| **Category**      | Authentication - Security                                          |
| **Preconditions** | - User exists                                                      |
| **Test Data**     | `email`: "teacher@educare.test"<br>`password`: "WrongPassword123!" |

**Test Steps:**

| Step | Action                                      | Expected Result                                      |
| ---- | ------------------------------------------- | ---------------------------------------------------- |
| 1    | Send POST `/auth/login` with wrong password | HTTP 401 Unauthorized                                |
| 2    | Verify error                                | `error: "INVALID_CREDENTIALS"`                       |
| 3    | Check message                               | Generic message (not revealing which field is wrong) |
| 4    | Verify rate limit counter                   | Incremented in Redis                                 |

**Expected Response:**

```json
{
  "success": false,
  "error": "INVALID_CREDENTIALS",
  "message": "Email hoặc mật khẩu không đúng."
}
```

**Security Notes:**

- ⚠️ Message should NOT reveal which field is incorrect
- ⚠️ Rate limit counter should increment
- ⚠️ No tokens returned

---

### 1.7 Login - Rate Limiting

| Test Case ID      | TC-AUTH-007                              |
| ----------------- | ---------------------------------------- |
| **Test Name**     | Rate limit after 5 failed login attempts |
| **Priority**      | High                                     |
| **Category**      | Authentication - Security                |
| **Preconditions** | - Clean rate limit state                 |
| **Test Data**     | Same email, wrong password × 6 times     |

**Test Steps:**

| Step | Action                                  | Expected Result                 |
| ---- | --------------------------------------- | ------------------------------- |
| 1    | Attempt login with wrong password (1st) | HTTP 401                        |
| 2    | Repeat 4 more times (total 5)           | HTTP 401 each time              |
| 3    | Attempt 6th login                       | HTTP 429 Too Many Requests      |
| 4    | Verify error                            | `error: "TOO_MANY_ATTEMPTS"`    |
| 5    | Check headers                           | `Retry-After: 900` (15 minutes) |
| 6    | Wait 15 minutes or clear Redis          | Can login again                 |

**Expected Response (6th attempt):**

```json
{
  "success": false,
  "error": "TOO_MANY_ATTEMPTS",
  "message": "Quá nhiều lần đăng nhập thất bại. Vui lòng thử lại sau 15 phút.",
  "retry_after": 900
}
```

**Rate Limit Rules:**

- ✅ 5 failed attempts per 15 minutes per email
- ✅ Counter stored in Redis with TTL
- ✅ Counter resets after successful login
- ✅ Response includes `Retry-After` header

---

### 1.8 Refresh Token - Success

| Test Case ID      | TC-AUTH-008                                   |
| ----------------- | --------------------------------------------- |
| **Test Name**     | Refresh access token with valid refresh token |
| **Priority**      | High                                          |
| **Category**      | Authentication                                |
| **Preconditions** | - Valid refresh token from login              |
| **Test Data**     | `refresh_token`: from TC-AUTH-005             |

**Test Steps:**

| Step | Action                    | Expected Result                |
| ---- | ------------------------- | ------------------------------ |
| 1    | Send POST `/auth/refresh` | HTTP 200 OK                    |
| 2    | Verify new access token   | Different from old token       |
| 3    | Decode new token          | Same teacher_id, new exp time  |
| 4    | Verify old access token   | Still valid until its exp      |
| 5    | Use new token             | Can access protected endpoints |

**Expected Response:**

```json
{
  "success": true,
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expires_in": 3600
}
```

**Assertions:**

- ✅ New access token is different from previous
- ✅ New token expires in 1 hour from now
- ✅ Refresh token is NOT rotated (stays same)
- ✅ Can use new token to access APIs

---

### 1.9 Refresh Token - Expired

| Test Case ID  | TC-AUTH-009                          |
| ------------- | ------------------------------------ |
| **Test Name** | Refresh with expired refresh token   |
| **Priority**  | Medium                               |
| **Category**  | Authentication - Security            |
| **Test Data** | Expired refresh token (> 7 days old) |

**Test Steps:**

| Step | Action                             | Expected Result          |
| ---- | ---------------------------------- | ------------------------ |
| 1    | Create refresh token with past exp | Token expired            |
| 2    | Send POST `/auth/refresh`          | HTTP 401 Unauthorized    |
| 3    | Verify error                       | `error: "TOKEN_EXPIRED"` |

**Expected Response:**

```json
{
  "success": false,
  "error": "TOKEN_EXPIRED",
  "message": "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại."
}
```

---

### 1.10 Logout - Success

| Test Case ID      | TC-AUTH-010                       |
| ----------------- | --------------------------------- |
| **Test Name**     | Logout successfully               |
| **Priority**      | Medium                            |
| **Category**      | Authentication                    |
| **Preconditions** | - User logged in with valid token |
| **Test Data**     | Valid `access_token`              |

**Test Steps:**

| Step | Action                              | Expected Result                     |
| ---- | ----------------------------------- | ----------------------------------- |
| 1    | Send POST `/auth/logout` with token | HTTP 200 OK                         |
| 2    | Verify response                     | `success: true`                     |
| 3    | Try to use old token                | HTTP 401 Unauthorized               |
| 4    | Check if token blacklisted          | Token in blacklist (if implemented) |

**Expected Response:**

```json
{
  "success": true,
  "message": "Đăng xuất thành công"
}
```

---

### 1.11 Verify Email - Success

| Test Case ID      | TC-AUTH-011                                                      |
| ----------------- | ---------------------------------------------------------------- |
| **Test Name**     | Verify email with valid token                                    |
| **Priority**      | High                                                             |
| **Category**      | Authentication                                                   |
| **Preconditions** | - User registered but not verified<br>- Valid verification token |
| **Test Data**     | `token`: JWT from verification email                             |

**Test Steps:**

| Step | Action                             | Expected Result               |
| ---- | ---------------------------------- | ----------------------------- |
| 1    | GET `/auth/verify-email?token=...` | HTTP 200 OK                   |
| 2    | Verify response                    | `success: true`               |
| 3    | Check database                     | `is_verified` updated to TRUE |
| 4    | Try to login                       | Can login successfully        |

**Expected Response:**

```json
{
  "success": true,
  "message": "Email đã được xác thực thành công. Bạn có thể đăng nhập ngay bây giờ."
}
```

---

### 1.12 Verify Email - Expired Token

| Test Case ID  | TC-AUTH-012                             |
| ------------- | --------------------------------------- |
| **Test Name** | Verify email with expired token (> 24h) |
| **Priority**  | Medium                                  |
| **Category**  | Authentication - Negative               |

**Expected Response:**

```json
{
  "success": false,
  "error": "TOKEN_EXPIRED",
  "message": "Link xác thực đã hết hạn. Vui lòng yêu cầu gửi lại email xác thực."
}
```

---

### 1.13 Verify Email - Idempotency

| Test Case ID  | TC-AUTH-013                   |
| ------------- | ----------------------------- |
| **Test Name** | Verify already verified email |
| **Priority**  | Low                           |
| **Category**  | Authentication - Edge Case    |

**Test Steps:**

| Step | Action                    | Expected Result              |
| ---- | ------------------------- | ---------------------------- |
| 1    | Verify email (first time) | Success, `is_verified: true` |
| 2    | Click verify link again   | HTTP 200 OK (idempotent)     |
| 3    | Verify message            | Still success message        |
| 4    | Check database            | No duplicate updates         |

---

### 1.14 Get My Profile

| Test Case ID  | TC-AUTH-014                       |
| ------------- | --------------------------------- |
| **Test Name** | Get authenticated teacher profile |
| **Priority**  | High                              |
| **Category**  | User Management                   |

**Test Steps:**

| Step | Action                                  | Expected Result                 |
| ---- | --------------------------------------- | ------------------------------- |
| 1    | GET `/api/teachers/me` with valid token | HTTP 200 OK                     |
| 2    | Verify all fields returned              | All profile fields present      |
| 3    | Verify sensitive data excluded          | `password_hash` NOT in response |

**Expected Response:**

```json
{
  "success": true,
  "user": {
    "id": "uuid",
    "email": "teacher@educare.test",
    "first_name": "Trần",
    "last_name": "Hảo",
    "full_name": "Trần Hảo",
    "phone": "0901234567",
    "school": "Trường ABC",
    "avatar_url": "https://...",
    "timezone": "Asia/Ho_Chi_Minh",
    "language": "vi",
    "is_verified": true,
    "is_active": true,
    "created_at": "2025-11-05T12:06:54Z",
    "updated_at": "2025-11-05T12:06:54Z"
  }
}
```

**Assertions:**

- ✅ `password_hash` is NOT in response
- ✅ `full_name` is computed correctly
- ✅ All timestamps are ISO format

---

### 1.15 Update Profile

| Test Case ID  | TC-AUTH-015            |
| ------------- | ---------------------- |
| **Test Name** | Update teacher profile |
| **Priority**  | Medium                 |
| **Category**  | User Management        |

**Test Steps:**

| Step | Action                                | Expected Result                   |
| ---- | ------------------------------------- | --------------------------------- |
| 1    | PATCH `/api/teachers/me` with updates | HTTP 200 OK                       |
| 2    | Verify fields updated                 | Changed fields reflect new values |
| 3    | Verify `updated_at` changed           | Timestamp updated                 |
| 4    | Verify immutable fields               | `email`, `id` cannot be changed   |

**Test Data:**

```json
{
  "first_name": "Nguyễn",
  "school": "Trường XYZ Updated",
  "phone": "0909876543"
}
```

---

## 2. STUDENT MANAGEMENT TESTS

### 2.1 Create Student - Happy Path

| Test Case ID  | TC-STU-001                         |
| ------------- | ---------------------------------- |
| **Test Name** | Create student with all valid data |
| **Priority**  | High                               |
| **Category**  | Student Management                 |

**Test Steps:**

| Step | Action                               | Expected Result                          |
| ---- | ------------------------------------ | ---------------------------------------- |
| 1    | POST `/api/students` with valid data | HTTP 201 Created                         |
| 2    | Verify student object                | All fields populated correctly           |
| 3    | Verify computed fields               | `age` = 7, `full_name` = "Nguyễn Văn An" |
| 4    | Check database                       | Record exists with correct `teacher_id`  |
| 5    | Verify default values                | `status: 'active'`                       |

**Test Data:**

```json
{
  "first_name": "Nguyễn Văn",
  "last_name": "An",
  "nickname": "An",
  "date_of_birth": "2018-05-15",
  "gender": "male",
  "diagnosis": "ASD Level 1",
  "notes": "Thích màu xanh",
  "parent_name": "Nguyễn Thị B",
  "parent_phone": "0901234567"
}
```

**Expected Response:**

```json
{
  "success": true,
  "student": {
    "id": "uuid",
    "teacher_id": "uuid",
    "first_name": "Nguyễn Văn",
    "last_name": "An",
    "nickname": "An",
    "full_name": "Nguyễn Văn An",
    "date_of_birth": "2018-05-15",
    "age": 7,
    "gender": "male",
    "avatar_url": null,
    "status": "active",
    "diagnosis": "ASD Level 1",
    "notes": "Thích màu xanh",
    "parent_name": "Nguyễn Thị B",
    "parent_phone": "0901234567",
    "created_at": "2025-11-05T12:06:54Z",
    "updated_at": "2025-11-05T12:06:54Z"
  }
}
```

**Assertions:**

- ✅ Student ID is UUID
- ✅ `teacher_id` matches authenticated user
- ✅ `age` calculated correctly from `date_of_birth`
- ✅ `full_name` = `first_name + ' ' + last_name`
- ✅ `status` defaults to 'active'
- ✅ `deleted_at` is NULL

---

### 2.2 Create Student - Invalid Age

| Test Case ID  | TC-STU-002                                 |
| ------------- | ------------------------------------------ |
| **Test Name** | Create student with age outside 2-18 range |
| **Priority**  | High                                       |
| **Category**  | Student Management - Validation            |

**Test Data:**

- DOB for age 1: `2024-01-01` → Error
- DOB for age 19: `2006-01-01` → Error
- DOB for age 2: `2023-11-05` → Success
- DOB for age 18: `2007-11-05` → Success

**Expected Response (age 1):**

```json
{
  "success": false,
  "error": "INVALID_AGE",
  "message": "Tuổi học sinh phải từ 2 đến 18. Tuổi hiện tại: 1.",
  "details": {
    "field": "date_of_birth",
    "value_received": "2024-01-01",
    "current_age": 1,
    "allowed_range": {
      "min": 2,
      "max": 18
    }
  }
}
```

---

### 2.3 Create Student - Avatar Upload

| Test Case ID  | TC-STU-003                       |
| ------------- | -------------------------------- |
| **Test Name** | Create student with avatar image |
| **Priority**  | Medium                           |
| **Category**  | Student Management - Media       |

**Test Steps:**

| Step | Action                                        | Expected Result              |
| ---- | --------------------------------------------- | ---------------------------- |
| 1    | POST with `multipart/form-data` + avatar file | HTTP 201                     |
| 2    | Verify file uploaded to R2                    | File exists at R2 path       |
| 3    | Verify URL format                             | `avatar_url` is valid R2 URL |
| 4    | Verify image resized                          | Max 512x512px                |
| 5    | Check file size                               | Compressed if > 1MB          |

**File Validation:**

- ✅ Allowed formats: JPG, PNG, HEIC
- ✅ Max size: 5MB
- ✅ Auto-resize to 512x512px (maintain aspect ratio)
- ✅ R2 path: `students/{teacher_id}/{student_id}/avatar.jpg`

---

### 2.4 Create Student - Avatar Too Large

| Test Case ID  | TC-STU-004                      |
| ------------- | ------------------------------- |
| **Test Name** | Upload avatar > 5MB             |
| **Priority**  | Medium                          |
| **Category**  | Student Management - Validation |

**Expected Response:**

```json
{
  "success": false,
  "error": "FILE_TOO_LARGE",
  "message": "Ảnh đại diện quá lớn. Kích thước tối đa: 5MB.",
  "details": {
    "field": "avatar",
    "file_size_received": 6291456,
    "max_allowed": 5242880
  }
}
```

---

### 2.5 List Students - Pagination

| Test Case ID  | TC-STU-005                    |
| ------------- | ----------------------------- |
| **Test Name** | List students with pagination |
| **Priority**  | High                          |
| **Category**  | Student Management            |

**Test Steps:**

| Step | Action                              | Expected Result               |
| ---- | ----------------------------------- | ----------------------------- |
| 1    | Create 25 students                  | Success                       |
| 2    | GET `/api/students?page=1&limit=20` | Returns 20 students           |
| 3    | Verify pagination object            | `total: 25`, `total_pages: 2` |
| 4    | GET `/api/students?page=2&limit=20` | Returns 5 students            |
| 5    | Verify `has_next` and `has_prev`    | Correct boolean values        |

**Expected Response (page 1):**

```json
{
  "success": true,
  "data": [...], // 20 students
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

---

### 2.6 List Students - Search

| Test Case ID  | TC-STU-006                       |
| ------------- | -------------------------------- |
| **Test Name** | Search students by name/nickname |
| **Priority**  | High                             |
| **Category**  | Student Management               |

**Test Data:**

- Student 1: "Nguyễn Văn An", nickname "An"
- Student 2: "Trần Thị Bình", nickname "Bé Bình"
- Student 3: "Lê Văn Cường", nickname "Cường"

**Test Cases:**

- Search "An" → Returns Student 1
- Search "Bình" → Returns Student 2
- Search "ân" (case insensitive) → Returns Student 1
- Search "xyz" → Returns empty array

**Assertions:**

- ✅ Case-insensitive search
- ✅ Searches in `first_name`, `last_name`, `nickname`
- ✅ Partial match supported
- ✅ Vietnamese characters supported

---

### 2.7 List Students - Filter by Status

| Test Case ID  | TC-STU-007                |
| ------------- | ------------------------- |
| **Test Name** | Filter students by status |
| **Priority**  | Medium                    |
| **Category**  | Student Management        |

**Test Steps:**

| Step | Action                                  | Expected Result                |
| ---- | --------------------------------------- | ------------------------------ |
| 1    | Create students with different statuses | 3 active, 2 paused, 1 archived |
| 2    | GET `/api/students?status=active`       | Returns 3 students             |
| 3    | GET `/api/students?status=paused`       | Returns 2 students             |
| 4    | GET `/api/students?status=archived`     | Returns 1 student              |
| 5    | GET `/api/students` (no filter)         | Returns all 6 students         |

---

### 2.8 Get Student Details

| Test Case ID  | TC-STU-008                          |
| ------------- | ----------------------------------- |
| **Test Name** | Get student details with statistics |
| **Priority**  | High                                |
| **Category**  | Student Management                  |

**Test Steps:**

| Step | Action                        | Expected Result                              |
| ---- | ----------------------------- | -------------------------------------------- |
| 1    | Create student                | Success                                      |
| 2    | Create 5 sessions for student | 3 completed, 2 pending                       |
| 3    | GET `/api/students/:id`       | Returns student + stats                      |
| 4    | Verify stats                  | `total_sessions: 5`, `completed_sessions: 3` |

**Expected Response:**

```json
{
  "success": true,
  "student": {
    "id": "uuid",
    "first_name": "Nguyễn Văn",
    "last_name": "An",
    ...
  },
  "stats": {
    "total_sessions": 5,
    "completed_sessions": 3,
    "pending_sessions": 2
  }
}
```

---

### 2.9 Update Student

| Test Case ID  | TC-STU-009                 |
| ------------- | -------------------------- |
| **Test Name** | Update student information |
| **Priority**  | High                       |
| **Category**  | Student Management         |

**Test Steps:**

| Step | Action                                 | Expected Result                            |
| ---- | -------------------------------------- | ------------------------------------------ |
| 1    | Create student                         | Success                                    |
| 2    | PATCH `/api/students/:id` with updates | HTTP 200                                   |
| 3    | Verify fields updated                  | Only changed fields affected               |
| 4    | Verify `updated_at` changed            | Timestamp updated                          |
| 5    | Verify immutable fields                | `id`, `teacher_id`, `created_at` unchanged |

**Test Data:**

```json
{
  "notes": "Updated notes - Trẻ đã tiến bộ",
  "diagnosis": "ASD Level 1 - Updated"
}
```

---

### 2.10 Delete Student (Soft Delete)

| Test Case ID  | TC-STU-010          |
| ------------- | ------------------- |
| **Test Name** | Soft delete student |
| **Priority**  | High                |
| **Category**  | Student Management  |

**Test Steps:**

| Step | Action                     | Expected Result                   |
| ---- | -------------------------- | --------------------------------- |
| 1    | Create student + sessions  | Success                           |
| 2    | DELETE `/api/students/:id` | HTTP 200                          |
| 3    | Verify response            | `success: true`                   |
| 4    | Check database             | `deleted_at` set to NOW()         |
| 5    | Try to list students       | Deleted student NOT in list       |
| 6    | Check sessions             | Also soft-deleted (cascade)       |
| 7    | Direct DB query            | Record still exists (soft delete) |

**Expected Behavior:**

- ✅ `deleted_at` field set to timestamp
- ✅ Record NOT returned in normal queries
- ✅ Related sessions also soft-deleted (cascade logic)
- ✅ Can be recovered by setting `deleted_at = NULL`

---

### 2.11 Change Student Status

| Test Case ID  | TC-STU-011                                     |
| ------------- | ---------------------------------------------- |
| **Test Name** | Change student status (active/paused/archived) |
| **Priority**  | Medium                                         |
| **Category**  | Student Management                             |

**Test Steps:**

| Step | Action                                       | Expected Result               |
| ---- | -------------------------------------------- | ----------------------------- |
| 1    | Create student (default: active)             | `status: 'active'`            |
| 2    | PATCH `/api/students/:id/status` to "paused" | Success, `status: 'paused'`   |
| 3    | PATCH to "archived"                          | Success, `status: 'archived'` |
| 4    | Try invalid status "invalid"                 | HTTP 400, validation error    |

**Valid Status Values:**

- ✅ active
- ✅ paused
- ✅ archived
- ❌ Any other value → 400 error

---

Tôi sẽ tiếp tục với các sections còn lại. Bạn có muốn tôi:

1. **Tiếp tục với Section 3-10** (Session Management, Logging, Behaviors, etc.)?
2. **Export toàn bộ test cases** thành file Excel/CSV?
3. **Tạo automated test scripts** (Jest/Mocha) từ test cases này?
