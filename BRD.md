# Business Requirements Document (BRD)

## Educare Connect - Ứng dụng Quản lý Giảng dạy cho Giáo viên Giáo dục Đặc biệt

---

**Document Version**: 1.0  
**Date**: October 23, 2025  
**Project Name**: Educare Connect  
**Document Owner**: Product Management Team  
**Status**: Approved

---

## 1. Executive Summary

### 1.1 Overview

Educare Connect là ứng dụng di động (React Native) được thiết kế dành riêng cho giáo viên giáo dục đặc biệt tại Việt Nam, giúp tối ưu hóa quy trình quản lý học sinh, lập kế hoạch giảng dạy, ghi nhật ký buổi học, và theo dõi hành vi học sinh một cách hiệu quả.

### 1.2 Problem Statement

Hiện tại, giáo viên giáo dục đặc biệt đang gặp phải các thách thức:

- **Khối lượng công việc hành chính lớn**: Phải ghi chép thủ công, tốn thời gian và dễ sai sót
- **Thiếu công cụ chuyên biệt**: Các ứng dụng hiện tại không đáp ứng nhu cầu đặc thù của giáo dục đặc biệt
- **Khó theo dõi tiến độ**: Không có cách thức hệ thống để theo dõi hành vi và tiến bộ của học sinh
- **Thiếu phân tích dữ liệu**: Không có insights từ dữ liệu để điều chỉnh phương pháp giảng dạy
- **Lập kế hoạch giảng dạy tốn thời gian**: Mỗi giáo án cần nhiều giờ để chuẩn bị

### 1.3 Proposed Solution

Educare Connect cung cấp giải pháp toàn diện với 4 module chính:

1. **Quản lý Học sinh & Buổi học** - Tập trung hóa thông tin học sinh và lịch học
2. **Ghi Nhật ký Thông minh** - Đánh giá mục tiêu, thái độ, ghi chú nhanh chóng
3. **Theo dõi Hành vi ABC** - Ghi nhận và phân tích hành vi với phương pháp khoa học
4. **Phân tích & Báo cáo** - Insights tự động từ dữ liệu thu thập được
5. **AI-Powered Lesson Creation** - Tạo giáo án tự động từ tài liệu bằng AI

### 1.4 Expected Benefits

- **Tiết kiệm thời gian**: Giảm 60-70% thời gian ghi chép và lập kế hoạch
- **Cải thiện chất lượng giảng dạy**: Ra quyết định dựa trên dữ liệu thực tế
- **Tăng hiệu quả theo dõi**: Phát hiện patterns hành vi sớm hơn
- **Hỗ trợ cá nhân hóa**: Điều chỉnh phương pháp giảng dạy phù hợp với từng học sinh
- **Nâng cao tính chuyên nghiệp**: Báo cáo chi tiết cho phụ huynh và cơ quan quản lý

---

## 2. Business Objectives

### 2.1 Primary Objectives

#### Objective 1: Market Leadership

**Goal**: Trở thành ứng dụng số 1 cho giáo viên giáo dục đặc biệt tại Việt Nam trong 18 tháng

**Success Metrics**:

- 10,000+ giáo viên active users trong năm đầu
- 80% retention rate sau 3 tháng sử dụng
- 4.5+ rating trên App Store và Google Play

#### Objective 2: Operational Efficiency

**Goal**: Giảm thiểu thời gian công việc hành chính cho giáo viên

**Success Metrics**:

- 60%+ giảm thời gian ghi chép nhật ký (từ 30 phút xuống 12 phút/buổi)
- 70%+ giảm thời gian lập giáo án với AI (từ 2 giờ xuống 30 phút)
- 50%+ tăng tốc độ tìm kiếm thông tin học sinh

#### Objective 3: Data-Driven Teaching

**Goal**: Cho phép giáo viên ra quyết định dựa trên dữ liệu

**Success Metrics**:

- 80% giáo viên sử dụng tính năng Analytics thường xuyên
- 90% buổi học có ghi nhận hành vi ABC
- 75% giáo viên điều chỉnh phương pháp giảng dạy dựa trên insights

#### Objective 4: Revenue Generation

**Goal**: Xây dựng mô hình kinh doanh bền vững

**Success Metrics**:

- 5,000 paid subscribers trong 12 tháng
- Average Revenue Per User (ARPU): 150,000 VND/tháng
- Monthly Recurring Revenue (MRR): 750 triệu VND sau 12 tháng

### 2.2 Secondary Objectives

- Xây dựng cộng đồng giáo viên giáo dục đặc biệt
- Tích hợp với hệ thống quản lý trường học
- Mở rộng ra các nước khu vực Đông Nam Á
- Phát triển tính năng collaboration cho team giáo viên

---

## 3. Target Users

### 3.1 Primary User Persona

**Persona 1: Cô Lan - Giáo viên Giáo dục Đặc biệt**

**Demographics**:

- Tuổi: 28-45
- Giới tính: Nữ (75%), Nam (25%)
- Địa điểm: Thành phố lớn (Hà Nội, TP.HCM, Đà Nẵng)
- Kinh nghiệm: 3-10 năm giảng dạy
- Thu nhập: 8-15 triệu VND/tháng

**Goals**:

- Quản lý 10-15 học sinh đồng thời
- Ghi nhật ký buổi học nhanh chóng và chính xác
- Theo dõi tiến bộ của học sinh
- Tạo báo cáo cho phụ huynh định kỳ
- Tiết kiệm thời gian lập giáo án

**Pain Points**:

- Phải ghi chép thủ công nhiều, mất thời gian
- Khó nhớ chi tiết hành vi từng học sinh
- Không có công cụ phân tích xu hướng hành vi
- Lập giáo án tốn nhiều giờ
- Khó tổ chức và tìm lại thông tin cũ

**Tech Savviness**: Trung bình - Sử dụng smartphone hàng ngày, quen với các ứng dụng cơ bản

**Device**: iPhone 11+, Samsung Galaxy A series, sử dụng 80% thời gian trên mobile

### 3.2 Secondary User Personas

**Persona 2: Anh Minh - Phụ huynh Học sinh**

- Muốn nhận báo cáo tiến độ con
- Xem ảnh/video buổi học
- Trao đổi với giáo viên

**Persona 3: Bà Hương - Hiệu trưởng/Quản lý Trung tâm**

- Giám sát chất lượng giảng dạy
- Xem báo cáo tổng hợp
- Quản lý đội ngũ giáo viên

### 3.3 Market Size

**Total Addressable Market (TAM)**:

- 50,000+ giáo viên giáo dục đặc biệt tại Việt Nam
- 200,000+ giáo viên mầm non/tiểu học có học sinh cần hỗ trợ đặc biệt
- Thị trường Đông Nam Á: 500,000+ giáo viên tiềm năng

**Serviceable Addressable Market (SAM)**:

- 30,000 giáo viên giáo dục đặc biệt ở các thành phố lớn
- 15,000 giáo viên có smartphone và kỹ năng sử dụng ứng dụng

**Serviceable Obtainable Market (SOM)**:

- Year 1: 10,000 users (33% of SAM)
- Year 2: 20,000 users (67% of SAM)
- Year 3: 30,000 users (100% of SAM)

---

## 4. Success Metrics (KPIs)

### 4.1 User Adoption Metrics

| Metric                   | Target Q1 | Target Q2 | Target Q3 | Target Q4 | Year 1 |
| ------------------------ | --------- | --------- | --------- | --------- | ------ |
| Total Downloads          | 2,000     | 5,000     | 8,000     | 12,000    | 12,000 |
| Active Users (MAU)       | 1,500     | 4,000     | 6,500     | 10,000    | 10,000 |
| Daily Active Users (DAU) | 600       | 1,600     | 2,600     | 4,000     | 4,000  |
| DAU/MAU Ratio            | 40%       | 40%       | 40%       | 40%       | 40%    |

### 4.2 Engagement Metrics

| Metric                          | Target              | Measurement        |
| ------------------------------- | ------------------- | ------------------ |
| Session Duration                | 15+ minutes/session | Google Analytics   |
| Sessions per User               | 5+ sessions/week    | Firebase Analytics |
| Feature Adoption - Logging      | 95% users           | In-app tracking    |
| Feature Adoption - AI Lessons   | 60% users           | In-app tracking    |
| Feature Adoption - Analytics    | 80% users           | In-app tracking    |
| Feature Adoption - ABC Behavior | 85% users           | In-app tracking    |

### 4.3 Retention Metrics

| Metric            | Target    | Measurement     |
| ----------------- | --------- | --------------- |
| Day 1 Retention   | 80%       | Cohort analysis |
| Day 7 Retention   | 65%       | Cohort analysis |
| Day 30 Retention  | 50%       | Cohort analysis |
| Month 3 Retention | 80%       | Cohort analysis |
| Churn Rate        | <5%/month | User analytics  |

### 4.4 Business Metrics

| Metric                          | Target            | Measurement         |
| ------------------------------- | ----------------- | ------------------- |
| Free to Paid Conversion         | 50%               | Revenue tracking    |
| ARPU (Average Revenue Per User) | 150K VND/month    | Revenue tracking    |
| Customer Acquisition Cost (CAC) | 200K VND          | Marketing analytics |
| Lifetime Value (LTV)            | 1.8M VND          | Revenue tracking    |
| LTV:CAC Ratio                   | 9:1               | Calculation         |
| Monthly Recurring Revenue (MRR) | 750M VND (Year 1) | Revenue tracking    |

### 4.5 Quality Metrics

| Metric              | Target               | Measurement          |
| ------------------- | -------------------- | -------------------- |
| App Crash Rate      | <1%                  | Firebase Crashlytics |
| App Store Rating    | 4.5+ stars           | App Store/Play Store |
| Support Tickets     | <2% of users         | Helpdesk system      |
| Bug Resolution Time | <48 hours (critical) | Jira/GitHub          |
| API Response Time   | <500ms (p95)         | Firebase Performance |
| App Load Time       | <2 seconds           | Firebase Performance |

### 4.6 Feature-Specific Metrics

**Session Logging**:

- 95% sessions have complete logs
- Average logging time: <12 minutes
- 90% logs include attitude assessment
- 85% logs include ABC behavior tracking

**AI Lesson Creation**:

- 60% users try AI feature in first month
- 80% satisfaction rate with AI results
- Average time saved: 1.5 hours per lesson
- 70% users edit AI suggestions before finalizing

**Analytics & Reports**:

- 80% users view analytics weekly
- 65% users export reports monthly
- Average insights per user: 5+ per month

**Behavior Dictionary**:

- 90% users access dictionary in first week
- Average 3+ behaviors saved to favorites
- 75% ABC records use dictionary suggestions

---

## 5. Budget & Timeline

### 5.1 Project Phases & Timeline

```
┌────────────────────────────────────────────────────────┐
│ PHASE 1: Discovery & Design (2 months)                │
│ Nov 2025 - Dec 2025                                    │
└────────────────────────────────────────────────────────┘
  - Requirements gathering
  - User research & interviews
  - Wireframes & UI/UX design
  - Technical architecture design
  - Database design
  - API design

┌────────────────────────────────────────────────────────┐
│ PHASE 2: MVP Development (4 months)                    │
│ Jan 2026 - Apr 2026                                    │
└────────────────────────────────────────────────────────┘
  - Core features development
    • Student management
    • Session creation (manual)
    • Session logging
    • Basic analytics
  - Testing & QA
  - Beta launch

┌────────────────────────────────────────────────────────┐
│ PHASE 3: AI Integration (2 months)                     │
│ May 2026 - Jun 2026                                    │
└────────────────────────────────────────────────────────┘
  - AI lesson creation feature
  - OCR integration
  - OpenAI API integration
  - File upload & processing
  - Testing & optimization

┌────────────────────────────────────────────────────────┐
│ PHASE 4: Advanced Features (2 months)                  │
│ Jul 2026 - Aug 2026                                    │
└────────────────────────────────────────────────────────┘
  - ABC behavior tracking enhancements
  - Behavior dictionary (127+ behaviors)
  - Advanced analytics
  - Comparison reports
  - Export functionality

┌────────────────────────────────────────────────────────┐
│ PHASE 5: Launch & Marketing (2 months)                 │
│ Sep 2026 - Oct 2026                                    │
└────────────────────────────────────────────────────────┘
  - App Store submission
  - Google Play submission
  - Marketing campaign
  - User onboarding optimization
  - Support infrastructure

┌────────────────────────────────────────────────────────┐
│ PHASE 6: Growth & Iteration (Ongoing)                  │
│ Nov 2026 onwards                                       │
└────────────────────────────────────────────────────────┘
  - Feature enhancements based on feedback
  - Performance optimization
  - Scale infrastructure
  - Collaboration features
  - Expansion to new markets
```

**Total Timeline**: 12 months from start to public launch

### 5.2 Budget Breakdown

#### Development Costs (8 months)

| Role                     | Quantity | Rate (VND/month) | Duration | Total (VND) |
| ------------------------ | -------- | ---------------- | -------- | ----------- |
| Tech Lead / Architect    | 1        | 50M              | 8 months | 400M        |
| Senior React Native Dev  | 2        | 40M              | 8 months | 640M        |
| Backend Developer        | 2        | 35M              | 8 months | 560M        |
| UI/UX Designer           | 1        | 30M              | 6 months | 180M        |
| QA Engineer              | 1        | 25M              | 6 months | 150M        |
| Product Manager          | 1        | 45M              | 8 months | 360M        |
| **Subtotal Development** |          |                  |          | **2,290M**  |

#### Infrastructure & Tools (Annual)

| Item                                    | Monthly Cost | Annual Cost |
| --------------------------------------- | ------------ | ----------- |
| Firebase (Firestore, Auth, Storage)     | 10M          | 120M        |
| OpenAI API Credits                      | 15M          | 180M        |
| OCR Service (Google Vision)             | 5M           | 60M         |
| AWS/Cloud Hosting                       | 8M           | 96M         |
| Development Tools (GitHub, Figma, etc.) | 3M           | 36M         |
| Monitoring (Sentry, Analytics)          | 2M           | 24M         |
| **Subtotal Infrastructure**             |              | **516M**    |

#### Marketing & Launch

| Item                              | Cost (VND) |
| --------------------------------- | ---------- |
| App Store Fees (iOS + Android)    | 10M        |
| Launch Marketing Campaign         | 200M       |
| Content Creation (Videos, Guides) | 50M        |
| PR & Media                        | 100M       |
| Community Building                | 40M        |
| **Subtotal Marketing**            | **400M**   |

#### Operations & Contingency

| Item                     | Cost (VND) |
| ------------------------ | ---------- |
| Legal & Compliance       | 50M        |
| Customer Support Setup   | 30M        |
| Training & Documentation | 20M        |
| Contingency (10%)        | 331M       |
| **Subtotal Operations**  | **431M**   |

#### Total Budget Summary

| Category       | Amount (VND) | % of Total |
| -------------- | ------------ | ---------- |
| Development    | 2,290M       | 63%        |
| Infrastructure | 516M         | 14%        |
| Marketing      | 400M         | 11%        |
| Operations     | 431M         | 12%        |
| **TOTAL**      | **3,637M**   | **100%**   |

**Total Budget**: **3.637 Billion VND** (~$150,000 USD)

### 5.3 Revenue Projections (Year 1)

#### Pricing Model

**Free Tier**:

- Up to 5 students
- Basic session logging
- 30-day data retention
- Standard support

**Premium Tier**: 150,000 VND/month

- Unlimited students
- AI lesson creation (20 lessons/month)
- Advanced analytics & reports
- Behavior dictionary
- Unlimited data retention
- Priority support
- Export functionality

**Enterprise Tier**: Custom pricing

- All Premium features
- Team collaboration
- School-wide dashboard
- API access
- Dedicated account manager

#### Revenue Forecast

| Month  | Total Users | Paid Users | Conversion | MRR (VND) | Cumulative Revenue |
| ------ | ----------- | ---------- | ---------- | --------- | ------------------ |
| M1-2   | 1,500       | 375        | 25%        | 56M       | 112M               |
| M3-4   | 4,000       | 1,600      | 40%        | 240M      | 592M               |
| M5-6   | 6,500       | 3,250      | 50%        | 487M      | 1,566M             |
| M7-8   | 8,000       | 4,400      | 55%        | 660M      | 2,886M             |
| M9-10  | 10,000      | 5,500      | 55%        | 825M      | 4,536M             |
| M11-12 | 12,000      | 6,600      | 55%        | 990M      | 6,516M             |

**Year 1 Total Revenue**: ~6.5 Billion VND (~$270,000 USD)

**Break-even Point**: Month 7 (Cumulative)

**Return on Investment (ROI)**:

- Investment: 3.637B VND
- Year 1 Revenue: 6.516B VND
- Year 1 ROI: 79%

---

## 6. Stakeholders

### 6.1 Internal Stakeholders

#### Executive Team

**CEO / Founder**

- **Role**: Overall vision and strategy
- **Responsibilities**: Product direction, fundraising, partnerships
- **Decision Authority**: Final approval on major features and budget
- **Communication**: Weekly executive meetings

**CTO / Tech Lead**

- **Role**: Technical architecture and development oversight
- **Responsibilities**: Technology stack, team management, code quality
- **Decision Authority**: Technical decisions, infrastructure, tools
- **Communication**: Daily standups with dev team

**Product Manager**

- **Role**: Product strategy and roadmap
- **Responsibilities**: Requirements, prioritization, user research
- **Decision Authority**: Feature specifications, UI/UX approval
- **Communication**: Daily collaboration with design and dev

**Head of Marketing**

- **Role**: Go-to-market strategy
- **Responsibilities**: Marketing campaigns, user acquisition, branding
- **Decision Authority**: Marketing budget, campaigns
- **Communication**: Weekly marketing reviews

#### Development Team

**React Native Developers (2)**

- **Role**: Mobile app development
- **Responsibilities**: Feature implementation, bug fixes, code reviews
- **Engagement**: Daily standups, sprint planning

**Backend Developers (2)**

- **Role**: API and database development
- **Responsibilities**: API design, Firebase integration, data management
- **Engagement**: Daily standups, sprint planning

**UI/UX Designer (1)**

- **Role**: Product design
- **Responsibilities**: Wireframes, mockups, design system, user testing
- **Engagement**: Design reviews, user testing sessions

**QA Engineer (1)**

- **Role**: Quality assurance
- **Responsibilities**: Test planning, manual/automated testing, bug tracking
- **Engagement**: Sprint testing, release validation

### 6.2 External Stakeholders

#### Primary Customers

**Special Education Teachers**

- **Interest**: Effective tool to manage students and reduce workload
- **Expectations**: Easy to use, time-saving, reliable
- **Influence**: High - Product success depends on their adoption
- **Communication**: User surveys, in-app feedback, focus groups

**School Administrators**

- **Interest**: Oversight and reporting capabilities
- **Expectations**: Data security, compliance, bulk user management
- **Influence**: Medium - Can recommend or mandate app usage
- **Communication**: Partnership meetings, enterprise demos

#### Secondary Customers

**Parents of Special Needs Students**

- **Interest**: Transparency and visibility into child's progress
- **Expectations**: Regular updates, photos/videos, communication channel
- **Influence**: Low - Indirect influence through teachers
- **Communication**: In-app reports, parent portal (future)

#### Partners & Vendors

**Firebase / Google Cloud**

- **Role**: Infrastructure provider
- **Responsibilities**: Hosting, database, authentication, storage
- **Engagement**: Technical support, billing

**OpenAI**

- **Role**: AI service provider
- **Responsibilities**: GPT API for lesson creation
- **Engagement**: API usage, support tickets

**Apple & Google**

- **Role**: App distribution platforms
- **Responsibilities**: App Store / Play Store hosting
- **Engagement**: App review process, compliance

#### Regulatory Bodies

**Ministry of Education and Training (MOET)**

- **Interest**: Compliance with education regulations
- **Expectations**: Data privacy, child protection standards
- **Influence**: High - Can mandate or restrict app usage
- **Communication**: Compliance reports, official correspondence

**Personal Data Protection Authority**

- **Interest**: GDPR/data privacy compliance
- **Expectations**: User consent, data security, transparency
- **Influence**: High - Can impose fines or restrictions
- **Communication**: Privacy policy, compliance audits

#### Advisors & Consultants

**Special Education Experts**

- **Role**: Domain expertise and validation
- **Responsibilities**: Review features, provide best practices
- **Engagement**: Monthly advisory meetings

**Education Technology Consultants**

- **Role**: EdTech industry insights
- **Responsibilities**: Market trends, competitive analysis
- **Engagement**: Quarterly strategy reviews

### 6.3 Stakeholder Engagement Plan

| Stakeholder Group | Engagement Frequency | Method                      | Key Messages                        |
| ----------------- | -------------------- | --------------------------- | ----------------------------------- |
| Teachers (Users)  | Weekly               | In-app notifications, email | New features, tips, success stories |
| School Admins     | Monthly              | Email, webinars             | Product updates, case studies, ROI  |
| Development Team  | Daily                | Standups, Slack             | Sprint goals, blockers, decisions   |
| Executive Team    | Weekly               | Meetings, reports           | Progress, metrics, risks            |
| Investors         | Monthly              | Reports, calls              | User growth, revenue, milestones    |
| Regulatory Bodies | As needed            | Official docs               | Compliance, privacy, security       |
| Media & Press     | Quarterly            | Press releases              | Major launches, achievements        |

---

## 7. Risks & Mitigation Strategies

### 7.1 Business Risks

| Risk                        | Probability | Impact | Mitigation Strategy                                                                         |
| --------------------------- | ----------- | ------ | ------------------------------------------------------------------------------------------- |
| Low user adoption           | Medium      | High   | - Extensive user research<br>- Free tier to lower barrier<br>- Strong onboarding experience |
| Competition from incumbents | Medium      | Medium | - Focus on niche (special education)<br>- Superior UX<br>- AI differentiation               |
| Pricing resistance          | High        | Medium | - Freemium model<br>- Clear ROI messaging<br>- Pilot programs                               |
| Slow sales cycle (schools)  | High        | Low    | - Target individual teachers first<br>- Bottom-up adoption strategy                         |

### 7.2 Technical Risks

| Risk                     | Probability | Impact | Mitigation Strategy                                                                                |
| ------------------------ | ----------- | ------ | -------------------------------------------------------------------------------------------------- |
| AI quality issues        | Medium      | High   | - Extensive testing with real data<br>- Human-in-the-loop review<br>- Continuous model improvement |
| Performance issues       | Low         | Medium | - Load testing<br>- CDN for assets<br>- Offline-first architecture                                 |
| Data loss                | Low         | High   | - Regular backups<br>- Firebase redundancy<br>- Data export features                               |
| Third-party API downtime | Medium      | Medium | - Graceful degradation<br>- Queue system<br>- Status monitoring                                    |

### 7.3 Regulatory Risks

| Risk                         | Probability | Impact | Mitigation Strategy                                                             |
| ---------------------------- | ----------- | ------ | ------------------------------------------------------------------------------- |
| Data privacy violations      | Low         | High   | - GDPR compliance<br>- Regular security audits<br>- Clear privacy policy        |
| App store rejection          | Low         | Medium | - Follow guidelines strictly<br>- Pre-submission review<br>- Legal consultation |
| Education regulation changes | Low         | Medium | - Monitor regulatory updates<br>- Flexible architecture<br>- Legal advisor      |

### 7.4 Operational Risks

| Risk                  | Probability | Impact | Mitigation Strategy                                                          |
| --------------------- | ----------- | ------ | ---------------------------------------------------------------------------- |
| Key personnel leaving | Medium      | High   | - Knowledge documentation<br>- Cross-training<br>- Competitive compensation  |
| Budget overrun        | Medium      | Medium | - 10% contingency buffer<br>- Monthly budget reviews<br>- Phased development |
| Delayed timeline      | High        | Low    | - Agile methodology<br>- MVP approach<br>- Regular retrospectives            |

---

## 8. Competitive Analysis

### 8.1 Direct Competitors

**1. ClassDojo (International)**

- Strengths: Large user base, strong brand, behavior tracking
- Weaknesses: Not tailored for special education, no AI features
- Our Advantage: Special education focus, AI lesson creation, Vietnamese language

**2. Các ứng dụng giáo dục Việt Nam**

- Strengths: Local knowledge, Vietnamese language
- Weaknesses: Generic K-12 focus, limited special education features
- Our Advantage: Niche focus, ABC behavior methodology, advanced analytics

### 8.2 Indirect Competitors

- Google Classroom / Microsoft Teams for Education
- Paper-based logging systems
- Excel spreadsheets
- Generic note-taking apps (Notion, Evernote)

### 8.3 Competitive Advantages

1. **Specialized for Special Education**: Only app designed for special needs teachers in Vietnam
2. **AI-Powered**: Automate lesson planning with OpenAI integration
3. **ABC Behavior Methodology**: Scientific approach to behavior tracking
4. **Mobile-First**: Optimized for on-the-go teachers
5. **Vietnamese Language**: Native language support with local terminology
6. **Offline-First**: Works without internet connection
7. **Behavior Dictionary**: 127+ pre-defined behaviors with interventions

---

## 9. Success Criteria

### 9.1 Launch Success (Month 3)

- ✅ 4,000+ total downloads
- ✅ 3,000+ monthly active users
- ✅ 40% DAU/MAU ratio
- ✅ 4.0+ App Store rating
- ✅ 65% Day 7 retention
- ✅ <2% crash rate
- ✅ 80% users complete onboarding
- ✅ 1,500+ paid subscribers (40% conversion)

### 9.2 Product-Market Fit (Month 6)

- ✅ 6,500+ monthly active users
- ✅ 50% free-to-paid conversion
- ✅ 80% Month 3 retention
- ✅ 4.5+ App Store rating
- ✅ 60%+ users try AI feature
- ✅ NPS Score: 50+
- ✅ <5% monthly churn
- ✅ Organic growth (word-of-mouth) >30%

### 9.3 Sustainable Growth (Month 12)

- ✅ 10,000+ monthly active users
- ✅ 750M VND MRR
- ✅ 55% free-to-paid conversion
- ✅ LTV:CAC ratio >3:1
- ✅ Break-even or profitable
- ✅ 80%+ users rate as "essential" tool
- ✅ Feature parity with international competitors
- ✅ Ready for Series A fundraising

---

## 10. Các Bước Tiếp Theo & Phê Duyệt

### 10.1 Các Bước Ngay Sau Đây

1. **Tuần 1-2**: Các bên liên quan xem xét và phê duyệt BRD
2. **Tuần 3-4**: Tạo Tài liệu Yêu cầu Sản phẩm (PRD)
3. **Tuần 5-6**: Thực hiện phỏng vấn người dùng với 20+ giáo viên
4. **Tuần 7-8**: Hoàn thiện Đặc tả Yêu cầu Chức năng (FRS)
5. **Tuần 9-10**: Bắt đầu thiết kế hệ thống và kiến trúc

### 10.2 Phê Duyệt Bắt Buộc

| Người Phê Duyệt | Vai Trò               | Yêu Cầu Trước | Trạng Thái   |
| --------------- | --------------------- | ------------- | ------------ |
| CEO             | Nhà Tài trợ Điều hành | 01/11/2025    | ⏳ Chờ duyệt |
| CTO             | Khả thi Kỹ thuật      | 01/11/2025    | ⏳ Chờ duyệt |
| CFO             | Phê duyệt Ngân sách   | 05/11/2025    | ⏳ Chờ duyệt |
| Product Manager | Đồng bộ Yêu cầu       | 01/11/2025    | ⏳ Chờ duyệt |
| Legal Counsel   | Xem xét Tuân thủ      | 10/11/2025    | ⏳ Chờ duyệt |

### 10.3 Ký Xác Nhận

Bằng việc ký dưới đây, các bên liên quan xác nhận đã xem xét và phê duyệt Tài liệu Yêu cầu Kinh doanh này.

---

**CEO / Nhà Tài trợ Điều hành**: ******\_\_\_\_****** Ngày: ****\_\_****

**CTO / Trưởng phòng Kỹ thuật**: ******\_\_\_\_****** Ngày: ****\_\_****

**CFO / Tài chính**: ******\_\_\_\_****** Ngày: ****\_\_****

**Product Manager / Quản lý Sản phẩm**: ******\_\_\_\_****** Ngày: ****\_\_****

**Head of Marketing / Trưởng phòng Marketing**: ******\_\_\_\_****** Ngày: ****\_\_****

---

## Phụ Lục

### Phụ Lục A: Bảng Thuật Ngữ

- **ABC Behavior**: Phương pháp Tiền tố-Hành vi-Hậu quả để theo dõi hành vi
- **ARPU**: Doanh thu Trung bình trên Người dùng (Average Revenue Per User)
- **DAU**: Người dùng Hoạt động Hàng ngày (Daily Active Users)
- **LTV**: Giá trị Trọn đời (Lifetime Value)
- **MAU**: Người dùng Hoạt động Hàng tháng (Monthly Active Users)
- **MRR**: Doanh thu Định kỳ Hàng tháng (Monthly Recurring Revenue)
- **NPS**: Điểm Khuyến nghị Thuần (Net Promoter Score)
- **MVP**: Sản phẩm Khả thi Tối thiểu (Minimum Viable Product)
- **SAM**: Thị trường Có thể Phục vụ (Serviceable Addressable Market)
- **SOM**: Thị trường Có thể Đạt được (Serviceable Obtainable Market)
- **TAM**: Tổng Thị trường Tiềm năng (Total Addressable Market)

### Phụ Lục B: Tài Liệu Tham Khảo

- Wireframes: `/docs-project/wireframes-final/`
- Tài liệu Kỹ thuật: `/docs-project/MODULE_INTEGRATION.md`
- Cấu trúc Dữ liệu: `/docs-project/DATA_STRUCTURE.md`
- Quy trình Phát triển: `/docs-project/DEVELOPMENT_PROCESS.md`

### Phụ Lục C: Lịch Sử Sửa Đổi

| Phiên bản | Ngày       | Tác giả       | Thay đổi             |
| --------- | ---------- | ------------- | -------------------- |
| 1.0       | 23/10/2025 | Nhóm Sản phẩm | Tạo tài liệu ban đầu |

---

**Kết thúc Tài liệu Yêu cầu Kinh doanh**
