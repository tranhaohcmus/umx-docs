# PHẦN 3/10: FUNCTIONAL REQUIREMENTS - STUDENT MANAGEMENT

````markdown
## 2.2 Quản lý Học sinh

### **FR-007: Tạo Hồ sơ Học sinh**

#### Mã Chức năng

`FR-007`

#### Mô tả

Giáo viên tạo hồ sơ mới cho học sinh.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Giáo viên đã đăng nhập (có access token hợp lệ)

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình "Danh sách Học sinh"

**Bước 2:** Giáo viên nhấn "Thêm Học sinh mới"

**Bước 3:** Hệ thống hiển thị form với các trường (mapping sang `STUDENTS` table):

- `first_name` (string, required) → `STUDENTS.first_name`
- `last_name` (string, required) → `STUDENTS.last_name`
- `nickname` (string, optional) → `STUDENTS.nickname`
- `date_of_birth` (date, required) → `STUDENTS.date_of_birth`
- `gender` (enum: male/female/other, required) → `STUDENTS.gender`
- `avatar` (image file, optional) → `STUDENTS.avatar_url`
- `diagnosis` (text, optional) → `STUDENTS.diagnosis`
- `notes` (text, optional) → `STUDENTS.notes`
- `parent_name` (string, optional) → `STUDENTS.parent_name`
- `parent_phone` (string, optional) → `STUDENTS.parent_phone`

**Bước 4:** Giáo viên nhập thông tin và submit

**Bước 5:** Hệ thống validate:

- `date_of_birth`: tuổi từ 2-18 (tính từ current_date)
  ```sql
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, :date_of_birth)) BETWEEN 2 AND 18
  ```
````

- `gender`: phải thuộc enum ('male', 'female', 'other')
- `avatar`: nếu có, kiểm tra:
  - File type: JPG, PNG, HEIC
  - Max size: 5MB
  - Auto-resize về 512x512px (maintain aspect ratio, crop center)

**Bước 6:** Nếu có avatar:

- Upload file lên **Cloudflare R2**
- Đường dẫn: `students/{teacher_id}/{student_id}/avatar.jpg`
- Lưu signed URL vào `STUDENTS.avatar_url`

**Bước 7:** Hệ thống tạo bản ghi mới trong bảng `STUDENTS`:

```sql
INSERT INTO students (
  id,                    -- UUID auto-generated
  teacher_id,            -- từ access token (authenticated teacher)
  first_name,
  last_name,
  nickname,
  date_of_birth,
  gender,
  avatar_url,
  status,                -- default 'active'
  diagnosis,
  notes,
  parent_name,
  parent_phone,
  created_at,            -- NOW()
  updated_at             -- NOW()
) VALUES (...)
RETURNING *;
```

**Bước 8:** Hệ thống trả về response với student object

**Bước 9:** Client cập nhật danh sách học sinh

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                               | Mô tả                                                              |
| ------------ | ---------------------------------------- | ------------------------------------------------------------------ |
| **RB-007-1** | `STUDENTS.teacher_id` FK → `TEACHERS.id` | Mỗi học sinh phải thuộc về 1 giáo viên duy nhất (1-N relationship) |
| **RB-007-2** | `STUDENTS.date_of_birth`                 | Tuổi phải trong khoảng 2-18 năm                                    |
| **RB-007-3** | `STUDENTS.gender` CHECK                  | Chỉ chấp nhận 'male', 'female', 'other'                            |
| **RB-007-4** | `STUDENTS.status`                        | Mặc định 'active'                                                  |
| **RB-007-5** | `STUDENTS.avatar_url`                    | Lưu signed URL từ R2, không lưu binary data                        |
| **RB-007-6** | Auto-computed                            | `full_name = CONCAT(first_name, ' ', last_name)`                   |
| **RB-007-7** | Auto-computed                            | `age = EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth))`        |

#### Dữ liệu Đầu vào

```typescript
interface CreateStudentInput {
  first_name: string; // required
  last_name: string; // required
  nickname?: string;
  date_of_birth: string; // YYYY-MM-DD, required
  gender: "male" | "female" | "other"; // required
  avatar?: File; // optional, max 5MB
  diagnosis?: string;
  notes?: string;
  parent_name?: string;
  parent_phone?: string;
}
```

#### Dữ liệu Đầu ra

**Success (201 Created):**

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
    "avatar_url": "https://r2.../avatar.jpg",
    "status": "active",
    "diagnosis": "ASD Level 1",
    "notes": "Thích màu xanh...",
    "parent_name": "Nguyễn Thị B",
    "parent_phone": "0901234567",
    "created_at": "2025-11-05T04:00:00Z",
    "updated_at": "2025-11-05T04:00:00Z"
  }
}
```

#### Xử lý Ngoại lệ

| Tình huống         | HTTP Code | Error Code          | Xử lý                                        |
| ------------------ | --------- | ------------------- | -------------------------------------------- |
| Tuổi ngoài 2-18    | 400       | `INVALID_AGE`       | Trả lỗi với tuổi hiện tại                    |
| Avatar quá lớn     | 413       | `FILE_TOO_LARGE`    | Trả lỗi, yêu cầu file < 5MB                  |
| Avatar format sai  | 400       | `INVALID_FILE_TYPE` | Trả lỗi, chỉ chấp nhận JPG/PNG/HEIC          |
| Upload R2 thất bại | 500       | `UPLOAD_FAILED`     | Retry 3 lần, nếu fail → rollback tạo student |

#### API Endpoint

```
POST /api/students
Authorization: Bearer <access_token>
Content-Type: multipart/form-data
```

#### Ưu tiên

**Must Have**

---

### **FR-008: Xem Danh sách Học sinh**

#### Mã Chức năng

`FR-008`

#### Mô tả

Giáo viên xem danh sách tất cả học sinh của mình với tính năng search, filter, pagination.

#### Tác nhân

- **Giáo viên** (đã đăng nhập)

#### Điều kiện Tiên quyết

- Giáo viên đã đăng nhập

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình "Danh sách Học sinh"

**Bước 2:** Hệ thống query bảng `STUDENTS`:

```sql
SELECT
  id, first_name, last_name, nickname,
  CONCAT(first_name, ' ', last_name) AS full_name,
  date_of_birth,
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) AS age,
  gender, avatar_url, status
FROM students
WHERE teacher_id = :authenticated_teacher_id
  AND deleted_at IS NULL              -- Không lấy soft-deleted
  AND (:search IS NULL OR             -- Search (nếu có)
       LOWER(first_name || ' ' || last_name || ' ' || COALESCE(nickname, ''))
       LIKE LOWER('%' || :search || '%'))
  AND (:status IS NULL OR status = :status)  -- Filter theo status (nếu có)
ORDER BY created_at DESC
LIMIT :limit OFFSET :offset;         -- Pagination: default limit=20
```

**Bước 3:** Hệ thống trả về danh sách students

**Bước 4:** Client hiển thị danh sách với:

- Avatar thumbnail
- Tên đầy đủ + nickname
- Tuổi
- Status badge (active/paused/archived)

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                    | Mô tả                                                      |
| ------------ | ----------------------------- | ---------------------------------------------------------- |
| **RB-008-1** | `STUDENTS.teacher_id`         | Chỉ hiển thị học sinh của giáo viên đang đăng nhập         |
| **RB-008-2** | `STUDENTS.deleted_at IS NULL` | Không hiển thị học sinh đã soft-delete                     |
| **RB-008-3** | Search                        | Case-insensitive, tìm trên first_name, last_name, nickname |
| **RB-008-4** | Filter                        | Theo `status` ('active', 'paused', 'archived')             |
| **RB-008-5** | Pagination                    | Default 20 items/page                                      |

#### Dữ liệu Đầu vào

```typescript
interface GetStudentsQuery {
  search?: string; // optional, search query
  status?: "active" | "paused" | "archived"; // optional filter
  page?: number; // default 1
  limit?: number; // default 20, max 100
}
```

#### Dữ liệu Đầu ra

**Success (200 OK):**

```json
{
  "success": true,
  "data": [
    {
      "id": "uuid-1",
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

#### API Endpoint

```
GET /api/students?search=An&status=active&page=1&limit=20
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-009: Xem Chi tiết Học sinh**

#### Mã Chức năng

`FR-009`

#### Mô tả

Giáo viên xem thông tin chi tiết của 1 học sinh.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên click vào 1 học sinh từ danh sách (FR-008)

**Bước 2:** Hệ thống query chi tiết student và thống kê:

```sql
-- Main student info
SELECT * FROM students
WHERE id = :student_id
  AND teacher_id = :authenticated_teacher_id
  AND deleted_at IS NULL;

-- Statistics
SELECT
  COUNT(*) as total_sessions,
  COUNT(CASE WHEN status = 'completed' THEN 1 END) as completed_sessions
FROM sessions
WHERE student_id = :student_id AND deleted_at IS NULL;
```

#### API Endpoint

```
GET /api/students/:student_id
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-010: Cập nhật Hồ sơ Học sinh**

#### Mã Chức năng

`FR-010`

#### Mô tả

Giáo viên cập nhật thông tin học sinh.

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình "Chi tiết Học sinh" (FR-009)

**Bước 2:** Giáo viên nhấn "Chỉnh sửa"

**Bước 3:** Hệ thống pre-fill form với dữ liệu hiện tại

**Bước 4:** Giáo viên thay đổi thông tin và submit

**Bước 5:** Hệ thống update bảng `STUDENTS`:

```sql
UPDATE students
SET
  first_name = :first_name,
  last_name = :last_name,
  nickname = :nickname,
  date_of_birth = :date_of_birth,
  gender = :gender,
  avatar_url = :avatar_url,
  diagnosis = :diagnosis,
  notes = :notes,
  parent_name = :parent_name,
  parent_phone = :parent_phone,
  updated_at = NOW()
WHERE id = :student_id
  AND teacher_id = :authenticated_teacher_id
  AND deleted_at IS NULL
RETURNING *;
```

#### API Endpoint

```
PATCH /api/students/:student_id
Authorization: Bearer <access_token>
Content-Type: multipart/form-data
```

#### Ưu tiên

**Must Have**

---

### **FR-011: Xóa Học sinh (Soft Delete)**

#### Mã Chức năng

`FR-011`

#### Mô tả

Giáo viên xóa học sinh (soft delete).

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên nhấn "Xóa Học sinh"

**Bước 2:** Hệ thống hiển thị dialog xác nhận:

```
"Bạn có chắc muốn xóa học sinh này?
Lưu ý: Tất cả buổi học và nhật ký liên quan cũng sẽ bị xóa."
```

**Bước 3:** Giáo viên xác nhận

**Bước 4:** Hệ thống **soft delete** bằng cách update `deleted_at`:

```sql
UPDATE students
SET
  deleted_at = NOW(),
  updated_at = NOW()
WHERE id = :student_id
  AND teacher_id = :authenticated_teacher_id
  AND deleted_at IS NULL;
```

**Bước 5:** Hệ thống **cascade soft delete** các bản ghi liên quan:

```sql
-- Soft delete tất cả sessions của student
UPDATE sessions
SET deleted_at = NOW()
WHERE student_id = :student_id AND deleted_at IS NULL;
```

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD            | Mô tả                                                           |
| ------------ | --------------------- | --------------------------------------------------------------- |
| **RB-011-1** | `STUDENTS.deleted_at` | Soft delete: set timestamp thay vì DELETE                       |
| **RB-011-2** | Cascade Logic         | Phải soft delete tất cả `SESSIONS` liên quan                    |
| **RB-011-3** | FK Constraint         | ERD có `ON DELETE CASCADE`, nhưng soft delete không trigger này |
| **RB-011-4** | Recovery              | Có thể khôi phục bằng cách set `deleted_at = NULL`              |

#### API Endpoint

```
DELETE /api/students/:student_id
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-012: Thay đổi Trạng thái Học sinh**

#### Mã Chức năng

`FR-012`

#### Mô tả

Giáo viên thay đổi trạng thái học sinh (active/paused/archived).

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình "Chi tiết Học sinh"

**Bước 2:** Giáo viên click dropdown "Trạng thái" và chọn:

- **Active**: Đang học tích cực
- **Paused**: Tạm nghỉ (ví dụ: ốm, nghỉ hè)
- **Archived**: Đã kết thúc chương trình

**Bước 3:** Hệ thống update:

```sql
UPDATE students
SET
  status = :new_status,  -- 'active' | 'paused' | 'archived'
  updated_at = NOW()
WHERE id = :student_id
  AND teacher_id = :authenticated_teacher_id
  AND deleted_at IS NULL;
```

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD              | Mô tả                                        |
| ------------ | ----------------------- | -------------------------------------------- |
| **RB-012-1** | `STUDENTS.status` CHECK | Chỉ chấp nhận 'active', 'paused', 'archived' |

#### API Endpoint

```
PATCH /api/students/:student_id/status
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "status": "paused"
}
```

#### Ưu tiên

**Should Have**

---

```

**✅ PHẦN 3 XONG - Section 2.2 Student Management hoàn tất**

Tiếp tục với **PHẦN 4/10: SESSION MANAGEMENT (FR-013 đến FR-017)**?
```
