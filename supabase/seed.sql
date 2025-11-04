-- ============================================================================
-- EDUCARE CONNECT - SEED DATA
-- ============================================================================
-- Description: Seed data for the schema defined in ../script.sql
-- Safe to re-run: uses deterministic UUIDs and upserts where appropriate
-- ============================================================================

BEGIN;

-- --------------------------------------------------------------------------
-- Helpers
-- --------------------------------------------------------------------------
-- Ensure extensions are present (idempotent)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- --------------------------------------------------------------------------
-- Teachers
-- --------------------------------------------------------------------------
-- Two sample teachers
INSERT INTO teachers (id, email, full_name, phone, school, avatar_url, password, is_verified, email_verified_at, two_fa_enabled, created_at, updated_at)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'teacher1@school.edu', 'Nguyễn Văn A', '+84901230001', 'Trường PTCS ABC', NULL, '$2b$10$examplehashTeacher1', TRUE, NOW(), FALSE, NOW(), NOW()),
  ('22222222-2222-2222-2222-222222222222', 'teacher2@school.edu', 'Trần Thị B', '+84901230002', 'Trường PTCS XYZ', NULL, '$2b$10$examplehashTeacher2', TRUE, NOW(), FALSE, NOW(), NOW())
ON CONFLICT (email) DO NOTHING;

-- Index-friendly hint inserts for settings and tokens will come later

-- --------------------------------------------------------------------------
-- Students
-- --------------------------------------------------------------------------
INSERT INTO students (id, teacher_id, full_name, nickname, age, gender, avatar_url, status, notes, created_at, updated_at)
VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 'Nguyễn Văn An', 'An', 5, 'male', NULL, 'active', 'Học sinh ngoan...', NOW(), NOW()),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111', 'Lê Minh Khang', 'Khang', 6, 'male', NULL, 'active', NULL, NOW(), NOW()),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '22222222-2222-2222-2222-222222222222', 'Phạm Gia Linh', 'Linh', 6, 'female', NULL, 'active', NULL, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- Content Library (mix of templates and custom)
-- --------------------------------------------------------------------------
INSERT INTO content_library (id, teacher_id, name, domain, description, default_goals, is_template, usage_count, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-00000000c001', NULL, 'Nhận diện màu sắc', 'cognitive', 'Học nhận biết màu sắc cơ bản', '["Gọi tên màu đỏ","Nhận diện màu xanh"]'::jsonb, TRUE, 45, NOW(), NOW()),
  ('00000000-0000-0000-0000-00000000c002', NULL, 'Vận động tinh', 'motor', 'Luyện tập vận động tinh', '["Xâu hạt","Kẹp đồ"]'::jsonb, TRUE, 18, NOW(), NOW()),
  ('00000000-0000-0000-0000-00000000c003', '11111111-1111-1111-1111-111111111111', 'Nhận diện hình học', 'cognitive', 'Học nhận biết hình học', '["Nhận diện hình vuông","Nhận diện hình tròn"]'::jsonb, FALSE, 3, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- Sessions (for student aaaa...1)
-- --------------------------------------------------------------------------
INSERT INTO sessions (id, student_id, date, time_slot, start_time, end_time, notes, creation_method, status, has_evaluation, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-000000000101', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', DATE '2025-10-22', 'morning', TIME '08:00', TIME '11:00', 'Buổi học về màu sắc', 'manual', 'pending', FALSE, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000102', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', DATE '2025-10-23', 'afternoon', TIME '14:00', TIME '16:30', 'Ôn tập vận động tinh', 'manual', 'pending', FALSE, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000103', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', DATE '2025-10-24', 'morning', TIME '09:00', TIME '11:00', 'Nhận diện hình học', 'manual', 'pending', FALSE, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- Session Contents & Goals
-- --------------------------------------------------------------------------
INSERT INTO session_contents (id, session_id, content_library_id, name, domain, description, order_index, notes, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-000000000201', '00000000-0000-0000-0000-000000000101', '00000000-0000-0000-0000-00000000c001', 'Phân biệt màu sắc', 'cognitive', 'Học nhận diện màu cơ bản', 1, NULL, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000202', '00000000-0000-0000-0000-000000000101', NULL, 'Nhận diện đồ vật theo màu', 'cognitive', 'Phân loại đồ vật theo màu', 2, NULL, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000203', '00000000-0000-0000-0000-000000000102', '00000000-0000-0000-0000-00000000c002', 'Vận động tinh cơ bản', 'motor', 'Bài tập kẹp đồ, xâu hạt', 1, NULL, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000204', '00000000-0000-0000-0000-000000000103', '00000000-0000-0000-0000-00000000c003', 'Nhận diện hình học', 'cognitive', 'Hình vuông, tròn', 1, NULL, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

INSERT INTO content_goals (id, session_content_id, description, order_index, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-000000000301', '00000000-0000-0000-0000-000000000201', 'Gọi tên màu đỏ', 1, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000302', '00000000-0000-0000-0000-000000000201', 'Nhận diện màu xanh', 2, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000303', '00000000-0000-0000-0000-000000000202', 'Phân loại 5 đồ vật theo màu', 1, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000304', '00000000-0000-0000-0000-000000000203', 'Kẹp 10 kẹp áo liên tục', 1, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000305', '00000000-0000-0000-0000-000000000204', 'Nhận diện hình vuông', 1, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000306', '00000000-0000-0000-0000-000000000204', 'Nhận diện hình tròn', 2, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- Session Logs (Step-by-step per API spec examples)
-- --------------------------------------------------------------------------
INSERT INTO session_logs (id, session_id, logged_at, completed_at, mood, cooperation_level, focus_level, independence_level, attitude_notes, teacher_notes_text, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-000000000401', '00000000-0000-0000-0000-000000000101', NOW(), NOW(), 'good', 4, 3, 4, 'Con rất vui và hợp tác...', 'Hôm nay con đã thể hiện tốt...', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- Goal Evaluations for session 1
INSERT INTO goal_evaluations (id, session_log_id, content_goal_id, status, notes, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-000000000501', '00000000-0000-0000-0000-000000000401', '00000000-0000-0000-0000-000000000301', 'achieved', 'Đạt tốt', NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000502', '00000000-0000-0000-0000-000000000401', '00000000-0000-0000-0000-000000000302', 'not_achieved', 'Còn nhầm lẫn', NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000503', '00000000-0000-0000-0000-000000000401', '00000000-0000-0000-0000-000000000303', 'achieved', NULL, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- Media attachments (image example)
INSERT INTO log_media_attachments (id, session_log_id, type, url, filename, file_size, duration, created_at)
VALUES
  ('00000000-0000-0000-0000-000000000601', '00000000-0000-0000-0000-000000000401', 'image', 'https://cdn.educare.vn/media/photo1.jpg', 'photo1.jpg', 1024000, NULL, NOW())
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- Behavior Library (curated from wireframes-final/data.md groups)
-- --------------------------------------------------------------------------
INSERT INTO behavior_library (id, name_vn, name_en, category, description, definition, function, examples, common_antecedents, common_consequences, intervention_tips, icon, is_active, created_at, updated_at)
VALUES
  -- 1.1 Ăn vạ (Tantrums)
  ('00000000-0000-0000-0000-000000000701', 'Ăn vạ', 'Tantrums', 'attention',
   'Bộc phát cảm xúc dữ dội: la hét, khóc, ném đồ...',
   'Cơn bùng nổ cảm xúc do quá tải hoặc bị giới hạn.',
   'attention',
   '["La hét","Nằm lăn","Ném đồ"]'::jsonb,
   '["Bị từ chối yêu cầu","Quá tải cảm giác"]'::jsonb,
   '["Được chú ý","Được nhượng bộ"]'::jsonb,
   '["Giữ bình tĩnh","Planned ignoring","Dạy điều chỉnh cảm xúc"]'::jsonb,
   '⚠️', TRUE, NOW(), NOW()),

  -- 1.2 Từ chối làm theo (Non-compliance)
  ('00000000-0000-0000-0000-000000000702', 'Từ chối làm theo yêu cầu', 'Non-compliance', 'avoidance',
   'Không hợp tác, phớt lờ yêu cầu.',
   'Chiến lược thoát khỏi nhiệm vụ hoặc khẳng định tự chủ.',
   'escape',
   '["Phớt lờ","Nói không","Ì ra"]'::jsonb,
   '["Nhiệm vụ quá khó","Yêu cầu quá dài"]'::jsonb,
   '["Thoát khỏi nhiệm vụ","Giảm yêu cầu"]'::jsonb,
   '["First-Then","Khen hợp tác","Cho thời gian xử lý"]'::jsonb,
   '✅', TRUE, NOW(), NOW()),

  -- 2.1 Đánh bạn (Physical Aggression)
  ('00000000-0000-0000-0000-000000000703', 'Đánh bạn', 'Physical Aggression', 'aggression',
   'Tác động vật lý gây đau cho người khác.',
   'Hành vi hung hăng khi xung đột.',
   'tangible',
   '["Đánh","Đẩy","Giật tóc"]'::jsonb,
   '["Tranh giành đồ chơi","Bị khiêu khích"]'::jsonb,
   '["Bạn rời đi","Bị nhắc nhở"]'::jsonb,
   '["Dạy kỹ năng thay thế","Nhập vai tình huống","Giám sát"]'::jsonb,
   '👊', TRUE, NOW(), NOW()),

  -- 3.1 Nhạy cảm âm thanh (Auditory Hypersensitivity)
  ('00000000-0000-0000-0000-000000000704', 'Nhạy cảm với âm thanh', 'Auditory Hypersensitivity', 'self_stim',
   'Phản ứng tiêu cực mạnh với âm thanh thường nhật.',
   'Khó chịu/đau đớn do xử lý cảm giác khác biệt.',
   'sensory',
   '["Bịt tai","La hét khi ồn","Chạy trốn khỏi nguồn âm"]'::jsonb,
   '["Âm thanh đột ngột","Môi trường ồn ào"]'::jsonb,
   '["Được rời khỏi khu vực ồn","Giảm kích thích"]'::jsonb,
   '["Tai nghe chống ồn","Góc yên tĩnh","Chuẩn bị trước"]'::jsonb,
   '🎧', TRUE, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- Teacher favorites
INSERT INTO teacher_favorites (id, teacher_id, behavior_library_id, created_at)
VALUES
  ('00000000-0000-0000-0000-000000000801', '11111111-1111-1111-1111-111111111111', '00000000-0000-0000-0000-000000000701', NOW())
ON CONFLICT (id) DO NOTHING;

-- Behavior incidents linked to session log
INSERT INTO behavior_incidents (id, session_log_id, behavior_library_id, antecedent, behavior_description, consequence, severity_level, occurred_at, notes, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-000000000901', '00000000-0000-0000-0000-000000000401', '00000000-0000-0000-0000-000000000703', 'Bị từ chối yêu cầu', 'Ném bút xuống đất', 'Được nghỉ 5 phút', 3, TIMESTAMPTZ '2025-10-22 10:15:00+00', NULL, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- User Settings, Backup, AI, Notifications (lightweight examples)
-- --------------------------------------------------------------------------
INSERT INTO user_settings (id, teacher_id, key, value, created_at, updated_at)
VALUES
  ('00000000-0000-0000-0000-000000001001', '11111111-1111-1111-1111-111111111111', 'theme', '"light"'::jsonb, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000001002', '11111111-1111-1111-1111-111111111111', 'language', '"vi"'::jsonb, NOW(), NOW()),
  ('00000000-0000-0000-0000-000000001003', '11111111-1111-1111-1111-111111111111', 'notifications', '{"email":true, "push":true}'::jsonb, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

INSERT INTO backup_history (id, teacher_id, backup_type, file_url, file_size, status, created_at)
VALUES
  ('00000000-0000-0000-0000-000000001101', '11111111-1111-1111-1111-111111111111', 'manual', 'https://cdn.educare.vn/backups/seed_backup.zip', 1048576, 'completed', NOW())
ON CONFLICT (id) DO NOTHING;

INSERT INTO ai_processing (id, teacher_id, student_id, file_url, file_type, text_content, processing_status, progress, result_sessions, error_message, created_at, completed_at)
VALUES
  ('00000000-0000-0000-0000-000000001201', '11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', NULL, 'text', 'Thứ 2: Hoạt động 1...', 'completed', 100, '[{"date":"2025-10-21","time_slot":"morning","contents":[{"name":"Ai đây? (Nhận diện)","domain":"language","goals":["Nhận biết tên mình","Trỏ vào ảnh bản thân"]}]}]'::jsonb, NULL, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

INSERT INTO notifications (id, teacher_id, type, title, message, data, is_read, read_at, created_at)
VALUES
  ('00000000-0000-0000-0000-000000001301', '11111111-1111-1111-1111-111111111111', 'session_reminder', 'Nhắc nhở buổi học', 'Buổi học với Bé An sắp bắt đầu (14:00)', NULL, FALSE, NULL, NOW())
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- Auth-related tokens (demo; not used by RLS in seed)
-- --------------------------------------------------------------------------
INSERT INTO refresh_tokens (id, teacher_id, token, expires_at, is_revoked, created_at)
VALUES
  ('00000000-0000-0000-0000-000000001401', '11111111-1111-1111-1111-111111111111', 'demo-refresh-token-1', NOW() + INTERVAL '7 days', FALSE, NOW())
ON CONFLICT (id) DO NOTHING;

INSERT INTO password_reset_tokens (id, teacher_id, token, expires_at, used, created_at)
VALUES
  ('00000000-0000-0000-0000-000000001501', '11111111-1111-1111-1111-111111111111', 'demo-reset-token-1', NOW() + INTERVAL '1 day', FALSE, NOW())
ON CONFLICT (id) DO NOTHING;

COMMIT;

-- ============================================================================
-- Run order suggestion:
-- 1) Execute ../script.sql to create schema
-- 2) Execute this seed.sql to populate sample data
-- ============================================================================


