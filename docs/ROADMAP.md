# 🚀 LỘ TRÌNH CHI TIẾT CODE BACKEND - EDUCARE CONNECT API

**Version:** 1.0  
**Date:** 2025-11-05  
**Author:** tranhaohcmus  
**Stack:** Node.js + Express + PostgreSQL + Prisma + Redis + R2

---

## 📋 MỤC LỤC

1. [Setup & Infrastructure](#1-setup--infrastructure)
2. [Core Architecture](#2-core-architecture)
3. [Authentication System](#3-authentication-system)
4. [API Development Phases](#4-api-development-phases)
5. [Testing Strategy](#5-testing-strategy)
6. [Deployment & DevOps](#6-deployment--devops)

---

## 1. SETUP & INFRASTRUCTURE

### Phase 1.1: Project Initialization (Day 1)

```bash
# 1. Create project
mkdir educare-api
cd educare-api
npm init -y

# 2. Install core dependencies
npm install express @prisma/client bcryptjs jsonwebtoken
npm install dotenv cors helmet express-rate-limit
npm install joi validator express-validator
npm install winston morgan
npm install bull bullmq ioredis
npm install @aws-sdk/client-s3 @aws-sdk/s3-request-presigner

# 3. Install dev dependencies
npm install -D nodemon typescript @types/node @types/express
npm install -D prisma
npm install -D jest supertest @types/jest
npm install -D eslint prettier eslint-config-airbnb-base
npm install -D ts-node ts-node-dev

# 4. Initialize TypeScript
npx tsc --init

# 5. Initialize Prisma
npx prisma init
```

### Phase 1.2: Project Structure

```
educare-api/
├── src/
│   ├── config/
│   │   ├── database.ts          # Prisma client
│   │   ├── redis.ts             # Redis connection
│   │   ├── r2.ts                # Cloudflare R2 config
│   │   ├── openai.ts            # GPT-4 config
│   │   └── index.ts
│   ├── middlewares/
│   │   ├── auth.ts              # JWT verification
│   │   ├── validate.ts          # Request validation
│   │   ├── errorHandler.ts      # Global error handler
│   │   ├── rateLimit.ts         # Rate limiting
│   │   └── upload.ts            # File upload (multer)
│   ├── utils/
│   │   ├── logger.ts            # Winston logger
│   │   ├── jwt.ts               # JWT helpers
│   │   ├── password.ts          # Bcrypt helpers
│   │   ├── email.ts             # Email service
│   │   └── validators.ts        # Custom validators
│   ├── types/
│   │   ├── express.d.ts         # Express type extensions
│   │   └── index.ts
│   ├── modules/
│   │   ├── auth/
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.service.ts
│   │   │   ├── auth.routes.ts
│   │   │   ├── auth.validation.ts
│   │   │   └── auth.test.ts
│   │   ├── teachers/
│   │   ├── students/
│   │   ├── sessions/
│   │   ├── session-logs/
│   │   ├── behaviors/
│   │   ├── content-library/
│   │   ├── ai-processing/
│   │   ├── analytics/
│   │   └── sync/
│   ├── jobs/
│   │   ├── ai-processing.job.ts
│   │   ├── report-generation.job.ts
│   │   └── backup.job.ts
│   ├── app.ts                   # Express app
│   └── server.ts                # Server entry point
├── prisma/
│   ├── schema.prisma
│   ├── migrations/
│   └── seed.ts
├── tests/
│   ├── integration/
│   ├── unit/
│   └── helpers/
├── .env.example
├── .eslintrc.js
├── .prettierrc
├── tsconfig.json
├── jest.config.js
└── package.json
```

### Phase 1.3: Environment Variables

**.env.example:**
```bash
# Server
NODE_ENV=development
PORT=3000
API_VERSION=v1

# Database
DATABASE_URL="postgresql://user:password@localhost:5432/educare_dev?schema=public"

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# JWT
JWT_SECRET=your-super-secret-key-change-in-production
JWT_EXPIRES_IN=1h
JWT_REFRESH_SECRET=your-refresh-secret
JWT_REFRESH_EXPIRES_IN=7d

# Email (SendGrid/SMTP)
EMAIL_FROM=noreply@educare.com
SENDGRID_API_KEY=
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=

# Cloudflare R2
R2_ACCOUNT_ID=
R2_ACCESS_KEY_ID=
R2_SECRET_ACCESS_KEY=
R2_BUCKET_NAME=educare-storage
R2_PUBLIC_URL=https://pub-xxx.r2.dev

# OpenAI
OPENAI_API_KEY=sk-...
OPENAI_MODEL=gpt-4-turbo-preview

# Rate Limiting
RATE_LIMIT_WINDOW_MS=60000
RATE_LIMIT_MAX_REQUESTS=100

# CORS
CORS_ORIGIN=http://localhost:3001,https://app.educare.com
```

### Phase 1.4: Prisma Schema Setup

**prisma/schema.prisma:**
```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model Teacher {
  id              String    @id @default(uuid())
  email           String    @unique
  password_hash   String
  first_name      String
  last_name       String
  phone           String?
  school          String?
  avatar_url      String?
  timezone        String    @default("Asia/Ho_Chi_Minh")
  language        String    @default("vi")
  is_verified     Boolean   @default(false)
  is_active       Boolean   @default(true)
  last_login_at   DateTime?
  created_at      DateTime  @default(now())
  updated_at      DateTime  @updatedAt
  deleted_at      DateTime?

  students            Student[]
  content_library     ContentLibrary[]
  template_ratings    TemplateRating[]
  teacher_favorites   TeacherFavorite[]
  ai_processing       AiProcessing[]
  
  @@map("teachers")
}

model Student {
  id              String    @id @default(uuid())
  teacher_id      String
  first_name      String
  last_name       String
  nickname        String?
  date_of_birth   DateTime
  gender          String
  avatar_url      String?
  status          String    @default("active") // active, paused, archived
  diagnosis       String?
  notes           String?   @db.Text
  parent_name     String?
  parent_phone    String?
  created_at      DateTime  @default(now())
  updated_at      DateTime  @updatedAt
  deleted_at      DateTime?

  teacher         Teacher   @relation(fields: [teacher_id], references: [id])
  sessions        Session[]
  
  @@map("students")
  @@index([teacher_id])
}

model Session {
  id                  String    @id @default(uuid())
  student_id          String
  session_date        DateTime  @db.Date
  time_slot           String    // morning, afternoon, evening
  start_time          DateTime  @db.Time
  end_time            DateTime  @db.Time
  duration_minutes    Int
  location            String?
  notes               String?   @db.Text
  creation_method     String    @default("manual") // manual, ai
  status              String    @default("pending") // pending, completed, cancelled
  cancellation_reason String?
  cancelled_at        DateTime?
  has_evaluation      Boolean   @default(false)
  created_by          String
  created_at          DateTime  @default(now())
  updated_at          DateTime  @updatedAt
  deleted_at          DateTime?

  student             Student         @relation(fields: [student_id], references: [id])
  contents            SessionContent[]
  session_log         SessionLog?
  
  @@map("sessions")
  @@index([student_id])
  @@index([session_date])
}

model SessionContent {
  id                    String   @id @default(uuid())
  session_id            String
  content_library_id    String?
  title                 String
  domain                String   // cognitive, motor, language, social, self_care
  description           String?  @db.Text
  materials_needed      String?
  estimated_duration    Int
  instructions          String?  @db.Text
  tips                  String?  @db.Text
  order_index           Int
  created_at            DateTime @default(now())
  updated_at            DateTime @updatedAt

  session               Session              @relation(fields: [session_id], references: [id], onDelete: Cascade)
  content_library       ContentLibrary?      @relation(fields: [content_library_id], references: [id])
  goals                 SessionContentGoal[]
  
  @@map("session_contents")
  @@index([session_id])
  @@unique([session_id, order_index])
}

model SessionContentGoal {
  id                  String   @id @default(uuid())
  session_content_id  String
  description         String
  goal_type           String   // knowledge, skill, behavior
  is_primary          Boolean  @default(false)
  order_index         Int
  created_at          DateTime @default(now())

  session_content     SessionContent    @relation(fields: [session_content_id], references: [id], onDelete: Cascade)
  evaluations         GoalEvaluation[]
  
  @@map("session_content_goals")
  @@index([session_content_id])
  @@unique([session_content_id, order_index])
}

model SessionLog {
  id                      String    @id @default(uuid())
  session_id              String    @unique
  logged_at               DateTime  @default(now())
  mood                    String?   // very_difficult, difficult, normal, good, very_good
  energy_level            Int?      // 1-5
  cooperation_level       Int?      // 1-5
  focus_level             Int?      // 1-5
  independence_level      Int?      // 1-5
  attitude_summary        String?   @db.Text
  progress_notes          String?   @db.Text
  challenges_faced        String?   @db.Text
  recommendations         String?   @db.Text
  teacher_notes_text      String?   @db.Text
  overall_rating          Int?      // 1-5
  actual_start_time       DateTime? @db.Time
  actual_end_time         DateTime? @db.Time
  completed_at            DateTime?
  created_by              String
  created_at              DateTime  @default(now())
  updated_at              DateTime  @updatedAt

  session                 Session             @relation(fields: [session_id], references: [id], onDelete: Cascade)
  goal_evaluations        GoalEvaluation[]
  media_attachments       MediaAttachment[]
  behavior_incidents      BehaviorIncident[]
  
  @@map("session_logs")
}

model GoalEvaluation {
  id                  String   @id @default(uuid())
  session_log_id      String
  content_goal_id     String
  status              String   // achieved, partially_achieved, not_achieved, not_applicable
  achievement_level   Int?     // 0-100
  support_level       String?  // independent, minimal_prompt, moderate_prompt, substantial_prompt, full_assistance
  notes               String?  @db.Text
  created_at          DateTime @default(now())
  updated_at          DateTime @updatedAt

  session_log         SessionLog         @relation(fields: [session_log_id], references: [id], onDelete: Cascade)
  content_goal        SessionContentGoal @relation(fields: [content_goal_id], references: [id])
  
  @@map("goal_evaluations")
  @@index([session_log_id])
  @@unique([session_log_id, content_goal_id])
}

// ... (Continue với các models khác: BehaviorGroup, BehaviorLibrary, ContentLibrary, etc.)
```

---

## 2. CORE ARCHITECTURE

### Phase 2.1: Base Configuration Files

**src/config/database.ts:**
```typescript
import { PrismaClient } from '@prisma/client';
import logger from '../utils/logger';

const prisma = new PrismaClient({
  log: [
    { level: 'query', emit: 'event' },
    { level: 'error', emit: 'event' },
    { level: 'warn', emit: 'event' },
  ],
});

// Log queries in development
if (process.env.NODE_ENV === 'development') {
  prisma.$on('query', (e: any) => {
    logger.debug(`Query: ${e.query}`);
    logger.debug(`Duration: ${e.duration}ms`);
  });
}

prisma.$on('error', (e: any) => {
  logger.error('Prisma error:', e);
});

export default prisma;
```

**src/config/redis.ts:**
```typescript
import Redis from 'ioredis';
import logger from '../utils/logger';

const redis = new Redis({
  host: process.env.REDIS_HOST || 'localhost',
  port: parseInt(process.env.REDIS_PORT || '6379'),
  password: process.env.REDIS_PASSWORD,
  retryStrategy: (times) => {
    const delay = Math.min(times * 50, 2000);
    return delay;
  },
});

redis.on('connect', () => {
  logger.info('Redis connected');
});

redis.on('error', (err) => {
  logger.error('Redis error:', err);
});

export default redis;
```

**src/utils/logger.ts:**
```typescript
import winston from 'winston';

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    new winston.transports.File({ filename: 'logs/combined.log' }),
  ],
});

if (process.env.NODE_ENV !== 'production') {
  logger.add(
    new winston.transports.Console({
      format: winston.format.combine(
        winston.format.colorize(),
        winston.format.simple()
      ),
    })
  );
}

export default logger;
```

---

## 3. AUTHENTICATION SYSTEM

### Phase 3.1: Auth Module Structure

**src/modules/auth/auth.validation.ts:**
```typescript
import Joi from 'joi';

export const registerSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string()
    .min(8)
    .pattern(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]/)
    .required()
    .messages({
      'string.pattern.base': 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, số và ký tự đặc biệt',
    }),
  first_name: Joi.string().required(),
  last_name: Joi.string().required(),
  phone: Joi.string().pattern(/^[0-9]{10}$/).optional(),
  school: Joi.string().optional(),
});

export const loginSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().required(),
});

export const refreshTokenSchema = Joi.object({
  refresh_token: Joi.string().required(),
});
```

**src/modules/auth/auth.service.ts:**
```typescript
import bcrypt from 'bcryptjs';
import prisma from '../../config/database';
import { generateTokens, verifyRefreshToken } from '../../utils/jwt';
import { sendVerificationEmail } from '../../utils/email';
import { AppError } from '../../middlewares/errorHandler';

export class AuthService {
  async register(data: {
    email: string;
    password: string;
    first_name: string;
    last_name: string;
    phone?: string;
    school?: string;
  }) {
    // Check if email exists
    const existingUser = await prisma.teacher.findUnique({
      where: { email: data.email },
    });

    if (existingUser) {
      throw new AppError('EMAIL_ALREADY_EXISTS', 'Email đã được sử dụng', 400);
    }

    // Hash password
    const password_hash = await bcrypt.hash(data.password, 12);

    // Create user
    const user = await prisma.teacher.create({
      data: {
        email: data.email,
        password_hash,
        first_name: data.first_name,
        last_name: data.last_name,
        phone: data.phone,
        school: data.school,
      },
      select: {
        id: true,
        email: true,
        first_name: true,
        last_name: true,
        is_verified: true,
        created_at: true,
      },
    });

    // Send verification email
    await sendVerificationEmail(user.email, user.id);

    return user;
  }

  async login(email: string, password: string) {
    // Find user
    const user = await prisma.teacher.findUnique({
      where: { email },
    });

    if (!user || !user.is_active) {
      throw new AppError('INVALID_CREDENTIALS', 'Email hoặc mật khẩu không đúng', 401);
    }

    // Check password
    const isPasswordValid = await bcrypt.compare(password, user.password_hash);
    if (!isPasswordValid) {
      throw new AppError('INVALID_CREDENTIALS', 'Email hoặc mật khẩu không đúng', 401);
    }

    // Check if verified
    if (!user.is_verified) {
      throw new AppError('EMAIL_NOT_VERIFIED', 'Vui lòng xác thực email trước khi đăng nhập', 403);
    }

    // Generate tokens
    const tokens = generateTokens(user.id, user.email);

    // Update last login
    await prisma.teacher.update({
      where: { id: user.id },
      data: { last_login_at: new Date() },
    });

    return {
      tokens,
      user: {
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        avatar_url: user.avatar_url,
        is_verified: user.is_verified,
      },
    };
  }

  async refreshToken(refresh_token: string) {
    const payload = verifyRefreshToken(refresh_token);
    
    const user = await prisma.teacher.findUnique({
      where: { id: payload.userId },
    });

    if (!user || !user.is_active) {
      throw new AppError('INVALID_TOKEN', 'Token không hợp lệ', 401);
    }

    const tokens = generateTokens(user.id, user.email);
    return tokens;
  }

  async verifyEmail(token: string) {
    const payload = verifyRefreshToken(token);
    
    await prisma.teacher.update({
      where: { id: payload.userId },
      data: { is_verified: true },
    });

    return { success: true };
  }
}
```

**src/modules/auth/auth.controller.ts:**
```typescript
import { Request, Response, NextFunction } from 'express';
import { AuthService } from './auth.service';

const authService = new AuthService();

export class AuthController {
  async register(req: Request, res: Response, next: NextFunction) {
    try {
      const user = await authService.register(req.body);
      
      res.status(201).json({
        success: true,
        message: 'Đăng ký thành công. Vui lòng kiểm tra email để xác thực tài khoản.',
        user,
      });
    } catch (error) {
      next(error);
    }
  }

  async login(req: Request, res: Response, next: NextFunction) {
    try {
      const { email, password } = req.body;
      const result = await authService.login(email, password);

      res.json({
        success: true,
        access_token: result.tokens.access_token,
        refresh_token: result.tokens.refresh_token,
        expires_in: 3600,
        user: result.user,
      });
    } catch (error) {
      next(error);
    }
  }

  async refreshToken(req: Request, res: Response, next: NextFunction) {
    try {
      const { refresh_token } = req.body;
      const tokens = await authService.refreshToken(refresh_token);

      res.json({
        success: true,
        access_token: tokens.access_token,
        expires_in: 3600,
      });
    } catch (error) {
      next(error);
    }
  }

  async verifyEmail(req: Request, res: Response, next: NextFunction) {
    try {
      const { token } = req.query;
      await authService.verifyEmail(token as string);

      res.json({
        success: true,
        message: 'Email đã được xác thực thành công. Bạn có thể đăng nhập ngay bây giờ.',
      });
    } catch (error) {
      next(error);
    }
  }
}
```

**src/modules/auth/auth.routes.ts:**
```typescript
import { Router } from 'express';
import { AuthController } from './auth.controller';
import { validate } from '../../middlewares/validate';
import { registerSchema, loginSchema, refreshTokenSchema } from './auth.validation';

const router = Router();
const authController = new AuthController();

router.post('/register', validate(registerSchema), authController.register);
router.post('/login', validate(loginSchema), authController.login);
router.post('/refresh', validate(refreshTokenSchema), authController.refreshToken);
router.get('/verify-email', authController.verifyEmail);

export default router;
```

---

## 4. API DEVELOPMENT PHASES

### WEEK 1: Foundation & Authentication

**Days 1-2: Setup & Auth**
- ✅ Project setup
- ✅ Database schema
- ✅ Auth endpoints (register, login, refresh)
- ✅ JWT middleware
- ✅ Email verification

**Days 3-4: User Management**
- ✅ Get profile
- ✅ Update profile
- ✅ Change password
- ✅ Delete account

**Days 5-7: Testing**
- ✅ Unit tests for auth service
- ✅ Integration tests for auth endpoints
- ✅ Password validation tests

### WEEK 2: Student Management

**Days 1-2: Student CRUD**
```typescript
// src/modules/students/students.service.ts
export class StudentsService {
  async create(teacherId: string, data: CreateStudentDto) {
    // Validate age (2-18)
    const age = calculateAge(data.date_of_birth);
    if (age < 2 || age > 18) {
      throw new AppError('INVALID_AGE', `Tuổi học sinh phải từ 2 đến 18. Tuổi hiện tại: ${age}`, 400);
    }

    // Upload avatar if provided
    let avatar_url = null;
    if (data.avatar) {
      avatar_url = await uploadToR2(data.avatar, `students/${teacherId}`);
    }

    const student = await prisma.student.create({
      data: {
        teacher_id: teacherId,
        first_name: data.first_name,
        last_name: data.last_name,
        nickname: data.nickname,
        date_of_birth: new Date(data.date_of_birth),
        gender: data.gender,
        avatar_url,
        diagnosis: data.diagnosis,
        notes: data.notes,
        parent_name: data.parent_name,
        parent_phone: data.parent_phone,
      },
    });

    return student;
  }

  async list(teacherId: string, filters: ListStudentsDto) {
    const { search, status, page = 1, limit = 20 } = filters;
    
    const where: any = {
      teacher_id: teacherId,
      deleted_at: null,
    };

    if (search) {
      where.OR = [
        { first_name: { contains: search, mode: 'insensitive' } },
        { last_name: { contains: search, mode: 'insensitive' } },
        { nickname: { contains: search, mode: 'insensitive' } },
      ];
    }

    if (status) {
      where.status = status;
    }

    const [students, total] = await Promise.all([
      prisma.student.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { created_at: 'desc' },
      }),
      prisma.student.count({ where }),
    ]);

    return {
      data: students,
      pagination: {
        page,
        limit,
        total,
        total_pages: Math.ceil(total / limit),
        has_next: page * limit < total,
        has_prev: page > 1,
      },
    };
  }
}
```

**Days 3-5: Student Status & Soft Delete**
- ✅ Change status endpoint
- ✅ Soft delete implementation
- ✅ Tests

### WEEK 3: Session Management

**Days 1-3: Session Creation (3 Steps)**
```typescript
// Step 1: Create session
async createSession(teacherId: string, data: CreateSessionDto) {
  // Validate student ownership
  const student = await prisma.student.findFirst({
    where: { id: data.student_id, teacher_id: teacherId },
  });
  
  if (!student) {
    throw new AppError('FORBIDDEN', 'Bạn không có quyền tạo buổi học cho học sinh này', 403);
  }

  // Validate date range
  const sixMonthsAgo = new Date();
  sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 6);
  
  const oneYearLater = new Date();
  oneYearLater.setFullYear(oneYearLater.getFullYear() + 1);

  if (new Date(data.session_date) < sixMonthsAgo || new Date(data.session_date) > oneYearLater) {
    throw new AppError('INVALID_DATE_RANGE', 'Ngày buổi học phải trong khoảng từ 6 tháng trước đến 1 năm sau', 400);
  }

  // Calculate duration
  const duration = calculateDuration(data.start_time, data.end_time);
  if (duration < 30) {
    throw new AppError('INVALID_DURATION', 'Thời lượng buổi học tối thiểu 30 phút', 400);
  }

  const session = await prisma.session.create({
    data: {
      student_id: data.student_id,
      session_date: new Date(data.session_date),
      time_slot: data.time_slot,
      start_time: data.start_time,
      end_time: data.end_time,
      duration_minutes: duration,
      location: data.location,
      notes: data.notes,
      created_by: teacherId,
    },
  });

  return { session, next_step: 'add_contents' };
}

// Step 2: Add contents
async addContent(sessionId: string, teacherId: string, data: AddContentDto) {
  // Verify session ownership
  const session = await this.verifySessionOwnership(sessionId, teacherId);

  // Validate domain
  const validDomains = ['cognitive', 'motor', 'language', 'social', 'self_care'];
  if (!validDomains.includes(data.domain)) {
    throw new AppError('INVALID_DOMAIN', 'Domain không hợp lệ', 400);
  }

  // Get next order_index
  const maxOrder = await prisma.sessionContent.aggregate({
    where: { session_id: sessionId },
    _max: { order_index: true },
  });
  const order_index = (maxOrder._max.order_index || 0) + 1;

  const content = await prisma.sessionContent.create({
    data: {
      session_id: sessionId,
      title: data.title,
      domain: data.domain,
      description: data.description,
      materials_needed: data.materials_needed,
      estimated_duration: data.estimated_duration,
      order_index,
      goals: {
        create: data.goals.map((goal, index) => ({
          description: goal.description,
          goal_type: goal.goal_type,
          is_primary: goal.is_primary,
          order_index: index + 1,
        })),
      },
    },
    include: { goals: true },
  });

  return content;
}

// Step 3: Confirm session
async confirmSession(sessionId: string, teacherId: string) {
  // Verify ownership
  const session = await this.verifySessionOwnership(sessionId, teacherId);

  // Check has contents
  const contentsCount = await prisma.sessionContent.count({
    where: { session_id: sessionId },
  });

  if (contentsCount === 0) {
    throw new AppError('VALIDATION_ERROR', 'Buổi học phải có ít nhất 1 nội dung', 400);
  }

  // Count goals
  const goalsCount = await prisma.sessionContentGoal.count({
    where: {
      session_content: {
        session_id: sessionId,
      },
    },
  });

  return {
    session: {
      id: session.id,
      status: session.status,
      contents_count: contentsCount,
      goals_count: goalsCount,
    },
  };
}
```

**Days 4-7: Session Logging (4 Steps)**
- ✅ Create log
- ✅ Evaluate goals
- ✅ Update attitude
- ✅ Update notes & media
- ✅ Complete log

### WEEK 4: Behavior System

**Days 1-2: Behavior Library**
```typescript
// Seed behaviors
async seedBehaviors() {
  const groups = await prisma.behaviorGroup.createMany({
    data: [
      {
        code: 'GROUP_01',
        name_vn: 'CHỐNG ĐỐI & BƯỚNG BỈNH',
        name_en: 'Opposition & Defiance',
        icon: '😤',
        color_code: '#FF5733',
        order_index: 1,
      },
      // ... other groups
    ],
  });

  // Seed behaviors with JSONB fields
  await prisma.behaviorLibrary.create({
    data: {
      behavior_code: 'BH_01_01',
      behavior_group_id: group1.id,
      name_vn: 'Ăn vạ',
      name_en: 'Tantrums',
      icon: '😭',
      age_range_min: 2,
      age_range_max: 10,
      manifestation_vn: 'Trẻ bộc phát cảm xúc...',
      keywords_vn: ['ăn vạ', 'khóc lóc', 'la hét'],
      keywords_en: ['tantrum', 'crying', 'screaming'],
      explanation: [
        {
          title: 'Nhu cầu Giao tiếp',
          content: 'Với trẻ nhỏ hoặc trẻ chậm phát triển ngôn ngữ...',
        },
      ],
      solutions: [
        {
          step: 1,
          title: 'Giữ bình tĩnh',
          description: 'Phản ứng của người lớn rất quan trọng...',
        },
      ],
      prevention_strategies: [
        {
          category: 'Dự đoán',
          strategies: ['Nhận biết dấu hiệu sớm...'],
        },
      ],
      sources: [
        {
          type: 'research',
          title: 'Applied Behavior Analysis',
          author: 'Cooper et al.',
          year: 2020,
        },
      ],
    },
  });
}
```

**Days 3-5: Behavior Incidents**
- ✅ Create incident (A-B-C model)
- ✅ Update/delete incident
- ✅ Trigger for usage_count

**Days 6-7: Favorites**
- ✅ Add/remove favorites
- ✅ List favorites

### WEEK 5: Content Library & Templates

**Days 1-3: Template CRUD**
```typescript
async createTemplate(teacherId: string, data: CreateTemplateDto) {
  // Generate code
  const count = await prisma.contentLibrary.count({
    where: { teacher_id: teacherId },
  });
  const code = `CTL_TH_${String(count + 1).padStart(3, '0')}`;

  const template = await prisma.contentLibrary.create({
    data: {
      teacher_id: teacherId,
      code,
      title: data.title,
      domain: data.domain,
      description: data.description,
      target_age_min: data.target_age_min,
      target_age_max: data.target_age_max,
      difficulty_level: data.difficulty_level,
      materials_needed: data.materials_needed,
      estimated_duration: data.estimated_duration,
      instructions: data.instructions,
      tips: data.tips,
      default_goals: data.default_goals, // JSONB
      tags: data.tags, // JSONB
      is_template: true,
      is_public: data.is_public,
    },
  });

  return template;
}
```

**Days 4-5: Ratings System**
- ✅ Rate template
- ✅ Update/delete rating
- ✅ Aggregate rating_avg

**Days 6-7: Template Usage**
- ✅ Use template in session
- ✅ Trigger for usage_count

### WEEK 6: AI Processing

**Days 1-2: File Upload & OCR**
```typescript
// AI Processing Job
import { Job } from 'bullmq';
import { extractTextFromPDF } from '../utils/pdf';
import { extractTextFromImage } from '../utils/ocr';
import { callGPT4 } from '../utils/openai';

export async function processAIDocument(job: Job) {
  const { processing_id, file_url, file_type } = job.data;

  try {
    // Update progress: 20%
    await updateProgress(processing_id, 20, 'Đang đọc file');

    // Extract text based on file type
    let text = '';
    if (file_type === 'pdf') {
      text = await extractTextFromPDF(file_url);
    } else if (file_type === 'image') {
      await updateProgress(processing_id, 30, 'Đang trích xuất văn bản (OCR)');
      text = await extractTextFromImage(file_url);
    } else if (file_type === 'docx') {
      text = await extractTextFromDOCX(file_url);
    } else {
      text = await fetchTextContent(processing_id);
    }

    // Update progress: 40%
    await updateProgress(processing_id, 40, 'Đang phân tích với AI');

    // Call GPT-4
    const prompt = buildPrompt(text);
    const response = await callGPT4(prompt);

    // Update progress: 70%
    await updateProgress(processing_id, 70, 'Đang tạo cấu trúc buổi học');

    // Parse response
    const sessions = parseGPT4Response(response);

    // Validate structure
    validateSessionsStructure(sessions);

    // Update progress: 90%
    await updateProgress(processing_id, 90, 'Hoàn tất');

    // Save result
    await prisma.aiProcessing.update({
      where: { id: processing_id },
      data: {
        processing_status: 'completed',
        progress: 100,
        result_sessions: sessions, // JSONB
        completed_at: new Date(),
      },
    });

    return { success: true };
  } catch (error) {
    await prisma.aiProcessing.update({
      where: { id: processing_id },
      data: {
        processing_status: 'failed',
        error_message: error.message,
        failed_at: new Date(),
      },
    });
    throw error;
  }
}
```

**Days 3-5: GPT-4 Integration**
- ✅ Prompt engineering
- ✅ Response parsing
- ✅ Validation

**Days 6-7: Create Sessions from AI**
- ✅ Batch insert
- ✅ Transaction handling

### WEEK 7: Analytics & Reports

**Days 1-3: Analytics Queries**
```typescript
async getAnalyticsOverview(teacherId: string, filters: AnalyticsFilters) {
  const { student_id, date_from, date_to } = filters;

  const where: any = {
    teacher_id: teacherId,
    session_date: {
      gte: new Date(date_from),
      lte: new Date(date_to),
    },
    deleted_at: null,
  };

  if (student_id) {
    where.student_id = student_id;
  }

  // KPIs
  const sessions = await prisma.session.findMany({ where });
  const kpis = calculateKPIs(sessions);

  // Charts data
  const sessionsTrend = await getSessionsTrend(where);
  const goalDistribution = await getGoalDistribution(where);
  const moodTrend = await getMoodTrend(where);

  // Top behaviors
  const topBehaviors = await getTopBehaviors(where);

  return { kpis, charts: { sessionsTrend, goalDistribution, moodTrend }, topBehaviors };
}
```

**Days 4-5: Report Generation**
```typescript
// Report Job
import puppeteer from 'puppeteer';

export async function generatePDFReport(job: Job) {
  const { report_id, data } = job.data;

  // Generate HTML
  const html = renderReportHTML(data);

  // Launch headless Chrome
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.setContent(html);

  // Generate PDF
  const pdf = await page.pdf({
    format: 'A4',
    printBackground: true,
  });

  await browser.close();

  // Upload to R2
  const fileUrl = await uploadToR2(pdf, `reports/${report_id}.pdf`);

  // Update report record
  await prisma.report.update({
    where: { id: report_id },
    data: {
      status: 'completed',
      file_url: fileUrl,
      file_size: pdf.length,
      completed_at: new Date(),
      expires_at: new Date(Date.now() + 24 * 60 * 60 * 1000), // 24h
    },
  });
}
```

**Days 6-7: Excel Reports**
- ✅ ExcelJS integration
- ✅ Multi-sheet reports

### WEEK 8: Sync & Backup

**Days 1-3: Sync Endpoints**
```typescript
async uploadOfflineQueue(teacherId: string, queue: OfflineAction[]) {
  const results = [];

  for (const action of queue) {
    try {
      let result;
      
      if (action.action_type === 'CREATE_SESSION') {
        result = await this.createSession(teacherId, action.payload);
      } else if (action.action_type === 'UPDATE_SESSION') {
        result = await this.updateSession(action.entity_id, teacherId, action.payload);
      } else if (action.action_type === 'CREATE_LOG') {
        result = await this.createLog(action.payload.session_id, teacherId, action.payload);
      }

      results.push({
        local_id: action.local_id,
        entity_id: action.entity_id,
        status: 'success',
        server_id: result?.id,
      });
    } catch (error) {
      results.push({
        local_id: action.local_id,
        entity_id: action.entity_id,
        status: 'failed',
        error: error.message,
      });
    }
  }

  return { results, summary: { total: queue.length, success: results.filter(r => r.status === 'success').length } };
}
```

**Days 4-5: Backup System**
- ✅ Create backup (ZIP all data + media)
- ✅ List backups
- ✅ Download backup

**Days 6-7: Auto Backup Cron**
- ✅ Weekly auto backup
- ✅ Max 4 backups retention

---

## 5. TESTING STRATEGY

### Phase 5.1: Unit Tests

**Example: Auth Service Test**
```typescript
// src/modules/auth/auth.test.ts
import { AuthService } from './auth.service';
import prisma from '../../config/database';

describe('AuthService', () => {
  let authService: AuthService;

  beforeAll(async () => {
    authService = new AuthService();
  });

  afterEach(async () => {
    await prisma.teacher.deleteMany({});
  });

  describe('register', () => {
    it('should register a new teacher successfully', async () => {
      const data = {
        email: 'test@example.com',
        password: 'SecurePass123!',
        first_name: 'Trần',
        last_name: 'Hảo',
      };

      const user = await authService.register(data);

      expect(user).toHaveProperty('id');
      expect(user.email).toBe(data.email);
      expect(user.is_verified).toBe(false);
    });

    it('should throw error if email already exists', async () => {
      const data = {
        email: 'test@example.com',
        password: 'SecurePass123!',
        first_name: 'Trần',
        last_name: 'Hảo',
      };

      await authService.register(data);

      await expect(authService.register(data)).rejects.toThrow('EMAIL_ALREADY_EXISTS');
    });

    it('should hash password correctly', async () => {
      const data = {
        email: 'test@example.com',
        password: 'SecurePass123!',
        first_name: 'Trần',
        last_name: 'Hảo',
      };

      await authService.register(data);

      const user = await prisma.teacher.findUnique({
        where: { email: data.email },
      });

      expect(user.password_hash).not.toBe(data.password);
      expect(user.password_hash).toHaveLength(60); // bcrypt hash length
    });
  });
});
```

### Phase 5.2: Integration Tests

**Example: Sessions E2E Test**
```typescript
// tests/integration/sessions.test.ts
import request from 'supertest';
import app from '../../src/app';
import prisma from '../../src/config/database';

describe('Sessions API', () => {
  let authToken: string;
  let studentId: string;

  beforeAll(async () => {
    // Register and login
    const registerRes = await request(app)
      .post('/api/v1/auth/register')
      .send({
        email: 'teacher@test.com',
        password: 'SecurePass123!',
        first_name: 'Test',
        last_name: 'Teacher',
      });

    // Manually verify email in test DB
    await prisma.teacher.update({
      where: { email: 'teacher@test.com' },
      data: { is_verified: true },
    });

    const loginRes = await request(app)
      .post('/api/v1/auth/login')
      .send({
        email: 'teacher@test.com',
        password: 'SecurePass123!',
      });

    authToken = loginRes.body.access_token;

    // Create student
    const studentRes = await request(app)
      .post('/api/v1/students')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        first_name: 'Nguyễn Văn',
        last_name: 'An',
        date_of_birth: '2018-05-15',
        gender: 'male',
      });

    studentId = studentRes.body.student.id;
  });

  afterAll(async () => {
    await prisma.teacher.deleteMany({});
    await prisma.student.deleteMany({});
  });

  describe('POST /api/v1/sessions', () => {
    it('should create session successfully', async () => {
      const res = await request(app)
        .post('/api/v1/sessions')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          student_id: studentId,
          session_date: '2025-11-10',
          time_slot: 'morning',
          start_time: '09:00:00',
          end_time: '10:30:00',
          location: 'Phòng 101',
          notes: 'Test session',
        });

      expect(res.status).toBe(201);
      expect(res.body.success).toBe(true);
      expect(res.body.session).toHaveProperty('id');
      expect(res.body.session.duration_minutes).toBe(90);
      expect(res.body.next_step).toBe('add_contents');
    });

    it('should reject session with invalid date range', async () => {
      const res = await request(app)
        .post('/api/v1/sessions')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          student_id: studentId,
          session_date: '2024-01-01',
          time_slot: 'morning',
          start_time: '09:00:00',
          end_time: '10:30:00',
        });

      expect(res.status).toBe(400);
      expect(res.body.error).toBe('INVALID_DATE_RANGE');
    });
  });
});
```

### Phase 5.3: Test Coverage Goals

**Coverage Targets:**
- Overall: > 80%
- Critical paths (auth, sessions): > 95%
- Services: > 90%
- Controllers: > 85%

**Run Tests:**
```bash
# Unit tests
npm run test:unit

# Integration tests
npm run test:integration

# Coverage
npm run test:coverage

# Watch mode
npm run test:watch
```

---

## 6. DEPLOYMENT & DEVOPS

### Phase 6.1: Docker Setup

**Dockerfile:**
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npx prisma generate
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
```

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/educare
      - REDIS_HOST=redis
    depends_on:
      - db
      - redis

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: educare
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

### Phase 6.2: CI/CD Pipeline

**.github/workflows/test.yml:**
```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
      
      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run migrations
        run: npx prisma migrate deploy
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/test
      
      - name: Run tests
        run: npm test
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/test
          REDIS_HOST: localhost
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
```

---

## 📊 TIMELINE SUMMARY

| Week | Focus | Endpoints | Tests |
|------|-------|-----------|-------|
| 1 | Auth & User | 10 | 35 |
| 2 | Students | 6 | 30 |
| 3 | Sessions | 10 | 45 |
| 4 | Behaviors | 9 | 25 |
| 5 | Content Library | 9 | 20 |
| 6 | AI Processing | 5 | 20 |
| 7 | Analytics | 5 | 9 |
| 8 | Sync & Backup | 14 | 12 |
| **Total** | **8 weeks** | **82** | **195** |

---

## ✅ CHECKLIST

**Week 1:**
- [ ] Project setup
- [ ] Prisma schema
- [ ] Auth endpoints (10)
- [ ] JWT middleware
- [ ] Email service
- [ ] Tests (35)

**Week 2:**
- [ ] Student CRUD (6 endpoints)
- [ ] Soft delete
- [ ] Avatar upload
- [ ] Tests (30)

**Week 3:**
- [ ] Session creation (3 steps)
- [ ] Session logging (4 steps)
- [ ] Media upload
- [ ] Tests (45)

**Week 4:**
- [ ] Behavior library seeding
- [ ] Behavior search
- [ ] Incidents CRUD
- [ ] Favorites
- [ ] Tests (25)

**Week 5:**
- [ ] Template CRUD
- [ ] Ratings system
- [ ] Template usage tracking
- [ ] Tests (20)

**Week 6:**
- [ ] File upload to R2
- [ ] OCR integration
- [ ] GPT-4 integration
- [ ] Background jobs
- [ ] Tests (20)

**Week 7:**
- [ ] Analytics queries
- [ ] PDF reports (puppeteer)
- [ ] Excel reports
- [ ] Tests (9)

**Week 8:**
- [ ] Sync endpoints
- [ ] Backup system
- [ ] Auto backup cron
- [ ] Tests (12)
- [ ] Documentation
- [ ] Deployment

---

**🎯 Mục tiêu cuối cùng:**
- ✅ 82 API endpoints hoàn chỉnh
- ✅ 195 test cases (80%+ coverage)
- ✅ CI/CD pipeline
- ✅ Docker deployment
- ✅ API documentation (Swagger)
- ✅ Production-ready trong 8 tuần

Bạn có muốn tôi chi tiết hóa thêm phần nào không?
