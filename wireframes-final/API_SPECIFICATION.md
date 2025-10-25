# API Specification - Educare Connect

Tài liệu này mô tả **đầy đủ REST API endpoints** cho ứng dụng Educare Connect.

---

## 📋 MỤC LỤC

1. [Authentication & Authorization](#authentication--authorization)
2. [Teachers (Giáo viên)](#teachers-giáo-viên)
3. [Students (Học sinh)](#students-học-sinh)
4. [Sessions (Buổi học)](#sessions-buổi-học)
5. [Session Contents (Nội dung)](#session-contents-nội-dung)
6. [Session Logs (Ghi nhật ký)](#session-logs-ghi-nhật-ký)
7. [Goal Evaluations (Đánh giá mục tiêu)](#goal-evaluations-đánh-giá-mục-tiêu)
8. [Behaviors (Hành vi)](#behaviors-hành-vi)
9. [Content Library (Thư viện nội dung)](#content-library-thư-viện-nội-dung)
10. [Analytics & Reports (Phân tích & Báo cáo)](#analytics--reports-phân-tích--báo-cáo)
11. [Media Upload](#media-upload)
12. [AI Processing](#ai-processing)
13. [Settings & Backup](#settings--backup)

---

## 🔑 BASE URL

```
Production: https://api.educare.vn/v1
Staging: https://api-staging.educare.vn/v1
Development: http://localhost:3000/api/v1
```

---

## 🔐 AUTHENTICATION & AUTHORIZATION

### 1. Register Teacher

```http
POST /auth/register
```

**Request Body:**

```json
{
  "email": "teacher@school.edu",
  "password": "SecurePass123!",
  "full_name": "Nguyễn Văn A",
  "phone": "+84901234567",
  "school": "Trường PTCS ABC"
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Đăng ký thành công. Vui lòng kiểm tra email để xác thực.",
  "data": {
    "teacher_id": "uuid",
    "email": "teacher@school.edu",
    "verification_sent": true
  }
}
```

---

### 2. Login

```http
POST /auth/login
```

**Request Body:**

```json
{
  "email": "teacher@school.edu",
  "password": "SecurePass123!"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expires_in": 3600,
    "teacher": {
      "id": "uuid",
      "email": "teacher@school.edu",
      "full_name": "Nguyễn Văn A",
      "avatar_url": "https://...",
      "school": "Trường PTCS ABC"
    }
  }
}
```

---

### 3. Refresh Token

```http
POST /auth/refresh
```

**Request Body:**

```json
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "access_token": "new_access_token",
    "expires_in": 3600
  }
}
```

---

### 4. Logout

```http
POST /auth/logout
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đăng xuất thành công"
}
```

---

### 5. Verify Email

```http
GET /auth/verify-email?token={verification_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Email đã được xác thực"
}
```

---

### 6. Forgot Password

```http
POST /auth/forgot-password
```

**Request Body:**

```json
{
  "email": "teacher@school.edu"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Email đặt lại mật khẩu đã được gửi"
}
```

---

### 7. Reset Password

```http
POST /auth/reset-password
```

**Request Body:**

```json
{
  "token": "reset_token",
  "new_password": "NewSecurePass123!"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Mật khẩu đã được đặt lại"
}
```

---

## 👨‍🏫 TEACHERS (Giáo viên)

### 1. Get Teacher Profile

```http
GET /teachers/me
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "email": "teacher@school.edu",
    "full_name": "Nguyễn Văn A",
    "phone": "+84901234567",
    "school": "Trường PTCS ABC",
    "avatar_url": "https://...",
    "is_verified": true,
    "two_fa": false,
    "created_at": "2025-01-01T00:00:00Z",
    "last_login": "2025-10-22T08:00:00Z"
  }
}
```

---

### 2. Update Teacher Profile

```http
PATCH /teachers/me
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "full_name": "Nguyễn Văn A",
  "phone": "+84901234567",
  "school": "Trường PTCS ABC"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Cập nhật thông tin thành công",
  "data": {
    "id": "uuid",
    "full_name": "Nguyễn Văn A",
    "phone": "+84901234567",
    "school": "Trường PTCS ABC",
    "updated_at": "2025-10-22T10:00:00Z"
  }
}
```

---

### 3. Update Avatar

```http
POST /teachers/me/avatar
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

**Request Body:**

```
file: [binary image data]
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "avatar_url": "https://cdn.educare.vn/avatars/uuid.jpg"
  }
}
```

---

### 4. Change Password

```http
POST /teachers/me/change-password
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "current_password": "OldPass123!",
  "new_password": "NewPass123!"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đổi mật khẩu thành công"
}
```

---

### 5. Enable 2FA

```http
POST /teachers/me/enable-2fa
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "qr_code": "data:image/png;base64,...",
    "secret": "JBSWY3DPEHPK3PXP"
  }
}
```

---

### 6. Verify 2FA

```http
POST /teachers/me/verify-2fa
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "code": "123456"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "2FA đã được kích hoạt"
}
```

---

## 👶 STUDENTS (Học sinh)

### 1. List Students

```http
GET /students?status=active&page=1&limit=20
Authorization: Bearer {access_token}
```

**Query Parameters:**

- `status` (optional): `active`, `paused`, `archived`
- `search` (optional): Search by name
- `page` (optional): Default 1
- `limit` (optional): Default 20

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "students": [
      {
        "id": "uuid",
        "full_name": "Bé An",
        "nickname": "BA",
        "age": 5,
        "gender": "male",
        "avatar_url": "https://...",
        "status": "active",
        "stats": {
          "total_sessions": 12,
          "completed_sessions": 8,
          "completion_rate": 0.67,
          "total_hours": 45
        }
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 3,
      "total_count": 50,
      "per_page": 20
    }
  }
}
```

---

### 2. Get Student Detail

```http
GET /students/{student_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "full_name": "Bé An",
    "nickname": "BA",
    "age": 5,
    "gender": "male",
    "avatar_url": "https://...",
    "status": "active",
    "notes": "Học sinh ngoan...",
    "created_at": "2025-01-01T00:00:00Z",
    "stats": {
      "total_sessions": 12,
      "completed_sessions": 8,
      "completion_rate": 0.89,
      "total_behaviors": 8,
      "total_hours": 45
    }
  }
}
```

---

### 3. Create Student

```http
POST /students
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "full_name": "Nguyễn Văn An",
  "nickname": "BA",
  "age": 5,
  "gender": "male",
  "notes": "Học sinh ngoan..."
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Thêm học sinh thành công",
  "data": {
    "id": "uuid",
    "full_name": "Nguyễn Văn An",
    "nickname": "BA",
    "age": 5,
    "gender": "male",
    "status": "active",
    "created_at": "2025-10-22T10:00:00Z"
  }
}
```

---

### 4. Update Student

```http
PATCH /students/{student_id}
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "full_name": "Nguyễn Văn An",
  "age": 6,
  "notes": "Updated notes..."
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Cập nhật học sinh thành công",
  "data": {
    "id": "uuid",
    "full_name": "Nguyễn Văn An",
    "age": 6,
    "updated_at": "2025-10-22T10:00:00Z"
  }
}
```

---

### 5. Update Student Avatar

```http
POST /students/{student_id}/avatar
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

**Request Body:**

```
file: [binary image data]
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "avatar_url": "https://cdn.educare.vn/avatars/student_uuid.jpg"
  }
}
```

---

### 6. Archive Student

```http
POST /students/{student_id}/archive
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã lưu trữ học sinh"
}
```

---

### 7. Delete Student

```http
DELETE /students/{student_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã xóa học sinh"
}
```

---

## 📚 SESSIONS (Buổi học)

### 1. List Sessions

```http
GET /sessions?student_id={uuid}&date=2025-10-22&status=pending
Authorization: Bearer {access_token}
```

**Query Parameters:**

- `student_id` (optional): Filter by student
- `date` (optional): Filter by date (YYYY-MM-DD)
- `date_from` (optional): From date
- `date_to` (optional): To date
- `status` (optional): `pending`, `completed`
- `page` (optional): Default 1
- `limit` (optional): Default 20

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "sessions": [
      {
        "id": "uuid",
        "student": {
          "id": "uuid",
          "full_name": "Bé An",
          "nickname": "BA",
          "age": 5
        },
        "date": "2025-10-22",
        "time_slot": "morning",
        "start_time": "08:00",
        "end_time": "11:00",
        "status": "pending",
        "has_evaluation": false,
        "creation_method": "manual",
        "content_count": 5,
        "created_at": "2025-10-20T10:00:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_count": 100
    }
  }
}
```

---

### 2. Get Session Detail

```http
GET /sessions/{session_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "student": {
      "id": "uuid",
      "full_name": "Bé An",
      "nickname": "BA",
      "age": 5,
      "avatar_url": "https://..."
    },
    "date": "2025-10-22",
    "time_slot": "morning",
    "start_time": "08:00",
    "end_time": "11:00",
    "notes": "Buổi học về màu sắc...",
    "status": "pending",
    "has_evaluation": false,
    "creation_method": "manual",
    "contents": [
      {
        "id": "uuid",
        "name": "Phân biệt màu sắc",
        "domain": "cognitive",
        "order_index": 1,
        "goals": [
          {
            "id": "uuid",
            "description": "Gọi tên màu đỏ",
            "order_index": 1
          }
        ]
      }
    ],
    "created_at": "2025-10-20T10:00:00Z",
    "updated_at": "2025-10-20T10:00:00Z"
  }
}
```

---

### 3. Create Session (Manual)

```http
POST /sessions
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "student_id": "uuid",
  "date": "2025-10-22",
  "time_slot": "morning",
  "start_time": "08:00",
  "end_time": "11:00",
  "notes": "Buổi học về màu sắc",
  "contents": [
    {
      "name": "Phân biệt màu sắc",
      "domain": "cognitive",
      "description": "Học nhận diện màu sắc cơ bản",
      "order_index": 1,
      "goals": [
        {
          "description": "Gọi tên màu đỏ",
          "order_index": 1
        },
        {
          "description": "Nhận diện màu xanh",
          "order_index": 2
        }
      ]
    }
  ]
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Tạo buổi học thành công",
  "data": {
    "id": "uuid",
    "student_id": "uuid",
    "date": "2025-10-22",
    "time_slot": "morning",
    "content_count": 1,
    "goal_count": 2,
    "created_at": "2025-10-22T10:00:00Z"
  }
}
```

---

### 4. Update Session

```http
PATCH /sessions/{session_id}
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "date": "2025-10-23",
  "time_slot": "afternoon",
  "start_time": "14:00",
  "end_time": "16:30",
  "notes": "Updated notes"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Cập nhật buổi học thành công",
  "data": {
    "id": "uuid",
    "date": "2025-10-23",
    "time_slot": "afternoon",
    "updated_at": "2025-10-22T11:00:00Z"
  }
}
```

---

### 5. Delete Session

```http
DELETE /sessions/{session_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã xóa buổi học"
}
```

---

### 6. Duplicate Session

```http
POST /sessions/{session_id}/duplicate
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "new_date": "2025-10-25",
  "time_slot": "morning"
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Sao chép buổi học thành công",
  "data": {
    "id": "new_uuid",
    "date": "2025-10-25",
    "content_count": 5
  }
}
```

---

## 📝 SESSION CONTENTS (Nội dung)

### 1. Add Content to Session

```http
POST /sessions/{session_id}/contents
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "name": "Vận động tinh",
  "domain": "motor",
  "description": "Luyện tập vận động tinh",
  "order_index": 2,
  "goals": [
    {
      "description": "Chạy thẳng 10m",
      "order_index": 1
    }
  ]
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Thêm nội dung thành công",
  "data": {
    "id": "uuid",
    "name": "Vận động tinh",
    "domain": "motor",
    "order_index": 2,
    "goal_count": 1
  }
}
```

---

### 2. Update Content

```http
PATCH /contents/{content_id}
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "name": "Vận động tinh (Updated)",
  "order_index": 3
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Cập nhật nội dung thành công"
}
```

---

### 3. Delete Content

```http
DELETE /contents/{content_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã xóa nội dung"
}
```

---

### 4. Reorder Contents

```http
POST /sessions/{session_id}/contents/reorder
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "content_ids": ["uuid1", "uuid2", "uuid3", "uuid4", "uuid5"]
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã sắp xếp lại thứ tự"
}
```

---

## 📊 SESSION LOGS (Ghi nhật ký)

### 1. Get Session Log

```http
GET /sessions/{session_id}/log
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "session_id": "uuid",
    "logged_at": "2025-10-22T11:00:00Z",
    "completed_at": "2025-10-22T11:30:00Z",
    "mood": "good",
    "cooperation_level": 4,
    "focus_level": 3,
    "independence_level": 4,
    "attitude_notes": "Con rất vui và hợp tác...",
    "teacher_notes_text": "Hôm nay con đã thể hiện...",
    "media_attachments": [
      {
        "id": "uuid",
        "type": "image",
        "url": "https://...",
        "filename": "photo.jpg"
      }
    ],
    "goal_evaluations": [
      {
        "id": "uuid",
        "content_goal_id": "uuid",
        "status": "achieved",
        "notes": "Đạt tốt"
      }
    ],
    "behavior_incidents": [
      {
        "id": "uuid",
        "behavior": {
          "id": "uuid",
          "name_vn": "Ném đồ vật",
          "category": "aggression"
        },
        "antecedent": "Bị từ chối yêu cầu",
        "behavior_description": "Ném bút xuống đất",
        "consequence": "Được nghỉ 5 phút",
        "severity_level": 3,
        "occurred_at": "2025-10-22T10:15:00Z"
      }
    ]
  }
}
```

---

### 2. Create/Update Session Log (Step 1: Goals)

```http
POST /sessions/{session_id}/log/goals
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "evaluations": [
    {
      "content_goal_id": "uuid",
      "status": "achieved",
      "notes": "Đạt tốt"
    },
    {
      "content_goal_id": "uuid",
      "status": "not_achieved",
      "notes": "Còn nhầm lẫn"
    }
  ]
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Lưu đánh giá mục tiêu thành công",
  "data": {
    "session_log_id": "uuid",
    "evaluated_goals": 16,
    "achieved_count": 15
  }
}
```

---

### 3. Save Attitude (Step 2)

```http
POST /sessions/{session_id}/log/attitude
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "mood": "good",
  "cooperation_level": 4,
  "focus_level": 3,
  "independence_level": 4,
  "attitude_notes": "Con rất vui và hợp tác..."
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Lưu thái độ học tập thành công"
}
```

---

### 4. Save Teacher Notes (Step 3)

```http
POST /sessions/{session_id}/log/notes
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

**Request Body:**

```
teacher_notes_text: "Hôm nay con đã thể hiện..."
audio: [audio file] (optional)
images: [image files] (optional, max 5)
videos: [video files] (optional)
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Lưu ghi chú thành công",
  "data": {
    "media_count": 3,
    "media_urls": [
      "https://cdn.educare.vn/media/uuid1.jpg",
      "https://cdn.educare.vn/media/uuid2.jpg",
      "https://cdn.educare.vn/media/audio1.mp3"
    ]
  }
}
```

---

### 5. Add Behavior Incident (Step 4)

```http
POST /sessions/{session_id}/log/behaviors
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "behavior_library_id": "uuid",
  "antecedent": "Bị từ chối yêu cầu",
  "behavior_description": "Ném bút xuống đất",
  "consequence": "Được nghỉ 5 phút",
  "severity_level": 3,
  "occurred_at": "2025-10-22T10:15:00Z",
  "notes": "Con ném bút rất mạnh..."
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Thêm hành vi thành công",
  "data": {
    "id": "uuid",
    "behavior_name": "Ném đồ vật",
    "severity_level": 3
  }
}
```

---

### 6. Complete Session Log

```http
POST /sessions/{session_id}/log/complete
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Hoàn tất ghi nhật ký thành công",
  "data": {
    "session_id": "uuid",
    "completed_at": "2025-10-22T11:30:00Z",
    "summary": {
      "goals_achieved": "15/16",
      "mood": "good",
      "behaviors_count": 2
    }
  }
}
```

---

### 7. Update Behavior Incident

```http
PATCH /behaviors/incidents/{incident_id}
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "antecedent": "Updated antecedent",
  "severity_level": 4
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Cập nhật hành vi thành công"
}
```

---

### 8. Delete Behavior Incident

```http
DELETE /behaviors/incidents/{incident_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã xóa hành vi"
}
```

---

## 📖 GOAL EVALUATIONS (Đánh giá mục tiêu)

### 1. Batch Update Goal Evaluations

```http
PUT /sessions/{session_id}/log/goals
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "evaluations": [
    {
      "content_goal_id": "uuid1",
      "status": "achieved",
      "notes": "Tốt"
    },
    {
      "content_goal_id": "uuid2",
      "status": "not_achieved",
      "notes": "Cần luyện thêm"
    }
  ]
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Cập nhật đánh giá thành công",
  "data": {
    "updated_count": 2,
    "achieved_count": 1
  }
}
```

---

## 🎭 BEHAVIORS (Hành vi)

### 1. List Behavior Library

```http
GET /behaviors/library?category=aggression&search=ném
Authorization: Bearer {access_token}
```

**Query Parameters:**

- `category` (optional): `aggression`, `avoidance`, `attention`, `self_stim`
- `function` (optional): `attention`, `escape`, `sensory`, `tangible`
- `search` (optional): Search by name
- `favorites_only` (optional): `true`/`false`

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "behaviors": [
      {
        "id": "uuid",
        "name_vn": "Ném đồ vật",
        "name_en": "Throwing Objects",
        "category": "aggression",
        "function": "attention",
        "icon": "⚠️",
        "usage_count": 127,
        "is_favorite": true
      }
    ],
    "stats": {
      "total": 127,
      "by_category": {
        "aggression": 45,
        "avoidance": 32,
        "attention": 28,
        "self_stim": 22
      }
    }
  }
}
```

---

### 2. Get Behavior Detail

```http
GET /behaviors/library/{behavior_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name_vn": "Ném đồ vật",
    "name_en": "Throwing Objects",
    "category": "aggression",
    "function": "attention",
    "description": "Hành vi ném các vật dụng...",
    "definition": "Định nghĩa chi tiết...",
    "examples": ["Ném bút xuống đất", "Ném đồ chơi"],
    "common_antecedents": ["Bị từ chối yêu cầu", "Được yêu cầu làm việc khó"],
    "common_consequences": ["Được nghỉ ngơi", "Được chú ý"],
    "intervention_tips": ["Dạy kỹ năng thay thế", "Điều chỉnh môi trường"],
    "icon": "⚠️",
    "usage_count": 127,
    "is_favorite": true,
    "teacher_usage": {
      "count": 12,
      "affected_students": 3
    }
  }
}
```

---

### 3. Toggle Favorite Behavior

```http
POST /behaviors/library/{behavior_id}/favorite
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã thêm vào yêu thích",
  "data": {
    "is_favorite": true
  }
}
```

---

### 4. Get Frequently Used Behaviors

```http
GET /behaviors/frequently-used?limit=10
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "behaviors": [
      {
        "id": "uuid",
        "name_vn": "Ném đồ vật",
        "category": "aggression",
        "teacher_usage_count": 12,
        "icon": "⚠️"
      }
    ]
  }
}
```

---

### 5. Get Trending Behaviors

```http
GET /behaviors/trending?period=week
Authorization: Bearer {access_token}
```

**Query Parameters:**

- `period` (optional): `week`, `month`. Default: `week`

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "behaviors": [
      {
        "id": "uuid",
        "name_vn": "Cáu giận",
        "count": 45,
        "change_percentage": 15,
        "trend": "up"
      }
    ]
  }
}
```

---

## 📚 CONTENT LIBRARY (Thư viện nội dung)

### 1. List Content Templates

```http
GET /content-library?domain=cognitive&is_template=true
Authorization: Bearer {access_token}
```

**Query Parameters:**

- `domain` (optional): `cognitive`, `motor`, `language`, `social`, `self_care`
- `is_template` (optional): `true` (system), `false` (custom)
- `search` (optional): Search by name

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "contents": [
      {
        "id": "uuid",
        "name": "Nhận diện màu sắc",
        "domain": "cognitive",
        "description": "Học nhận biết màu sắc cơ bản",
        "default_goals": ["Gọi tên màu đỏ", "Nhận diện màu xanh"],
        "is_template": true,
        "usage_count": 45
      }
    ]
  }
}
```

---

### 2. Create Custom Content Template

```http
POST /content-library
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "name": "Nhận diện hình học",
  "domain": "cognitive",
  "description": "Học nhận biết hình học",
  "default_goals": ["Nhận diện hình vuông", "Nhận diện hình tròn"]
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Tạo template thành công",
  "data": {
    "id": "uuid",
    "name": "Nhận diện hình học",
    "is_template": false
  }
}
```

---

### 3. Search Content Library

```http
GET /content-library/search?q=màu%20sắc
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "results": [
      {
        "id": "uuid",
        "name": "Nhận diện màu sắc",
        "domain": "cognitive",
        "usage_count": 45
      }
    ]
  }
}
```

---

## 📈 ANALYTICS & REPORTS (Phân tích & Báo cáo)

### 1. Dashboard Stats

```http
GET /analytics/dashboard?date_from=2025-10-01&date_to=2025-10-31
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "summary": {
      "total_students": 5,
      "total_sessions": 24,
      "completed_sessions": 18,
      "completion_rate": 0.75,
      "total_behaviors": 18,
      "total_hours": 120
    },
    "weekly_sessions": [
      {
        "week": "2025-W41",
        "session_count": 6,
        "completion_rate": 0.83
      }
    ]
  }
}
```

---

### 2. Behavior Analytics Overview

```http
GET /analytics/behaviors?date_from=2025-10-01&date_to=2025-10-31
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "total_incidents": 18,
    "average_per_week": 3.6,
    "trend": {
      "direction": "up",
      "percentage": 15
    },
    "top_behaviors": [
      {
        "behavior_id": "uuid",
        "name": "Ném đồ vật",
        "count": 6,
        "percentage": 33
      }
    ],
    "by_function": {
      "attention": {
        "count": 8,
        "percentage": 44
      },
      "escape": {
        "count": 6,
        "percentage": 33
      },
      "sensory": {
        "count": 3,
        "percentage": 17
      },
      "tangible": {
        "count": 1,
        "percentage": 6
      }
    },
    "timeline": [
      {
        "date": "2025-10-01",
        "count": 2
      }
    ]
  }
}
```

---

### 3. Behavior Detail Analytics

```http
GET /analytics/behaviors/{behavior_id}?date_from=2025-10-01&date_to=2025-10-31
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "behavior": {
      "id": "uuid",
      "name": "Ném đồ vật"
    },
    "period": {
      "start": "2025-10-01",
      "end": "2025-10-31",
      "total_incidents": 6
    },
    "trend": {
      "direction": "up",
      "percentage": 50,
      "previous_period_count": 4
    },
    "abc_analysis": {
      "common_antecedents": [
        {
          "text": "Bị từ chối yêu cầu",
          "count": 4,
          "percentage": 67
        }
      ],
      "common_consequences": [
        {
          "text": "Được nghỉ ngơi",
          "count": 3,
          "percentage": 50
        }
      ]
    },
    "severity_distribution": {
      "mild": {
        "count": 2,
        "percentage": 33
      },
      "moderate": {
        "count": 3,
        "percentage": 50
      },
      "severe": {
        "count": 1,
        "percentage": 17
      }
    },
    "time_distribution": {
      "morning": {
        "count": 4,
        "percentage": 67
      },
      "afternoon": {
        "count": 2,
        "percentage": 33
      }
    },
    "incidents": [
      {
        "id": "uuid",
        "date": "2025-10-22",
        "time": "10:15",
        "severity_level": 3,
        "antecedent": "Bị từ chối yêu cầu",
        "behavior": "Ném bút xuống",
        "consequence": "Được nghỉ 5 phút",
        "student": {
          "id": "uuid",
          "name": "Bé An"
        }
      }
    ]
  }
}
```

---

### 4. Student Progress Report

```http
GET /analytics/students/{student_id}/progress?date_from=2025-10-01&date_to=2025-10-31
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "student": {
      "id": "uuid",
      "name": "Bé An"
    },
    "period": {
      "start": "2025-10-01",
      "end": "2025-10-31"
    },
    "sessions": {
      "total": 12,
      "completed": 10,
      "completion_rate": 0.83
    },
    "goals": {
      "total_evaluated": 150,
      "achieved": 135,
      "achievement_rate": 0.9
    },
    "behaviors": {
      "total_incidents": 8,
      "average_per_session": 0.67,
      "trend": "down"
    },
    "attitude": {
      "average_mood": 4.2,
      "average_cooperation": 4.1,
      "average_focus": 3.8,
      "average_independence": 4.0
    },
    "by_domain": {
      "cognitive": {
        "sessions": 8,
        "achievement_rate": 0.92
      },
      "motor": {
        "sessions": 6,
        "achievement_rate": 0.88
      }
    }
  }
}
```

---

### 5. Compare Students

```http
POST /analytics/compare
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "student_ids": ["uuid1", "uuid2"],
  "date_from": "2025-10-01",
  "date_to": "2025-10-31"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "comparison": [
      {
        "student_id": "uuid1",
        "name": "Bé An",
        "achievement_rate": 0.9,
        "behavior_count": 8,
        "session_count": 12
      },
      {
        "student_id": "uuid2",
        "name": "Bé Linh",
        "achievement_rate": 0.95,
        "behavior_count": 5,
        "session_count": 14
      }
    ]
  }
}
```

---

### 6. Export Report

```http
POST /analytics/export
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "type": "student_progress",
  "format": "pdf",
  "student_id": "uuid",
  "date_from": "2025-10-01",
  "date_to": "2025-10-31"
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "download_url": "https://cdn.educare.vn/reports/report_uuid.pdf",
    "expires_at": "2025-10-23T10:00:00Z"
  }
}
```

---

## 📤 MEDIA UPLOAD

### 1. Upload Image

```http
POST /media/upload/image
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

**Request Body:**

```
file: [binary image data]
type: "avatar" | "session_photo" | "other"
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "url": "https://cdn.educare.vn/images/uuid.jpg",
    "filename": "photo.jpg",
    "file_size": 1024000,
    "mime_type": "image/jpeg"
  }
}
```

---

### 2. Upload Audio

```http
POST /media/upload/audio
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

**Request Body:**

```
file: [binary audio data]
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "url": "https://cdn.educare.vn/audio/uuid.mp3",
    "filename": "recording.mp3",
    "file_size": 512000,
    "duration": 154,
    "mime_type": "audio/mpeg"
  }
}
```

---

### 3. Upload Video

```http
POST /media/upload/video
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

**Request Body:**

```
file: [binary video data]
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "url": "https://cdn.educare.vn/video/uuid.mp4",
    "filename": "video.mp4",
    "file_size": 5120000,
    "duration": 30,
    "mime_type": "video/mp4"
  }
}
```

---

### 4. Delete Media

```http
DELETE /media/{media_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã xóa file"
}
```

---

## 🤖 AI PROCESSING

### 1. Upload Document for AI Processing

```http
POST /ai/upload
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

**Request Body:**

```
file: [PDF/DOCX/TXT/JPG file] (optional)
text_content: "Thứ 2: Hoạt động 1..." (optional)
student_id: "uuid"
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Đã nhận file, bắt đầu xử lý",
  "data": {
    "processing_id": "uuid",
    "status": "pending",
    "estimated_time": 20
  }
}
```

---

### 2. Get AI Processing Status

```http
GET /ai/processing/{processing_id}
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "status": "processing",
    "progress": 65,
    "steps": [
      {
        "name": "Đọc file",
        "status": "completed"
      },
      {
        "name": "Trích xuất cấu trúc",
        "status": "completed"
      },
      {
        "name": "Phân tích nội dung",
        "status": "in_progress"
      },
      {
        "name": "Tạo danh sách buổi học",
        "status": "pending"
      }
    ],
    "estimated_remaining_time": 8
  }
}
```

---

### 3. Get AI Processing Result

```http
GET /ai/processing/{processing_id}/result
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "status": "completed",
    "result_sessions": [
      {
        "date": "2025-10-21",
        "time_slot": "morning",
        "contents": [
          {
            "name": "Ai đây? (Nhận diện)",
            "domain": "language",
            "goals": ["Nhận biết tên mình", "Trỏ vào ảnh bản thân"]
          }
        ]
      }
    ],
    "total_sessions": 12,
    "completed_at": "2025-10-22T10:00:00Z"
  }
}
```

---

### 4. Create Sessions from AI Result

```http
POST /ai/processing/{processing_id}/create-sessions
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "selected_session_indices": [0, 1, 2, 5, 7],
  "student_id": "uuid"
}
```

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Đã tạo 5 buổi học thành công",
  "data": {
    "created_session_ids": ["uuid1", "uuid2", "uuid3", "uuid4", "uuid5"]
  }
}
```

---

### 5. Cancel AI Processing

```http
POST /ai/processing/{processing_id}/cancel
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã hủy quá trình xử lý"
}
```

---

## ⚙️ SETTINGS & BACKUP

### 1. Get User Settings

```http
GET /settings
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "settings": {
      "theme": "light",
      "language": "vi",
      "notifications": {
        "email": true,
        "push": true
      },
      "auto_backup": true
    }
  }
}
```

---

### 2. Update User Settings

```http
PATCH /settings
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "theme": "dark",
  "language": "vi",
  "notifications": {
    "email": true,
    "push": false
  }
}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Cập nhật cài đặt thành công"
}
```

---

### 3. Create Backup

```http
POST /backup/create
Authorization: Bearer {access_token}
```

**Response:** `202 Accepted`

```json
{
  "success": true,
  "message": "Đang tạo bản sao lưu...",
  "data": {
    "backup_id": "uuid",
    "status": "pending"
  }
}
```

---

### 4. Get Backup History

```http
GET /backup/history?page=1&limit=10
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "backups": [
      {
        "id": "uuid",
        "backup_type": "manual",
        "file_url": "https://...",
        "file_size": 10485760,
        "status": "completed",
        "created_at": "2025-10-20T10:00:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 2
    }
  }
}
```

---

### 5. Download Backup

```http
GET /backup/{backup_id}/download
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "download_url": "https://cdn.educare.vn/backups/backup_uuid.zip",
    "expires_at": "2025-10-23T10:00:00Z"
  }
}
```

---

### 6. Export All Data

```http
POST /export/all-data
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "format": "csv",
  "include": ["students", "sessions", "logs", "behaviors"]
}
```

**Response:** `202 Accepted`

```json
{
  "success": true,
  "message": "Đang xuất dữ liệu...",
  "data": {
    "export_id": "uuid",
    "estimated_time": 30
  }
}
```

---

## 🔔 NOTIFICATIONS

### 1. Get Notifications

```http
GET /notifications?unread_only=true&page=1
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "id": "uuid",
        "type": "session_reminder",
        "title": "Nhắc nhở buổi học",
        "message": "Buổi học với Bé An sắp bắt đầu (14:00)",
        "is_read": false,
        "created_at": "2025-10-22T13:30:00Z"
      }
    ],
    "unread_count": 3
  }
}
```

---

### 2. Mark Notification as Read

```http
PATCH /notifications/{notification_id}/read
Authorization: Bearer {access_token}
```

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Đã đánh dấu đã đọc"
}
```

---

## 📊 RESPONSE FORMATS

### Success Response

```json
{
  "success": true,
  "data": {
    // Response data here
  },
  "message": "Optional success message"
}
```

### Error Response

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable error message",
    "details": {
      // Additional error details
    }
  }
}
```

### Pagination

```json
{
  "success": true,
  "data": {
    "items": [],
    "pagination": {
      "current_page": 1,
      "total_pages": 10,
      "total_count": 200,
      "per_page": 20,
      "has_next": true,
      "has_prev": false
    }
  }
}
```

---

## ⚠️ ERROR CODES

| Code                  | HTTP Status | Description                        |
| --------------------- | ----------- | ---------------------------------- |
| `UNAUTHORIZED`        | 401         | Token không hợp lệ hoặc đã hết hạn |
| `FORBIDDEN`           | 403         | Không có quyền truy cập            |
| `NOT_FOUND`           | 404         | Không tìm thấy resource            |
| `VALIDATION_ERROR`    | 422         | Dữ liệu không hợp lệ               |
| `DUPLICATE_ERROR`     | 409         | Dữ liệu đã tồn tại                 |
| `SERVER_ERROR`        | 500         | Lỗi server                         |
| `SERVICE_UNAVAILABLE` | 503         | Dịch vụ tạm thời không khả dụng    |

---

## 🔒 AUTHENTICATION

Tất cả API endpoints (trừ `/auth/*`) yêu cầu **Bearer Token** trong header:

```http
Authorization: Bearer {access_token}
```

### Token Expiration

- **Access Token**: 1 hour
- **Refresh Token**: 7 days

### Auto-refresh

Client nên tự động refresh token khi nhận `401 Unauthorized` với error code `TOKEN_EXPIRED`.

---

## 📊 RATE LIMITING

- **General APIs**: 100 requests/minute/user
- **Upload APIs**: 10 requests/minute/user
- **AI Processing**: 3 requests/hour/user

Response headers:

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1635235200
```

---

## 🌐 CORS

API hỗ trợ CORS cho các domain:

- `https://app.educare.vn`
- `https://*.educare.vn`
- `http://localhost:*` (development only)

---

## 📱 MOBILE APP SPECIFIC

### Device Registration

```http
POST /devices/register
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "device_token": "fcm_token_or_apns_token",
  "platform": "ios",
  "device_info": {
    "model": "iPhone 13",
    "os_version": "iOS 15.0"
  }
}
```

---

## 🔍 SEARCH & FILTERS

### Global Search

```http
GET /search?q=màu%20sắc&type=all
Authorization: Bearer {access_token}
```

**Query Parameters:**

- `q`: Search query
- `type`: `students`, `sessions`, `behaviors`, `contents`, `all`

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "students": [],
    "sessions": [],
    "behaviors": [],
    "contents": []
  }
}
```

---

## 📝 WEBHOOKS (Optional)

### Register Webhook

```http
POST /webhooks
Authorization: Bearer {access_token}
```

**Request Body:**

```json
{
  "url": "https://your-server.com/webhook",
  "events": ["session.completed", "backup.completed"]
}
```

### Webhook Events

- `session.completed`: Khi buổi học được hoàn tất
- `backup.completed`: Khi backup hoàn tất
- `student.archived`: Khi học sinh bị lưu trữ

---

_API Specification hoàn chỉnh cho Educare Connect. Tất cả endpoints follow RESTful conventions và hỗ trợ đầy đủ tính năng từ wireframes 01-32._
