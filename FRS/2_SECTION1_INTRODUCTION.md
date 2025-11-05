# PHẦN 2/10: FUNCTIONAL REQUIREMENTS - AUTHENTICATION & USER MANAGEMENT

````markdown
## 2. YÊU CẦU CHỨC NĂNG CHI TIẾT

---

## 2.1 Quản lý Người dùng & Xác thực

### **FR-001: Đăng ký Tài khoản Giáo viên**

#### Mã Chức năng

`FR-001`

#### Mô tả

Cho phép giáo viên mới tạo tài khoản trên hệ thống bằng email và mật khẩu.

#### Tác nhân

- **Giáo viên mới** (chưa có tài khoản)

#### Điều kiện Tiên quyết

- Không có (public endpoint)

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình Đăng ký

**Bước 2:** Hệ thống hiển thị form với các trường:

- `email` (string, required, unique)
- `password` (string, required, min 8 chars)
- `first_name` (string, required)
- `last_name` (string, required)
- `phone` (string, optional)
- `school` (string, optional)

**Bước 3:** Giáo viên nhập thông tin và submit

**Bước 4:** Hệ thống validate:

- Email format (RFC 5322 compliant)
- Email chưa tồn tại trong `TEACHERS.email` (UNIQUE constraint)
- Password >= 8 ký tự, chứa ít nhất 1 chữ hoa, 1 số, 1 ký tự đặc biệt

**Bước 5:** Hệ thống tạo bản ghi mới trong bảng `TEACHERS`:

```sql
INSERT INTO teachers (
  id,                    -- UUID auto-generated
  email,                 -- from input
  password_hash,         -- bcrypt hash, cost=12
  first_name,
  last_name,
  phone,
  school,
  is_verified,           -- default FALSE
  is_active,             -- default TRUE
  timezone,              -- default 'Asia/Ho_Chi_Minh'
  language,              -- default 'vi'
  created_at,            -- current timestamp
  updated_at             -- current timestamp
) VALUES (...)
```
````

**Bước 6:** Hệ thống gửi email xác thực đến `TEACHERS.email` với link chứa token (JWT, exp 24h)

**Bước 7:** Hệ thống trả về response:

```json
{
  "success": true,
  "message": "Đăng ký thành công. Vui lòng kiểm tra email để xác thực tài khoản.",
  "user": {
    "id": "uuid",
    "email": "...",
    "first_name": "...",
    "last_name": "...",
    "is_verified": false
  }
}
```

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD                     | Mô tả                                                                      |
| ------------ | ------------------------------ | -------------------------------------------------------------------------- |
| **RB-001-1** | `TEACHERS.email UNIQUE`        | Email phải duy nhất trong hệ thống. Không cho phép 2 giáo viên cùng email. |
| **RB-001-2** | `TEACHERS.password_hash`       | Mật khẩu phải hash bằng bcrypt với cost factor = 12 trước khi lưu.         |
| **RB-001-3** | `TEACHERS.is_verified = FALSE` | Tài khoản mới mặc định chưa xác thực.                                      |
| **RB-001-4** | `TEACHERS.timezone`            | Mặc định là 'Asia/Ho_Chi_Minh', có thể thay đổi sau trong Settings.        |
| **RB-001-5** | `TEACHERS.language`            | Mặc định 'vi' (Tiếng Việt).                                                |

#### Dữ liệu Đầu vào

```typescript
interface RegisterInput {
  email: string; // required, RFC 5322 format
  password: string; // required, min 8 chars
  first_name: string; // required
  last_name: string; // required
  phone?: string; // optional
  school?: string; // optional
}
```

#### Dữ liệu Đầu ra

**Success (201 Created):**

```json
{
  "success": true,
  "message": "...",
  "user": {
    "id": "uuid",
    "email": "...",
    "first_name": "...",
    "last_name": "...",
    "is_verified": false,
    "created_at": "2025-11-05T04:00:00Z"
  }
}
```

**Error (400 Bad Request):**

```json
{
  "success": false,
  "error": "EMAIL_ALREADY_EXISTS",
  "message": "Email đã được sử dụng. Vui lòng đăng nhập hoặc sử dụng email khác."
}
```

#### Xử lý Ngoại lệ

| Tình huống         | HTTP Code | Error Code             | Xử lý                                              |
| ------------------ | --------- | ---------------------- | -------------------------------------------------- |
| Email đã tồn tại   | 400       | `EMAIL_ALREADY_EXISTS` | Trả lỗi, đề xuất đăng nhập hoặc khôi phục mật khẩu |
| Email không hợp lệ | 400       | `INVALID_EMAIL_FORMAT` | Trả lỗi validation                                 |
| Mật khẩu yếu       | 400       | `WEAK_PASSWORD`        | Trả lỗi với yêu cầu mật khẩu mạnh hơn              |
| Gửi email thất bại | 500       | `EMAIL_SERVICE_ERROR`  | Log lỗi, cho phép user resend verification         |

#### API Endpoint

```
POST /auth/register
Content-Type: application/json
```

#### Ưu tiên

**Must Have**

---

### **FR-002: Xác thực Email**

#### Mã Chức năng

`FR-002`

#### Mô tả

Xác thực địa chỉ email của giáo viên thông qua link trong email.

#### Tác nhân

- **Giáo viên** (đã đăng ký, chưa xác thực)

#### Điều kiện Tiên quyết

- Giáo viên đã hoàn thành FR-001 (Đăng ký)
- `TEACHERS.is_verified = FALSE`

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên nhận email từ hệ thống (từ FR-001)

**Bước 2:** Giáo viên click vào link xác thực (chứa token JWT)

**Bước 3:** Hệ thống validate token:

- Token chưa hết hạn (24h)
- Token signature hợp lệ
- Token chứa `teacher_id` hợp lệ

**Bước 4:** Hệ thống cập nhật bảng `TEACHERS`:

```sql
UPDATE teachers
SET
  is_verified = TRUE,
  updated_at = NOW()
WHERE id = :teacher_id
  AND is_verified = FALSE;
```

**Bước 5:** Hệ thống chuyển hướng đến màn hình thông báo thành công hoặc trang đăng nhập

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD             | Mô tả                                                   |
| ------------ | ---------------------- | ------------------------------------------------------- |
| **RB-002-1** | `TEACHERS.is_verified` | Chỉ cập nhật nếu giá trị hiện tại là FALSE (idempotent) |
| **RB-002-2** | `TEACHERS.updated_at`  | Phải cập nhật timestamp khi verify                      |

#### Dữ liệu Đầu vào

```typescript
interface VerifyEmailInput {
  token: string; // JWT từ email
}
```

#### Dữ liệu Đầu ra

**Success (200 OK):**

```json
{
  "success": true,
  "message": "Email đã được xác thực thành công. Bạn có thể đăng nhập ngay bây giờ."
}
```

#### Xử lý Ngoại lệ

| Tình huống         | HTTP Code | Error Code      | Xử lý                              |
| ------------------ | --------- | --------------- | ---------------------------------- |
| Token hết hạn      | 400       | `TOKEN_EXPIRED` | Cho phép resend verification email |
| Token không hợp lệ | 400       | `INVALID_TOKEN` | Trả lỗi                            |
| Email đã verified  | 200       | N/A             | Trả success (idempotent)           |

#### API Endpoint

```
GET /auth/verify-email?token=<jwt_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-003: Đăng nhập**

#### Mã Chức năng

`FR-003`

#### Mô tả

Xác thực giáo viên và cấp access token + refresh token.

#### Tác nhân

- **Giáo viên** (đã có tài khoản)

#### Điều kiện Tiên quyết

- Giáo viên đã hoàn thành FR-001 (Đăng ký)
- `TEACHERS.is_verified = TRUE` (khuyến nghị, nhưng không bắt buộc để cho phép login và resend verification)

#### Luồng Sự kiện Chính

**Bước 1:** Giáo viên truy cập màn hình Đăng nhập

**Bước 2:** Hệ thống hiển thị form:

- `email` (string, required)
- `password` (string, required)

**Bước 3:** Giáo viên nhập và submit

**Bước 4:** Hệ thống kiểm tra rate limit:

- Key: `login_attempts:{email}`
- Limit: 5 lần thất bại / 15 phút
- Nếu vượt: trả lỗi `TOO_MANY_ATTEMPTS`

**Bước 5:** Hệ thống query bảng `TEACHERS`:

```sql
SELECT * FROM teachers
WHERE email = :email
  AND is_active = TRUE
  AND deleted_at IS NULL;
```

**Bước 6:** Hệ thống verify password:

- So sánh bcrypt hash của input với `TEACHERS.password_hash`
- Nếu sai: increment rate limit counter, trả lỗi `INVALID_CREDENTIALS`

**Bước 7:** Hệ thống tạo tokens:

- **Access Token** (JWT): payload = `{teacher_id, email, role: 'teacher'}`, exp = 1 hour
- **Refresh Token** (JWT): payload = `{teacher_id, type: 'refresh'}`, exp = 7 days

**Bước 8:** Hệ thống cập nhật `TEACHERS.last_login_at`:

```sql
UPDATE teachers
SET last_login_at = NOW()
WHERE id = :teacher_id;
```

**Bước 9:** Hệ thống trả về response

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD               | Mô tả                                                        |
| ------------ | ------------------------ | ------------------------------------------------------------ |
| **RB-003-1** | `TEACHERS.is_active`     | Chỉ cho phép đăng nhập nếu `is_active = TRUE`                |
| **RB-003-2** | `TEACHERS.last_login_at` | Phải cập nhật timestamp mỗi lần đăng nhập thành công         |
| **RB-003-3** | Rate Limiting            | 5 lần thất bại / 15 phút; 10 lần thất bại / 1 giờ → tạm khóa |
| **RB-003-4** | `TEACHERS.password_hash` | Verify bằng bcrypt.compare()                                 |

#### Dữ liệu Đầu vào

```typescript
interface LoginInput {
  email: string;
  password: string;
}
```

#### Dữ liệu Đầu ra

**Success (200 OK):**

```json
{
  "success": true,
  "access_token": "eyJhbGc...",
  "refresh_token": "eyJhbGc...",
  "expires_in": 3600,
  "user": {
    "id": "uuid",
    "email": "...",
    "first_name": "...",
    "last_name": "...",
    "is_verified": true,
    "avatar_url": "..."
  }
}
```

#### API Endpoint

```
POST /auth/login
Content-Type: application/json
```

#### Ưu tiên

**Must Have**

---

### **FR-004: Refresh Token**

#### Mã Chức năng

`FR-004`

#### Mô tả

Làm mới access token khi hết hạn mà không cần đăng nhập lại.

#### Tác nhân

- **Client App** (tự động)

#### Điều kiện Tiên quyết

- Giáo viên đã đăng nhập (có refresh token từ FR-003)
- Refresh token chưa hết hạn (7 ngày)

#### Luồng Sự kiện Chính

**Bước 1:** Khi app start hoặc khi có kết nối internet, client kiểm tra cache version

**Bước 2:** Client gọi API với refresh token

**Bước 3:** Server validate refresh token và trả về access token mới

#### API Endpoint

```
POST /auth/refresh
Content-Type: application/json
```

#### Ưu tiên

**Must Have**

---

### **FR-005: Đăng xuất**

#### Mã Chức năng

`FR-005`

#### Mô tả

Vô hiệu hóa tokens và xóa session.

#### API Endpoint

```
POST /auth/logout
Authorization: Bearer <access_token>
```

#### Ưu tiên

**Must Have**

---

### **FR-006: Đăng nhập bằng Biometric (Face ID / Touch ID / Fingerprint)**

#### Mã Chức năng

`FR-006`

#### Mô tả

Cho phép giáo viên đăng nhập nhanh bằng sinh trắc học sau lần đăng nhập email/password đầu tiên.

#### Ràng buộc Nghiệp vụ

| Ràng buộc    | Ánh xạ ERD      | Mô tả                                                              |
| ------------ | --------------- | ------------------------------------------------------------------ |
| **RB-006-1** | `USER_SETTINGS` | Lưu preference `biometric_enabled` với key = 'biometric_enabled'   |
| **RB-006-2** | Security        | Refresh token phải lưu trong encrypted storage (Keychain/Keystore) |

#### Ưu tiên

**Could Have**

---

```

**✅ PHẦN 2 XONG - Section 2.1 Authentication hoàn tất**

Tiếp tục với **PHẦN 3/10: STUDENT MANAGEMENT (FR-007 đến FR-012)**?
```
