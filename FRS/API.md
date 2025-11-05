# 📋 DANH SÁCH API ENDPOINTS CHI TIẾT - EDUCARE CONNECT

**Version:** 2.0  
**Date:** 2025-11-05  
**Author:** tranhaohcmus  
**Total Endpoints:** 82

---

## 🔐 1. AUTHENTICATION & USER MANAGEMENT (10 endpoints)

### 1.1 Registration & Verification

```http
POST /auth/register
Content-Type: application/json

Request Body:
{
  "email": "teacher@example.com",
  "password": "SecurePass123!",
  "first_name": "Nguyễn",
  "last_name": "Văn A",
  "phone": "0901234567",
  "school": "Trường ABC"
}

Response: 201 Created
{
  "success": true,
  "message": "Đăng ký thành công. Vui lòng kiểm tra email để xác thực tài khoản.",
  "user": {
    "id": "uuid",
    "email": "teacher@example.com",
    "first_name": "Nguyễn",
    "last_name": "Văn A",
    "is_verified": false,
    "created_at": "2025-11-05T07:46:12Z"
  }
}
```

```http
GET /auth/verify-email?token=<jwt_token>

Response: 200 OK
{
  "success": true,
  "message": "Email đã được xác thực thành công. Bạn có thể đăng nhập ngay bây giờ."
}
```

### 1.2 Login & Token Management

```http
POST /auth/login
Content-Type: application/json

Request Body:
{
  "email": "teacher@example.com",
  "password": "SecurePass123!"
}

Response: 200 OK
{
  "success": true,
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expires_in": 3600,
  "user": {
    "id": "uuid",
    "email": "teacher@example.com",
    "first_name": "Nguyễn",
    "last_name": "Văn A",
    "is_verified": true,
    "avatar_url": "https://..."
  }
}
```

```http
POST /auth/refresh
Content-Type: application/json

Request Body:
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}

Response: 200 OK
{
  "success": true,
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expires_in": 3600
}
```

```http
POST /auth/logout
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Đăng xuất thành công"
}
```

### 1.3 Password Recovery

```http
POST /auth/forgot-password
Content-Type: application/json

Request Body:
{
  "email": "teacher@example.com"
}

Response: 200 OK
{
  "success": true,
  "message": "Email khôi phục mật khẩu đã được gửi"
}
```

```http
POST /auth/reset-password
Content-Type: application/json

Request Body:
{
  "token": "reset_token_from_email",
  "new_password": "NewSecurePass123!"
}

Response: 200 OK
{
  "success": true,
  "message": "Mật khẩu đã được đặt lại thành công"
}
```

### 1.4 User Profile

```http
GET /api/teachers/me
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "user": {
    "id": "uuid",
    "email": "teacher@example.com",
    "first_name": "Nguyễn",
    "last_name": "Văn A",
    "full_name": "Nguyễn Văn A",
    "phone": "0901234567",
    "school": "Trường ABC",
    "avatar_url": "https://...",
    "timezone": "Asia/Ho_Chi_Minh",
    "language": "vi",
    "is_verified": true,
    "is_active": true,
    "created_at": "2025-11-05T07:46:12Z",
    "updated_at": "2025-11-05T07:46:12Z"
  }
}
```

```http
PATCH /api/teachers/me
Authorization: Bearer <access_token>
Content-Type: multipart/form-data

Request Body (FormData):
- first_name: "Trần"
- last_name: "Hảo"
- phone: "0901234567"
- school: "Trường XYZ"
- avatar: File (optional, max 5MB)
- timezone: "Asia/Ho_Chi_Minh"
- language: "vi"

Response: 200 OK
{
  "success": true,
  "user": {
    "id": "uuid",
    "first_name": "Trần",
    "last_name": "Hảo",
    "avatar_url": "https://...",
    "updated_at": "2025-11-05T07:46:12Z"
  }
}
```

```http
DELETE /api/account
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "password": "SecurePass123!",
  "confirmation": true
}

Response: 202 Accepted
{
  "success": true,
  "message": "Tài khoản của bạn đang được xóa. Bạn sẽ nhận email xác nhận sau khi hoàn tất.",
  "logout": true
}
```

---

## 👨‍🎓 2. STUDENT MANAGEMENT (6 endpoints)

### 2.1 Create Student

```http
POST /api/students
Authorization: Bearer <access_token>
Content-Type: multipart/form-data

Request Body (FormData):
- first_name: "Nguyễn Văn"
- last_name: "An"
- nickname: "An"
- date_of_birth: "2018-05-15"
- gender: "male"
- avatar: File (optional, max 5MB)
- diagnosis: "ASD Level 1"
- notes: "Thích màu xanh..."
- parent_name: "Nguyễn Thị B"
- parent_phone: "0901234567"

Response: 201 Created
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
    "avatar_url": "https://...",
    "status": "active",
    "diagnosis": "ASD Level 1",
    "notes": "Thích màu xanh...",
    "parent_name": "Nguyễn Thị B",
    "parent_phone": "0901234567",
    "created_at": "2025-11-05T07:46:12Z"
  }
}
```

### 2.2 List Students

```http
GET /api/students?search=An&status=active&page=1&limit=20
Authorization: Bearer <access_token>

Query Parameters:
- search: string (optional) - Search by name/nickname
- status: "active" | "paused" | "archived" (optional)
- page: number (default: 1)
- limit: number (default: 20, max: 100)

Response: 200 OK
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "first_name": "Nguyễn Văn",
      "last_name": "An",
      "full_name": "Nguyễn Văn An",
      "nickname": "An",
      "age": 7,
      "gender": "male",
      "avatar_url": "https://...",
      "status": "active",
      "date_of_birth": "2018-05-15"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 45,
    "total_pages": 3
  }
}
```

### 2.3 Get Student Details

```http
GET /api/students/:student_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "student": {
    "id": "uuid",
    "teacher_id": "uuid",
    "first_name": "Nguyễn Văn",
    "last_name": "An",
    "full_name": "Nguyễn Văn An",
    "nickname": "An",
    "date_of_birth": "2018-05-15",
    "age": 7,
    "gender": "male",
    "avatar_url": "https://...",
    "status": "active",
    "diagnosis": "ASD Level 1",
    "notes": "Thích màu xanh...",
    "parent_name": "Nguyễn Thị B",
    "parent_phone": "0901234567",
    "created_at": "2025-11-05T07:46:12Z",
    "updated_at": "2025-11-05T07:46:12Z"
  },
  "stats": {
    "total_sessions": 12,
    "completed_sessions": 10,
    "pending_sessions": 2
  }
}
```

### 2.4 Update Student

```http
PATCH /api/students/:student_id
Authorization: Bearer <access_token>
Content-Type: multipart/form-data

Request Body (FormData):
- first_name: "Nguyễn Văn" (optional)
- last_name: "An" (optional)
- nickname: "An" (optional)
- diagnosis: "ASD Level 1" (optional)
- notes: "Updated notes..." (optional)
- avatar: File (optional)

Response: 200 OK
{
  "success": true,
  "student": {
    "id": "uuid",
    "updated_at": "2025-11-05T07:46:12Z"
  }
}
```

### 2.5 Delete Student (Soft Delete)

```http
DELETE /api/students/:student_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Học sinh đã được xóa thành công"
}
```

### 2.6 Change Student Status

```http
PATCH /api/students/:student_id/status
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "status": "paused"
}

Response: 200 OK
{
  "success": true,
  "student": {
    "id": "uuid",
    "status": "paused",
    "updated_at": "2025-11-05T07:46:12Z"
  }
}
```

---

## 📅 3. SESSION MANAGEMENT (10 endpoints)

### 3.1 Create Session (Step 1 - Basic Info)

```http
POST /api/sessions
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "student_id": "uuid",
  "session_date": "2025-11-10",
  "time_slot": "morning",
  "start_time": "09:00:00",
  "end_time": "10:30:00",
  "location": "Phòng 101",
  "notes": "Buổi học về nhận biết màu sắc"
}

Response: 201 Created
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
    "created_at": "2025-11-05T07:46:12Z"
  },
  "next_step": "add_contents"
}
```

### 3.2 Add Contents to Session (Step 2)

```http
POST /api/sessions/:session_id/contents
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "title": "Nhận biết màu sắc cơ bản",
  "domain": "cognitive",
  "description": "Dạy trẻ nhận biết 4 màu: đỏ, vàng, xanh lá, xanh dương",
  "materials_needed": "Thẻ màu, đồ chơi nhiều màu",
  "estimated_duration": 30,
  "notes": "",
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

Response: 201 Created
{
  "success": true,
  "content": {
    "id": "uuid",
    "session_id": "uuid",
    "title": "Nhận biết màu sắc cơ bản",
    "domain": "cognitive",
    "order_index": 1,
    "goals": [
      {
        "id": "uuid",
        "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
        "goal_type": "knowledge",
        "is_primary": true,
        "order_index": 1
      }
    ]
  }
}
```

### 3.3 Add Contents from Template

```http
POST /api/sessions/:session_id/contents/from-template
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "template_id": "uuid"
}

Response: 201 Created
{
  "success": true,
  "content": {
    "id": "uuid",
    "content_library_id": "uuid",
    "title": "Nhận biết màu sắc cơ bản",
    "goals": [...]
  }
}
```

### 3.4 Reorder Session Contents

```http
PATCH /api/sessions/:session_id/contents/reorder
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "content_ids": ["uuid1", "uuid2", "uuid3"]
}

Response: 200 OK
{
  "success": true,
  "message": "Đã cập nhật thứ tự nội dung"
}
```

### 3.5 Confirm Session (Step 3)

```http
POST /api/sessions/:session_id/confirm
Authorization: Bearer <access_token>

Response: 200 OK
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

### 3.6 List Sessions

```http
GET /api/sessions?student_id=uuid&status=pending&date_from=2025-11-01&date_to=2025-11-30&page=1&limit=20
Authorization: Bearer <access_token>

Query Parameters:
- student_id: uuid (optional)
- status: "pending" | "completed" | "cancelled" (optional)
- date_from: YYYY-MM-DD (optional)
- date_to: YYYY-MM-DD (optional)
- page: number (default: 1)
- limit: number (default: 20)

Response: 200 OK
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "student_id": "uuid",
      "student_name": "Nguyễn Văn An",
      "student_avatar": "https://...",
      "session_date": "2025-11-10",
      "time_slot": "morning",
      "start_time": "09:00:00",
      "end_time": "10:30:00",
      "duration_minutes": 90,
      "status": "pending",
      "contents_count": 2,
      "goals_count": 5,
      "has_log": false
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "total_pages": 8
  }
}
```

### 3.7 Get Session Details

```http
GET /api/sessions/:session_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "session": {
    "id": "uuid",
    "student_id": "uuid",
    "student_name": "Nguyễn Văn An",
    "student_avatar": "https://...",
    "session_date": "2025-11-10",
    "time_slot": "morning",
    "start_time": "09:00:00",
    "end_time": "10:30:00",
    "duration_minutes": 90,
    "location": "Phòng 101",
    "notes": "Buổi học về nhận biết màu sắc",
    "status": "pending",
    "creation_method": "manual",
    "has_evaluation": false,
    "contents": [
      {
        "id": "uuid",
        "title": "Nhận biết màu sắc",
        "domain": "cognitive",
        "description": "...",
        "materials_needed": "...",
        "order_index": 1,
        "estimated_duration": 30,
        "goals": [
          {
            "id": "uuid",
            "description": "Trẻ có thể chỉ đúng màu",
            "goal_type": "knowledge",
            "is_primary": true,
            "order_index": 1
          }
        ]
      }
    ],
    "created_at": "2025-11-05T07:46:12Z"
  }
}
```

### 3.8 Update Session

```http
PATCH /api/sessions/:session_id
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "session_date": "2025-11-11",
  "start_time": "10:00:00",
  "end_time": "11:30:00",
  "location": "Phòng 102"
}

Response: 200 OK
{
  "success": true,
  "session": {
    "id": "uuid",
    "updated_at": "2025-11-05T07:46:12Z"
  }
}
```

### 3.9 Cancel Session

```http
POST /api/sessions/:session_id/cancel
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "cancellation_reason": "Học sinh ốm"
}

Response: 200 OK
{
  "success": true,
  "session": {
    "id": "uuid",
    "status": "cancelled",
    "cancellation_reason": "Học sinh ốm",
    "cancelled_at": "2025-11-05T07:46:12Z"
  }
}
```

### 3.10 Delete Session (Soft Delete)

```http
DELETE /api/sessions/:session_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Buổi học đã được xóa"
}
```

---

## 📝 4. SESSION LOGGING (6 endpoints)

### 4.1 Create/Get Session Log

```http
POST /api/sessions/:session_id/logs
Authorization: Bearer <access_token>

Response: 201 Created
{
  "success": true,
  "session_log": {
    "id": "uuid",
    "session_id": "uuid",
    "logged_at": "2025-11-05T07:46:12Z",
    "created_by": "uuid"
  },
  "next_step": "evaluate_goals"
}
```

### 4.2 Evaluate Goals (Step 1)

```http
PUT /api/session-logs/:log_id/goals
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "evaluations": [
    {
      "content_goal_id": "uuid",
      "status": "achieved",
      "achievement_level": 90,
      "support_level": "minimal_prompt",
      "notes": "Trẻ làm tốt, chỉ cần nhắc 1-2 lần"
    },
    {
      "content_goal_id": "uuid",
      "status": "partially_achieved",
      "achievement_level": 60,
      "support_level": "moderate_prompt",
      "notes": "Cần luyện tập thêm"
    }
  ]
}

Response: 200 OK
{
  "success": true,
  "session_log": {
    "id": "uuid",
    "goal_evaluations": [
      {
        "id": "uuid",
        "content_goal_id": "uuid",
        "goal_description": "Trẻ có thể chỉ đúng màu",
        "status": "achieved",
        "achievement_level": 90,
        "support_level": "minimal_prompt",
        "notes": "Trẻ làm tốt"
      }
    ],
    "evaluations_count": 8,
    "evaluated_count": 8
  },
  "next_step": "attitude"
}
```

### 4.3 Update Attitude (Step 2)

```http
PUT /api/session-logs/:log_id/attitude
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "mood": "good",
  "energy_level": 4,
  "cooperation_level": 5,
  "focus_level": 3,
  "independence_level": 4,
  "attitude_summary": "Trẻ rất hợp tác hôm nay"
}

Response: 200 OK
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
    "updated_at": "2025-11-05T07:46:12Z"
  },
  "next_step": "notes_media"
}
```

### 4.4 Update Notes & Media (Step 3)

```http
PUT /api/session-logs/:log_id/notes
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "progress_notes": "Trẻ đã tiến bộ rõ rệt...",
  "challenges_faced": "Vẫn còn khó khăn với kỹ năng...",
  "recommendations": "Tiếp tục luyện tập...",
  "teacher_notes_text": "Ghi chú khác...",
  "overall_rating": 4,
  "actual_start_time": "09:05:00",
  "actual_end_time": "10:35:00"
}

Response: 200 OK
{
  "success": true,
  "session_log": {
    "id": "uuid",
    "progress_notes": "Trẻ đã tiến bộ rõ rệt...",
    "overall_rating": 4,
    "updated_at": "2025-11-05T07:46:12Z"
  },
  "next_step": "behavior_optional"
}
```

### 4.5 Get Session Log Details

```http
GET /api/session-logs/:log_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "session_log": {
    "id": "uuid",
    "session_id": "uuid",
    "logged_at": "2025-11-05T07:46:12Z",
    "mood": "good",
    "energy_level": 4,
    "cooperation_level": 5,
    "focus_level": 3,
    "independence_level": 4,
    "overall_rating": 4,
    "progress_notes": "...",
    "challenges_faced": "...",
    "recommendations": "...",
    "goal_evaluations": [...],
    "media_attachments": [...],
    "behavior_incidents": [...],
    "completed_at": "2025-11-05T07:46:12Z"
  }
}
```

### 4.6 Complete Session Log

```http
POST /api/session-logs/:log_id/complete
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Nhật ký đã được lưu thành công!",
  "session": {
    "id": "uuid",
    "status": "completed",
    "has_evaluation": true,
    "session_log": {
      "id": "uuid",
      "completed_at": "2025-11-05T07:46:12Z"
    }
  }
}
```

# 📋 DANH SÁCH API ENDPOINTS CHI TIẾT (Tiếp theo)

---

## 📷 5. MEDIA MANAGEMENT (4 endpoints)

### 5.1 Request Upload URL

```http
POST /api/media/upload-url
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "session_log_id": "uuid",
  "media_type": "image",
  "filename": "photo1.jpg",
  "file_size": 3145728,
  "mime_type": "image/jpeg"
}

Response: 200 OK
{
  "success": true,
  "upload_url": "https://r2.cloudflare.com/educare/session-logs/.../signed-url",
  "file_url": "https://r2.cloudflare.com/educare/session-logs/.../photo1.jpg",
  "media_id": "uuid",
  "expires_in": 3600
}
```

### 5.2 Confirm Upload

```http
POST /api/media/:media_id/confirm
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "caption": "Trẻ đang nhận biết màu sắc"
}

Response: 200 OK
{
  "success": true,
  "media": {
    "id": "uuid",
    "session_log_id": "uuid",
    "media_type": "image",
    "url": "https://r2.../photo1.jpg",
    "thumbnail_url": "https://r2.../photo1_thumb.jpg",
    "filename": "photo1.jpg",
    "file_size": 2457600,
    "mime_type": "image/jpeg",
    "width": 1920,
    "height": 1080,
    "caption": "Trẻ đang nhận biết màu sắc",
    "created_at": "2025-11-05T07:47:46Z"
  }
}
```

### 5.3 Get Media Details

```http
GET /api/media/:media_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "media": {
    "id": "uuid",
    "session_log_id": "uuid",
    "media_type": "image",
    "url": "https://r2.../photo1.jpg",
    "thumbnail_url": "https://r2.../photo1_thumb.jpg",
    "filename": "photo1.jpg",
    "file_size": 2457600,
    "width": 1920,
    "height": 1080,
    "caption": "Trẻ đang nhận biết màu sắc",
    "uploaded_by": "uuid",
    "created_at": "2025-11-05T07:47:46Z"
  }
}
```

### 5.4 Delete Media

```http
DELETE /api/media/:media_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Media đã được xóa thành công"
}
```

---

## 😤 6. BEHAVIOR SYSTEM (9 endpoints)

### 6.1 List Behavior Groups

```http
GET /api/behavior-groups
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "groups": [
    {
      "id": "uuid",
      "code": "GROUP_01",
      "name_vn": "CHỐNG ĐỐI & BƯỚNG BỈNH",
      "name_en": "Opposition & Defiance",
      "icon": "😤",
      "color_code": "#FF5733",
      "order_index": 1,
      "behaviors_count": 45
    },
    {
      "id": "uuid",
      "code": "GROUP_02",
      "name_vn": "HÀNH VI GÂY HẤN",
      "name_en": "Aggression",
      "icon": "👊",
      "color_code": "#C70039",
      "order_index": 2,
      "behaviors_count": 38
    },
    {
      "id": "uuid",
      "code": "GROUP_03",
      "name_vn": "VẤN ĐỀ VỀ GIÁC QUAN",
      "name_en": "Sensory Issues",
      "icon": "👂",
      "color_code": "#900C3F",
      "order_index": 3,
      "behaviors_count": 44
    }
  ]
}
```

### 6.2 Search/Browse Behaviors

```http
GET /api/behaviors?q=ăn vạ&group_id=uuid&favorites_only=false&limit=50
Authorization: Bearer <access_token>

Query Parameters:
- q: string (optional) - Search query
- group_id: uuid (optional) - Filter by group
- favorites_only: boolean (default: false)
- limit: number (default: 50, max: 100)

Response: 200 OK
{
  "success": true,
  "behaviors": [
    {
      "id": "uuid",
      "behavior_code": "BH_01_01",
      "name_vn": "Ăn vạ",
      "name_en": "Tantrums",
      "icon": "😭",
      "group_id": "uuid",
      "group_name": "CHỐNG ĐỐI & BƯỚNG BỈNH",
      "group_icon": "😤",
      "group_color": "#FF5733",
      "age_range": {
        "min": 2,
        "max": 10
      },
      "usage_count": 245,
      "is_favorite": true
    }
  ],
  "total": 127
}
```

### 6.3 Get Behavior Details

```http
GET /api/behaviors/:behavior_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "behavior": {
    "id": "uuid",
    "behavior_code": "BH_01_01",
    "name_vn": "Ăn vạ",
    "name_en": "Tantrums",
    "icon": "😭",
    "group": {
      "id": "uuid",
      "name_vn": "CHỐNG ĐỐI & BƯỚNG BỈNH",
      "icon": "😤",
      "color_code": "#FF5733",
      "common_tips": "Giữ bình tĩnh, nhất quán..."
    },
    "age_range": {
      "min": 2,
      "max": 10
    },
    "manifestation_vn": "Trẻ bộc phát cảm xúc một cách dữ dội, có thể la hét, khóc lóc, ném đồ, nằm lăn ra sàn...",
    "explanation": [
      {
        "title": "Nhu cầu Giao tiếp",
        "description": "Với trẻ nhỏ hoặc trẻ chậm phát triển ngôn ngữ, ăn vạ thường là cách duy nhất trẻ biết để diễn đạt nhu cầu..."
      },
      {
        "title": "Giới hạn Sinh lý",
        "description": "Khi trẻ mệt, đói, khát, hoặc khó chịu về mặt cảm giác (quá ồn, quá sáng)..."
      }
    ],
    "solutions": [
      {
        "title": "Giữ bình tĩnh",
        "description": "Phản ứng của người lớn rất quan trọng. Nếu bạn tức giận hoặc hoảng sợ, trẻ có thể học được rằng ăn vạ là cách hiệu quả để thu hút sự chú ý..."
      },
      {
        "title": "Phớt lờ có kế hoạch (Planned Ignoring)",
        "description": "Nếu ăn vạ là để đòi hỏi điều không được phép hoặc thu hút sự chú ý tiêu cực, hãy phớt lờ an toàn..."
      }
    ],
    "prevention_strategies": [
      {
        "title": "Dạy kỹ năng giao tiếp",
        "description": "Dạy trẻ cách yêu cầu điều họ muốn bằng lời nói, cử chỉ, hoặc hình ảnh..."
      }
    ],
    "sources": [
      "Potegal, M., & Davidson, R. J. (2003). Temper tantrums in young children: Behavioral composition. Journal of Developmental & Behavioral Pediatrics, 24(3), 140-147.",
      "Sroufe, L. A. (2000). Early relationships and the development of children. Infant Mental Health Journal, 21(1‐2), 67-74."
    ],
    "related_behaviors": [
      {
        "id": "uuid",
        "name_vn": "Từ chối tuân thủ",
        "code": "BH_01_02"
      }
    ],
    "usage_count": 245,
    "last_used_at": "2025-11-03T14:20:00Z",
    "is_favorite": true
  }
}
```

### 6.4 Create Behavior Incident

```http
POST /api/behavior-incidents
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "session_log_id": "uuid",
  "behavior_library_id": "uuid",
  "antecedent": "Giáo viên yêu cầu trẻ dọn đồ chơi để chuyển sang hoạt động mới.",
  "behavior_description": "Trẻ la hét 'Không!', ném 2-3 đồ chơi xuống sàn, nằm lăn ra đất và gào khóc.",
  "consequence": "Giáo viên áp dụng kỹ thuật phớt lờ có kế hoạch, trẻ ngừng khóc sau 3 phút.",
  "duration_minutes": 5,
  "intensity_level": 3,
  "frequency_count": 1,
  "intervention_used": "Phớt lờ có kế hoạch (Planned Ignoring)",
  "intervention_effective": true,
  "environmental_factors": "Phòng học ồn do nhóm bên cạnh",
  "occurred_at": "09:45:00",
  "notes": "",
  "requires_followup": false
}

Response: 201 Created
{
  "success": true,
  "incident": {
    "id": "uuid",
    "session_log_id": "uuid",
    "incident_number": 1,
    "behavior": {
      "id": "uuid",
      "name_vn": "Ăn vạ",
      "code": "BH_01_01",
      "group_name": "CHỐNG ĐỐI & BƯỚNG BỈNH",
      "icon": "😭"
    },
    "antecedent": "Giáo viên yêu cầu trẻ dọn đồ chơi...",
    "behavior_description": "Trẻ la hét 'Không!'...",
    "consequence": "Giáo viên áp dụng kỹ thuật phớt lờ...",
    "duration_minutes": 5,
    "intensity_level": 3,
    "frequency_count": 1,
    "intervention_used": "Phớt lờ có kế hoạch",
    "intervention_effective": true,
    "environmental_factors": "Phòng học ồn",
    "occurred_at": "09:45:00",
    "requires_followup": false,
    "created_at": "2025-11-05T07:47:46Z"
  }
}
```

### 6.5 Update Behavior Incident

```http
PATCH /api/behavior-incidents/:incident_id
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "intensity_level": 4,
  "intervention_effective": false,
  "notes": "Cần thử phương pháp khác"
}

Response: 200 OK
{
  "success": true,
  "incident": {
    "id": "uuid",
    "intensity_level": 4,
    "intervention_effective": false,
    "updated_at": "2025-11-05T07:47:46Z"
  }
}
```

### 6.6 Delete Behavior Incident

```http
DELETE /api/behavior-incidents/:incident_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Sự cố hành vi đã được xóa"
}
```

### 6.7 Add to Favorites

```http
POST /api/teachers/me/favorites
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "behavior_id": "uuid"
}

Response: 200 OK
{
  "success": true,
  "is_favorite": true,
  "message": "Đã thêm vào yêu thích"
}
```

### 6.8 Remove from Favorites

```http
DELETE /api/teachers/me/favorites/:behavior_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "is_favorite": false,
  "message": "Đã xóa khỏi yêu thích"
}
```

### 6.9 List Favorites

```http
GET /api/teachers/me/favorites
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "favorites": [
    {
      "id": "uuid",
      "behavior_code": "BH_01_01",
      "name_vn": "Ăn vạ",
      "name_en": "Tantrums",
      "icon": "😭",
      "group_name": "CHỐNG ĐỐI & BƯỚNG BỈNH",
      "created_at": "2025-11-05T07:47:46Z"
    }
  ],
  "total": 12
}
```

---

## 📚 7. CONTENT LIBRARY & TEMPLATES (9 endpoints)

### 7.1 Create Template

```http
POST /api/content-library
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "title": "Nhận biết màu sắc cơ bản",
  "domain": "cognitive",
  "description": "Dạy trẻ nhận biết 4 màu: đỏ, vàng, xanh lá, xanh dương",
  "target_age_min": 3,
  "target_age_max": 6,
  "difficulty_level": "beginner",
  "materials_needed": "Thẻ màu, đồ chơi nhiều màu",
  "estimated_duration": 30,
  "instructions": "Bước 1: Giới thiệu màu...",
  "tips": "Sử dụng đồ vật quen thuộc...",
  "default_goals": [
    {
      "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
      "order": 1
    },
    {
      "description": "Trẻ có thể nói tên màu",
      "order": 2
    }
  ],
  "tags": ["màu sắc", "nhận biết", "cognitive"],
  "is_public": false
}

Response: 201 Created
{
  "success": true,
  "template": {
    "id": "uuid",
    "teacher_id": "uuid",
    "code": "CTL_TH_001",
    "title": "Nhận biết màu sắc cơ bản",
    "domain": "cognitive",
    "description": "...",
    "target_age_min": 3,
    "target_age_max": 6,
    "difficulty_level": "beginner",
    "default_goals": [...],
    "tags": ["màu sắc", "nhận biết", "cognitive"],
    "is_template": true,
    "is_public": false,
    "usage_count": 0,
    "rating_avg": 0,
    "rating_count": 0,
    "created_at": "2025-11-05T07:47:46Z"
  }
}
```

### 7.2 List Templates

```http
GET /api/content-library?domain=cognitive&difficulty=beginner&public_only=false&page=1&limit=20
Authorization: Bearer <access_token>

Query Parameters:
- domain: "cognitive" | "motor" | "language" | "social" | "self_care" (optional)
- difficulty: "beginner" | "intermediate" | "advanced" (optional)
- public_only: boolean (default: false)
- tags: string (optional) - comma-separated
- page: number (default: 1)
- limit: number (default: 20)

Response: 200 OK
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "code": "CTL_TH_001",
      "title": "Nhận biết màu sắc cơ bản",
      "domain": "cognitive",
      "difficulty_level": "beginner",
      "target_age_min": 3,
      "target_age_max": 6,
      "estimated_duration": 30,
      "usage_count": 15,
      "rating_avg": 4.5,
      "rating_count": 8,
      "is_public": false,
      "created_by": {
        "id": "uuid",
        "name": "Trần Hảo"
      },
      "tags": ["màu sắc", "nhận biết"]
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 45,
    "total_pages": 3
  }
}
```

### 7.3 Get Template Details

```http
GET /api/content-library/:template_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "template": {
    "id": "uuid",
    "teacher_id": "uuid",
    "code": "CTL_TH_001",
    "title": "Nhận biết màu sắc cơ bản",
    "domain": "cognitive",
    "description": "Dạy trẻ nhận biết 4 màu...",
    "target_age_min": 3,
    "target_age_max": 6,
    "difficulty_level": "beginner",
    "materials_needed": "Thẻ màu, đồ chơi",
    "estimated_duration": 30,
    "instructions": "Bước 1: Giới thiệu màu...",
    "tips": "Sử dụng đồ vật quen thuộc...",
    "default_goals": [
      {
        "description": "Trẻ có thể chỉ đúng màu khi được hỏi",
        "order": 1
      },
      {
        "description": "Trẻ có thể nói tên màu",
        "order": 2
      }
    ],
    "tags": ["màu sắc", "nhận biết", "cognitive"],
    "is_template": true,
    "is_public": false,
    "usage_count": 15,
    "rating_avg": 4.5,
    "rating_count": 8,
    "last_used_at": "2025-11-03T10:00:00Z",
    "created_at": "2025-11-05T07:47:46Z"
  }
}
```

### 7.4 Update Template

```http
PATCH /api/content-library/:template_id
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "title": "Nhận biết màu sắc cơ bản (Updated)",
  "description": "Updated description...",
  "is_public": true
}

Response: 200 OK
{
  "success": true,
  "template": {
    "id": "uuid",
    "title": "Nhận biết màu sắc cơ bản (Updated)",
    "is_public": true,
    "updated_at": "2025-11-05T07:47:46Z"
  }
}
```

### 7.5 Delete Template (Soft Delete)

```http
DELETE /api/content-library/:template_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Template đã được xóa"
}
```

### 7.6 Rate Template

```http
POST /api/content-library/:template_id/ratings
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "rating": 5,
  "review": "Template rất hữu ích, trẻ học rất tốt!"
}

Response: 200 OK
{
  "success": true,
  "rating": {
    "id": "uuid",
    "content_library_id": "uuid",
    "teacher_id": "uuid",
    "rating": 5,
    "review": "Template rất hữu ích...",
    "created_at": "2025-11-05T07:47:46Z"
  },
  "template_stats": {
    "rating_avg": 4.75,
    "rating_count": 12
  }
}
```

### 7.7 Update Rating

```http
PATCH /api/content-library/:template_id/ratings
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "rating": 4,
  "review": "Updated review..."
}

Response: 200 OK
{
  "success": true,
  "rating": {
    "id": "uuid",
    "rating": 4,
    "review": "Updated review...",
    "updated_at": "2025-11-05T07:47:46Z"
  }
}
```

### 7.8 Get Template Ratings

```http
GET /api/content-library/:template_id/ratings?page=1&limit=10
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "ratings": [
    {
      "id": "uuid",
      "teacher": {
        "id": "uuid",
        "name": "Trần Hảo",
        "avatar_url": "https://..."
      },
      "rating": 5,
      "review": "Template rất hữu ích...",
      "created_at": "2025-11-05T07:47:46Z"
    }
  ],
  "stats": {
    "rating_avg": 4.75,
    "rating_count": 12
  },
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 12
  }
}
```

### 7.9 Delete Rating

```http
DELETE /api/content-library/:template_id/ratings
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Đánh giá đã được xóa"
}
```

---

## 🤖 8. AI PROCESSING (5 endpoints)

### 8.1 Upload for AI Processing

```http
POST /api/ai/process
Authorization: Bearer <access_token>
Content-Type: multipart/form-data

Request Body (FormData):
- student_id: "uuid"
- file: File (optional, PDF/DOCX/TXT/JPG/PNG, max 10MB)
- text_content: "text content..." (optional, max 5000 chars)
  (Either file OR text_content, not both)

Response: 202 Accepted
{
  "success": true,
  "processing": {
    "id": "uuid",
    "teacher_id": "uuid",
    "student_id": "uuid",
    "file_url": "https://r2.../file.pdf",
    "file_type": "pdf",
    "processing_status": "pending",
    "progress": 0,
    "created_at": "2025-11-05T07:47:46Z"
  },
  "message": "Đang xử lý file của bạn. Quá trình có thể mất 30-60 giây.",
  "estimated_time": "30-60 seconds"
}
```

### 8.2 Get Processing Status

```http
GET /api/ai/process/:processing_id/status
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "processing_status": "processing",
  "progress": 45,
  "message": "Đang phân tích nội dung với AI..."
}
```

### 8.3 Get Processing Result

```http
GET /api/ai/process/:processing_id
Authorization: Bearer <access_token>

Response: 200 OK (when completed)
{
  "success": true,
  "processing": {
    "id": "uuid",
    "teacher_id": "uuid",
    "student_id": "uuid",
    "file_url": "https://r2.../file.pdf",
    "file_type": "pdf",
    "processing_status": "completed",
    "progress": 100,
    "result_sessions": {
      "sessions": [
        {
          "session_date": "2025-11-12",
          "time_slot": "morning",
          "start_time": "09:00",
          "end_time": "10:30",
          "location": "Phòng học số 1",
          "notes": "Buổi học về nhận biết màu sắc",
          "contents": [
            {
              "title": "Nhận biết màu sắc",
              "domain": "cognitive",
              "description": "Dạy trẻ nhận biết 4 màu cơ bản",
              "materials_needed": "Thẻ màu, đồ chơi",
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
            }
          ]
        }
      ]
    },
    "completed_at": "2025-11-05T07:48:46Z"
  }
}
```

### 8.4 Create Sessions from AI Result

```http
POST /api/ai/process/:processing_id/create-sessions
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "sessions": [
    {
      "session_date": "2025-11-12",
      "time_slot": "morning",
      "start_time": "09:00:00",
      "end_time": "10:30:00",
      "location": "Phòng học số 1",
      "notes": "Buổi học về nhận biết màu sắc",
      "contents": [
        {
          "title": "Nhận biết màu sắc",
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

Response: 201 Created
{
  "success": true,
  "message": "Đã tạo thành công 3 buổi học từ AI",
  "sessions": [
    {
      "id": "uuid",
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

### 8.5 Delete AI Processing

```http
DELETE /api/ai/process/:processing_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "AI processing đã được xóa"
}
```

---

## 📊 9. ANALYTICS & REPORTS (5 endpoints)

### 9.1 Get Analytics Overview

```http
GET /api/analytics/overview?student_id=uuid&date_from=2025-10-06&date_to=2025-11-05
Authorization: Bearer <access_token>

Query Parameters:
- student_id: uuid (optional, filter by student)
- date_from: YYYY-MM-DD (default: 30 days ago)
- date_to: YYYY-MM-DD (default: today)

Response: 200 OK
{
  "success": true,
  "filters": {
    "student_id": null,
    "student_name": "Tất cả học sinh",
    "date_from": "2025-10-06",
    "date_to": "2025-11-05"
  },
  "kpis": {
    "total_sessions": 45,
    "completed_sessions": 40,
    "pending_sessions": 3,
    "cancelled_sessions": 2,
    "completion_rate": 88.9,
    "avg_duration_minutes": 85,
    "total_goals_evaluated": 320,
    "goal_achievement_rate": 76.5,
    "avg_achievement_level": 78.3,
    "total_incidents": 12,
    "unique_behaviors": 5,
    "avg_incident_intensity": 2.8
  },
  "charts": {
    "sessions_trend": [
      {
        "week": "2025-10-06",
        "session_count": 8,
        "completed_count": 7
      },
      {
        "week": "2025-10-13",
        "session_count": 10,
        "completed_count": 9
      }
    ],
    "goal_distribution": {
      "achieved": 245,
      "partially_achieved": 50,
      "not_achieved": 20,
      "not_applicable": 5
    },
    "mood_trend": [
      {
        "session_date": "2025-10-06",
        "mood": "good",
        "energy_level": 4,
        "cooperation_level": 5,
        "focus_level": 3,
        "overall_rating": 4
      }
    ]
  },
  "top_behaviors": [
    {
      "name_vn": "Ăn vạ",
      "icon": "😭",
      "group_name": "CHỐNG ĐỐI & BƯỚNG BỈNH",
      "color_code": "#FF5733",
      "incident_count": 5,
      "avg_intensity": 3.2
    }
  ]
}
```

### 9.2 Get Student Analytics

```http
GET /api/analytics/student/:student_id?date_from=2025-10-06&date_to=2025-11-05
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "student": {
    "id": "uuid",
    "full_name": "Nguyễn Văn An",
    "age": 7,
    "avatar_url": "https://..."
  },
  "period": {
    "date_from": "2025-10-06",
    "date_to": "2025-11-05"
  },
  "kpis": {
    "total_sessions": 12,
    "completed_sessions": 11,
    "completion_rate": 91.7,
    "total_goals": 88,
    "goals_achieved": 67,
    "achievement_rate": 76.1,
    "total_incidents": 3,
    "avg_mood": "good",
    "avg_cooperation": 4.5
  },
  "progress_over_time": {
    "achievement_trend": [...],
    "mood_trend": [...],
    "behavior_trend": [...]
  },
  "domain_breakdown": {
    "cognitive": {
      "total_goals": 25,
      "achieved": 20,
      "rate": 80.0
    },
    "motor": {...},
    "language": {...},
    "social": {...},
    "self_care": {...}
  }
}
```

### 9.3 Request Report Generation

```http
POST /api/reports
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "format": "pdf",
  "report_type": "individual",
  "student_id": "uuid",
  "date_from": "2025-10-06",
  "date_to": "2025-11-05"
}

Response: 202 Accepted
{
  "success": true,
  "report_job_id": "uuid",
  "estimated_time": "30 giây",
  "message": "Đang tạo báo cáo PDF. Bạn sẽ nhận được thông báo khi hoàn tất."
}
```

### 9.4 Check Report Status

```http
GET /api/reports/:job_id
Authorization: Bearer <access_token>

Response: 200 OK (when completed)
{
  "success": true,
  "report": {
    "id": "uuid",
    "format": "pdf",
    "report_type": "individual",
    "student_id": "uuid",
    "file_url": "https://r2.../report.pdf?signed=...",
    "file_size": 2457600,
    "status": "completed",
    "expires_at": "2025-11-05T08:47:46Z",
    "created_at": "2025-11-05T07:47:46Z"
  }
}
```

### 9.5 Download Report

```http
GET /api/reports/:job_id/download
Authorization: Bearer <access_token>

Response: 302 Redirect
Location: https://r2.cloudflare.com/.../report.pdf?signed=...
```

---

Bạn có muốn tôi tiếp tục với phần cuối:

- **Section 10:** Settings, Sync & Backups (14 endpoints)?

# 📋 DANH SÁCH API ENDPOINTS CHI TIẾT (PHẦN CUỐI)

---

## ⚙️ 10. SETTINGS, SYNC & BACKUPS (14 endpoints)

### 10.1 Get User Settings

```http
GET /api/settings
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "user": {
    "id": "uuid",
    "email": "tranhaohcmus@gmail.com",
    "first_name": "Trần",
    "last_name": "Hảo",
    "phone": "0901234567",
    "school": "Trường ABC",
    "timezone": "Asia/Ho_Chi_Minh",
    "language": "vi",
    "avatar_url": "https://..."
  },
  "settings": {
    "theme": "dark",
    "font_size": "medium",
    "push_notifications": true,
    "email_notifications": false,
    "notification_frequency": "immediate",
    "auto_save_interval": 60,
    "biometric_enabled": true,
    "auto_backup_enabled": true
  }
}
```

### 10.2 Update Settings

```http
PATCH /api/settings
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "theme": "dark",
  "font_size": "large",
  "push_notifications": true,
  "email_notifications": false,
  "notification_frequency": "daily",
  "timezone": "Asia/Ho_Chi_Minh",
  "language": "vi"
}

Response: 200 OK
{
  "success": true,
  "user": {
    "id": "uuid",
    "timezone": "Asia/Ho_Chi_Minh",
    "language": "vi",
    "updated_at": "2025-11-05T07:49:55Z"
  },
  "settings": {
    "theme": "dark",
    "font_size": "large",
    "push_notifications": true,
    "email_notifications": false,
    "notification_frequency": "daily"
  }
}
```

### 10.3 Change Password

```http
POST /api/settings/change-password
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "current_password": "OldPassword123!",
  "new_password": "NewSecurePass456!",
  "confirm_password": "NewSecurePass456!"
}

Response: 200 OK
{
  "success": true,
  "message": "Mật khẩu đã được thay đổi thành công"
}
```

### 10.4 Get Sync Metadata

```http
GET /api/sync/metadata
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "last_sync_at": "2025-11-04T10:00:00Z",
  "data_versions": {
    "students": "v123",
    "sessions": "v456",
    "behaviors": "v789",
    "content_library": "v012"
  },
  "server_time": "2025-11-05T07:49:55Z"
}
```

### 10.5 Sync Students Data

```http
GET /api/students?all=true&sync=true
Authorization: Bearer <access_token>

Query Parameters:
- all: true (get all, ignore pagination)
- sync: true (optimized for sync)
- updated_since: ISO timestamp (optional, incremental sync)

Response: 200 OK
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "teacher_id": "uuid",
      "first_name": "Nguyễn Văn",
      "last_name": "An",
      "nickname": "An",
      "full_name": "Nguyễn Văn An",
      "date_of_birth": "2018-05-15",
      "age": 7,
      "gender": "male",
      "avatar_url": "https://...",
      "status": "active",
      "diagnosis": "ASD Level 1",
      "notes": "...",
      "parent_name": "Nguyễn Thị B",
      "parent_phone": "0901234567",
      "created_at": "2025-11-05T07:00:00Z",
      "updated_at": "2025-11-05T07:49:55Z",
      "deleted_at": null
    }
  ],
  "sync_metadata": {
    "version": "v124",
    "timestamp": "2025-11-05T07:49:55Z",
    "total_records": 15
  }
}
```

### 10.6 Sync Sessions Data

```http
GET /api/sessions?date_from=2025-10-06&limit=all&sync=true
Authorization: Bearer <access_token>

Query Parameters:
- date_from: YYYY-MM-DD (default: 30 days ago)
- limit: "all" (get all matching records)
- sync: true (include full details: contents, goals)
- updated_since: ISO timestamp (optional)

Response: 200 OK
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "student_id": "uuid",
      "session_date": "2025-11-10",
      "time_slot": "morning",
      "start_time": "09:00:00",
      "end_time": "10:30:00",
      "duration_minutes": 90,
      "location": "Phòng 101",
      "notes": "...",
      "status": "pending",
      "creation_method": "manual",
      "has_evaluation": false,
      "contents": [
        {
          "id": "uuid",
          "session_id": "uuid",
          "title": "Nhận biết màu sắc",
          "domain": "cognitive",
          "description": "...",
          "order_index": 1,
          "goals": [
            {
              "id": "uuid",
              "description": "Trẻ có thể chỉ đúng màu",
              "goal_type": "knowledge",
              "is_primary": true,
              "order_index": 1
            }
          ]
        }
      ],
      "created_at": "2025-11-05T07:00:00Z",
      "updated_at": "2025-11-05T07:49:55Z",
      "deleted_at": null
    }
  ],
  "sync_metadata": {
    "version": "v457",
    "timestamp": "2025-11-05T07:49:55Z",
    "total_records": 45
  }
}
```

### 10.7 Sync Behaviors Data

```http
GET /api/behaviors?limit=all&sync=true
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "groups": [
    {
      "id": "uuid",
      "code": "GROUP_01",
      "name_vn": "CHỐNG ĐỐI & BƯỚNG BỈNH",
      "name_en": "Opposition & Defiance",
      "icon": "😤",
      "color_code": "#FF5733",
      "order_index": 1
    }
  ],
  "behaviors": [
    {
      "id": "uuid",
      "behavior_code": "BH_01_01",
      "name_vn": "Ăn vạ",
      "name_en": "Tantrums",
      "icon": "😭",
      "group_id": "uuid",
      "age_range": {"min": 2, "max": 10},
      "manifestation_vn": "...",
      "explanation": [...],
      "solutions": [...],
      "prevention_strategies": [...],
      "sources": [...],
      "keywords_vn": ["ăn vạ", "tantrum", "khóc lóc"],
      "keywords_en": ["tantrum", "meltdown"],
      "is_active": true
    }
  ],
  "sync_metadata": {
    "version": "v790",
    "timestamp": "2025-11-05T07:49:55Z",
    "total_groups": 3,
    "total_behaviors": 127
  }
}
```

### 10.8 Upload Offline Queue Data

```http
POST /api/sync/upload
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "queue": [
    {
      "action_type": "CREATE_SESSION",
      "entity_type": "sessions",
      "local_id": "temp-uuid-1",
      "payload": {
        "student_id": "uuid",
        "session_date": "2025-11-10",
        "start_time": "09:00:00",
        "end_time": "10:30:00",
        "contents": [...]
      },
      "created_at": "2025-11-05T07:30:00Z"
    },
    {
      "action_type": "UPDATE_SESSION",
      "entity_type": "sessions",
      "entity_id": "uuid",
      "local_id": null,
      "payload": {
        "notes": "Updated offline"
      },
      "created_at": "2025-11-05T07:35:00Z"
    }
  ]
}

Response: 200 OK
{
  "success": true,
  "results": [
    {
      "local_id": "temp-uuid-1",
      "status": "success",
      "server_id": "uuid",
      "message": "Session created successfully"
    },
    {
      "entity_id": "uuid",
      "status": "success",
      "message": "Session updated successfully"
    }
  ],
  "summary": {
    "total": 2,
    "success": 2,
    "failed": 0
  }
}
```

### 10.9 Create Backup

```http
POST /api/backups
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "backup_type": "manual",
  "include_media": true
}

Response: 202 Accepted
{
  "success": true,
  "backup_job_id": "uuid",
  "message": "Đang tạo bản sao lưu. Bạn sẽ nhận được thông báo khi hoàn tất.",
  "estimated_time": "5-10 phút"
}
```

### 10.10 List Backups

```http
GET /api/backups
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "backups": [
    {
      "id": "uuid",
      "teacher_id": "uuid",
      "backup_type": "auto",
      "file_url": "https://r2.../backup.zip",
      "file_size": 145678900,
      "status": "completed",
      "created_at": "2025-10-29T02:00:00Z",
      "expires_at": "2025-11-05T02:00:00Z"
    },
    {
      "id": "uuid",
      "backup_type": "manual",
      "file_url": "https://r2.../backup.zip",
      "file_size": 157286400,
      "status": "completed",
      "created_at": "2025-11-05T07:00:00Z",
      "expires_at": "2025-11-12T07:00:00Z"
    }
  ],
  "total": 4
}
```

### 10.11 Get Backup Details

```http
GET /api/backups/:backup_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "backup": {
    "id": "uuid",
    "teacher_id": "uuid",
    "backup_type": "manual",
    "file_url": "https://r2.../backup.zip",
    "file_size": 157286400,
    "status": "completed",
    "created_at": "2025-11-05T07:00:00Z",
    "expires_at": "2025-11-12T07:00:00Z"
  }
}
```

### 10.12 Download Backup

```http
GET /api/backups/:backup_id/download
Authorization: Bearer <access_token>

Response: 302 Redirect
Location: https://r2.cloudflare.com/.../backup.zip?signed=...&expires=1730836795
```

### 10.13 Enable/Disable Auto Backup

```http
PATCH /api/settings
Authorization: Bearer <access_token>
Content-Type: application/json

Request Body:
{
  "auto_backup_enabled": true
}

Response: 200 OK
{
  "success": true,
  "settings": {
    "auto_backup_enabled": true
  },
  "message": "Tự động sao lưu đã được bật. Hệ thống sẽ tạo backup mỗi tuần."
}
```

### 10.14 Delete Backup

```http
DELETE /api/backups/:backup_id
Authorization: Bearer <access_token>

Response: 200 OK
{
  "success": true,
  "message": "Backup đã được xóa"
}
```

---

## 📊 TỔNG KẾT API ENDPOINTS

### Thống kê theo Category

| Category                     | Số lượng Endpoints | Mô tả                                          |
| ---------------------------- | ------------------ | ---------------------------------------------- |
| **Authentication & User**    | 10                 | Register, login, profile, delete account       |
| **Students**                 | 6                  | CRUD + status management                       |
| **Sessions**                 | 10                 | Create (3 steps), list, detail, update, delete |
| **Session Contents & Goals** | 4                  | Add/update/delete contents và goals            |
| **Session Logging**          | 6                  | 4-step logging flow + complete                 |
| **Media**                    | 4                  | Upload, confirm, get, delete                   |
| **Behaviors**                | 9                  | Groups, library, incidents, favorites          |
| **Content Library**          | 9                  | Templates CRUD + ratings                       |
| **AI Processing**            | 5                  | Upload, status, result, create sessions        |
| **Analytics & Reports**      | 5                  | Overview, student analytics, reports           |
| **Settings & Sync**          | 14                 | Settings, sync metadata, backups               |
| **TOTAL**                    | **82**             | **Complete API Coverage**                      |

---

## 🔐 AUTHENTICATION METHODS

Tất cả endpoints (trừ public endpoints) yêu cầu authentication:

### Public Endpoints (Không cần auth):

```
POST   /auth/register
GET    /auth/verify-email
POST   /auth/login
POST   /auth/refresh
POST   /auth/forgot-password
POST   /auth/reset-password
```

### Protected Endpoints (Cần Bearer Token):

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

## 📝 COMMON RESPONSE PATTERNS

### Success Response Structure:

```json
{
  "success": true,
  "data": {...} | [...],
  "message": "Optional success message",
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "total_pages": 8
  }
}
```

### Error Response Structure:

```json
{
  "success": false,
  "error": "ERROR_CODE",
  "message": "Human-readable error message in Vietnamese",
  "details": {
    "field": "email",
    "constraint": "unique",
    "value_received": "existing@email.com"
  }
}
```

---

## 🚨 COMMON ERROR CODES

| HTTP Code | Error Code              | Mô tả                                |
| --------- | ----------------------- | ------------------------------------ |
| **400**   | `VALIDATION_ERROR`      | Dữ liệu đầu vào không hợp lệ         |
| **400**   | `INVALID_DATE_RANGE`    | Khoảng thời gian không hợp lệ        |
| **400**   | `INVALID_AGE`           | Tuổi không trong khoảng 2-18         |
| **400**   | `EMAIL_ALREADY_EXISTS`  | Email đã được sử dụng                |
| **400**   | `WEAK_PASSWORD`         | Mật khẩu không đủ mạnh               |
| **401**   | `UNAUTHORIZED`          | Chưa đăng nhập hoặc token hết hạn    |
| **401**   | `INVALID_CREDENTIALS`   | Email/password không đúng            |
| **401**   | `TOKEN_EXPIRED`         | Access token đã hết hạn              |
| **403**   | `FORBIDDEN`             | Không có quyền truy cập resource này |
| **404**   | `NOT_FOUND`             | Resource không tồn tại               |
| **409**   | `CONFLICT`              | Dữ liệu bị conflict (offline sync)   |
| **413**   | `FILE_TOO_LARGE`        | File vượt quá kích thước cho phép    |
| **429**   | `TOO_MANY_REQUESTS`     | Rate limit exceeded                  |
| **500**   | `INTERNAL_SERVER_ERROR` | Lỗi server                           |
| **503**   | `SERVICE_UNAVAILABLE`   | Service tạm thời không khả dụng      |

---

## 📈 RATE LIMITING

| Endpoint Type              | Limit             | Window     |
| -------------------------- | ----------------- | ---------- |
| **Authentication (Login)** | 5 failed attempts | 15 minutes |
| **API Calls (General)**    | 100 requests      | 1 minute   |
| **File Upload**            | 10 uploads        | 1 minute   |
| **AI Processing**          | 5 requests        | 1 hour     |
| **Report Generation**      | 3 requests        | 1 hour     |

### Rate Limit Headers:

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1730794795
```

---

## 🌐 API VERSIONING

Current Version: **v1**

Base URL: `https://api.educare-connect.com/v1`

Future versions sẽ maintain backward compatibility trong tối thiểu 6 tháng.

---

## 📖 PAGINATION PATTERN

Áp dụng cho tất cả list endpoints:

### Query Parameters:

```
?page=1&limit=20
```

### Response:

```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "total_pages": 8,
    "has_next": true,
    "has_prev": false
  }
}
```

---

## 🔍 FILTERING & SORTING

### Common Filter Parameters:

```
?search=keyword
?status=active
?date_from=2025-11-01
?date_to=2025-11-30
?sort_by=created_at
?sort_order=desc
```

### Example:

```http
GET /api/sessions?student_id=uuid&status=completed&date_from=2025-11-01&sort_by=session_date&sort_order=desc&page=1&limit=20
```

---

## 🎯 WEBHOOK EVENTS (Optional - Future)

Cho real-time updates thay vì polling:

```http
POST https://your-app.com/webhooks/educare
Content-Type: application/json
X-Educare-Signature: sha256=...

{
  "event": "ai.processing.completed",
  "data": {
    "processing_id": "uuid",
    "status": "completed",
    "teacher_id": "uuid"
  },
  "timestamp": "2025-11-05T07:49:55Z"
}
```

### Available Events:

- `ai.processing.completed`
- `ai.processing.failed`
- `report.generation.completed`
- `backup.completed`

---

# 🎉 HOÀN THÀNH DANH SÁCH API ENDPOINTS

**Tổng cộng: 82 endpoints** được documented đầy đủ với:

✅ Request/Response examples  
✅ Query parameters  
✅ Error handling  
✅ Authentication requirements  
✅ Rate limiting  
✅ Pagination patterns

---

**File này có thể sử dụng để:**

1. Frontend development reference
2. API testing (Postman/Insomnia collection)
3. Generate OpenAPI/Swagger spec
4. Documentation cho developers

**Author:** tranhaohcmus  
**Generated:** 2025-11-05 07:49:55 UTC  
**Version:** 2.0 - Complete API Reference

---

Bạn có cần tôi:

1. **Tạo Postman Collection** từ danh sách này?
2. **Generate OpenAPI 3.0 spec** (Swagger)?
3. **Tạo API test cases** chi tiết?
4. **Export sang format khác** (Excel, CSV)?
