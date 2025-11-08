-- ========================================
-- EDUCARE CONNECT - DATABASE SETUP
-- Version: 2.0 (Fixed)
-- Author: tranhaohcmus
-- Date: 2025-11-08
-- ========================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ========================================
-- PHASE 1: CORE USER & STUDENT MANAGEMENT
-- ========================================

-- 1.1 TEACHERS TABLE
CREATE TABLE teachers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) NOT NULL UNIQUE,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  school VARCHAR(255),
  avatar_url TEXT,
  password_hash VARCHAR(255) NOT NULL,
  is_verified BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  timezone VARCHAR(50) DEFAULT 'Asia/Ho_Chi_Minh',
  language VARCHAR(10) DEFAULT 'vi',
  last_login_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  deleted_at TIMESTAMP WITH TIME ZONE,
  
  CONSTRAINT email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- 1.2 STUDENTS TABLE
CREATE TABLE students (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  nickname VARCHAR(50),
  date_of_birth DATE NOT NULL,
  gender VARCHAR(10) NOT NULL,
  avatar_url TEXT,
  status VARCHAR(20) DEFAULT 'active',
  diagnosis TEXT,
  notes TEXT,
  parent_name VARCHAR(255),
  parent_phone VARCHAR(20),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  deleted_at TIMESTAMP WITH TIME ZONE,
  
  CONSTRAINT students_gender_check CHECK (gender IN ('male', 'female', 'other')),
  CONSTRAINT students_status_check CHECK (status IN ('active', 'paused', 'archived'))
);

-- ========================================
-- PHASE 2: SESSION MANAGEMENT
-- ========================================

-- 2.1 SESSIONS TABLE
CREATE TABLE sessions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  session_date DATE NOT NULL,
  time_slot VARCHAR(20) NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  duration_minutes INTEGER GENERATED ALWAYS AS (
    EXTRACT(EPOCH FROM (end_time - start_time)) / 60
  ) STORED,
  location VARCHAR(255),
  notes TEXT,
  creation_method VARCHAR(20) DEFAULT 'manual',
  status VARCHAR(20) DEFAULT 'pending',
  has_evaluation BOOLEAN DEFAULT FALSE,
  cancellation_reason TEXT,
  cancelled_at TIMESTAMP WITH TIME ZONE,
  created_by UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  deleted_at TIMESTAMP WITH TIME ZONE,
  
  CONSTRAINT sessions_time_slot_check CHECK (time_slot IN ('morning', 'afternoon', 'evening')),
  CONSTRAINT sessions_creation_method_check CHECK (creation_method IN ('manual', 'ai')),
  CONSTRAINT sessions_status_check CHECK (status IN ('pending', 'completed', 'cancelled')),
  CONSTRAINT sessions_time_logic CHECK (end_time > start_time)
);

-- 2.2 CONTENT_LIBRARY TABLE (must be created before SESSION_CONTENTS)
CREATE TABLE content_library (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  teacher_id UUID REFERENCES teachers(id) ON DELETE CASCADE,
  code VARCHAR(50) UNIQUE,
  title VARCHAR(255) NOT NULL,
  domain VARCHAR(20) NOT NULL,
  description TEXT,
  target_age_min INTEGER,
  target_age_max INTEGER,
  difficulty_level VARCHAR(20),
  default_goals JSONB,
  materials_needed TEXT,
  estimated_duration INTEGER,
  instructions TEXT,
  tips TEXT,
  is_template BOOLEAN DEFAULT TRUE,
  is_public BOOLEAN DEFAULT FALSE,
  usage_count INTEGER DEFAULT 0,
  rating_avg NUMERIC(3, 2) DEFAULT 0.00,
  rating_count INTEGER DEFAULT 0,
  last_used_at TIMESTAMP WITH TIME ZONE,
  tags JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  deleted_at TIMESTAMP WITH TIME ZONE,
  
  CONSTRAINT content_library_domain_check CHECK (domain IN ('cognitive', 'motor', 'language', 'social', 'self_care')),
  CONSTRAINT content_library_difficulty_check CHECK (difficulty_level IN ('beginner', 'intermediate', 'advanced')),
  CONSTRAINT content_library_age_logic CHECK (target_age_max >= target_age_min),
  CONSTRAINT content_library_rating_range CHECK (rating_avg BETWEEN 0 AND 5)
);

-- 2.3 SESSION_CONTENTS TABLE
CREATE TABLE session_contents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
  content_library_id UUID REFERENCES content_library(id) ON DELETE SET NULL,
  title VARCHAR(255) NOT NULL,
  domain VARCHAR(20) NOT NULL,
  description TEXT,
  materials_needed TEXT,
  estimated_duration INTEGER,
  instructions TEXT,
  tips TEXT,
  order_index INTEGER NOT NULL,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT session_contents_domain_check CHECK (domain IN ('cognitive', 'motor', 'language', 'social', 'self_care')),
  CONSTRAINT session_contents_order_unique UNIQUE (session_id, order_index)
);

-- 2.4 SESSION_CONTENT_GOALS TABLE
CREATE TABLE session_content_goals (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_content_id UUID NOT NULL REFERENCES session_contents(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  goal_type VARCHAR(20) NOT NULL,
  is_primary BOOLEAN DEFAULT FALSE,
  order_index INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT session_content_goals_goal_type_check CHECK (goal_type IN ('knowledge', 'skill', 'behavior')),
  CONSTRAINT session_content_goals_order_unique UNIQUE (session_content_id, order_index)
);

-- ========================================
-- PHASE 3: SESSION LOGGING
-- ========================================

-- 3.1 SESSION_LOGS TABLE
CREATE TABLE session_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id UUID NOT NULL UNIQUE REFERENCES sessions(id) ON DELETE CASCADE,
  logged_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  actual_start_time TIME,
  actual_end_time TIME,
  mood VARCHAR(20),
  energy_level INTEGER,
  cooperation_level INTEGER,
  focus_level INTEGER,
  independence_level INTEGER,
  attitude_summary TEXT,
  progress_notes TEXT,
  challenges_faced TEXT,
  recommendations TEXT,
  teacher_notes_text TEXT,
  overall_rating INTEGER,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_by UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT session_logs_mood_check CHECK (mood IN ('very_difficult', 'difficult', 'normal', 'good', 'very_good')),
  CONSTRAINT session_logs_energy_level_check CHECK (energy_level BETWEEN 1 AND 5),
  CONSTRAINT session_logs_cooperation_level_check CHECK (cooperation_level BETWEEN 1 AND 5),
  CONSTRAINT session_logs_focus_level_check CHECK (focus_level BETWEEN 1 AND 5),
  CONSTRAINT session_logs_independence_level_check CHECK (independence_level BETWEEN 1 AND 5),
  CONSTRAINT session_logs_overall_rating_check CHECK (overall_rating BETWEEN 1 AND 5),
  CONSTRAINT session_logs_actual_time_logic CHECK (actual_end_time > actual_start_time),
  CONSTRAINT session_logs_progress_notes_length CHECK (char_length(progress_notes) <= 2000),
  CONSTRAINT session_logs_challenges_length CHECK (char_length(challenges_faced) <= 2000),
  CONSTRAINT session_logs_recommendations_length CHECK (char_length(recommendations) <= 2000),
  CONSTRAINT session_logs_teacher_notes_length CHECK (char_length(teacher_notes_text) <= 2000)
);

-- 3.2 MEDIA_ATTACHMENTS TABLE
CREATE TABLE media_attachments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_log_id UUID NOT NULL REFERENCES session_logs(id) ON DELETE CASCADE,
  media_type VARCHAR(20) NOT NULL,
  url TEXT NOT NULL,
  thumbnail_url TEXT,
  filename VARCHAR(255) NOT NULL,
  file_size BIGINT NOT NULL,
  mime_type VARCHAR(100) NOT NULL,
  width INTEGER,
  height INTEGER,
  duration INTEGER,
  caption TEXT,
  uploaded_by UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT media_attachments_media_type_check CHECK (media_type IN ('image', 'video', 'audio'))
);

-- 3.3 GOAL_EVALUATIONS TABLE
CREATE TABLE goal_evaluations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_log_id UUID NOT NULL REFERENCES session_logs(id) ON DELETE CASCADE,
  content_goal_id UUID NOT NULL REFERENCES session_content_goals(id) ON DELETE CASCADE,
  status VARCHAR(30) NOT NULL,
  achievement_level INTEGER,
  support_level VARCHAR(30),
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT goal_evaluations_status_check CHECK (status IN ('achieved', 'partially_achieved', 'not_achieved', 'not_applicable')),
  CONSTRAINT goal_evaluations_support_level_check CHECK (support_level IN ('independent', 'minimal_prompt', 'moderate_prompt', 'substantial_prompt', 'full_assistance')),
  CONSTRAINT goal_evaluations_achievement_level_check CHECK (achievement_level BETWEEN 0 AND 100),
  CONSTRAINT goal_evaluations_evaluation_unique UNIQUE (session_log_id, content_goal_id)
);

-- ========================================
-- PHASE 4: BEHAVIOR SYSTEM
-- ========================================

-- 4.1 BEHAVIOR_GROUPS TABLE
CREATE TABLE behavior_groups (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  code VARCHAR(20) NOT NULL UNIQUE,
  name_vn VARCHAR(255) NOT NULL,
  name_en VARCHAR(255) NOT NULL,
  description_vn TEXT,
  description_en TEXT,
  icon VARCHAR(10),
  color_code VARCHAR(7),
  common_tips JSONB,
  order_index INTEGER NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4.2 BEHAVIOR_LIBRARY TABLE
CREATE TABLE behavior_library (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  behavior_group_id UUID NOT NULL REFERENCES behavior_groups(id) ON DELETE CASCADE,
  behavior_code VARCHAR(20) NOT NULL UNIQUE,
  name_vn VARCHAR(255) NOT NULL,
  name_en VARCHAR(255) NOT NULL,
  icon VARCHAR(10),
  keywords_vn JSONB,
  keywords_en JSONB,
  manifestation_vn TEXT,
  manifestation_en TEXT,
  age_range_min INTEGER,
  age_range_max INTEGER,
  explanation JSONB,
  solutions JSONB,
  prevention_strategies JSONB,
  sources JSONB,
  related_behaviors JSONB,
  is_active BOOLEAN DEFAULT TRUE,
  usage_count INTEGER DEFAULT 0,
  last_used_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT behavior_library_age_logic CHECK (age_range_max >= age_range_min)
);

-- 4.3 BEHAVIOR_INCIDENTS TABLE
CREATE TABLE behavior_incidents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_log_id UUID NOT NULL REFERENCES session_logs(id) ON DELETE CASCADE,
  behavior_library_id UUID REFERENCES behavior_library(id) ON DELETE SET NULL,
  incident_number INTEGER NOT NULL,
  antecedent TEXT,
  behavior_description TEXT NOT NULL,
  consequence TEXT,
  duration_minutes INTEGER,
  intensity_level INTEGER,
  frequency_count INTEGER,
  intervention_used TEXT,
  intervention_effective BOOLEAN,
  environmental_factors TEXT,
  occurred_at TIME NOT NULL,
  notes TEXT,
  requires_followup BOOLEAN DEFAULT FALSE,
  recorded_by UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT behavior_incidents_intensity_check CHECK (intensity_level BETWEEN 1 AND 5)
);

-- 4.4 TEACHER_FAVORITES TABLE
CREATE TABLE teacher_favorites (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  behavior_library_id UUID NOT NULL REFERENCES behavior_library(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT teacher_favorites_favorite_unique UNIQUE (teacher_id, behavior_library_id)
);

-- ========================================
-- PHASE 5: TEMPLATE RATINGS
-- ========================================

-- 5.1 TEMPLATE_RATINGS TABLE
CREATE TABLE template_ratings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  content_library_id UUID NOT NULL REFERENCES content_library(id) ON DELETE CASCADE,
  teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  rating INTEGER NOT NULL,
  review TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  CONSTRAINT template_ratings_rating_check CHECK (rating BETWEEN 1 AND 5),
  CONSTRAINT template_ratings_rating_unique UNIQUE (content_library_id, teacher_id)
);

-- ========================================
-- PHASE 6: AI PROCESSING & REPORTS
-- ========================================

-- 6.1 AI_PROCESSING TABLE
CREATE TABLE ai_processing (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  file_url TEXT,
  file_type VARCHAR(20),
  file_size BIGINT,
  text_content TEXT,
  processing_status VARCHAR(20) DEFAULT 'pending',
  progress INTEGER DEFAULT 0,
  result_sessions JSONB,
  error_message TEXT,
  processing_time_seconds INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,
  failed_at TIMESTAMP WITH TIME ZONE,
  
  CONSTRAINT ai_processing_file_type_check CHECK (file_type IN ('pdf', 'docx', 'txt', 'image')),
  CONSTRAINT ai_processing_status_check CHECK (processing_status IN ('pending', 'processing', 'completed', 'failed')),
  CONSTRAINT ai_processing_progress_check CHECK (progress BETWEEN 0 AND 100),
  CONSTRAINT ai_processing_input_check CHECK (
    (file_url IS NOT NULL AND text_content IS NULL) OR
    (file_url IS NULL AND text_content IS NOT NULL)
  )
);

-- 6.2 REPORTS TABLE
CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  format VARCHAR(20) NOT NULL,
  report_type VARCHAR(20) NOT NULL,
  student_id UUID REFERENCES students(id) ON DELETE CASCADE,
  date_from DATE NOT NULL,
  date_to DATE NOT NULL,
  file_url TEXT,
  file_size BIGINT,
  status VARCHAR(20) DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,
  expires_at TIMESTAMP WITH TIME ZONE,
  
  CONSTRAINT reports_format_check CHECK (format IN ('pdf', 'excel')),
  CONSTRAINT reports_report_type_check CHECK (report_type IN ('individual', 'summary')),
  CONSTRAINT reports_status_check CHECK (status IN ('pending', 'completed', 'failed')),
  CONSTRAINT reports_date_logic CHECK (date_to >= date_from)
);

-- 6.3 BACKUPS TABLE
CREATE TABLE backups (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  backup_type VARCHAR(20) NOT NULL,
  file_url TEXT,
  file_size BIGINT,
  status VARCHAR(20) DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,
  expires_at TIMESTAMP WITH TIME ZONE,
  
  CONSTRAINT backups_backup_type_check CHECK (backup_type IN ('manual', 'auto')),
  CONSTRAINT backups_status_check CHECK (status IN ('pending', 'completed', 'failed'))
);

-- ========================================
-- PHASE 7: CREATE INDEXES
-- ========================================

-- Primary relationship indexes
CREATE INDEX idx_students_teacher_id ON students(teacher_id);
CREATE INDEX idx_sessions_student_id ON sessions(student_id);
CREATE INDEX idx_sessions_created_by ON sessions(created_by);
CREATE INDEX idx_session_contents_session_id ON session_contents(session_id);
CREATE INDEX idx_session_contents_library_id ON session_contents(content_library_id);
CREATE INDEX idx_session_content_goals_content_id ON session_content_goals(session_content_id);
CREATE INDEX idx_session_logs_session_id ON session_logs(session_id);
CREATE INDEX idx_session_logs_created_by ON session_logs(created_by);
CREATE INDEX idx_media_attachments_log_id ON media_attachments(session_log_id);
CREATE INDEX idx_media_attachments_uploaded_by ON media_attachments(uploaded_by);
CREATE INDEX idx_goal_evaluations_log_id ON goal_evaluations(session_log_id);
CREATE INDEX idx_goal_evaluations_goal_id ON goal_evaluations(content_goal_id);

-- Behavior system indexes
CREATE INDEX idx_behavior_library_group_id ON behavior_library(behavior_group_id);
CREATE INDEX idx_behavior_incidents_log_id ON behavior_incidents(session_log_id);
CREATE INDEX idx_behavior_incidents_behavior_id ON behavior_incidents(behavior_library_id);
CREATE INDEX idx_behavior_incidents_recorded_by ON behavior_incidents(recorded_by);
CREATE INDEX idx_teacher_favorites_teacher_id ON teacher_favorites(teacher_id);
CREATE INDEX idx_teacher_favorites_behavior_id ON teacher_favorites(behavior_library_id);

-- Template system indexes
CREATE INDEX idx_content_library_teacher_id ON content_library(teacher_id);
CREATE INDEX idx_template_ratings_library_id ON template_ratings(content_library_id);
CREATE INDEX idx_template_ratings_teacher_id ON template_ratings(teacher_id);

-- AI & Reports indexes
CREATE INDEX idx_ai_processing_teacher_id ON ai_processing(teacher_id);
CREATE INDEX idx_ai_processing_student_id ON ai_processing(student_id);
CREATE INDEX idx_reports_teacher_id ON reports(teacher_id);
CREATE INDEX idx_reports_student_id ON reports(student_id);
CREATE INDEX idx_backups_teacher_id ON backups(teacher_id);

-- Composite indexes for common queries
CREATE INDEX idx_sessions_student_date ON sessions(student_id, session_date DESC);
CREATE INDEX idx_students_teacher_active ON students(teacher_id, status) WHERE deleted_at IS NULL;
CREATE INDEX idx_session_contents_session_order ON session_contents(session_id, order_index);
CREATE INDEX idx_session_content_goals_content_order ON session_content_goals(session_content_id, order_index);
CREATE INDEX idx_sessions_date_desc ON sessions(session_date DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_behavior_usage_desc ON behavior_library(usage_count DESC);
CREATE INDEX idx_content_usage_desc ON content_library(usage_count DESC, rating_avg DESC);
CREATE INDEX idx_media_type ON media_attachments(session_log_id, media_type);

-- GIN indexes for JSONB full-text search
CREATE INDEX idx_behavior_keywords_vn_gin ON behavior_library USING GIN (keywords_vn);
CREATE INDEX idx_behavior_keywords_en_gin ON behavior_library USING GIN (keywords_en);
CREATE INDEX idx_content_tags_gin ON content_library USING GIN (tags);

-- ========================================
-- PHASE 8: CREATE UPDATED_AT TRIGGERS
-- ========================================

-- Generic updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to all tables with updated_at
CREATE TRIGGER update_teachers_updated_at BEFORE UPDATE ON teachers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_students_updated_at BEFORE UPDATE ON students
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sessions_updated_at BEFORE UPDATE ON sessions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_session_contents_updated_at BEFORE UPDATE ON session_contents
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_session_content_goals_updated_at BEFORE UPDATE ON session_content_goals
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_session_logs_updated_at BEFORE UPDATE ON session_logs
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_media_attachments_updated_at BEFORE UPDATE ON media_attachments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_goal_evaluations_updated_at BEFORE UPDATE ON goal_evaluations
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_behavior_groups_updated_at BEFORE UPDATE ON behavior_groups
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_behavior_library_updated_at BEFORE UPDATE ON behavior_library
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_behavior_incidents_updated_at BEFORE UPDATE ON behavior_incidents
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_content_library_updated_at BEFORE UPDATE ON content_library
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_template_ratings_updated_at BEFORE UPDATE ON template_ratings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ========================================
-- SETUP COMPLETED
-- ========================================

-- Verify table creation
SELECT 
  schemaname,
  tablename,
  tableowner
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

-- ========================================
-- EDUCARE CONNECT - BUSINESS LOGIC TRIGGERS
-- Version: 2.0
-- Author: tranhaohcmus
-- Date: 2025-11-08
-- ========================================

-- ========================================
-- TRIGGER 1: INCREMENT BEHAVIOR USAGE
-- ========================================
-- Tự động tăng usage_count và update last_used_at 
-- khi có behavior incident mới

CREATE OR REPLACE FUNCTION increment_behavior_usage()
RETURNS TRIGGER AS $$
BEGIN
  -- Only increment if behavior_library_id is not null
  IF NEW.behavior_library_id IS NOT NULL THEN
    UPDATE behavior_library
    SET 
      usage_count = usage_count + 1,
      last_used_at = NOW()
    WHERE id = NEW.behavior_library_id;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_increment_behavior_usage
  AFTER INSERT ON behavior_incidents
  FOR EACH ROW
  EXECUTE FUNCTION increment_behavior_usage();

COMMENT ON TRIGGER trigger_increment_behavior_usage ON behavior_incidents IS 
  'Automatically increments usage_count and updates last_used_at in behavior_library when a new incident is recorded';

-- ========================================
-- TRIGGER 2: INCREMENT TEMPLATE USAGE
-- ========================================
-- Tự động tăng usage_count và update last_used_at
-- khi template được sử dụng trong session content

CREATE OR REPLACE FUNCTION increment_template_usage()
RETURNS TRIGGER AS $$
BEGIN
  -- Only increment if content_library_id is not null (using a template)
  IF NEW.content_library_id IS NOT NULL THEN
    UPDATE content_library
    SET 
      usage_count = usage_count + 1,
      last_used_at = NOW()
    WHERE id = NEW.content_library_id;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_increment_template_usage
  AFTER INSERT ON session_contents
  FOR EACH ROW
  EXECUTE FUNCTION increment_template_usage();

COMMENT ON TRIGGER trigger_increment_template_usage ON session_contents IS 
  'Automatically increments usage_count and updates last_used_at in content_library when a template is used';

-- ========================================
-- TRIGGER 3: UPDATE SESSION STATUS ON LOG COMPLETE
-- ========================================
-- Tự động update session.status = 'completed' và has_evaluation = true
-- khi session_log.completed_at được set

CREATE OR REPLACE FUNCTION update_session_on_log_complete()
RETURNS TRIGGER AS $$
BEGIN
  -- Only trigger when completed_at is newly set or changed
  IF NEW.completed_at IS NOT NULL AND 
     (OLD.completed_at IS NULL OR OLD.completed_at != NEW.completed_at) THEN
    
    UPDATE sessions
    SET 
      status = 'completed',
      has_evaluation = true,
      updated_at = NOW()
    WHERE id = NEW.session_id;
    
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_session_status
  AFTER UPDATE OF completed_at ON session_logs
  FOR EACH ROW
  EXECUTE FUNCTION update_session_on_log_complete();

COMMENT ON TRIGGER trigger_update_session_status ON session_logs IS 
  'Automatically marks session as completed when log is finalized';

-- ========================================
-- TRIGGER 4: RECALCULATE TEMPLATE RATINGS
-- ========================================
-- Tự động tính lại rating_avg và rating_count trong content_library
-- khi có rating mới, update, hoặc delete

CREATE OR REPLACE FUNCTION recalculate_template_rating()
RETURNS TRIGGER AS $$
DECLARE
  template_id UUID;
BEGIN
  -- Get the template_id from NEW (insert/update) or OLD (delete)
  template_id := COALESCE(NEW.content_library_id, OLD.content_library_id);
  
  -- Recalculate average rating and count
  UPDATE content_library
  SET 
    rating_avg = COALESCE(
      (SELECT AVG(rating)::NUMERIC(3,2) 
       FROM template_ratings 
       WHERE content_library_id = template_id),
      0.00
    ),
    rating_count = (
      SELECT COUNT(*)::INTEGER
      FROM template_ratings
      WHERE content_library_id = template_id
    ),
    updated_at = NOW()
  WHERE id = template_id;
  
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_recalculate_rating_insert
  AFTER INSERT ON template_ratings
  FOR EACH ROW
  EXECUTE FUNCTION recalculate_template_rating();

CREATE TRIGGER trigger_recalculate_rating_update
  AFTER UPDATE OF rating ON template_ratings
  FOR EACH ROW
  EXECUTE FUNCTION recalculate_template_rating();

CREATE TRIGGER trigger_recalculate_rating_delete
  AFTER DELETE ON template_ratings
  FOR EACH ROW
  EXECUTE FUNCTION recalculate_template_rating();

COMMENT ON FUNCTION recalculate_template_rating() IS 
  'Recalculates rating_avg and rating_count in content_library when ratings change';

-- ========================================
-- OPTIONAL: TRIGGER 5: AUTO-INCREMENT INCIDENT NUMBER
-- ========================================
-- Tự động set incident_number theo thứ tự trong mỗi session_log

CREATE OR REPLACE FUNCTION set_incident_number()
RETURNS TRIGGER AS $$
BEGIN
  -- Auto-set incident_number based on existing incidents in the same log
  IF NEW.incident_number IS NULL THEN
    SELECT COALESCE(MAX(incident_number), 0) + 1
    INTO NEW.incident_number
    FROM behavior_incidents
    WHERE session_log_id = NEW.session_log_id;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_incident_number
  BEFORE INSERT ON behavior_incidents
  FOR EACH ROW
  EXECUTE FUNCTION set_incident_number();

COMMENT ON TRIGGER trigger_set_incident_number ON behavior_incidents IS 
  'Automatically sets incident_number in sequence for each session_log';

-- ========================================
-- OPTIONAL: TRIGGER 6: PREVENT DUPLICATE SESSION LOGS
-- ========================================
-- Đảm bảo mỗi session chỉ có 1 log (already enforced by UNIQUE constraint,
-- but this provides better error message)

CREATE OR REPLACE FUNCTION prevent_duplicate_session_log()
RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM session_logs WHERE session_id = NEW.session_id AND id != COALESCE(NEW.id, '00000000-0000-0000-0000-000000000000'::uuid)) THEN
    RAISE EXCEPTION 'A log already exists for this session (session_id: %)', NEW.session_id
      USING HINT = 'Each session can only have one log. Update the existing log instead.';
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_prevent_duplicate_session_log
  BEFORE INSERT OR UPDATE ON session_logs
  FOR EACH ROW
  EXECUTE FUNCTION prevent_duplicate_session_log();

COMMENT ON TRIGGER trigger_prevent_duplicate_session_log ON session_logs IS 
  'Prevents duplicate logs for the same session with descriptive error message';

-- ========================================
-- VERIFICATION QUERIES
-- ========================================

-- Check all triggers are created
SELECT 
  trigger_name,
  event_object_table,
  action_timing,
  event_manipulation,
  action_statement
FROM information_schema.triggers 
WHERE trigger_schema = 'public'
  AND trigger_name LIKE 'trigger_%'
ORDER BY event_object_table, trigger_name;

-- Check all functions are created
SELECT 
  routine_name,
  routine_type,
  data_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN (
    'increment_behavior_usage',
    'increment_template_usage',
    'update_session_on_log_complete',
    'recalculate_template_rating',
    'set_incident_number',
    'prevent_duplicate_session_log'
  )
ORDER BY routine_name;

-- ========================================
-- EDUCARE CONNECT - ROW LEVEL SECURITY (RLS)
-- Version: 2.0
-- Author: tranhaohcmus
-- Date: 2025-11-08
-- ========================================

-- ========================================
-- ENABLE RLS ON ALL TABLES
-- ========================================

ALTER TABLE teachers ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_contents ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_content_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE media_attachments ENABLE ROW LEVEL SECURITY;
ALTER TABLE goal_evaluations ENABLE ROW LEVEL SECURITY;
ALTER TABLE behavior_incidents ENABLE ROW LEVEL SECURITY;
ALTER TABLE teacher_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_library ENABLE ROW LEVEL SECURITY;
ALTER TABLE template_ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_processing ENABLE ROW LEVEL SECURITY;
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE backups ENABLE ROW LEVEL SECURITY;

-- Behavior groups and library are READ-ONLY for all authenticated users
ALTER TABLE behavior_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE behavior_library ENABLE ROW LEVEL SECURITY;

-- ========================================
-- TEACHERS TABLE POLICIES
-- ========================================

-- Teachers can view their own profile
CREATE POLICY teachers_select_own ON teachers
  FOR SELECT
  USING (auth.uid() = id);

-- Teachers can update their own profile
CREATE POLICY teachers_update_own ON teachers
  FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Teachers can soft delete their own account
CREATE POLICY teachers_delete_own ON teachers
  FOR UPDATE
  USING (auth.uid() = id AND deleted_at IS NULL)
  WITH CHECK (auth.uid() = id);

-- ========================================
-- STUDENTS TABLE POLICIES
-- ========================================

-- Teachers can view their own students
CREATE POLICY students_select_own ON students
  FOR SELECT
  USING (teacher_id = auth.uid() AND deleted_at IS NULL);

-- Teachers can create students
CREATE POLICY students_insert_own ON students
  FOR INSERT
  WITH CHECK (teacher_id = auth.uid());

-- Teachers can update their own students
CREATE POLICY students_update_own ON students
  FOR UPDATE
  USING (teacher_id = auth.uid())
  WITH CHECK (teacher_id = auth.uid());

-- Teachers can soft delete their own students
CREATE POLICY students_delete_own ON students
  FOR UPDATE
  USING (teacher_id = auth.uid() AND deleted_at IS NULL)
  WITH CHECK (teacher_id = auth.uid());

-- ========================================
-- SESSIONS TABLE POLICIES
-- ========================================

-- Teachers can view sessions of their students
CREATE POLICY sessions_select_own ON sessions
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM students 
      WHERE students.id = sessions.student_id 
        AND students.teacher_id = auth.uid()
        AND students.deleted_at IS NULL
    )
    AND sessions.deleted_at IS NULL
  );

-- Teachers can create sessions for their students
CREATE POLICY sessions_insert_own ON sessions
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM students 
      WHERE students.id = sessions.student_id 
        AND students.teacher_id = auth.uid()
        AND students.deleted_at IS NULL
    )
    AND created_by = auth.uid()
  );

-- Teachers can update sessions they created
CREATE POLICY sessions_update_own ON sessions
  FOR UPDATE
  USING (created_by = auth.uid() AND deleted_at IS NULL)
  WITH CHECK (created_by = auth.uid());

-- Teachers can soft delete sessions they created
CREATE POLICY sessions_delete_own ON sessions
  FOR UPDATE
  USING (created_by = auth.uid() AND deleted_at IS NULL)
  WITH CHECK (created_by = auth.uid());

-- ========================================
-- SESSION_CONTENTS TABLE POLICIES
-- ========================================

-- Teachers can view contents of their sessions
CREATE POLICY session_contents_select_own ON session_contents
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM sessions
      JOIN students ON sessions.student_id = students.id
      WHERE sessions.id = session_contents.session_id
        AND students.teacher_id = auth.uid()
        AND sessions.deleted_at IS NULL
        AND students.deleted_at IS NULL
    )
  );

-- Teachers can create contents for their sessions
CREATE POLICY session_contents_insert_own ON session_contents
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM sessions
      WHERE sessions.id = session_contents.session_id
        AND sessions.created_by = auth.uid()
        AND sessions.deleted_at IS NULL
    )
  );

-- Teachers can update/delete contents of their sessions
CREATE POLICY session_contents_update_own ON session_contents
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM sessions
      WHERE sessions.id = session_contents.session_id
        AND sessions.created_by = auth.uid()
        AND sessions.deleted_at IS NULL
    )
  );

CREATE POLICY session_contents_delete_own ON session_contents
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM sessions
      WHERE sessions.id = session_contents.session_id
        AND sessions.created_by = auth.uid()
        AND sessions.deleted_at IS NULL
    )
  );

-- ========================================
-- SESSION_CONTENT_GOALS TABLE POLICIES
-- ========================================

-- Similar pattern: check ownership through session_contents -> sessions
CREATE POLICY session_content_goals_select_own ON session_content_goals
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM session_contents
      JOIN sessions ON session_contents.session_id = sessions.id
      JOIN students ON sessions.student_id = students.id
      WHERE session_contents.id = session_content_goals.session_content_id
        AND students.teacher_id = auth.uid()
    )
  );

CREATE POLICY session_content_goals_insert_own ON session_content_goals
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM session_contents
      JOIN sessions ON session_contents.session_id = sessions.id
      WHERE session_contents.id = session_content_goals.session_content_id
        AND sessions.created_by = auth.uid()
    )
  );

CREATE POLICY session_content_goals_update_delete_own ON session_content_goals
  FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM session_contents
      JOIN sessions ON session_contents.session_id = sessions.id
      WHERE session_contents.id = session_content_goals.session_content_id
        AND sessions.created_by = auth.uid()
    )
  );

-- ========================================
-- SESSION_LOGS TABLE POLICIES
-- ========================================

CREATE POLICY session_logs_select_own ON session_logs
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM sessions
      JOIN students ON sessions.student_id = students.id
      WHERE sessions.id = session_logs.session_id
        AND students.teacher_id = auth.uid()
    )
  );

CREATE POLICY session_logs_insert_own ON session_logs
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM sessions
      WHERE sessions.id = session_logs.session_id
        AND sessions.created_by = auth.uid()
    )
    AND created_by = auth.uid()
  );

CREATE POLICY session_logs_update_own ON session_logs
  FOR UPDATE
  USING (created_by = auth.uid())
  WITH CHECK (created_by = auth.uid());

-- ========================================
-- MEDIA_ATTACHMENTS TABLE POLICIES
-- ========================================

CREATE POLICY media_attachments_select_own ON media_attachments
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM session_logs
      JOIN sessions ON session_logs.session_id = sessions.id
      JOIN students ON sessions.student_id = students.id
      WHERE session_logs.id = media_attachments.session_log_id
        AND students.teacher_id = auth.uid()
    )
  );

CREATE POLICY media_attachments_insert_own ON media_attachments
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM session_logs
      WHERE session_logs.id = media_attachments.session_log_id
        AND session_logs.created_by = auth.uid()
    )
    AND uploaded_by = auth.uid()
  );

CREATE POLICY media_attachments_update_delete_own ON media_attachments
  FOR ALL
  USING (uploaded_by = auth.uid());

-- ========================================
-- GOAL_EVALUATIONS TABLE POLICIES
-- ========================================

CREATE POLICY goal_evaluations_select_own ON goal_evaluations
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM session_logs
      JOIN sessions ON session_logs.session_id = sessions.id
      JOIN students ON sessions.student_id = students.id
      WHERE session_logs.id = goal_evaluations.session_log_id
        AND students.teacher_id = auth.uid()
    )
  );

CREATE POLICY goal_evaluations_insert_update_own ON goal_evaluations
  FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM session_logs
      WHERE session_logs.id = goal_evaluations.session_log_id
        AND session_logs.created_by = auth.uid()
    )
  );

-- ========================================
-- BEHAVIOR_INCIDENTS TABLE POLICIES
-- ========================================

CREATE POLICY behavior_incidents_select_own ON behavior_incidents
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM session_logs
      JOIN sessions ON session_logs.session_id = sessions.id
      JOIN students ON sessions.student_id = students.id
      WHERE session_logs.id = behavior_incidents.session_log_id
        AND students.teacher_id = auth.uid()
    )
  );

CREATE POLICY behavior_incidents_insert_own ON behavior_incidents
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM session_logs
      WHERE session_logs.id = behavior_incidents.session_log_id
        AND session_logs.created_by = auth.uid()
    )
    AND recorded_by = auth.uid()
  );

CREATE POLICY behavior_incidents_update_delete_own ON behavior_incidents
  FOR ALL
  USING (recorded_by = auth.uid());

-- ========================================
-- TEACHER_FAVORITES TABLE POLICIES
-- ========================================

CREATE POLICY teacher_favorites_all_own ON teacher_favorites
  FOR ALL
  USING (teacher_id = auth.uid())
  WITH CHECK (teacher_id = auth.uid());

-- ========================================
-- CONTENT_LIBRARY TABLE POLICIES
-- ========================================

-- Teachers can view public templates and their own templates
CREATE POLICY content_library_select_public_or_own ON content_library
  FOR SELECT
  USING (
    (is_public = TRUE AND deleted_at IS NULL)
    OR (teacher_id = auth.uid() AND deleted_at IS NULL)
    OR teacher_id IS NULL  -- System templates
  );

-- Teachers can create their own templates
CREATE POLICY content_library_insert_own ON content_library
  FOR INSERT
  WITH CHECK (teacher_id = auth.uid());

-- Teachers can update/delete their own templates only
CREATE POLICY content_library_update_own ON content_library
  FOR UPDATE
  USING (teacher_id = auth.uid() AND deleted_at IS NULL)
  WITH CHECK (teacher_id = auth.uid());

CREATE POLICY content_library_delete_own ON content_library
  FOR UPDATE
  USING (teacher_id = auth.uid() AND deleted_at IS NULL)
  WITH CHECK (teacher_id = auth.uid());

-- ========================================
-- TEMPLATE_RATINGS TABLE POLICIES
-- ========================================

-- Teachers can view all ratings for public templates
CREATE POLICY template_ratings_select_public ON template_ratings
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM content_library
      WHERE content_library.id = template_ratings.content_library_id
        AND (content_library.is_public = TRUE OR content_library.teacher_id = auth.uid())
    )
  );

-- Teachers can rate templates
CREATE POLICY template_ratings_insert_own ON template_ratings
  FOR INSERT
  WITH CHECK (teacher_id = auth.uid());

-- Teachers can update/delete their own ratings
CREATE POLICY template_ratings_update_delete_own ON template_ratings
  FOR ALL
  USING (teacher_id = auth.uid());

-- ========================================
-- AI_PROCESSING TABLE POLICIES
-- ========================================

CREATE POLICY ai_processing_all_own ON ai_processing
  FOR ALL
  USING (teacher_id = auth.uid())
  WITH CHECK (teacher_id = auth.uid());

-- ========================================
-- REPORTS TABLE POLICIES
-- ========================================

CREATE POLICY reports_all_own ON reports
  FOR ALL
  USING (teacher_id = auth.uid())
  WITH CHECK (teacher_id = auth.uid());

-- ========================================
-- BACKUPS TABLE POLICIES
-- ========================================

CREATE POLICY backups_all_own ON backups
  FOR ALL
  USING (teacher_id = auth.uid())
  WITH CHECK (teacher_id = auth.uid());

-- ========================================
-- BEHAVIOR GROUPS & LIBRARY (READ-ONLY)
-- ========================================

-- All authenticated users can read behavior groups
CREATE POLICY behavior_groups_select_all ON behavior_groups
  FOR SELECT
  USING (auth.uid() IS NOT NULL AND is_active = TRUE);

-- All authenticated users can read behavior library
CREATE POLICY behavior_library_select_all ON behavior_library
  FOR SELECT
  USING (auth.uid() IS NOT NULL AND is_active = TRUE);

-- ========================================
-- VERIFICATION
-- ========================================

-- Check all policies are created
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

-- Count policies per table
SELECT 
  tablename,
  COUNT(*) as policy_count
FROM pg_policies
WHERE schemaname = 'public'
GROUP BY tablename
ORDER BY tablename;

-- ========================================
-- EDUCARE CONNECT - SEED DATA
-- Version: 2.0
-- Author: tranhaohcmus
-- Date: 2025-11-08
-- ========================================

-- ========================================
-- PART 1: BEHAVIOR GROUPS (3 groups)
-- ========================================

INSERT INTO behavior_groups (id, code, name_vn, name_en, description_vn, description_en, icon, color_code, order_index, common_tips) VALUES
(
  'dd0e8400-e29b-41d4-a716-446655440001',
  'GROUP_01',
  'CHỐNG ĐỐI & BƯỚNG BỈNH',
  'Opposition & Defiance',
  'Nhóm hành vi thách thức, từ chối, chống đối yêu cầu từ người lớn. Thường gặp ở trẻ từ 2-12 tuổi.',
  'Behaviors that challenge authority, refuse requests, and oppose adult demands. Common in children aged 2-12.',
  '😤',
  '#FF5733',
  1,
  '["Giữ bình tĩnh và nhất quán", "Đặt giới hạn rõ ràng", "Cho trẻ lựa chọn", "Khen ngợi hành vi tích cực", "Tránh đối đầu trực tiếp"]'::jsonb
),
(
  'dd0e8400-e29b-41d4-a716-446655440002',
  'GROUP_02',
  'HÀNH VI GÂY HẤN',
  'Aggression',
  'Nhóm hành vi tấn công, đánh đập, cắn, ném đồ vật gây hại cho người khác hoặc tài sản.',
  'Behaviors involving physical attacks, hitting, biting, throwing objects that harm others or property.',
  '👊',
  '#DC3545',
  2,
  '["Quan sát môi trường xung quanh", "Ghi chép chi tiết (ABC model)", "Dạy kỹ năng thay thế", "Can thiệp sớm khi thấy dấu hiệu", "Đảm bảo an toàn cho mọi người"]'::jsonb
),
(
  'dd0e8400-e29b-41d4-a716-446655440003',
  'GROUP_03',
  'VẤN ĐỀ VỀ GIÁC QUAN',
  'Sensory Issues',
  'Nhóm hành vi liên quan rối loạn xử lý thông tin cảm giác (thính giác, thị giác, xúc giác, khứu giác, vị giác).',
  'Behaviors related to sensory processing difficulties (auditory, visual, tactile, olfactory, gustatory).',
  '👂',
  '#FFC107',
  3,
  '["Tạo môi trường yên tĩnh", "Cho phép nghỉ ngơi cảm giác", "Sử dụng công cụ hỗ trợ cảm giác", "Tham khảo chuyên gia trị liệu", "Ghi nhận tình huống kích hoạt"]'::jsonb
)
ON CONFLICT (id) DO NOTHING;

-- ========================================
-- PART 2: BEHAVIOR LIBRARY (Sample 10 behaviors)
-- ========================================

-- GROUP 01: CHỐNG ĐỐI & BƯỚNG BỈNH
INSERT INTO behavior_library (
  id, behavior_group_id, behavior_code, name_vn, name_en, icon,
  keywords_vn, keywords_en,
  manifestation_vn, manifestation_en,
  age_range_min, age_range_max,
  explanation, solutions, prevention_strategies, sources
) VALUES
(
  'ee0e8400-e29b-41d4-a716-446655440001',
  'dd0e8400-e29b-41d4-a716-446655440001',
  'BH_01_01',
  'Ăn vạ',
  'Tantrums',
  '😭',
  '["ăn vạ", "la hét", "nằm lăn ra đất", "gào khóc", "tức giận dữ dội", "khóc dai", "mè nheo", "hờn dỗi"]'::jsonb,
  '["tantrums", "screaming", "crying", "meltdown", "rolling on floor", "intense anger"]'::jsonb,
  'Trẻ bộc phát cảm xúc một cách dữ dội, có thể la hét, khóc lóc, ném đồ, nằm lăn ra sàn, đá đạp. Khuôn mặt đỏ bừng, cơ thể căng cứng.',
  'Child displays intense emotional outbursts with screaming, crying, throwing objects, rolling on floor, kicking. Face becomes red, body stiffens.',
  2,
  10,
  '[{"title": "Nhu cầu Giao tiếp", "content": "Với trẻ nhỏ hoặc trẻ chậm phát triển ngôn ngữ, ăn vạ thường là cách duy nhất trẻ biết để diễn đạt nhu cầu, sự thất vọng, hoặc từ chối."}, {"title": "Giới hạn Sinh lý", "content": "Khi trẻ mệt, đói, khát, hoặc khó chịu về mặt cảm giác (quá ồn, quá sáng), trẻ dễ mất kiểm soát cảm xúc."}, {"title": "Chức năng Hành vi", "content": "Ăn vạ có thể có mục đích: thu hút sự chú ý, thoát khỏi yêu cầu, hoặc đòi hỏi điều mong muốn."}]'::jsonb,
  '[{"step": 1, "title": "Giữ bình tĩnh", "description": "Phản ứng của người lớn rất quan trọng. Nếu bạn tức giận hoặc hoảng sợ, trẻ có thể học được rằng ăn vạ là cách hiệu quả."}, {"step": 2, "title": "Phớt lờ có kế hoạch", "description": "Nếu ăn vạ là để đòi hỏi điều không được phép hoặc thu hút sự chú ý tiêu cực, hãy phớt lờ an toàn."}, {"step": 3, "title": "Dạy kỹ năng thay thế", "description": "Dạy trẻ cách yêu cầu bằng lời nói, cử chỉ, hoặc hình ảnh. Khen ngợi khi trẻ giao tiếp phù hợp."}]'::jsonb,
  '[{"category": "Dự đoán", "strategies": ["Nhận biết dấu hiệu sớm", "Tránh tình huống kích hoạt"]}, {"category": "Môi trường", "strategies": ["Tạo lịch trình rõ ràng", "Cho trẻ lựa chọn"]}]'::jsonb,
  '[{"type": "research", "title": "Temper tantrums in young children", "author": "Potegal & Davidson", "year": 2003}]'::jsonb
),
(
  'ee0e8400-e29b-41d4-a716-446655440002',
  'dd0e8400-e29b-41d4-a716-446655440001',
  'BH_01_02',
  'Từ chối tuân thủ',
  'Refusal to Comply',
  '🙅',
  '["từ chối", "không nghe lời", "chống đối", "nói không", "làm ngơ", "phớt lờ yêu cầu"]'::jsonb,
  '["refusal", "non-compliance", "defiance", "saying no", "ignoring requests"]'::jsonb,
  'Trẻ từ chối thực hiện yêu cầu, có thể nói "Không!", lắc đầu, quay mặt đi, hoặc làm ngơ như không nghe thấy.',
  'Child refuses to follow instructions, may say "No!", shake head, turn away, or ignore as if not hearing.',
  2,
  12,
  '[{"title": "Kiểm tra Quyền lực", "content": "Trẻ thử nghiệm ranh giới và khẳng định bản thân."}, {"title": "Thiếu Động lực", "content": "Yêu cầu quá khó hoặc không hấp dẫn với trẻ."}]'::jsonb,
  '[{"step": 1, "title": "Đưa ra lựa chọn", "description": "Thay vì ra lệnh, cho trẻ chọn giữa 2-3 phương án."}, {"step": 2, "title": "Sử dụng First-Then", "description": "Trước tiên làm X, sau đó được Y."}, {"step": 3, "title": "Khen ngợi khi tuân thủ", "description": "Ngay lập tức khen khi trẻ làm theo yêu cầu."}]'::jsonb,
  '[{"category": "Truyền đạt", "strategies": ["Đưa ra chỉ dẫn rõ ràng", "Sử dụng hình ảnh"]}]'::jsonb,
  '[{"type": "textbook", "title": "Applied Behavior Analysis", "author": "Cooper et al.", "year": 2020}]'::jsonb
),
(
  'ee0e8400-e29b-41d4-a716-446655440003',
  'dd0e8400-e29b-41d4-a716-446655440001',
  'BH_01_03',
  'La hét phản đối',
  'Screaming in Protest',
  '📢',
  '["la hét", "gào thét", "kêu to", "phản đối bằng tiếng la"]'::jsonb,
  '["screaming", "yelling", "shouting", "loud protest"]'::jsonb,
  'Trẻ la hét lớn tiếng để phản đối, có thể kéo dài hoặc ngắn ngủi tùy tình huống.',
  'Child screams loudly in protest, may be prolonged or brief depending on situation.',
  2,
  10,
  '[{"title": "Thiếu ngôn ngữ", "content": "Trẻ chưa có khả năng diễn đạt bằng lời."}, {"title": "Mục đích", "content": "Thu hút sự chú ý hoặc thoát khỏi yêu cầu."}]'::jsonb,
  '[{"step": 1, "title": "Dạy cách giao tiếp thay thế", "description": "Dạy trẻ nói hoặc sử dụng cử chỉ."}, {"step": 2, "title": "Phớt lờ có chọn lọc", "description": "Không phản ứng với tiếng la, phản ứng khi trẻ giao tiếp đúng."}]'::jsonb,
  '[{"category": "Dạy trước", "strategies": ["Dạy kỹ năng giao tiếp", "Luyện tập trong tình huống bình thường"]}]'::jsonb,
  '[]'::jsonb
);

-- GROUP 02: HÀNH VI GÂY HẤN
INSERT INTO behavior_library (
  id, behavior_group_id, behavior_code, name_vn, name_en, icon,
  keywords_vn, keywords_en,
  manifestation_vn, age_range_min, age_range_max,
  explanation, solutions, prevention_strategies
) VALUES
(
  'ee0e8400-e29b-41d4-a716-446655440010',
  'dd0e8400-e29b-41d4-a716-446655440002',
  'BH_02_01',
  'Đánh người khác',
  'Hitting Others',
  '✋',
  '["đánh", "đập", "vả", "tát", "đấm"]'::jsonb,
  '["hitting", "slapping", "punching", "striking"]'::jsonb,
  'Trẻ sử dụng tay để đánh người khác, có thể là bạn bè, người lớn, hoặc anh chị em.',
  2,
  12,
  '[{"title": "Thiếu kỹ năng xã hội", "content": "Trẻ chưa biết cách giải quyết xung đột."}, {"title": "Mô phỏng", "content": "Trẻ bắt chước hành vi đã thấy."}]'::jsonb,
  '[{"step": 1, "title": "Ngăn chặn ngay lập tức", "description": "Dừng hành vi và đảm bảo an toàn."}, {"step": 2, "title": "Dạy cách xin lỗi", "description": "Hướng dẫn trẻ xin lỗi và sửa chữa."}, {"step": 3, "title": "Dạy kỹ năng thay thế", "description": "Dạy cách diễn đạt cảm xúc bằng lời."}]'::jsonb,
  '[{"category": "Giáo dục", "strategies": ["Dạy về cảm xúc", "Luyện tập kỹ năng xã hội"]}]'::jsonb
),
(
  'ee0e8400-e29b-41d4-a716-446655440011',
  'dd0e8400-e29b-41d4-a716-446655440002',
  'BH_02_02',
  'Cắn',
  'Biting',
  '🦷',
  '["cắn", "cắn người", "dùng răng cắn"]'::jsonb,
  '["biting", "teeth", "bite"]'::jsonb,
  'Trẻ sử dụng răng để cắn người khác, thường xảy ra trong xung đột hoặc khi thất vọng.',
  1,
  5,
  '[{"title": "Cảm giác miệng", "content": "Trẻ nhỏ khám phá thế giới bằng miệng."}, {"title": "Thất vọng", "content": "Trẻ không có cách khác để diễn đạt."}]'::jsonb,
  '[{"step": 1, "title": "Nói rõ không được cắn", "description": "Phản ứng ngay lập tức và nghiêm túc."}, {"step": 2, "title": "Cung cấp đồ cắn an toàn", "description": "Cho trẻ đồ chơi cắn phù hợp."}]'::jsonb,
  '[{"category": "Giám sát", "strategies": ["Giám sát chặt chẽ khi chơi nhóm", "Can thiệp sớm"]}]'::jsonb
);

-- GROUP 03: VẤN ĐỀ VỀ GIÁC QUAN
INSERT INTO behavior_library (
  id, behavior_group_id, behavior_code, name_vn, name_en, icon,
  keywords_vn, keywords_en,
  manifestation_vn, age_range_min, age_range_max,
  explanation, solutions, prevention_strategies
) VALUES
(
  'ee0e8400-e29b-41d4-a716-446655440020',
  'dd0e8400-e29b-41d4-a716-446655440003',
  'BH_03_01',
  'Bịt tai khi ồn',
  'Covering Ears',
  '🔇',
  '["bịt tai", "che tai", "sợ ồn", "nhạy cảm âm thanh"]'::jsonb,
  '["covering ears", "sensitive to noise", "auditory sensitivity"]'::jsonb,
  'Trẻ bịt tai bằng cả hai tay khi môi trường quá ồn, có thể kèm theo khóc hoặc chạy trốn.',
  2,
  18,
  '[{"title": "Nhạy cảm thính giác", "content": "Trẻ có ngưỡng chịu đựng âm thanh thấp hơn bình thường."}, {"title": "Quá tải cảm giác", "content": "Não bộ xử lý âm thanh quá mức."}]'::jsonb,
  '[{"step": 1, "title": "Giảm âm lượng môi trường", "description": "Tạo không gian yên tĩnh."}, {"step": 2, "title": "Sử dụng tai nghe chống ồn", "description": "Cung cấp công cụ hỗ trợ."}, {"step": 3, "title": "Desensitization dần dần", "description": "Tiếp xúc với âm thanh từ từ."}]'::jsonb,
  '[{"category": "Môi trường", "strategies": ["Tránh môi trường quá ồn", "Cảnh báo trước khi có âm thanh lớn"]}]'::jsonb
),
(
  'ee0e8400-e29b-41d4-a716-446655440021',
  'dd0e8400-e29b-41d4-a716-446655440003',
  'BH_03_02',
  'Từ chối chạm vào',
  'Tactile Defensiveness',
  '🚫',
  '["từ chối chạm", "sợ chạm", "nhạy cảm xúc giác", "không thích động"]'::jsonb,
  '["tactile defensiveness", "touch sensitive", "avoid touch"]'::jsonb,
  'Trẻ tránh né hoặc phản ứng mạnh khi bị chạm vào, đặc biệt ở mặt, tay, chân.',
  2,
  18,
  '[{"title": "Nhạy cảm xúc giác", "content": "Da trẻ phản ứng quá mức với kích thích nhẹ."}, {"title": "Trải nghiệm tiêu cực", "content": "Trẻ từng có trải nghiệm đau đớn khi bị chạm."}]'::jsonb,
  '[{"step": 1, "title": "Tôn trọng ranh giới", "description": "Không ép buộc trẻ."}, {"step": 2, "title": "Deep pressure massage", "description": "Sử dụng áp lực sâu thay vì chạm nhẹ."}, {"step": 3, "title": "Desensitization", "description": "Tiếp xúc dần với các chất liệu khác nhau."}]'::jsonb,
  '[{"category": "Cảnh báo", "strategies": ["Nói cho trẻ biết trước khi chạm", "Để trẻ chủ động chạm trước"]}]'::jsonb
);

-- ========================================
-- PART 3: CONTENT LIBRARY (System Templates)
-- ========================================

INSERT INTO content_library (
  id, teacher_id, code, title, domain, description,
  target_age_min, target_age_max, difficulty_level,
  materials_needed, estimated_duration, instructions, tips,
  is_template, is_public, tags, default_goals
) VALUES
(
  '220e8400-e29b-41d4-a716-446655440001',
  NULL,
  'CTL_SYS_001',
  'Tập ngồi yên',
  'social',
  'Rèn kỹ năng tự kiểm soát, ngồi yên trên ghế trong thời gian ngắn và tăng dần. Phù hợp cho trẻ có vấn đề về chú ý và kiểm soát hành vi.',
  3, 8, 'beginner',
  'Ghế nhỏ phù hợp với trẻ, đồng hồ cát hoặc đồng hồ bấm giờ, đồ chơi hoặc sách để giữ trẻ tập trung',
  15,
  'Bước 1: Đặt trẻ ngồi trên ghế. Bước 2: Đặt đồng hồ cát hoặc bấm giờ. Bước 3: Hướng dẫn trẻ ngồi yên cho đến khi hết giờ. Bước 4: Khen ngợi ngay khi trẻ hoàn thành.',
  'Bắt đầu với thời gian ngắn (1-2 phút) và tăng dần. Sử dụng visual timer để trẻ thấy thời gian còn lại. Khen ngợi cụ thể: "Con ngồi yên rất tốt!"',
  TRUE, TRUE,
  '["tự kiểm soát", "ngồi yên", "ABA basic", "social skills", "attention"]'::jsonb,
  '[
    {"description": "Ngồi yên không rời ghế trong 3 phút", "order": 1},
    {"description": "Ngồi yên không rời ghế trong 5 phút", "order": 2},
    {"description": "Ngồi yên không rời ghế trong 10 phút", "order": 3}
  ]'::jsonb
),
(
  '220e8400-e29b-41d4-a716-446655440002',
  NULL,
  'CTL_SYS_002',
  'Bắt chước âm thanh động vật',
  'language',
  'Phát triển khả năng bắt chước âm thanh, nền tảng cho kỹ năng ngôn ngữ. Sử dụng hình ảnh và âm thanh động vật quen thuộc.',
  2, 6, 'beginner',
  'Thẻ hình động vật (chó, mèo, gà, bò, vịt), loa phát âm thanh động vật, hoặc video',
  20,
  'Bước 1: Cho trẻ xem hình động vật. Bước 2: Phát âm thanh động vật. Bước 3: Mô phỏng âm thanh và khuyến khích trẻ bắt chước. Bước 4: Khen ngợi ngay khi trẻ cố gắng bắt chước.',
  'Bắt đầu với 2-3 động vật dễ (chó, mèo). Phóng đại âm thanh và khuôn mặt khi mô phỏng. Chấp nhận mọi nỗ lực của trẻ, không cần hoàn hảo.',
  TRUE, TRUE,
  '["ngôn ngữ", "bắt chước", "âm thanh", "động vật", "imitation"]'::jsonb,
  '[
    {"description": "Bắt chước đúng 2/5 âm thanh động vật", "order": 1},
    {"description": "Bắt chước đúng 3/5 âm thanh động vật", "order": 2},
    {"description": "Tự phát âm khi thấy hình ảnh (2/5 hình)", "order": 3}
  ]'::jsonb
),
(
  '220e8400-e29b-41d4-a716-446655440003',
  NULL,
  'CTL_SYS_003',
  'Ghép hình cơ bản',
  'cognitive',
  'Phát triển tư duy không gian, nhận biết hình dạng và màu sắc. Hoạt động nền tảng cho kỹ năng toán học.',
  3, 7, 'beginner',
  'Bộ ghép hình gỗ hoặc nhựa (hình tròn, vuông, tam giác), bảng ghép hình',
  25,
  'Bước 1: Đặt các mảnh ghép trước mặt trẻ. Bước 2: Chỉ vào một vị trí trên bảng. Bước 3: Hướng dẫn trẻ tìm mảnh phù hợp. Bước 4: Khen ngợi khi ghép đúng.',
  'Bắt đầu với 3 hình cơ bản. Sử dụng hand-over-hand prompting nếu cần. Tăng số lượng hình dần dần.',
  TRUE, TRUE,
  '["cognitive", "shapes", "spatial", "matching", "problem solving"]'::jsonb,
  '[
    {"description": "Ghép đúng 3 hình cơ bản (tròn, vuông, tam giác)", "order": 1},
    {"description": "Ghép đúng 5 hình trong 10 phút", "order": 2},
    {"description": "Tự ghép mà không cần hướng dẫn", "order": 3}
  ]'::jsonb
),
(
  '220e8400-e29b-41d4-a716-446655440004',
  NULL,
  'CTL_SYS_004',
  'Rửa tay đúng cách',
  'self_care',
  'Dạy kỹ năng tự phục vụ cơ bản, vệ sinh cá nhân. Quan trọng cho sức khỏe và độc lập.',
  3, 10, 'beginner',
  'Bồn rửa tay, xà phòng, khăn lau, hình ảnh minh họa các bước rửa tay',
  10,
  'Bước 1: Mở vòi nước. Bước 2: Ướt tay. Bước 3: Lấy xà phòng. Bước 4: Chà xát đều 2 tay. Bước 5: Xả sạch. Bước 6: Lau khô.',
  'Dán hình ảnh từng bước ở bồn rửa. Hát bài hát trong khi rửa tay (20 giây). Khen ngợi từng bước hoàn thành.',
  TRUE, TRUE,
  '["self care", "hygiene", "independence", "daily living skills"]'::jsonb,
  '[
    {"description": "Rửa tay với hướng dẫn từng bước", "order": 1},
    {"description": "Rửa tay với nhắc nhở tối thiểu", "order": 2},
    {"description": "Tự rửa tay hoàn toàn độc lập", "order": 3}
  ]'::jsonb
),
(
  '220e8400-e29b-41d4-a716-446655440005',
  NULL,
  'CTL_SYS_005',
  'Giao tiếp bằng mắt',
  'social',
  'Phát triển kỹ năng giao tiếp phi ngôn ngữ quan trọng. Nền tảng cho tương tác xã hội.',
  2, 8, 'beginner',
  'Đồ chơi hoặc đồ ăn yêu thích của trẻ, gương (tùy chọn)',
  15,
  'Bước 1: Cầm đồ vật ở tầm mắt bạn. Bước 2: Gọi tên trẻ. Bước 3: Chờ trẻ nhìn vào mắt bạn. Bước 4: Ngay lập tức cho trẻ đồ vật và khen ngợi.',
  'Bắt đầu với thời gian rất ngắn (1 giây). Sử dụng đồ vật trẻ cực kỳ thích. Khen ngợi mọi nỗ lực nhìn về phía bạn.',
  TRUE, TRUE,
  '["social skills", "eye contact", "communication", "non-verbal"]'::jsonb,
  '[
    {"description": "Nhìn vào mắt người lớn trong 1 giây", "order": 1},
    {"description": "Nhìn vào mắt người lớn trong 3 giây", "order": 2},
    {"description": "Tự động nhìn vào mắt khi được gọi tên", "order": 3}
  ]'::jsonb
);

-- ========================================
-- VERIFICATION
-- ========================================

-- Check behavior groups
SELECT code, name_vn, icon, color_code 
FROM behavior_groups 
ORDER BY order_index;

-- Check behavior library count
SELECT 
  bg.name_vn as group_name,
  COUNT(bl.id) as behavior_count
FROM behavior_groups bg
LEFT JOIN behavior_library bl ON bg.id = bl.behavior_group_id
GROUP BY bg.id, bg.name_vn, bg.order_index
ORDER BY bg.order_index;

-- Check content library templates
SELECT 
  code,
  title,
  domain,
  difficulty_level,
  is_public
FROM content_library
WHERE teacher_id IS NULL
ORDER BY code;

-- Verify JSONB data
SELECT 
  name_vn,
  keywords_vn,
  jsonb_array_length(solutions) as solution_steps
FROM behavior_library
WHERE behavior_code = 'BH_01_01';

SELECT 
  title,
  tags,
  jsonb_array_length(default_goals) as goal_count
FROM content_library
WHERE code = 'CTL_SYS_001';
