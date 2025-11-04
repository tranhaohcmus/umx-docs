# Database Sample Data - Educare Connect

Tài liệu này minh họa **dữ liệu mẫu** cho tất cả các bảng trong hệ thống, giúp dễ hình dung cấu trúc và mối quan hệ giữa các bảng.

---

## 📋 Mục Lục

1. [TEACHERS](#1-teachers---giáo-viên)
2. [STUDENTS](#2-students---học-sinh)
3. [SESSIONS](#3-sessions---buổi-can-thiệp)
4. [SESSION_CONTENTS](#4-session_contents---nội-dung-buổi-học)
5. [CONTENT_GOALS](#5-content_goals---mục-tiêu-cụ-thể)
6. [SESSION_LOGS](#6-session_logs---nhật-ký-buổi-học)
7. [LOG_MEDIA_ATTACHMENTS](#7-log_media_attachments---file-đính-kèm)
8. [GOAL_EVALUATIONS](#8-goal_evaluations---đánh-giá-mục-tiêu)
9. [BEHAVIOR_GROUPS](#9-behavior_groups---nhóm-hành-vi)
10. [BEHAVIOR_LIBRARY](#10-behavior_library---thư-viện-hành-vi)
11. [BEHAVIOR_INCIDENTS](#11-behavior_incidents---sự-cố-hành-vi)
12. [TEACHER_FAVORITES](#12-teacher_favorites---hành-vi-yêu-thích)
13. [CONTENT_LIBRARY](#13-content_library---thư-viện-hoạt-động)
14. [CONTENT_LIBRARY_RATINGS](#14-content_library_ratings---đánh-giá-hoạt-động)
15. [USER_SETTINGS](#15-user_settings---cài-đặt-người-dùng)
16. [BACKUP_HISTORY](#16-backup_history---lịch-sử-backup)
17. [AI_PROCESSING](#17-ai_processing---xử-lý-ai)

---

## 1. TEACHERS - Giáo viên

**Mô tả:** Thông tin tài khoản giáo viên

| id                                     | email               | first_name | last_name  | phone      | school                     | is_verified | is_active | timezone         | language | created_at          |
| -------------------------------------- | ------------------- | ---------- | ---------- | ---------- | -------------------------- | ----------- | --------- | ---------------- | -------- | ------------------- |
| `550e8400-e29b-41d4-a716-446655440001` | comai@educare.vn    | Mai        | Nguyễn Thị | 0912345678 | Trường Đặc Biệt Ánh Dương  | true        | true      | Asia/Ho_Chi_Minh | vi       | 2024-01-15 08:30:00 |
| `550e8400-e29b-41d4-a716-446655440002` | thayminh@educare.vn | Minh       | Trần Văn   | 0987654321 | Trung Tâm Tâm Lý Hạnh Phúc | true        | true      | Asia/Ho_Chi_Minh | vi       | 2024-02-20 09:15:00 |
| `550e8400-e29b-41d4-a716-446655440003` | mshuong@educare.vn  | Hương      | Lê Thị     | 0901234567 | Trường Mầm Non Họa Mi      | true        | true      | Asia/Ho_Chi_Minh | vi       | 2024-03-10 10:00:00 |

**Computed Fields:**

- `full_name` = `first_name + ' ' + last_name` → "Nguyễn Thị Mai", "Trần Văn Minh"

---

## 2. STUDENTS - Học sinh

**Mô tả:** Hồ sơ học sinh/trẻ em cần can thiệp

| id                                     | teacher_id  | first_name | last_name  | nickname | date_of_birth | gender | status | diagnosis                   | parent_name    | parent_phone |
| -------------------------------------- | ----------- | ---------- | ---------- | -------- | ------------- | ------ | ------ | --------------------------- | -------------- | ------------ |
| `660e8400-e29b-41d4-a716-446655440001` | `...440001` | An         | Nguyễn Văn | BA       | 2018-05-12    | male   | active | Rối loạn phổ tự kỷ mức độ 2 | Nguyễn Thị Lan | 0923456789   |
| `660e8400-e29b-41d4-a716-446655440002` | `...440001` | Linh       | Trần Thị   | BL       | 2019-08-20    | female | active | Chậm phát triển ngôn ngữ    | Trần Văn Bình  | 0934567890   |
| `660e8400-e29b-41d4-a716-446655440003` | `...440002` | Khôi       | Lê Minh    | BK       | 2017-11-03    | male   | active | ADHD                        | Lê Thị Hoa     | 0945678901   |
| `660e8400-e29b-41d4-a716-446655440004` | `...440002` | My         | Phạm Thu   | BM       | 2020-02-15    | female | paused | Rối loạn cảm giác           | Phạm Văn Nam   | 0956789012   |

**Computed Fields:**

- `full_name` → "Nguyễn Văn An", "Trần Thị Linh"
- `age` → 7, 6, 8, 5 (tính từ `date_of_birth`)

**Notes:**

- `nickname` phải unique trong mỗi teacher (BA, BL, BK, BM...)
- `status`: active | paused | archived
- `deleted_at` NULL = còn active

---

## 3. SESSIONS - Buổi can thiệp

**Mô tả:** Các buổi học/can thiệp đã lên kế hoạch

| id                                     | student_id      | session_date | start_time | end_time | duration_minutes | status    | has_evaluation | created_by        | notes                          |
| -------------------------------------- | --------------- | ------------ | ---------- | -------- | ---------------- | --------- | -------------- | ----------------- | ------------------------------ |
| `770e8400-e29b-41d4-a716-446655440001` | `...BA(440001)` | 2024-11-04   | 08:00:00   | 09:30:00 | 90               | completed | true           | `...Mai(440001)`  | Buổi học tốt, BA tập trung cao |
| `770e8400-e29b-41d4-a716-446655440002` | `...BL(440002)` | 2024-11-04   | 10:00:00   | 11:00:00 | 60               | completed | true           | `...Mai(440001)`  | BL có tiến bộ về giao tiếp     |
| `770e8400-e29b-41d4-a716-446655440003` | `...BK(440003)` | 2024-11-04   | 14:00:00   | 15:30:00 | 90               | completed | false          | `...Minh(440002)` | Buổi đầu tuần, BK hơi mệt      |
| `770e8400-e29b-41d4-a716-446655440004` | `...BA(440001)` | 2024-11-05   | 08:00:00   | 09:30:00 | 90               | pending   | false          | `...Mai(440001)`  | Buổi học ngày mai              |

**Business Rules:**

- `duration_minutes` = tự động tính từ `start_time` và `end_time`
- `has_evaluation` = true khi có record trong `SESSION_LOGS`
- `status`: pending | completed | cancelled

---

## 4. SESSION_CONTENTS - Nội dung buổi học

**Mô tả:** Các hoạt động/nội dung trong mỗi buổi học

| id                                     | session_id    | content_library_id | domain    | activity_name               | content_order | estimated_duration |
| -------------------------------------- | ------------- | ------------------ | --------- | --------------------------- | ------------- | ------------------ |
| `880e8400-e29b-41d4-a716-446655440001` | `...Session1` | `...Library1`      | hành vi   | Tập ngồi yên 5 phút         | 1             | 15                 |
| `880e8400-e29b-41d4-a716-446655440002` | `...Session1` | `...Library2`      | giao tiếp | Bắt chước âm thanh động vật | 2             | 20                 |
| `880e8400-e29b-41d4-a716-446655440003` | `...Session1` | NULL               | học thuật | Ghép hình khối 3D           | 3             | 25                 |
| `880e8400-e29b-41d4-a716-446655440004` | `...Session1` | NULL               | vận động  | Chơi bóng rổ mini           | 4             | 30                 |

**Domains:**

- hành vi, học thuật, tự phục vụ, giao tiếp, vận động, xã hội, khác

**Notes:**

- `content_library_id` có thể NULL nếu là custom activity
- `content_order` định nghĩa thứ tự hoạt động

---

## 5. CONTENT_GOALS - Mục tiêu cụ thể

**Mô tả:** Mục tiêu cần đạt cho mỗi hoạt động

| id                                     | session_content_id | goal_description             | target_metric            |
| -------------------------------------- | ------------------ | ---------------------------- | ------------------------ |
| `990e8400-e29b-41d4-a716-446655440001` | `...Content1`      | Ngồi yên không rời ghế       | 5 phút liên tục          |
| `990e8400-e29b-41d4-a716-446655440002` | `...Content2`      | Bắt chước đúng 3/5 âm thanh  | 60% accuracy             |
| `990e8400-e29b-41d4-a716-446655440003` | `...Content2`      | Tự phát âm khi thấy hình ảnh | 2/5 hình đúng            |
| `990e8400-e29b-41d4-a716-446655440004` | `...Content3`      | Ghép đúng 5 khối hình        | Hoàn thành trong 10 phút |

**Notes:**

- Mỗi `session_content` có thể có nhiều goals
- `target_metric` miêu tả tiêu chí đánh giá

---

## 6. SESSION_LOGS - Nhật ký buổi học

**Mô tả:** Ghi chú chi tiết sau mỗi buổi học (1-1 với SESSIONS)

| id                                     | session_id    | actual_start_time   | actual_end_time     | energy_level | overall_rating | general_notes                                                                                                                      | recorded_by |
| -------------------------------------- | ------------- | ------------------- | ------------------- | ------------ | -------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `aa0e8400-e29b-41d4-a716-446655440001` | `...Session1` | 2024-11-04 08:05:00 | 2024-11-04 09:28:00 | 4            | 5              | BA hôm nay rất tập trung, hoàn thành tốt tất cả mục tiêu. Có 1 lần chống đối nhẹ khi chuyển hoạt động nhưng nhanh chóng bình tĩnh. | `...Mai`    |
| `aa0e8400-e29b-41d4-a716-446655440002` | `...Session2` | 2024-11-04 10:02:00 | 2024-11-04 10:58:00 | 3            | 4              | BL có tiến bộ rõ rệt về giao tiếp mắt. Tự phát âm 3/5 từ mới. Cần tiếp tục củng cố.                                                | `...Mai`    |
| `aa0e8400-e29b-41d4-a716-446655440003` | `...Session3` | 2024-11-04 14:03:00 | 2024-11-04 15:25:00 | 2            | 3              | BK hơi mệt do học buổi sáng ở trường. Cần lưu ý điều chỉnh lịch. Có 2 lần tăng động.                                               | `...Minh`   |

**Rating Scale:**

- `energy_level`: 1-5 (1=rất mệt, 5=rất tỉnh táo)
- `overall_rating`: 1-5 (1=kém, 5=xuất sắc)

**Relationship:**

- Khi INSERT vào bảng này → trigger tự động set `SESSIONS.has_evaluation = true`

---

## 7. LOG_MEDIA_ATTACHMENTS - File đính kèm

**Mô tả:** Ảnh, video, audio đính kèm nhật ký

| id                | session_log_id | media_type | file_url                              | file_size_bytes | uploaded_by | caption                             |
| ----------------- | -------------- | ---------- | ------------------------------------- | --------------- | ----------- | ----------------------------------- |
| `bb0e8400-...001` | `...Log1`      | image      | /storage/2024-11/ba-session-1-1.jpg   | 245800          | `...Mai`    | BA đang tập ghép hình               |
| `bb0e8400-...002` | `...Log1`      | video      | /storage/2024-11/ba-session-1-2.mp4   | 8950000         | `...Mai`    | Video BA phản ứng tốt với hoạt động |
| `bb0e8400-...003` | `...Log2`      | image      | /storage/2024-11/bl-communication.jpg | 189200          | `...Mai`    | BL tự phát âm "mèo"                 |
| `bb0e8400-...004` | `...Log3`      | audio      | /storage/2024-11/bk-recording.m4a     | 1250000         | `...Minh`   | Ghi âm BK đọc số 1-10               |

**Media Types:**

- image, video, audio, document

---

## 8. GOAL_EVALUATIONS - Đánh giá mục tiêu

**Mô tả:** Kết quả đạt được của từng mục tiêu

| id                | session_log_id | content_goal_id | achievement_level | notes                                |
| ----------------- | -------------- | --------------- | ----------------- | ------------------------------------ |
| `cc0e8400-...001` | `...Log1`      | `...Goal1`      | 100               | Hoàn thành xuất sắc, ngồi yên 7 phút |
| `cc0e8400-...002` | `...Log1`      | `...Goal2`      | 80                | Bắt chước đúng 4/5 âm thanh          |
| `cc0e8400-...003` | `...Log1`      | `...Goal3`      | 60                | Tự phát âm 3/5 hình, cần luyện thêm  |
| `cc0e8400-...004` | `...Log2`      | `...Goal5`      | 100               | BL hoàn thành vượt mục tiêu          |

**Achievement Level:**

- 0-100% (phần trăm hoàn thành mục tiêu)

---

## 9. BEHAVIOR_GROUPS - Nhóm hành vi

**Mô tả:** 3 nhóm hành vi chính theo phân loại khoa học

| id                | group_id | group_name_vn          | group_name_en            | description_vn                                                   | sort_order |
| ----------------- | -------- | ---------------------- | ------------------------ | ---------------------------------------------------------------- | ---------- |
| `dd0e8400-...001` | 1        | CHỐNG ĐỐI & BƯỚNG BỈNH | DEFIANCE & NONCOMPLIANCE | Nhóm hành vi thách thức, từ chối, chống đối yêu cầu từ người lớn | 1          |
| `dd0e8400-...002` | 2        | HÀNH VI GÂY HẤN        | AGGRESSION               | Nhóm hành vi tấn công, đánh đập, cắn, ném đồ vật gây hại         | 2          |
| `dd0e8400-...003` | 3        | VẤN ĐỀ VỀ GIÁC QUAN    | SENSORY ISSUES           | Nhóm hành vi liên quan rối loạn xử lý thông tin cảm giác         | 3          |

---

## 10. BEHAVIOR_LIBRARY - Thư viện hành vi

**Mô tả:** 127+ hành vi cụ thể với evidence-based strategies

### Ví dụ từ Nhóm 1 - CHỐNG ĐỐI

| id                | behavior_group_id | behavior_id | name_vn         | name_en              | keywords_vn                            | keywords_en                               |
| ----------------- | ----------------- | ----------- | --------------- | -------------------- | -------------------------------------- | ----------------------------------------- |
| `ee0e8400-...001` | `...Group1`       | 1.1         | Từ chối yêu cầu | Refusal to Comply    | ["từ chối", "không chịu", "nói không"] | ["refusal", "noncompliance", "saying no"] |
| `ee0e8400-...002` | `...Group1`       | 1.2         | La hét phản đối | Screaming in Protest | ["la hét", "kêu to", "phản đối"]       | ["screaming", "yelling", "protesting"]    |

**Explanation (JSONB):**

```json
{
  "manifestation": "Trẻ nói 'không', lắc đầu, quay mặt đi khi được yêu cầu làm việc gì",
  "why_happens": "Trẻ muốn tránh nhiệm vụ khó/chán, hoặc muốn làm việc khác hấp dẫn hơn",
  "function": "Escape/Avoidance (thoát khỏi yêu cầu)"
}
```

**Solutions (JSONB):**

```json
{
  "prevention": [
    "Cho trẻ lựa chọn (choice-making)",
    "Chia nhỏ nhiệm vụ thành bước dễ hơn",
    "Khen ngợi khi trẻ làm theo"
  ],
  "intervention": [
    "Planned ignoring: bỏ qua hành vi từ chối nhẹ",
    "Wait time: đợi 5-10 giây sau yêu cầu",
    "Redirect: chuyển hướng sang phần dễ hơn trước"
  ],
  "reinforcement": [
    "Token economy: tích điểm khi làm theo",
    "Immediate praise khi trẻ bắt đầu comply"
  ]
}
```

**Sources (JSONB):**

```json
[
  {
    "title": "Cooper et al. (2020) - Applied Behavior Analysis",
    "type": "textbook",
    "citation": "Cooper, J. O., Heron, T. E., & Heward, W. L. (2020). Applied Behavior Analysis (3rd ed.)"
  },
  {
    "title": "AAP Clinical Practice Guideline (2020)",
    "type": "research",
    "url": "https://publications.aap.org/pediatrics/article/145/1/e20193447"
  }
]
```

### Ví dụ từ Nhóm 2 - GÂY HẤN

| behavior_id | name_vn         | severity_indicators                                   |
| ----------- | --------------- | ----------------------------------------------------- |
| 2.1         | Đánh người khác | ["tần suất cao", "gây tổn thương", "không báo trước"] |
| 2.2         | Cắn             | ["để lại vết", "nhiều lần/ngày", "vô cớ"]             |
| 2.3         | Ném đồ vật      | ["đồ vật nặng", "hướng vào người", "phá hủy tài sản"] |

---

## 11. BEHAVIOR_INCIDENTS - Sự cố hành vi

**Mô tả:** Ghi nhận các lần xảy ra hành vi trong buổi học

| id                | session_log_id | behavior_library_id | incident_number | occurred_at         | duration_minutes | severity | antecedent                            | consequence                                            | notes                            |
| ----------------- | -------------- | ------------------- | --------------- | ------------------- | ---------------- | -------- | ------------------------------------- | ------------------------------------------------------ | -------------------------------- |
| `ff0e8400-...001` | `...Log1`      | `...Behavior1.1`    | 1               | 2024-11-04 08:25:00 | 2                | low      | Chuyển từ hoạt động chơi sang học bài | Đã bình tĩnh sau khi cho lựa chọn ghép hình hay tô màu | BA từ chối nhẹ, sau đó chấp nhận |
| `ff0e8400-...002` | `...Log3`      | `...Behavior2.5`    | 1               | 2024-11-04 14:15:00 | 5                | medium   | BK mệt, không muốn làm bài tập        | Cho nghỉ 3 phút, sau đó tiếp tục                       | Tăng động, đứng lên đi lại       |
| `ff0e8400-...003` | `...Log3`      | `...Behavior2.5`    | 2               | 2024-11-04 14:45:00 | 3                | medium   | Yêu cầu làm bài khó                   | Giảm độ khó, khen ngợi khi làm                         | Lần thứ 2 trong buổi             |

**ABC Model:**

- `antecedent`: Điều gì xảy ra TRƯỚC hành vi
- `behavior`: Hành vi cụ thể (từ BEHAVIOR_LIBRARY)
- `consequence`: Điều gì xảy ra SAU hành vi

**Severity:** low | medium | high

---

## 12. TEACHER_FAVORITES - Hành vi yêu thích

**Mô tả:** Các hành vi giáo viên thường gặp, lưu để tra cứu nhanh

| id                | teacher_id | behavior_library_id | added_at   |
| ----------------- | ---------- | ------------------- | ---------- |
| `110e8400-...001` | `...Mai`   | `...Behavior1.1`    | 2024-10-15 |
| `110e8400-...002` | `...Mai`   | `...Behavior1.2`    | 2024-10-15 |
| `110e8400-...003` | `...Mai`   | `...Behavior2.1`    | 2024-10-20 |
| `110e8400-...004` | `...Minh`  | `...Behavior3.1`    | 2024-10-18 |
| `110e8400-...005` | `...Minh`  | `...Behavior2.5`    | 2024-10-22 |

**Use Case:**

- Quick access trong màn hình logging
- Thống kê hành vi thường gặp của từng giáo viên

---

## 13. CONTENT_LIBRARY - Thư viện hoạt động

**Mô tả:** Mẫu hoạt động có sẵn, do hệ thống hoặc giáo viên tạo

| id                | title                          | domain    | description                                                 | is_template | is_public | created_by | tags                                       | default_goals                          |
| ----------------- | ------------------------------ | --------- | ----------------------------------------------------------- | ----------- | --------- | ---------- | ------------------------------------------ | -------------------------------------- |
| `220e8400-...001` | Tập ngồi yên                   | hành vi   | Rèn luyện khả năng tự kiểm soát, ngồi yên trên ghế          | true        | true      | NULL       | ["tự kiểm soát", "ngồi yên", "ABA basic"]  | ["Ngồi yên 3 phút", "Ngồi yên 5 phút"] |
| `220e8400-...002` | Bắt chước âm thanh             | giao tiếp | Phát triển kỹ năng bắt chước âm thanh, tiền đề cho ngôn ngữ | true        | true      | NULL       | ["ngôn ngữ", "bắt chước", "communication"] | ["Bắt chước 3/5 âm thanh"]             |
| `220e8400-...003` | Hoạt động ghép hình của cô Mai | học thuật | Custom activity của tôi cho nhóm lớp                        | false       | false     | `...Mai`   | ["ghép hình", "tư duy logic"]              | ["Ghép đúng 5 khối"]                   |

**Template vs Custom:**

- `is_template=true, created_by=NULL`: System templates (127 mẫu)
- `is_template=false, created_by=UUID`: Teacher's custom content
- `is_public=true`: Chia sẻ cho giáo viên khác

**Tags (JSONB Array):**

```json
["tự kiểm soát", "ngồi yên", "ABA basic"]
```

**Default Goals (JSONB Array):**

```json
["Ngồi yên 3 phút", "Ngồi yên 5 phút", "Ngồi yên 10 phút"]
```

---

## 14. CONTENT_LIBRARY_RATINGS - Đánh giá hoạt động

**Mô tả:** Giáo viên đánh giá chất lượng hoạt động

| id                | content_library_id | teacher_id | rating | review                                             | created_at |
| ----------------- | ------------------ | ---------- | ------ | -------------------------------------------------- | ---------- |
| `330e8400-...001` | `...Library1`      | `...Mai`   | 5      | Hoạt động rất hiệu quả, các con đều thích          | 2024-10-20 |
| `330e8400-...002` | `...Library1`      | `...Minh`  | 4      | Tốt nhưng cần điều chỉnh thời gian cho trẻ nhỏ hơn | 2024-10-25 |
| `330e8400-...003` | `...Library2`      | `...Mai`   | 5      | Các con tiến bộ rõ rệt sau 3 tuần                  | 2024-11-01 |

**Rating:** 1-5 stars

---

## 15. USER_SETTINGS - Cài đặt người dùng

**Mô tả:** Key-value settings cho mỗi teacher

| id                | teacher_id | key                      | value | updated_at |
| ----------------- | ---------- | ------------------------ | ----- | ---------- |
| `440e8400-...001` | `...Mai`   | theme                    | dark  | 2024-10-15 |
| `440e8400-...002` | `...Mai`   | notifications_enabled    | true  | 2024-10-15 |
| `440e8400-...003` | `...Mai`   | default_session_duration | 90    | 2024-10-20 |
| `440e8400-...004` | `...Minh`  | theme                    | light | 2024-10-18 |
| `440e8400-...005` | `...Minh`  | auto_backup              | true  | 2024-10-18 |

**Common Settings:**

- `theme`: light | dark
- `notifications_enabled`: true | false
- `default_session_duration`: minutes
- `auto_backup`: true | false
- `language`: vi | en

---

## 16. BACKUP_HISTORY - Lịch sử backup

**Mô tả:** Theo dõi các lần backup dữ liệu

| id                | teacher_id | backup_type | file_size_bytes | file_path                               | status    | created_at          | completed_at        |
| ----------------- | ---------- | ----------- | --------------- | --------------------------------------- | --------- | ------------------- | ------------------- |
| `550e8400-...001` | `...Mai`   | full        | 15680000        | /backups/2024-11/mai-full-20241101.zip  | completed | 2024-11-01 20:00:00 | 2024-11-01 20:02:15 |
| `550e8400-...002` | `...Mai`   | incremental | 2340000         | /backups/2024-11/mai-inc-20241104.zip   | completed | 2024-11-04 20:00:00 | 2024-11-04 20:00:45 |
| `550e8400-...003` | `...Minh`  | full        | 8920000         | /backups/2024-11/minh-full-20241103.zip | completed | 2024-11-03 19:00:00 | 2024-11-03 19:01:30 |

**Backup Types:**

- `full`: Toàn bộ dữ liệu
- `incremental`: Chỉ dữ liệu thay đổi

**Status:** in_progress | completed | failed

---

## 17. AI_PROCESSING - Xử lý AI

**Mô tả:** Lịch sử yêu cầu AI tạo session plan

| id                | teacher_id | student_id | request_type          | input_data | output_data | status    | created_at          | completed_at        |
| ----------------- | ---------- | ---------- | --------------------- | ---------- | ----------- | --------- | ------------------- | ------------------- |
| `660e8400-...001` | `...Mai`   | `...BA`    | generate_session_plan | `{...}`    | `{...}`     | completed | 2024-11-03 15:30:00 | 2024-11-03 15:30:08 |
| `660e8400-...002` | `...Minh`  | `...BK`    | generate_session_plan | `{...}`    | `{...}`     | completed | 2024-11-04 09:15:00 | 2024-11-04 09:15:12 |
| `660e8400-...003` | `...Mai`   | `...BL`    | generate_session_plan | `{...}`    | NULL        | failed    | 2024-11-04 10:00:00 | 2024-11-04 10:00:03 |

**Input Data Example (JSONB):**

```json
{
  "student_info": {
    "name": "Nguyễn Văn An",
    "age": 7,
    "diagnosis": "Autism Level 2",
    "current_focus_areas": ["communication", "behavior", "social"]
  },
  "session_preferences": {
    "duration": 90,
    "domains": ["hành vi", "giao tiếp", "học thuật"],
    "difficulty_level": "medium"
  },
  "recent_progress": {
    "strengths": ["Tập trung tốt", "Thích hoạt động ghép hình"],
    "challenges": ["Từ chối khi chuyển hoạt động", "Khó giao tiếp mắt"]
  }
}
```

**Output Data Example (JSONB):**

```json
{
  "generated_plan": {
    "session_duration": 90,
    "activities": [
      {
        "order": 1,
        "activity": "Tập ngồi yên",
        "domain": "hành vi",
        "duration": 15,
        "goals": ["Ngồi yên 5 phút"],
        "materials": ["Ghế nhỏ", "Timer"],
        "rationale": "Rèn tự kiểm soát trước khi bắt đầu học"
      },
      {
        "order": 2,
        "activity": "Bắt chước âm thanh động vật",
        "domain": "giao tiếp",
        "duration": 20,
        "goals": ["Bắt chước 3/5 âm thanh"],
        "materials": ["Flashcards động vật", "Speaker"],
        "rationale": "Tăng khả năng bắt chước - nền tảng cho ngôn ngữ"
      }
    ],
    "ai_notes": "Session được thiết kế dựa trên điểm mạnh của BA về ghép hình, và focus vào challenges về chuyển đổi hoạt động"
  },
  "model": "gpt-4o",
  "processing_time_ms": 8200
}
```

**Request Types:**

- `generate_session_plan`: Tạo kế hoạch buổi học
- `suggest_goals`: Gợi ý mục tiêu
- `behavior_analysis`: Phân tích hành vi

**Status:** pending | processing | completed | failed

---

## 🔗 Mối Quan Hệ Giữa Các Bảng

### Workflow điển hình:

```
1. TEACHERS tạo tài khoản
   ↓
2. Thêm STUDENTS vào hệ thống
   ↓
3. Tạo SESSIONS (thủ công hoặc dùng AI_PROCESSING)
   ↓
4. Thêm SESSION_CONTENTS (từ CONTENT_LIBRARY hoặc custom)
   ↓
5. Định nghĩa CONTENT_GOALS cho mỗi content
   ↓
6. Sau buổi học: Tạo SESSION_LOGS
   ↓
7. Upload LOG_MEDIA_ATTACHMENTS (photos/videos)
   ↓
8. Đánh giá GOAL_EVALUATIONS
   ↓
9. Ghi nhận BEHAVIOR_INCIDENTS (nếu có)
   ↓
10. Phân tích dữ liệu, tạo báo cáo
```

### Các mối quan hệ chính:

- **1 TEACHER → N STUDENTS** (1 giáo viên quản lý nhiều học sinh)
- **1 STUDENT → N SESSIONS** (1 học sinh có nhiều buổi học)
- **1 SESSION → N SESSION_CONTENTS** (1 buổi học có nhiều hoạt động)
- **1 SESSION_CONTENT → N CONTENT_GOALS** (1 hoạt động có nhiều mục tiêu)
- **1 SESSION ↔ 1 SESSION_LOG** (1-1 relationship)
- **1 SESSION_LOG → N LOG_MEDIA_ATTACHMENTS**
- **1 SESSION_LOG → N GOAL_EVALUATIONS**
- **1 SESSION_LOG → N BEHAVIOR_INCIDENTS**
- **1 BEHAVIOR_GROUP → N BEHAVIOR_LIBRARY** (1 nhóm có nhiều hành vi)
- **N TEACHERS ↔ N BEHAVIOR_LIBRARY** (many-to-many qua TEACHER_FAVORITES)

---

## 📊 Thống Kê Ví Dụ

Với dữ liệu mẫu trên:

### Cô Mai có:

- **2 học sinh** (BA, BL) - đang active
- **3 sessions** (2 completed, 1 pending)
- **2 session logs** đã hoàn thành
- **1 behavior incident** ghi nhận (BA từ chối nhẹ)
- **3 favorite behaviors** lưu sẵn
- **1 custom content** trong thư viện
- **Rating trung bình:** 5.0/5.0

### Thầy Minh có:

- **2 học sinh** (BK active, BM paused)
- **1 session** completed
- **1 session log** với 2 behavior incidents
- **2 favorite behaviors**
- **Rating trung bình:** N/A (chưa đủ dữ liệu)

### Học sinh BA:

- **Tổng số buổi:** 2 (1 completed, 1 pending)
- **Tổng thời gian:** 90 phút
- **Rating trung bình:** 5/5
- **Energy level:** 4/5
- **Behavior incidents:** 1 (severity: low)
- **Goal achievement:** 80% trung bình

---

## 💡 Notes về Data Types

### UUID Format:

```
550e8400-e29b-41d4-a716-446655440001
```

### JSONB Examples:

**Keywords Array:**

```json
["từ chối", "không chịu", "nói không"]
```

**Explanation Object:**

```json
{
  "manifestation": "Mô tả biểu hiện",
  "why_happens": "Nguyên nhân",
  "function": "Chức năng hành vi"
}
```

**Solutions Object:**

```json
{
  "prevention": ["Chiến lược phòng ngừa 1", "..."],
  "intervention": ["Can thiệp trực tiếp 1", "..."],
  "reinforcement": ["Củng cố tích cực 1", "..."]
}
```

### Timestamp Format:

```
2024-11-04 08:30:00 (YYYY-MM-DD HH:MM:SS)
```

### Date Format:

```
2024-11-04 (YYYY-MM-DD)
```

### Time Format:

```
08:30:00 (HH:MM:SS)
```

---

## 🎯 Use Cases Phổ Biến

### 1. Lấy tất cả sessions của 1 học sinh:

```sql
SELECT * FROM SESSIONS
WHERE student_id = '660e8400-e29b-41d4-a716-446655440001'
AND deleted_at IS NULL
ORDER BY session_date DESC;
```

### 2. Tìm behavior incidents theo severity:

```sql
SELECT bi.*, bl.name_vn, s.session_date
FROM BEHAVIOR_INCIDENTS bi
JOIN BEHAVIOR_LIBRARY bl ON bi.behavior_library_id = bl.id
JOIN SESSION_LOGS sl ON bi.session_log_id = sl.id
JOIN SESSIONS s ON sl.session_id = s.id
WHERE bi.severity = 'high'
ORDER BY bi.occurred_at DESC;
```

### 3. Top rated content library:

```sql
SELECT
    cl.title,
    cl.domain,
    AVG(clr.rating) as avg_rating,
    COUNT(clr.id) as rating_count
FROM CONTENT_LIBRARY cl
JOIN CONTENT_LIBRARY_RATINGS clr ON cl.id = clr.content_library_id
WHERE cl.deleted_at IS NULL
GROUP BY cl.id, cl.title, cl.domain
HAVING COUNT(clr.id) >= 3
ORDER BY avg_rating DESC, rating_count DESC;
```

### 4. Student progress summary:

```sql
SELECT
    s.first_name || ' ' || s.last_name as student_name,
    COUNT(se.id) as total_sessions,
    AVG(sl.overall_rating) as avg_rating,
    AVG(sl.energy_level) as avg_energy,
    COUNT(bi.id) as total_incidents
FROM STUDENTS s
LEFT JOIN SESSIONS se ON s.id = se.student_id AND se.deleted_at IS NULL
LEFT JOIN SESSION_LOGS sl ON se.id = sl.session_id
LEFT JOIN BEHAVIOR_INCIDENTS bi ON sl.id = bi.session_log_id
WHERE s.id = '660e8400-e29b-41d4-a716-446655440001'
GROUP BY s.id, s.first_name, s.last_name;
```

---

**Ghi chú:** Tất cả UUID trong tài liệu này đều được rút gọn (ví dụ: `...440001` thay vì full UUID) để dễ đọc. Trong thực tế, cần sử dụng full UUID format.
