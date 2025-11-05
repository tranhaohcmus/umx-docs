Tôi sẽ fix lại file DATABASE_SAMPLE_DATA.md cho đồng bộ với ERD mới:

# 📝 DATABASE_SAMPLE_DATA.md - PHIÊN BẢN SỬA LẠI

# Database Sample Data - Educare Connect

Tài liệu này minh họa **dữ liệu mẫu** cho tất cả các bảng trong hệ thống, giúp dễ hình dung cấu trúc và mối quan hệ giữa các bảng.

**Version:** 2.0  
**Last Updated:** 2025-11-05  
**Status:** ✅ Aligned with ERD v2.0

---

## 📋 Mục Lục

1. [TEACHERS](#1-teachers---giáo-viên)
2. [STUDENTS](#2-students---học-sinh)
3. [SESSIONS](#3-sessions---buổi-can-thiệp)
4. [SESSION_CONTENTS](#4-session_contents---nội-dung-buổi-học)
5. [SESSION_CONTENT_GOALS](#5-session_content_goals---mục-tiêu-cụ-thể)
6. [SESSION_LOGS](#6-session_logs---nhật-ký-buổi-học)
7. [MEDIA_ATTACHMENTS](#7-media_attachments---file-đính-kèm)
8. [GOAL_EVALUATIONS](#8-goal_evaluations---đánh-giá-mục-tiêu)
9. [BEHAVIOR_GROUPS](#9-behavior_groups---nhóm-hành-vi)
10. [BEHAVIOR_LIBRARY](#10-behavior_library---thư-viện-hành-vi)
11. [BEHAVIOR_INCIDENTS](#11-behavior_incidents---sự-cố-hành-vi)
12. [TEACHER_FAVORITES](#12-teacher_favorites---hành-vi-yêu-thích)
13. [CONTENT_LIBRARY](#13-content_library---thư-viện-template)
14. [TEMPLATE_RATINGS](#14-template_ratings---đánh-giá-template)
15. [AI_PROCESSING](#15-ai_processing---xử-lý-ai)
16. [REPORTS](#16-reports---báo-cáo)
17. [BACKUPS](#17-backups---sao-lưu)

---

## 1. TEACHERS - Giáo viên

**Mô tả:** Thông tin tài khoản giáo viên

| id | email | first_name | last_name | phone | school | password_hash | is_verified | is_active | timezone | language | created_at | deleted_at |
|----|-------|------------|-----------|-------|--------|---------------|-------------|-----------|----------|----------|------------|------------|
| `550e8400-e29b-41d4-a716-446655440001` | comai@educare.vn | Mai | Nguyễn Thị | 0912345678 | Trường Đặc Biệt Ánh Dương | $2b$12$... | true | true | Asia/Ho_Chi_Minh | vi | 2024-10-01 08:00:00 | NULL |
| `550e8400-e29b-41d4-a716-446655440002` | thayminh@educare.vn | Minh | Trần Văn | 0987654321 | Trung Tâm Tâm Lý Hạnh Phúc | $2b$12$... | true | true | Asia/Ho_Chi_Minh | vi | 2024-10-01 09:00:00 | NULL |
| `550e8400-e29b-41d4-a716-446655440003` | mshuong@educare.vn | Hương | Lê Thị | 0901234567 | Trường Mầm Non Họa Mi | $2b$12$... | true | true | Asia/Ho_Chi_Minh | vi | 2024-10-02 10:00:00 | NULL |

**Computed Fields:**
- `full_name` = `first_name + ' ' + last_name` → "Nguyễn Thị Mai", "Trần Văn Minh", "Lê Thị Hương"

**Notes:**
- `password_hash` là bcrypt hash, không lưu plain text
- `deleted_at` NULL = tài khoản còn hoạt động
- `last_login_at` được update mỗi lần login

---

## 2. STUDENTS - Học sinh

**Mô tả:** Hồ sơ học sinh/trẻ em cần can thiệp

| id | teacher_id | first_name | last_name | nickname | date_of_birth | gender | status | diagnosis | parent_name | parent_phone | created_at | deleted_at |
|----|------------|------------|-----------|----------|---------------|--------|--------|-----------|-------------|--------------|------------|------------|
| `660e8400-e29b-41d4-a716-446655440001` | `...440001` | Văn An | Nguyễn | An | 2018-05-12 | male | active | Rối loạn phổ tự kỷ mức độ 2 | Nguyễn Thị Lan | 0923456789 | 2024-10-05 | NULL |
| `660e8400-e29b-41d4-a716-446655440002` | `...440001` | Thị Linh | Trần | Linh | 2019-08-20 | female | active | Chậm phát triển ngôn ngữ | Trần Văn Bình | 0934567890 | 2024-10-06 | NULL |
| `660e8400-e29b-41d4-a716-446655440003` | `...440002` | Minh Khôi | Lê | Khôi | 2017-11-03 | male | active | ADHD | Lê Thị Hoa | 0945678901 | 2024-10-07 | NULL |
| `660e8400-e29b-41d4-a716-446655440004` | `...440002` | Thu My | Phạm | My | 2020-02-15 | female | paused | Rối loạn cảm giác | Phạm Văn Nam | 0956789012 | 2024-10-08 | NULL |

**Computed Fields:**
- `full_name` → "Nguyễn Văn An", "Trần Thị Linh", "Lê Minh Khôi", "Phạm Thu My"
- `age` → 7, 6, 8, 5 (tính từ `date_of_birth`)

**Enums:**
- `gender`: male | female | other
- `status`: active | paused | archived

**Notes:**
- Soft delete: `deleted_at` IS NULL để lấy students còn active
- `nickname` là tên gọi tắt trong lớp

---

## 3. SESSIONS - Buổi can thiệp

**Mô tả:** Các buổi học/can thiệp đã lên kế hoạch

| id | student_id | session_date | time_slot | start_time | end_time | duration_minutes | location | status | has_evaluation | creation_method | created_by | created_at | deleted_at |
|----|------------|--------------|-----------|------------|----------|------------------|----------|--------|----------------|-----------------|------------|------------|------------|
| `770e8400-e29b-41d4-a716-446655440001` | `...An(001)` | 2024-11-04 | morning | 08:00:00 | 09:30:00 | 90 | Phòng 101 | completed | true | manual | `...Mai(001)` | 2024-11-01 | NULL |
| `770e8400-e29b-41d4-a716-446655440002` | `...Linh(002)` | 2024-11-04 | morning | 10:00:00 | 11:00:00 | 60 | Phòng 102 | completed | true | manual | `...Mai(001)` | 2024-11-01 | NULL |
| `770e8400-e29b-41d4-a716-446655440003` | `...Khôi(003)` | 2024-11-04 | afternoon | 14:00:00 | 15:30:00 | 90 | Phòng 201 | completed | false | manual | `...Minh(002)` | 2024-11-02 | NULL |
| `770e8400-e29b-41d4-a716-446655440004` | `...An(001)` | 2024-11-05 | morning | 08:00:00 | 09:30:00 | 90 | Phòng 101 | pending | false | manual | `...Mai(001)` | 2024-11-04 | NULL |
| `770e8400-e29b-41d4-a716-446655440005` | `...An(001)` | 2024-11-12 | morning | 09:00:00 | 10:30:00 | 90 | Phòng 101 | pending | false | ai | `...Mai(001)` | 2024-11-05 | NULL |

**Enums:**
- `time_slot`: morning | afternoon | evening
- `status`: pending | completed | cancelled
- `creation_method`: manual | ai

**Business Rules:**
- `duration_minutes` = auto-computed từ (end_time - start_time)
- `has_evaluation` = true khi có SESSION_LOGS record
- Session #5 được tạo bởi AI (creation_method='ai')

---

## 4. SESSION_CONTENTS - Nội dung buổi học

**Mô tả:** Các hoạt động/nội dung trong mỗi buổi học

| id | session_id | content_library_id | title | domain | description | materials_needed | estimated_duration | order_index | created_at |
|----|------------|-------------------|-------|--------|-------------|------------------|-------------------|-------------|------------|
| `880e8400-e29b-41d4-a716-446655440001` | `...Session1` | `...Library001` | Tập ngồi yên 5 phút | social | Rèn kỹ năng tự kiểm soát, ngồi yên trên ghế | Ghế nhỏ, đồng hồ cát | 15 | 1 | 2024-11-01 |
| `880e8400-e29b-41d4-a716-446655440002` | `...Session1` | `...Library002` | Bắt chước âm thanh động vật | language | Phát triển khả năng bắt chước âm thanh | Thẻ hình động vật, loa | 20 | 2 | 2024-11-01 |
| `880e8400-e29b-41d4-a716-446655440003` | `...Session1` | NULL | Ghép hình khối 3D | cognitive | Phát triển tư duy không gian | Bộ khối hình gỗ | 25 | 3 | 2024-11-01 |
| `880e8400-e29b-41d4-a716-446655440004` | `...Session1` | NULL | Chơi bóng rổ mini | motor | Phát triển vận động thô | Bóng rổ mini, rổ | 30 | 4 | 2024-11-01 |

**Enums:**
- `domain`: cognitive | motor | language | social | self_care

**Notes:**
- `content_library_id` NULL = custom activity (không dùng template)
- `content_library_id` NOT NULL = sử dụng template từ CONTENT_LIBRARY
- `order_index` định nghĩa thứ tự hoạt động trong buổi học
- UNIQUE constraint: (session_id, order_index)

---

## 5. SESSION_CONTENT_GOALS - Mục tiêu cụ thể

**Mô tả:** Mục tiêu cần đạt cho mỗi hoạt động

| id | session_content_id | description | goal_type | is_primary | order_index | created_at |
|----|-------------------|-------------|-----------|------------|-------------|------------|
| `990e8400-e29b-41d4-a716-446655440001` | `...Content1` | Ngồi yên không rời ghế trong 5 phút liên tục | behavior | true | 1 | 2024-11-01 |
| `990e8400-e29b-41d4-a716-446655440002` | `...Content2` | Bắt chước đúng 3/5 âm thanh động vật | skill | true | 1 | 2024-11-01 |
| `990e8400-e29b-41d4-a716-446655440003` | `...Content2` | Tự phát âm khi thấy hình ảnh (2/5 hình) | skill | false | 2 | 2024-11-01 |
| `990e8400-e29b-41d4-a716-446655440004` | `...Content3` | Ghép đúng 5 khối hình trong 10 phút | knowledge | true | 1 | 2024-11-01 |
| `990e8400-e29b-41d4-a716-446655440005` | `...Content4` | Ném bóng vào rổ thành công 3/10 lần | skill | true | 1 | 2024-11-01 |

**Enums:**
- `goal_type`: knowledge | skill | behavior

**Notes:**
- `is_primary` = true cho mục tiêu chính của activity
- `order_index` định nghĩa thứ tự ưu tiên
- UNIQUE constraint: (session_content_id, order_index)

---

## 6. SESSION_LOGS - Nhật ký buổi học

**Mô tả:** Ghi chú chi tiết sau mỗi buổi học (1-1 với SESSIONS)

| id | session_id | logged_at | actual_start_time | actual_end_time | mood | energy_level | cooperation_level | focus_level | independence_level | overall_rating | progress_notes | completed_at | created_by |
|----|------------|-----------|-------------------|-----------------|------|--------------|-------------------|-------------|--------------------|----------------|----------------|--------------|------------|
| `aa0e8400-e29b-41d4-a716-446655440001` | `...Session1` | 2024-11-04 09:35:00 | 08:05:00 | 09:28:00 | good | 4 | 5 | 3 | 4 | 5 | BA hôm nay rất tập trung, hoàn thành tốt tất cả mục tiêu | 2024-11-04 09:40:00 | `...Mai` |
| `aa0e8400-e29b-41d4-a716-446655440002` | `...Session2` | 2024-11-04 11:05:00 | 10:02:00 | 10:58:00 | very_good | 3 | 4 | 4 | 3 | 4 | BL có tiến bộ rõ rệt về giao tiếp mắt. Tự phát âm được 2 từ mới | 2024-11-04 11:10:00 | `...Mai` |

**Enums:**
- `mood`: very_difficult | difficult | normal | good | very_good

**Rating Scale (1-5):**
- `energy_level`: 1=rất mệt, 5=rất tỉnh táo
- `cooperation_level`: 1=không hợp tác, 5=rất hợp tác
- `focus_level`: 1=không tập trung, 5=rất tập trung
- `independence_level`: 1=phụ thuộc hoàn toàn, 5=hoàn toàn độc lập
- `overall_rating`: 1=kém, 5=xuất sắc

**Business Rules:**
- UNIQUE constraint: session_id (1-1 relationship)
- `completed_at` IS NOT NULL → triggers update SESSIONS.status='completed', has_evaluation=true
- `progress_notes`, `challenges_faced`, `recommendations`, `teacher_notes_text` max 2000 chars each

---

## 7. MEDIA_ATTACHMENTS - File đính kèm

**Mô tả:** Ảnh, video, audio đính kèm nhật ký

| id | session_log_id | media_type | url | thumbnail_url | filename | file_size | mime_type | width | height | duration | caption | uploaded_by | created_at |
|----|----------------|------------|-----|---------------|----------|-----------|-----------|-------|--------|----------|---------|-------------|------------|
| `bb0e8400-e29b-41d4-a716-446655440001` | `...Log1` | image | https://r2.../ba-session-1-1.jpg | https://r2.../ba-session-1-1_thumb.jpg | ba-session-1-1.jpg | 245800 | image/jpeg | 1920 | 1080 | NULL | BA đang tập ghép hình | `...Mai` | 2024-11-04 09:30:00 |
| `bb0e8400-e29b-41d4-a716-446655440002` | `...Log1` | video | https://r2.../ba-session-1-2.mp4 | https://r2.../ba-session-1-2_thumb.jpg | ba-session-1-2.mp4 | 8950000 | video/mp4 | 1280 | 720 | 45 | Video BA phản ứng tốt với hoạt động | `...Mai` | 2024-11-04 09:32:00 |
| `bb0e8400-e29b-41d4-a716-446655440003` | `...Log2` | image | https://r2.../bl-communication.jpg | https://r2.../bl-communication_thumb.jpg | bl-communication.jpg | 189200 | image/jpeg | 1920 | 1080 | NULL | BL tự phát âm "mèo" | `...Mai` | 2024-11-04 11:05:00 |
| `bb0e8400-e29b-41d4-a716-446655440004` | `...Log2` | audio | https://r2.../bl-recording.m4a | NULL | bl-recording.m4a | 1250000 | audio/m4a | NULL | NULL | 30 | Ghi âm BL phát âm các từ mới | `...Mai` | 2024-11-04 11:07:00 |

**Enums:**
- `media_type`: image | video | audio

**Notes:**
- `file_size` in bytes
- `width`, `height` in px (chỉ cho images/videos)
- `duration` in seconds (chỉ cho audio/videos)
- `thumbnail_url` auto-generated cho images/videos
- Files stored in Cloudflare R2

---

## 8. GOAL_EVALUATIONS - Đánh giá mục tiêu

**Mô tả:** Kết quả đạt được của từng mục tiêu

| id | session_log_id | content_goal_id | status | achievement_level | support_level | notes | created_at |
|----|----------------|-----------------|--------|-------------------|---------------|-------|------------|
| `cc0e8400-e29b-41d4-a716-446655440001` | `...Log1` | `...Goal1` | achieved | 100 | independent | Hoàn thành xuất sắc, ngồi yên được 7 phút | 2024-11-04 09:35:00 |
| `cc0e8400-e29b-41d4-a716-446655440002` | `...Log1` | `...Goal2` | partially_achieved | 80 | minimal_prompt | Bắt chước đúng 4/5 âm thanh | 2024-11-04 09:35:00 |
| `cc0e8400-e29b-41d4-a716-446655440003` | `...Log1` | `...Goal3` | partially_achieved | 60 | moderate_prompt | Tự phát âm 3/5 hình, cần luyện thêm | 2024-11-04 09:35:00 |
| `cc0e8400-e29b-41d4-a716-446655440004` | `...Log1` | `...Goal4` | achieved | 90 | minimal_prompt | Ghép đúng 5 khối trong 8 phút | 2024-11-04 09:35:00 |
| `cc0e8400-e29b-41d4-a716-446655440005` | `...Log1` | `...Goal5` | not_achieved | 20 | substantial_prompt | Chỉ ném thành công 2/10, cần luyện thêm | 2024-11-04 09:35:00 |

**Enums:**
- `status`: achieved | partially_achieved | not_achieved | not_applicable
- `support_level`: independent | minimal_prompt | moderate_prompt | substantial_prompt | full_assistance

**Notes:**
- `achievement_level` (0-100%)
- UNIQUE constraint: (session_log_id, content_goal_id) - mỗi goal chỉ đánh giá 1 lần/log

---

## 9. BEHAVIOR_GROUPS - Nhóm hành vi

**Mô tả:** 3 nhóm hành vi chính theo phân loại khoa học

| id | code | name_vn | name_en | icon | color_code | description_vn | order_index | is_active | created_at |
|----|------|---------|---------|------|------------|----------------|-------------|-----------|------------|
| `dd0e8400-e29b-41d4-a716-446655440001` | GROUP_01 | CHỐNG ĐỐI & BƯỚNG BỈNH | Opposition & Defiance | 😤 | #FF5733 | Nhóm hành vi thách thức, từ chối, chống đối yêu cầu từ người lớn | 1 | true | 2024-10-01 |
| `dd0e8400-e29b-41d4-a716-446655440002` | GROUP_02 | HÀNH VI GÂY HẤN | Aggression | 👊 | #DC3545 | Nhóm hành vi tấn công, đánh đập, cắn, ném đồ vật gây hại | 2 | true | 2024-10-01 |
| `dd0e8400-e29b-41d4-a716-446655440003` | GROUP_03 | VẤN ĐỀ VỀ GIÁC QUAN | Sensory Issues | 👂 | #FFC107 | Nhóm hành vi liên quan rối loạn xử lý thông tin cảm giác | 3 | true | 2024-10-01 |

**JSONB Field Example - common_tips:**
```json
[
  "Giữ bình tĩnh và nhất quán",
  "Quan sát môi trường xung quanh",
  "Ghi chép chi tiết (ABC model)",
  "Tham khảo chuyên gia nếu cần"
]
```

---

## 10. BEHAVIOR_LIBRARY - Thư viện hành vi

**Mô tả:** 127+ hành vi cụ thể với evidence-based strategies

### Ví dụ 1: Ăn vạ (Tantrums)

| id | behavior_group_id | behavior_code | name_vn | name_en | icon | age_range_min | age_range_max | usage_count | last_used_at | is_active |
|----|-------------------|---------------|---------|---------|------|---------------|---------------|-------------|--------------|-----------|
| `ee0e8400-e29b-41d4-a716-446655440001` | `...GROUP_01` | BH_01_01 | Ăn vạ | Tantrums | 😭 | 2 | 10 | 15 | 2024-11-04 08:25:00 | true |

**JSONB Fields:**

**keywords_vn:**
```json
["ăn vạ", "la hét", "nằm lăn ra đất", "gào khóc", "tức giận dữ dội", "khóc dai", "mè nheo", "hờn dỗi", "nổi cáu", "cơn giận"]
```

**keywords_en:**
```json
["tantrums", "screaming", "crying", "meltdown", "rolling on floor"]
```

**manifestation_vn:**
```
Trẻ bộc phát cảm xúc một cách dữ dội, có thể la hét, khóc lóc, ném đồ, nằm lăn ra sàn, đá đạp. Khuôn mặt đỏ bừng, cơ thể căng cứng.
```

**explanation (JSONB):**
```json
[
  {
    "title": "Nhu cầu Giao tiếp",
    "content": "Với trẻ nhỏ hoặc trẻ chậm phát triển ngôn ngữ, ăn vạ thường là cách duy nhất trẻ biết để diễn đạt nhu cầu, sự thất vọng, hoặc từ chối."
  },
  {
    "title": "Giới hạn Sinh lý",
    "content": "Khi trẻ mệt, đói, khát, hoặc khó chịu về mặt cảm giác (quá ồn, quá sáng), trẻ dễ mất kiểm soát cảm xúc."
  },
  {
    "title": "Chức năng Hành vi",
    "content": "Ăn vạ có thể có mục đích: thu hút sự chú ý, thoát khỏi yêu cầu, hoặc đòi hỏi điều mong muốn."
  }
]
```

**solutions (JSONB):**
```json
[
  {
    "step": 1,
    "title": "Giữ bình tĩnh",
    "description": "Phản ứng của người lớn rất quan trọng. Nếu bạn tức giận hoặc hoảng sợ, trẻ có thể học được rằng ăn vạ là cách hiệu quả."
  },
  {
    "step": 2,
    "title": "Phớt lờ có kế hoạch (Planned Ignoring)",
    "description": "Nếu ăn vạ là để đòi hỏi điều không được phép hoặc thu hút sự chú ý tiêu cực, hãy phớt lờ an toàn (đảm bảo trẻ không tự làm hại mình)."
  },
  {
    "step": 3,
    "title": "Dạy kỹ năng thay thế",
    "description": "Dạy trẻ cách yêu cầu điều họ muốn bằng lời nói, cử chỉ, hoặc hình ảnh (PECS). Khen ngợi ngay khi trẻ sử dụng cách giao tiếp phù hợp."
  }
]
```

**prevention_strategies (JSONB):**
```json
[
  {
    "category": "Dự đoán",
    "strategies": [
      "Nhận biết dấu hiệu sớm (trẻ bắt đầu khó chịu)",
      "Tránh tình huống kích hoạt (quá đói, mệt)"
    ]
  },
  {
    "category": "Môi trường",
    "strategies": [
      "Tạo lịch trình rõ ràng, dễ đoán",
      "Cho trẻ lựa chọn (choice-making)"
    ]
  }
]
```

**sources (JSONB):**
```json
[
  {
    "type": "research",
    "title": "Temper tantrums in young children: Behavioral composition",
    "author": "Potegal, M., & Davidson, R. J.",
    "year": 2003,
    "citation": "Journal of Developmental & Behavioral Pediatrics, 24(3), 140-147"
  },
  {
    "type": "textbook",
    "title": "Applied Behavior Analysis (3rd ed.)",
    "author": "Cooper, J. O., Heron, T. E., & Heward, W. L.",
    "year": 2020
  }
]
```

**related_behaviors (JSONB):**
```json
["ee0e8400-e29b-41d4-a716-446655440002", "ee0e8400-e29b-41d4-a716-446655440003"]
```
(UUIDs of "Từ chối tuân thủ", "La hét phản đối")

### Ví dụ 2: Từ chối tuân thủ

| behavior_code | name_vn | name_en | usage_count |
|---------------|---------|---------|-------------|
| BH_01_02 | Từ chối tuân thủ | Refusal to Comply | 8 |

---

## 11. BEHAVIOR_INCIDENTS - Sự cố hành vi

**Mô tả:** Ghi nhận các lần xảy ra hành vi trong buổi học (A-B-C Model)

| id | session_log_id | behavior_library_id | incident_number | occurred_at | duration_minutes | intensity_level | frequency_count | antecedent | behavior_description | consequence | intervention_used | intervention_effective | recorded_by |
|----|----------------|---------------------|-----------------|-------------|------------------|-----------------|-----------------|------------|----------------------|-------------|-------------------|------------------------|-------------|
| `ff0e8400-e29b-41d4-a716-446655440001` | `...Log1` | `...BH_01_01` | 1 | 08:25:00 | 2 | 2 | 1 | Chuyển từ hoạt động chơi sang học bài | BA nói "Không!", quay mặt đi, khóc nhẹ | Cho BA lựa chọn bắt đầu từ phần nào trước | Cho lựa chọn, khen khi bắt đầu | true | `...Mai` |
| `ff0e8400-e29b-41d4-a716-446655440002` | `...Log2` | `...BH_01_02` | 1 | 10:15:00 | 1 | 1 | 1 | Yêu cầu BL dọn đồ chơi | BL lắc đầu, nói "Không dọn" | Wait time 10 giây, sau đó nhắc lại | Wait time + prompt | true | `...Mai` |

**ABC Model:**
- **A (Antecedent):** Điều gì xảy ra TRƯỚC hành vi
- **B (Behavior):** Hành vi cụ thể
- **C (Consequence):** Điều gì xảy ra SAU hành vi

**Notes:**
- `intensity_level` (1-5): 1=nhẹ, 5=rất nghiêm trọng
- `frequency_count`: số lần xảy ra trong buổi học
- `incident_number`: thứ tự sự cố trong buổi (tự động tăng)
- `intervention_effective`: boolean - can thiệp có hiệu quả không
- Trigger: INSERT → increment BEHAVIOR_LIBRARY.usage_count, update last_used_at

---

## 12. TEACHER_FAVORITES - Hành vi yêu thích

**Mô tả:** Các hành vi giáo viên thường gặp, lưu để tra cứu nhanh

| id | teacher_id | behavior_library_id | created_at |
|----|------------|---------------------|------------|
| `110e8400-e29b-41d4-a716-446655440001` | `...Mai` | `...BH_01_01` | 2024-10-15 |
| `110e8400-e29b-41d4-a716-446655440002` | `...Mai` | `...BH_01_02` | 2024-10-15 |
| `110e8400-e29b-41d4-a716-446655440003` | `...Mai` | `...BH_02_01` | 2024-10-20 |
| `110e8400-e29b-41d4-a716-446655440004` | `...Minh` | `...BH_03_01` | 2024-10-18 |
| `110e8400-e29b-41d4-a716-446655440005` | `...Minh` | `...BH_02_05` | 2024-10-22 |

**Notes:**
- UNIQUE constraint: (teacher_id, behavior_library_id)
- Use case: Quick access trong logging screen
- Behaviors appear first in search results for that teacher

---

## 13. CONTENT_LIBRARY - Thư viện Template

**Mô tả:** Mẫu hoạt động có sẵn, do hệ thống hoặc giáo viên tạo

| id | teacher_id | code | title | domain | difficulty_level | target_age_min | target_age_max | is_template | is_public | usage_count | rating_avg | rating_count | last_used_at | created_at | deleted_at |
|----|------------|------|-------|--------|------------------|----------------|----------------|-------------|-----------|-------------|------------|--------------|--------------|------------|------------|
| `220e8400-e29b-41d4-a716-446655440001` | NULL | CTL_SYS_001 | Tập ngồi yên | social | beginner | 3 | 8 | true | true | 45 | 4.5 | 12 | 2024-11-04 | 2024-10-01 | NULL |
| `220e8400-e29b-41d4-a716-446655440002` | NULL | CTL_SYS_002 | Bắt chước âm thanh | language | beginner | 2 | 6 | true | true | 38 | 4.8 | 10 | 2024-11-04 | 2024-10-01 | NULL |
| `220e8400-e29b-41d4-a716-446655440003` | `...Mai` | CTL_TH_001 | Hoạt động ghép hình của cô Mai | cognitive | intermediate | 5 | 10 | false | false | 5 | 5.0 | 2 | 2024-11-01 | 2024-10-20 | NULL |

**Enums:**
- `domain`: cognitive | motor | language | social | self_care
- `difficulty_level`: beginner | intermediate | advanced

**Template vs Custom:**
- `teacher_id=NULL, is_public=true`: System templates (seeded)
- `teacher_id=UUID, is_public=false`: Teacher's custom content
- `teacher_id=UUID, is_public=true`: Teacher shared publicly

**JSONB Fields:**

**default_goals:**
```json
[
  {"description": "Ngồi yên 3 phút", "order": 1},
  {"description": "Ngồi yên 5 phút", "order": 2},
  {"description": "Ngồi yên 10 phút", "order": 3}
]
```

**tags:**
```json
["tự kiểm soát", "ngồi yên", "ABA basic", "social skills"]
```

**Business Rules:**
- Trigger: INSERT into SESSION_CONTENTS → increment usage_count, update last_used_at
- `rating_avg`, `rating_count` computed from TEMPLATE_RATINGS

---

## 14. TEMPLATE_RATINGS - Đánh giá Template

**Mô tả:** Giáo viên đánh giá chất lượng template

| id | content_library_id | teacher_id | rating | review | created_at | updated_at |
|----|-------------------|------------|--------|--------|------------|------------|
| `330e8400-e29b-41d4-a716-446655440001` | `...Library001` | `...Mai` | 5 | Hoạt động rất hiệu quả, các con đều thích. Áp dụng được cho nhiều lứa tuổi. | 2024-10-20 | 2024-10-20 |
| `330e8400-e29b-41d4-a716-446655440002` | `...Library001` | `...Minh` | 4 | Tốt nhưng cần điều chỉnh thời gian cho trẻ nhỏ hơn 4 tuổi | 2024-10-25 | 2024-10-25 |
| `330e8400-e29b-41d4-a716-446655440003` | `...Library002` | `...Mai` | 5 | Các con tiến bộ rõ rệt sau 3 tuần áp dụng | 2024-11-01 | 2024-11-01 |

**Notes:**
- `rating` (1-5 stars)
- UNIQUE constraint: (content_library_id, teacher_id) - mỗi teacher chỉ rate 1 lần
- Trigger: INSERT/UPDATE/DELETE → recalculate CONTENT_LIBRARY.rating_avg, rating_count

---

## 15. AI_PROCESSING - Xử lý AI

**Mô tả:** Lịch sử yêu cầu AI tạo session plan

| id | teacher_id | student_id | file_url | file_type | file_size | text_content | processing_status | progress | processing_time_seconds | created_at | completed_at | failed_at |
|----|------------|------------|----------|-----------|-----------|--------------|-------------------|----------|------------------------|------------|--------------|-----------|
| `660e8400-e29b-41d4-a716-446655440001` | `...Mai` | `...An` | https://r2.../iep-ba.pdf | pdf | 1250000 | NULL | completed | 100 | 42 | 2024-11-03 15:30:00 | 2024-11-03 15:30:42 | NULL |
| `660e8400-e29b-41d4-a716-446655440002` | `...Minh` | `...Khôi` | NULL | NULL | NULL | Kế hoạch giáo dục cá nhân cho BK... | completed | 100 | 35 | 2024-11-04 09:15:00 | 2024-11-04 09:15:35 | NULL |
| `660e8400-e29b-41d4-a716-446655440003` | `...Mai` | `...Linh` | https://r2.../plan-bl.docx | docx | 890000 | NULL | failed | 60 | NULL | 2024-11-04 10:00:00 | NULL | 2024-11-04 10:00:15 |

**Enums:**
- `file_type`: pdf | docx | txt | image
- `processing_status`: pending | processing | completed | failed

**JSONB Field - result_sessions (when completed):**
```json
{
  "metadata": {
    "total_sessions": 3,
    "total_weeks": 4,
    "domains_covered": ["cognitive", "language", "social"]
  },
  "sessions": [
    {
      "session_date": "2024-11-12",
      "time_slot": "morning",
      "start_time": "09:00",
      "end_time": "10:30",
      "location": "Phòng học số 1",
      "notes": "Tuần 1 - Buổi 1: Giới thiệu màu sắc",
      "contents": [
        {
          "title": "Nhận biết màu sắc cơ bản",
          "domain": "cognitive",
          "description": "Dạy trẻ nhận biết 4 màu: đỏ, vàng, xanh lá, xanh dương",
          "materials_needed": "Thẻ màu, đồ chơi, hình ảnh",
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
}
```

**Notes:**
- Either `file_url` OR `text_content`, not both
- `progress` (0-100%) updated during processing
- `error_message` populated if failed
- Used to create SESSIONS with `creation_method='ai'`

---

## 16. REPORTS - Báo cáo

**Mô tả:** Báo cáo PDF/Excel được tạo theo yêu cầu

| id | teacher_id | format | report_type | student_id | date_from | date_to | file_url | file_size | status | created_at | completed_at | expires_at |
|----|------------|--------|-------------|------------|-----------|---------|----------|-----------|--------|------------|--------------|------------|
| `440e8400-e29b-41d4-a716-446655440001` | `...Mai` | pdf | individual | `...An` | 2024-10-01 | 2024-11-01 | https://r2.../report-ba-oct.pdf | 2450000 | completed | 2024-11-01 20:00:00 | 2024-11-01 20:00:35 | 2024-11-02 20:00:35 |
| `440e8400-e29b-41d4-a716-446655440002` | `...Mai` | excel | summary | NULL | 2024-10-01 | 2024-11-01 | https://r2.../report-summary-oct.xlsx | 1200000 | completed | 2024-11-01 20:05:00 | 2024-11-01 20:05:20 | 2024-11-02 20:05:20 |
| `440e8400-e29b-41d4-a716-446655440003` | `...Minh` | pdf | individual | `...Khôi` | 2024-10-15 | 2024-11-05 | NULL | NULL | failed | 2024-11-05 10:00:00 | NULL | NULL |

**Enums:**
- `format`: pdf | excel
- `report_type`: individual | summary
- `status`: pending | completed | failed

**Notes:**
- `student_id` NULL for summary reports (all students)
- `expires_at` = completed_at + 24 hours
- Background job generates using Puppeteer (PDF) or ExcelJS (Excel)
- Auto-cleanup after expiration

---

## 17. BACKUPS - Sao lưu

**Mô tả:** Lịch sử backup dữ liệu

| id | teacher_id | backup_type | file_url | file_size | status | created_at | completed_at | expires_at |
|----|------------|-------------|----------|-----------|--------|------------|--------------|------------|
| `550e8400-e29b-41d4-a716-446655440001` | `...Mai` | manual | https://r2.../backups/mai-full-20241101.zip | 15680000 | completed | 2024-11-01 20:00:00 | 2024-11-01 20:02:15 | 2024-11-08 20:02:15 |
| `550e8400-e29b-41d4-a716-446655440002` | `...Mai` | auto | https://r2.../backups/mai-auto-20241104.zip | 2340000 | completed | 2024-11-04 02:00:00 | 2024-11-04 02:00:45 | 2024-11-11 02:00:45 |
| `550e8400-e29b-41d4-a716-446655440003` | `...Minh` | manual | https://r2.../backups/minh-full-20241103.zip | 8920000 | completed | 2024-11-03 19:00:00 | 2024-11-03 19:01:30 | 2024-11-10 19:01:30 |

**Enums:**
- `backup_type`: manual | auto
- `status`: pending | completed | failed

**Notes:**
- `expires_at` = completed_at + 7 days
- Max 4 backups per teacher (oldest auto-deleted when creating 5th)
- Auto backup runs weekly (Sunday 2am) if enabled in settings
- Backup includes: all data JSON + media files (if include_media=true)

---

## 🔗 Mối Quan Hệ Giữa Các Bảng

### Workflow điển hình:

```
1. TEACHER đăng ký tài khoản → xác thực email
   ↓
2. Thêm STUDENT vào hệ thống
   ↓
3. Tạo SESSION (manual) hoặc dùng AI_PROCESSING
   ↓
4. Thêm SESSION_CONTENTS (từ CONTENT_LIBRARY hoặc custom)
   ↓
5. Định nghĩa SESSION_CONTENT_GOALS cho mỗi content
   ↓
6. Sau buổi học: Tạo SESSION_LOG
   ↓
7. Upload MEDIA_ATTACHMENTS (photos/videos)
   ↓
8. Đánh giá GOAL_EVALUATIONS cho từng goal
   ↓
9. Ghi nhận BEHAVIOR_INCIDENTS (nếu có) theo A-B-C model
   ↓
10. Complete SESSION_LOG → trigger update SESSION.status='completed'
   ↓
11. Request REPORT → background job generates PDF/Excel
   ↓
12. BACKUP (auto weekly hoặc manual)
```

---

## 📊 Thống Kê Ví Dụ

### Cô Mai có:
- **2 học sinh** (An, Linh) - đang active
- **5 sessions** (2 completed with logs, 1 completed no log, 2 pending)
- **2 session logs** đã hoàn thành
- **1 behavior incident** (An từ chối nhẹ)
- **3 favorite behaviors** lưu sẵn
- **1 custom template** trong thư viện (CTL_TH_001)
- **Rating trung bình:** 5.0/5.0
- **1 AI processing** completed (42 giây)
- **2 reports** generated (1 individual, 1 summary)
- **2 backups** (1 manual, 1 auto)

### Học sinh An:
- **Tổng số buổi:** 3 (2 completed, 1 pending)
- **Tổng thời gian:** 270 phút (3 × 90)
- **Overall rating:** 5/5
- **Energy level:** 4/5
- **Cooperation:** 5/5
- **Goal achievement:** 82% trung bình
- **Behavior incidents:** 1 (intensity: 2/5, effective intervention)

---

## 💡 Sample Queries

### 1. Lấy all sessions của 1 student với details:
```sql
SELECT 
  s.*,
  st.first_name || ' ' || st.last_name AS student_name,
  COUNT(DISTINCT sc.id) AS contents_count,
  COUNT(scg.id) AS goals_count
FROM sessions s
JOIN students st ON s.student_id = st.id
LEFT JOIN session_contents sc ON s.id = sc.session_id
LEFT JOIN session_content_goals scg ON sc.id = scg.session_content_id
WHERE s.student_id = '660e8400-e29b-41d4-a716-446655440001'
  AND s.deleted_at IS NULL
GROUP BY s.id, st.first_name, st.last_name
ORDER BY s.session_date DESC;
```

### 2. Top rated templates:
```sql
SELECT
  cl.title,
  cl.domain,
  cl.usage_count,
  cl.rating_avg,
  cl.rating_count
FROM content_library cl
WHERE cl.deleted_at IS NULL
  AND cl.rating_count >= 3
ORDER BY cl.rating_avg DESC, cl.usage_count DESC
LIMIT 10;
```

### 3. Student progress summary (last 30 days):
```sql
SELECT
  s.first_name || ' ' || s.last_name AS student_name,
  COUNT(se.id) AS total_sessions,
  COUNT(sl.id) AS logged_sessions,
  AVG(sl.overall_rating) AS avg_rating,
  AVG(sl.cooperation_level) AS avg_cooperation,
  COUNT(bi.id) AS total_incidents
FROM students s
LEFT JOIN sessions se ON s.id = se.student_id 
  AND se.session_date >= CURRENT_DATE - INTERVAL '30 days'
  AND se.deleted_at IS NULL
LEFT JOIN session_logs sl ON se.id = sl.session_id
LEFT JOIN behavior_incidents bi ON sl.id = bi.session_log_id
WHERE s.id = '660e8400-e29b-41d4-a716-446655440001'
GROUP BY s.id, s.first_name, s.last_name;
```

### 4. Most common behaviors (JSONB search):
```sql
SELECT
  bl.name_vn,
  bl.icon,
  bl.usage_count,
  bg.name_vn AS group_name
FROM behavior_library bl
JOIN behavior_groups bg ON bl.behavior_group_id = bg.id
WHERE bl.keywords_vn @> '["ăn vạ"]'::jsonb
  OR bl.keywords_vn @> '["từ chối"]'::jsonb
ORDER BY bl.usage_count DESC
LIMIT 10;
```

---

**Ghi chú:** 
- Tất cả UUID trong tài liệu này được rút gọn (ví dụ: `...440001`) để dễ đọc
- JSONB fields được format với indentation để dễ đọc
- Timestamps theo format `YYYY-MM-DD HH:MM:SS`
- File URLs sử dụng Cloudflare R2 storage
- Soft delete: `deleted_at IS NULL` để lấy records còn active

---

_Sample Data phiên bản 2.0 - Đã đồng bộ hoàn toàn với ERD v2.0_

**Author:** tranhaohcmus  
**Date:** 2025-11-05  
**Status:** ✅ Production Ready
```

---

## 📝 TÓM TẮT THAY ĐỔI

### Đổi tên bảng (4):
1. `CONTENT_GOALS` → `SESSION_CONTENT_GOALS`
2. `LOG_MEDIA_ATTACHMENTS` → `MEDIA_ATTACHMENTS`
3. `CONTENT_LIBRARY_RATINGS` → `TEMPLATE_RATINGS`
4. `BACKUP_HISTORY` → `BACKUPS`

### Thêm bảng mới (1):
1. `REPORTS` - Sample data với 3 records

### Cập nhật dữ liệu:
- Tất cả bảng đã cập nhật fields mới
- JSONB examples chi tiết hơn
- Thêm computed fields examples
- Thêm sample queries thực tế
- Timestamps đầy đủ
- Enums được document rõ ràng

File sample data mới đã **100% align** với ERD v2.0 và API design.
