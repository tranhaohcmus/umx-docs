-- ============================================================================
-- EDUCARE CONNECT - SUPABASE DATABASE SCHEMA
-- ============================================================================
-- Version: 1.0
-- Database: PostgreSQL (Supabase)
-- Description: Complete database schema for EduCare Connect application
-- ============================================================================

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- ENUMS
-- ============================================================================

-- Student status
CREATE TYPE student_status AS ENUM ('active', 'paused', 'archived');

-- Time slots
CREATE TYPE time_slot AS ENUM ('morning', 'afternoon', 'evening');

-- Session creation method
CREATE TYPE creation_method AS ENUM ('manual', 'ai');

-- Session status
CREATE TYPE session_status AS ENUM ('pending', 'completed');

-- Goal evaluation status
CREATE TYPE evaluation_status AS ENUM ('achieved', 'not_achieved', 'not_applicable');

-- Media type
CREATE TYPE media_type AS ENUM ('image', 'video', 'audio');

-- Behavior category
CREATE TYPE behavior_category AS ENUM ('aggression', 'avoidance', 'attention', 'self_stim');

-- Behavior function
CREATE TYPE behavior_function AS ENUM ('attention', 'escape', 'sensory', 'tangible');

-- Content domain
CREATE TYPE content_domain AS ENUM ('cognitive', 'motor', 'language', 'social', 'self_care');

-- Backup type
CREATE TYPE backup_type AS ENUM ('manual', 'auto');

-- Processing status
CREATE TYPE processing_status AS ENUM ('pending', 'processing', 'completed', 'failed', 'cancelled');

-- Gender
CREATE TYPE gender_type AS ENUM ('male', 'female', 'other');

-- ============================================================================
-- TABLE: TEACHERS
-- ============================================================================

CREATE TABLE teachers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    school VARCHAR(255),
    avatar_url TEXT,
    password TEXT NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    email_verified_at TIMESTAMPTZ,
    two_fa_enabled BOOLEAN DEFAULT FALSE,
    two_fa_secret TEXT,
    last_login TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for teachers
CREATE INDEX idx_teachers_email ON teachers(email);
CREATE INDEX idx_teachers_created_at ON teachers(created_at);

-- ============================================================================
-- TABLE: STUDENTS
-- ============================================================================

CREATE TABLE students (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    full_name VARCHAR(255) NOT NULL,
    nickname VARCHAR(100),
    age INTEGER CHECK (age > 0 AND age < 100),
    gender gender_type,
    avatar_url TEXT,
    status student_status DEFAULT 'active',
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for students
CREATE INDEX idx_students_teacher_id ON students(teacher_id);
CREATE INDEX idx_students_status ON students(status);
CREATE INDEX idx_students_full_name ON students(full_name);
CREATE INDEX idx_students_created_at ON students(created_at);

-- ============================================================================
-- TABLE: SESSIONS
-- ============================================================================

CREATE TABLE sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    time_slot time_slot NOT NULL,
    start_time TIME,
    end_time TIME,
    notes TEXT,
    creation_method creation_method DEFAULT 'manual',
    status session_status DEFAULT 'pending',
    has_evaluation BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT check_time_order CHECK (end_time > start_time)
);

-- Indexes for sessions
CREATE INDEX idx_sessions_student_id ON sessions(student_id);
CREATE INDEX idx_sessions_date ON sessions(date);
CREATE INDEX idx_sessions_status ON sessions(status);
CREATE INDEX idx_sessions_date_student ON sessions(date, student_id);
CREATE INDEX idx_sessions_created_at ON sessions(created_at);

-- ============================================================================
-- TABLE: CONTENT_LIBRARY
-- ============================================================================

CREATE TABLE content_library (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID REFERENCES teachers(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    domain content_domain NOT NULL,
    description TEXT,
    default_goals JSONB DEFAULT '[]'::jsonb,
    is_template BOOLEAN DEFAULT FALSE,
    usage_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for content_library
CREATE INDEX idx_content_library_teacher_id ON content_library(teacher_id);
CREATE INDEX idx_content_library_domain ON content_library(domain);
CREATE INDEX idx_content_library_is_template ON content_library(is_template);
CREATE INDEX idx_content_library_name ON content_library(name);

-- ============================================================================
-- TABLE: SESSION_CONTENTS
-- ============================================================================

CREATE TABLE session_contents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
    content_library_id UUID REFERENCES content_library(id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    domain content_domain NOT NULL,
    description TEXT,
    order_index INTEGER NOT NULL DEFAULT 0,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for session_contents
CREATE INDEX idx_session_contents_session_id ON session_contents(session_id);
CREATE INDEX idx_session_contents_content_library_id ON session_contents(content_library_id);
CREATE INDEX idx_session_contents_order ON session_contents(session_id, order_index);

-- ============================================================================
-- TABLE: CONTENT_GOALS
-- ============================================================================

CREATE TABLE content_goals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_content_id UUID NOT NULL REFERENCES session_contents(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    order_index INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for content_goals
CREATE INDEX idx_content_goals_session_content_id ON content_goals(session_content_id);
CREATE INDEX idx_content_goals_order ON content_goals(session_content_id, order_index);

-- ============================================================================
-- TABLE: SESSION_LOGS
-- ============================================================================

CREATE TABLE session_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id UUID NOT NULL UNIQUE REFERENCES sessions(id) ON DELETE CASCADE,
    logged_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ,
    mood VARCHAR(50),
    cooperation_level INTEGER CHECK (cooperation_level >= 1 AND cooperation_level <= 5),
    focus_level INTEGER CHECK (focus_level >= 1 AND focus_level <= 5),
    independence_level INTEGER CHECK (independence_level >= 1 AND independence_level <= 5),
    attitude_notes TEXT,
    teacher_notes_text TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for session_logs
CREATE INDEX idx_session_logs_session_id ON session_logs(session_id);
CREATE INDEX idx_session_logs_logged_at ON session_logs(logged_at);
CREATE INDEX idx_session_logs_completed_at ON session_logs(completed_at);

-- ============================================================================
-- TABLE: GOAL_EVALUATIONS
-- ============================================================================

CREATE TABLE goal_evaluations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_log_id UUID NOT NULL REFERENCES session_logs(id) ON DELETE CASCADE,
    content_goal_id UUID NOT NULL REFERENCES content_goals(id) ON DELETE CASCADE,
    status evaluation_status NOT NULL,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(session_log_id, content_goal_id)
);

-- Indexes for goal_evaluations
CREATE INDEX idx_goal_evaluations_session_log_id ON goal_evaluations(session_log_id);
CREATE INDEX idx_goal_evaluations_content_goal_id ON goal_evaluations(content_goal_id);
CREATE INDEX idx_goal_evaluations_status ON goal_evaluations(status);

-- ============================================================================
-- TABLE: LOG_MEDIA_ATTACHMENTS
-- ============================================================================

CREATE TABLE log_media_attachments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_log_id UUID NOT NULL REFERENCES session_logs(id) ON DELETE CASCADE,
    type media_type NOT NULL,
    url TEXT NOT NULL,
    filename VARCHAR(255),
    file_size BIGINT,
    duration INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for log_media_attachments
CREATE INDEX idx_log_media_attachments_session_log_id ON log_media_attachments(session_log_id);
CREATE INDEX idx_log_media_attachments_type ON log_media_attachments(type);

-- ============================================================================
-- TABLE: BEHAVIOR_LIBRARY
-- ============================================================================

CREATE TABLE behavior_library (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name_vn VARCHAR(255) NOT NULL,
    name_en VARCHAR(255),
    category behavior_category NOT NULL,
    description TEXT,
    definition TEXT,
    function behavior_function,
    examples JSONB DEFAULT '[]'::jsonb,
    common_antecedents JSONB DEFAULT '[]'::jsonb,
    common_consequences JSONB DEFAULT '[]'::jsonb,
    intervention_tips JSONB DEFAULT '[]'::jsonb,
    icon VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for behavior_library
CREATE INDEX idx_behavior_library_category ON behavior_library(category);
CREATE INDEX idx_behavior_library_function ON behavior_library(function);
CREATE INDEX idx_behavior_library_is_active ON behavior_library(is_active);
CREATE INDEX idx_behavior_library_name_vn ON behavior_library(name_vn);

-- ============================================================================
-- TABLE: BEHAVIOR_INCIDENTS
-- ============================================================================

CREATE TABLE behavior_incidents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_log_id UUID NOT NULL REFERENCES session_logs(id) ON DELETE CASCADE,
    behavior_library_id UUID NOT NULL REFERENCES behavior_library(id) ON DELETE RESTRICT,
    antecedent TEXT,
    behavior_description TEXT NOT NULL,
    consequence TEXT,
    severity_level INTEGER CHECK (severity_level >= 1 AND severity_level <= 5),
    occurred_at TIMESTAMPTZ NOT NULL,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for behavior_incidents
CREATE INDEX idx_behavior_incidents_session_log_id ON behavior_incidents(session_log_id);
CREATE INDEX idx_behavior_incidents_behavior_library_id ON behavior_incidents(behavior_library_id);
CREATE INDEX idx_behavior_incidents_occurred_at ON behavior_incidents(occurred_at);
CREATE INDEX idx_behavior_incidents_severity_level ON behavior_incidents(severity_level);

-- ============================================================================
-- TABLE: TEACHER_FAVORITES
-- ============================================================================

CREATE TABLE teacher_favorites (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    behavior_library_id UUID NOT NULL REFERENCES behavior_library(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(teacher_id, behavior_library_id)
);

-- Indexes for teacher_favorites
CREATE INDEX idx_teacher_favorites_teacher_id ON teacher_favorites(teacher_id);
CREATE INDEX idx_teacher_favorites_behavior_library_id ON teacher_favorites(behavior_library_id);

-- ============================================================================
-- TABLE: USER_SETTINGS
-- ============================================================================

CREATE TABLE user_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    key VARCHAR(100) NOT NULL,
    value JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(teacher_id, key)
);

-- Indexes for user_settings
CREATE INDEX idx_user_settings_teacher_id ON user_settings(teacher_id);
CREATE INDEX idx_user_settings_key ON user_settings(key);

-- ============================================================================
-- TABLE: BACKUP_HISTORY
-- ============================================================================

CREATE TABLE backup_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    backup_type backup_type NOT NULL,
    file_url TEXT,
    file_size BIGINT,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for backup_history
CREATE INDEX idx_backup_history_teacher_id ON backup_history(teacher_id);
CREATE INDEX idx_backup_history_created_at ON backup_history(created_at);
CREATE INDEX idx_backup_history_status ON backup_history(status);

-- ============================================================================
-- TABLE: AI_PROCESSING
-- ============================================================================

CREATE TABLE ai_processing (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    student_id UUID REFERENCES students(id) ON DELETE SET NULL,
    file_url TEXT,
    file_type VARCHAR(50),
    text_content TEXT,
    processing_status processing_status DEFAULT 'pending',
    progress INTEGER DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
    result_sessions JSONB,
    error_message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- Indexes for ai_processing
CREATE INDEX idx_ai_processing_teacher_id ON ai_processing(teacher_id);
CREATE INDEX idx_ai_processing_student_id ON ai_processing(student_id);
CREATE INDEX idx_ai_processing_status ON ai_processing(processing_status);
CREATE INDEX idx_ai_processing_created_at ON ai_processing(created_at);

-- ============================================================================
-- TABLE: NOTIFICATIONS (Additional table for push notifications)
-- ============================================================================

CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    data JSONB,
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for notifications
CREATE INDEX idx_notifications_teacher_id ON notifications(teacher_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
CREATE INDEX idx_notifications_created_at ON notifications(created_at);

-- ============================================================================
-- TABLE: REFRESH_TOKENS (For JWT refresh token management)
-- ============================================================================

CREATE TABLE refresh_tokens (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    token TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    is_revoked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for refresh_tokens
CREATE INDEX idx_refresh_tokens_teacher_id ON refresh_tokens(teacher_id);
CREATE INDEX idx_refresh_tokens_token ON refresh_tokens(token);
CREATE INDEX idx_refresh_tokens_expires_at ON refresh_tokens(expires_at);

-- ============================================================================
-- TABLE: PASSWORD_RESET_TOKENS
-- ============================================================================

CREATE TABLE password_reset_tokens (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    token TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for password_reset_tokens
CREATE INDEX idx_password_reset_tokens_token ON password_reset_tokens(token);
CREATE INDEX idx_password_reset_tokens_teacher_id ON password_reset_tokens(teacher_id);

-- ============================================================================
-- FUNCTIONS & TRIGGERS
-- ============================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at trigger to all tables that need it
CREATE TRIGGER update_teachers_updated_at BEFORE UPDATE ON teachers
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_students_updated_at BEFORE UPDATE ON students
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sessions_updated_at BEFORE UPDATE ON sessions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_session_contents_updated_at BEFORE UPDATE ON session_contents
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_content_goals_updated_at BEFORE UPDATE ON content_goals
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_session_logs_updated_at BEFORE UPDATE ON session_logs
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_goal_evaluations_updated_at BEFORE UPDATE ON goal_evaluations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_behavior_library_updated_at BEFORE UPDATE ON behavior_library
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_behavior_incidents_updated_at BEFORE UPDATE ON behavior_incidents
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_content_library_updated_at BEFORE UPDATE ON content_library
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_settings_updated_at BEFORE UPDATE ON user_settings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to update session has_evaluation flag
CREATE OR REPLACE FUNCTION update_session_has_evaluation()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE sessions 
    SET has_evaluation = TRUE 
    WHERE id = NEW.session_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_session_has_evaluation
AFTER INSERT ON session_logs
FOR EACH ROW
EXECUTE FUNCTION update_session_has_evaluation();

-- Function to increment content library usage count
CREATE OR REPLACE FUNCTION increment_content_usage()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.content_library_id IS NOT NULL THEN
        UPDATE content_library 
        SET usage_count = usage_count + 1 
        WHERE id = NEW.content_library_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_increment_content_usage
AFTER INSERT ON session_contents
FOR EACH ROW
EXECUTE FUNCTION increment_content_usage();

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE teachers ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_contents ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE goal_evaluations ENABLE ROW LEVEL SECURITY;
ALTER TABLE log_media_attachments ENABLE ROW LEVEL SECURITY;
ALTER TABLE behavior_incidents ENABLE ROW LEVEL SECURITY;
ALTER TABLE teacher_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE backup_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_processing ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_library ENABLE ROW LEVEL SECURITY;

-- Teachers policies
CREATE POLICY "Teachers can view own profile" ON teachers
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Teachers can update own profile" ON teachers
    FOR UPDATE USING (auth.uid() = id);

-- Students policies
CREATE POLICY "Teachers can view own students" ON students
    FOR SELECT USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers can insert own students" ON students
    FOR INSERT WITH CHECK (auth.uid() = teacher_id);

CREATE POLICY "Teachers can update own students" ON students
    FOR UPDATE USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers can delete own students" ON students
    FOR DELETE USING (auth.uid() = teacher_id);

-- Sessions policies
CREATE POLICY "Teachers can view own students' sessions" ON sessions
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM students 
            WHERE students.id = sessions.student_id 
            AND students.teacher_id = auth.uid()
        )
    );

CREATE POLICY "Teachers can insert sessions for own students" ON sessions
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM students 
            WHERE students.id = sessions.student_id 
            AND students.teacher_id = auth.uid()
        )
    );

CREATE POLICY "Teachers can update own students' sessions" ON sessions
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM students 
            WHERE students.id = sessions.student_id 
            AND students.teacher_id = auth.uid()
        )
    );

CREATE POLICY "Teachers can delete own students' sessions" ON sessions
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM students 
            WHERE students.id = sessions.student_id 
            AND students.teacher_id = auth.uid()
        )
    );

-- Session contents policies
CREATE POLICY "Teachers can manage session contents" ON session_contents
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM sessions s
            JOIN students st ON s.student_id = st.id
            WHERE s.id = session_contents.session_id 
            AND st.teacher_id = auth.uid()
        )
    );

-- Content goals policies
CREATE POLICY "Teachers can manage content goals" ON content_goals
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM session_contents sc
            JOIN sessions s ON sc.session_id = s.id
            JOIN students st ON s.student_id = st.id
            WHERE sc.id = content_goals.session_content_id 
            AND st.teacher_id = auth.uid()
        )
    );

-- Session logs policies
CREATE POLICY "Teachers can manage session logs" ON session_logs
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM sessions s
            JOIN students st ON s.student_id = st.id
            WHERE s.id = session_logs.session_id 
            AND st.teacher_id = auth.uid()
        )
    );

-- Goal evaluations policies
CREATE POLICY "Teachers can manage goal evaluations" ON goal_evaluations
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM session_logs sl
            JOIN sessions s ON sl.session_id = s.id
            JOIN students st ON s.student_id = st.id
            WHERE sl.id = goal_evaluations.session_log_id 
            AND st.teacher_id = auth.uid()
        )
    );

-- Log media attachments policies
CREATE POLICY "Teachers can manage log media" ON log_media_attachments
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM session_logs sl
            JOIN sessions s ON sl.session_id = s.id
            JOIN students st ON s.student_id = st.id
            WHERE sl.id = log_media_attachments.session_log_id 
            AND st.teacher_id = auth.uid()
        )
    );

-- Behavior incidents policies
CREATE POLICY "Teachers can manage behavior incidents" ON behavior_incidents
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM session_logs sl
            JOIN sessions s ON sl.session_id = s.id
            JOIN students st ON s.student_id = st.id
            WHERE sl.id = behavior_incidents.session_log_id 
            AND st.teacher_id = auth.uid()
        )
    );

-- Behavior library policies (public read, no write)
CREATE POLICY "Everyone can read behavior library" ON behavior_library
    FOR SELECT USING (is_active = true);

-- Teacher favorites policies
CREATE POLICY "Teachers can manage own favorites" ON teacher_favorites
    FOR ALL USING (auth.uid() = teacher_id);

-- User settings policies
CREATE POLICY "Teachers can manage own settings" ON user_settings
    FOR ALL USING (auth.uid() = teacher_id);

-- Backup history policies
CREATE POLICY "Teachers can view own backups" ON backup_history
    FOR SELECT USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers can create own backups" ON backup_history
    FOR INSERT WITH CHECK (auth.uid() = teacher_id);

-- AI processing policies
CREATE POLICY "Teachers can manage own AI processing" ON ai_processing
    FOR ALL USING (auth.uid() = teacher_id);

-- Notifications policies
CREATE POLICY "Teachers can manage own notifications" ON notifications
    FOR ALL USING (auth.uid() = teacher_id);

-- Content library policies
CREATE POLICY "Teachers can view all templates and own content" ON content_library
    FOR SELECT USING (
        is_template = true OR teacher_id = auth.uid() OR teacher_id IS NULL
    );

CREATE POLICY "Teachers can create own content" ON content_library
    FOR INSERT WITH CHECK (auth.uid() = teacher_id);

CREATE POLICY "Teachers can update own content" ON content_library
    FOR UPDATE USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers can delete own content" ON content_library
    FOR DELETE USING (auth.uid() = teacher_id);

-- ============================================================================
-- VIEWS FOR ANALYTICS
-- ============================================================================

-- View: Student statistics
CREATE OR REPLACE VIEW student_stats AS
SELECT 
    s.id as student_id,
    s.full_name,
    s.teacher_id,
    COUNT(DISTINCT ses.id) as total_sessions,
    COUNT(DISTINCT CASE WHEN ses.status = 'completed' THEN ses.id END) as completed_sessions,
    COUNT(DISTINCT bi.id) as total_behavior_incidents,
    COALESCE(
        ROUND(
            COUNT(DISTINCT CASE WHEN ses.status = 'completed' THEN ses.id END)::numeric / 
            NULLIF(COUNT(DISTINCT ses.id), 0), 
            2
        ), 
        0
    ) as completion_rate
FROM students s
LEFT JOIN sessions ses ON s.id = ses.student_id
LEFT JOIN session_logs sl ON ses.id = sl.session_id
LEFT JOIN behavior_incidents bi ON sl.id = bi.session_log_id
GROUP BY s.id, s.full_name, s.teacher_id;

-- View: Session summary with goal achievement
CREATE OR REPLACE VIEW session_summary AS
SELECT 
    ses.id as session_id,
    ses.student_id,
    ses.date,
    ses.status,
    COUNT(DISTINCT sc.id) as content_count,
    COUNT(DISTINCT cg.id) as goal_count,
    COUNT(DISTINCT CASE WHEN ge.status = 'achieved' THEN ge.id END) as goals_achieved,
    COUNT(DISTINCT bi.id) as behavior_count
FROM sessions ses
LEFT JOIN session_contents sc ON ses.id = sc.session_id
LEFT JOIN content_goals cg ON sc.id = cg.session_content_id
LEFT JOIN session_logs sl ON ses.id = sl.session_id
LEFT JOIN goal_evaluations ge ON sl.id = ge.session_log_id
LEFT JOIN behavior_incidents bi ON sl.id = bi.session_log_id
GROUP BY ses.id, ses.student_id, ses.date, ses.status;