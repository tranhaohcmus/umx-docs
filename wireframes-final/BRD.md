# Business Requirements Document (BRD)

# Educare Connect - Special Education Management System

**Document Version:** 1.0  
**Date:** November 4, 2025  
**Project Owner:** Educare Team  
**Prepared By:** Product Management Team

---

## 📋 TABLE OF CONTENTS

1. [Executive Summary](#executive-summary)
2. [Business Objectives](#business-objectives)
3. [Target Users](#target-users)
4. [Success Metrics (KPIs)](#success-metrics-kpis)
5. [Budget & Timeline](#budget--timeline)
6. [Stakeholders](#stakeholders)
7. [Market Analysis](#market-analysis)
8. [Risk Assessment](#risk-assessment)

---

## 1. EXECUTIVE SUMMARY

### 1.1 Project Overview

**Educare Connect** là ứng dụng mobile-first giúp giáo viên giáo dục đặc biệt (GDĐB) quản lý, ghi nhật ký và phân tích hành vi học sinh một cách hiệu quả, dựa trên phương pháp khoa học (evidence-based practice).

### 1.2 Business Problem

Hiện tại, giáo viên GDĐB đang gặp phải các vấn đề:

1. **Thiếu công cụ quản lý tập trung**: Giáo viên sử dụng sổ giấy, Excel, hoặc ghi chú rời rạc
2. **Tốn thời gian ghi chép**: Mất 30-45 phút/buổi để ghi nhật ký thủ công
3. **Khó theo dõi tiến độ**: Không có công cụ phân tích xu hướng hành vi theo thời gian
4. **Thiếu cơ sở khoa học**: Không có từ điển hành vi evidence-based bằng tiếng Việt
5. **Khó cộng tác với phụ huynh**: Báo cáo thủ công, không nhất quán

### 1.3 Proposed Solution

Educare Connect cung cấp:

- **Ghi nhật ký nhanh**: Giảm thời gian từ 45 phút xuống còn 10-15 phút
- **AI-powered session creation**: Tạo giáo án tự động từ file upload
- **Behavior Dictionary**: Thư viện 127+ hành vi evidence-based
- **ABC Tracking**: Ghi nhận hành vi theo mô hình Antecedent-Behavior-Consequence
- **Analytics Dashboard**: Trực quan hóa tiến độ và xu hướng hành vi
- **Cross-platform**: Mobile (iOS/Android) + Web (future)

### 1.4 Value Proposition

| Đối tượng          | Giá trị                                                                                                  |
| ------------------ | -------------------------------------------------------------------------------------------------------- |
| **Giáo viên**      | Tiết kiệm 70% thời gian ghi chép, có công cụ phân tích chuyên nghiệp, tăng tính khoa học trong can thiệp |
| **Phụ huynh**      | Nhận báo cáo chi tiết, minh bạch về tiến độ con, hiểu rõ hành vi và cách can thiệp                       |
| **Nhà trường**     | Quản lý chất lượng giảng dạy, có dữ liệu để cải tiến chương trình                                        |
| **Nhà nghiên cứu** | Dữ liệu ẩn danh hóa để nghiên cứu xu hướng hành vi trẻ GDĐB tại Việt Nam                                 |

---

## 2. BUSINESS OBJECTIVES

### 2.1 Primary Objectives

#### OBJ-1: Market Penetration (6 tháng đầu)

- Đạt **500 giáo viên đăng ký** trong 3 tháng đầu
- Đạt **1,000 giáo viên active users** sau 6 tháng
- Coverage **30% các trung tâm GDĐB tại TP.HCM và Hà Nội**

#### OBJ-2: User Engagement (12 tháng)

- **60% daily active users** (giáo viên mở app mỗi ngày)
- **80% logging completion rate** (tỷ lệ hoàn thành ghi nhật ký)
- **Average 5 sessions logged per teacher per week**

#### OBJ-3: Revenue Generation (12 tháng)

- **Freemium model**: Free tier với giới hạn 3 học sinh
- **Premium tier**: 99,000 VND/tháng (unlimited students + AI features)
- Target **20% conversion rate** (free → premium)
- **ARR (Annual Recurring Revenue)**: 500M VND sau 12 tháng

### 2.2 Secondary Objectives

#### OBJ-4: Data Quality

- **90% sessions** có ghi nhận hành vi ABC
- **85% sessions** có đánh giá thái độ học tập
- **Average 3 behaviors tracked per session**

#### OBJ-5: Feature Adoption

- **AI session creation**: Được sử dụng bởi 40% users
- **Behavior Dictionary**: Được tham khảo 80% users
- **Analytics Reports**: Được xuất 50% users monthly

#### OBJ-6: Platform Expansion (18-24 tháng)

- Launch **iPad app** với Apple Pencil support
- Launch **Web dashboard** cho nhà quản lý
- Integration với **Google Classroom, Microsoft Teams**

---

## 3. TARGET USERS

### 3.1 Primary Users (Personas)

#### Persona 1: Cô Mai - Giáo viên GDĐB Kinh nghiệm

**Demographics:**

- **Tuổi**: 28-35
- **Giới tính**: Nữ (85% giáo viên GDĐB)
- **Kinh nghiệm**: 3-7 năm
- **Địa điểm**: Trung tâm GDĐB tư nhân, TP.HCM

**Characteristics:**

- Quản lý 5-8 học sinh/tuần
- Mỗi buổi học 2-3 giờ
- Làm việc 6 ngày/tuần
- Tech-savvy, sử dụng smartphone thường xuyên

**Pain Points:**

- Tốn 45 phút/buổi để ghi nhật ký sau mỗi session
- Khó theo dõi tiến độ dài hạn của học sinh
- Phụ huynh thường hỏi "Con tiến bộ chưa?" → Khó trả lời định lượng
- Thiếu công cụ evidence-based để tham khảo can thiệp

**Goals:**

- Ghi nhật ký nhanh, chính xác
- Có báo cáo trực quan để chia sẻ với phụ huynh
- Học hỏi phương pháp can thiệp mới từ cộng đồng
- Tăng tính chuyên nghiệp trong công việc

**How Educare Helps:**

- ✅ Giảm thời gian ghi nhật ký từ 45 → 15 phút
- ✅ Tự động tạo báo cáo PDF/Excel để gửi phụ huynh
- ✅ Thư viện 127+ hành vi với can thiệp evidence-based
- ✅ Analytics Dashboard theo dõi xu hướng theo tuần/tháng

---

#### Persona 2: Thầy Minh - Giáo viên GDĐB Mới

**Demographics:**

- **Tuổi**: 22-26
- **Kinh nghiệm**: < 2 năm
- **Địa điểm**: Trường PTCS công lập, Hà Nội

**Characteristics:**

- Mới ra trường, chưa quen việc ghi chép
- Quản lý 3-5 học sinh
- Thiếu kinh nghiệm nhận diện hành vi
- Cần hướng dẫn chi tiết

**Pain Points:**

- Không biết ghi nhật ký như thế nào cho chuẩn
- Không biết hành vi nào cần can thiệp
- Sợ thiếu sót thông tin quan trọng
- Cần tham khảo từ đồng nghiệp nhiều hơn

**Goals:**

- Học cách ghi nhật ký đúng chuẩn
- Có template sẵn để tham khảo
- Học về các hành vi phổ biến và cách can thiệp
- Tự tin hơn khi báo cáo với phụ huynh

**How Educare Helps:**

- ✅ Onboarding chi tiết với video hướng dẫn
- ✅ Template session sẵn có (Content Library)
- ✅ Behavior Dictionary giải thích từng hành vi
- ✅ Gợi ý ABC antecedents/consequences

---

#### Persona 3: Bà Lan - Phụ Huynh (Secondary User)

**Demographics:**

- **Tuổi**: 30-45
- **Con**: Trẻ 3-8 tuổi có nhu cầu GDĐB
- **Nghề nghiệp**: Đa dạng (văn phòng, kinh doanh, nội trợ)

**Characteristics:**

- Quan tâm sâu sắc đến tiến độ con
- Muốn hiểu rõ hành vi con ở trường
- Sẵn sàng hợp tác với giáo viên
- Thường xuyên hỏi "Con học thế nào?"

**Pain Points:**

- Không biết con học gì, tiến bộ ra sao
- Báo cáo của giáo viên không đều đặn
- Khó hình dung hành vi con qua mô tả text
- Muốn biết cách can thiệp ở nhà

**Goals:**

- Nhận báo cáo định kỳ về tiến độ con
- Xem ảnh/video minh họa
- Hiểu rõ hành vi và cách can thiệp
- Cộng tác tốt hơn với giáo viên

**How Educare Helps:**

- ✅ Xuất báo cáo PDF với biểu đồ trực quan
- ✅ Ảnh/video đính kèm trong nhật ký
- ✅ Giải thích hành vi theo ABC model
- ✅ Gợi ý can thiệp evidence-based (future: parent portal)

---

### 3.2 Secondary Users

#### User Group: Quản Lý Trung Tâm GDĐB

**Needs:**

- Dashboard tổng quan toàn trung tâm
- So sánh hiệu suất giáo viên
- Xuất báo cáo cho cơ quan quản lý
- Quản lý thanh toán subscription

**Future Features:**

- Admin panel (Web)
- Multi-teacher management
- Billing & invoicing
- Compliance reports

---

#### User Group: Nhà Nghiên Cứu GDĐB

**Needs:**

- Dữ liệu ẩn danh hóa về hành vi trẻ GDĐB
- Phân tích xu hướng hành vi theo vùng/độ tuổi
- Nghiên cứu hiệu quả can thiệp

**Future Features:**

- Data export for research (with consent)
- Anonymized dataset API
- Research collaboration program

---

## 4. SUCCESS METRICS (KPIs)

### 4.1 User Acquisition Metrics

| Metric                         | Baseline | 3 months | 6 months | 12 months | Measurement Method     |
| ------------------------------ | -------- | -------- | -------- | --------- | ---------------------- |
| **Total Registered Users**     | 0        | 500      | 1,000    | 3,000     | Database count         |
| **Daily Active Users (DAU)**   | 0        | 300      | 600      | 1,800     | Google Analytics       |
| **Monthly Active Users (MAU)** | 0        | 450      | 900      | 2,700     | GA + Database          |
| **DAU/MAU Ratio**              | -        | 67%      | 67%      | 67%       | DAU/MAU                |
| **App Downloads**              | 0        | 800      | 1,500    | 4,000     | App Store + Play Store |

---

### 4.2 User Engagement Metrics

| Metric                              | Target     | Measurement Method                    |
| ----------------------------------- | ---------- | ------------------------------------- |
| **Avg Sessions Logged/Week**        | 5          | Database query                        |
| **Session Logging Completion Rate** | 80%        | (Completed sessions / Total sessions) |
| **Avg Time in App/Day**             | 15 minutes | Firebase Analytics                    |
| **Feature Adoption Rate**           |            |                                       |
| - AI Session Creation               | 40%        | % users who used AI upload            |
| - Behavior Dictionary               | 80%        | % users who viewed dictionary         |
| - Analytics Reports                 | 50%        | % users who exported reports          |
| **Retention Rate (D1)**             | 70%        | % users who return next day           |
| **Retention Rate (D7)**             | 50%        | % users who return after 7 days       |
| **Retention Rate (D30)**            | 40%        | % users who return after 30 days      |

---

### 4.3 Business Metrics

| Metric                               | Year 1 Target | Measurement Method                      |
| ------------------------------------ | ------------- | --------------------------------------- |
| **Total Revenue**                    | 500M VND      | Payment gateway reports                 |
| **ARR (Annual Recurring Revenue)**   | 500M VND      | Sum of all subscriptions                |
| **Conversion Rate (Free → Premium)** | 20%           | (Premium users / Total users)           |
| **Churn Rate**                       | < 5%/month    | Cancellations / Active subscribers      |
| **Customer Lifetime Value (CLV)**    | 1.5M VND      | Avg subscription duration × Monthly fee |
| **Customer Acquisition Cost (CAC)**  | 150K VND      | Marketing spend / New users             |
| **CLV/CAC Ratio**                    | 10:1          | CLV / CAC                               |

---

### 4.4 Product Quality Metrics

| Metric                      | Target     | Measurement Method           |
| --------------------------- | ---------- | ---------------------------- |
| **Crash-Free Rate**         | > 99%      | Firebase Crashlytics         |
| **App Load Time**           | < 2s       | Performance monitoring       |
| **API Response Time**       | < 500ms    | Backend monitoring (DataDog) |
| **User Satisfaction (NPS)** | > 50       | In-app surveys               |
| **App Store Rating**        | > 4.5      | App Store + Play Store       |
| **Support Ticket Volume**   | < 50/month | Zendesk tickets              |

---

### 4.5 Data Quality Metrics

| Metric                                | Target | Measurement Method              |
| ------------------------------------- | ------ | ------------------------------- |
| **Sessions with ABC Behavior Logs**   | 90%    | Database query                  |
| **Sessions with Attitude Evaluation** | 85%    | Database query                  |
| **Sessions with Teacher Notes**       | 70%    | Database query                  |
| **Avg Behaviors Tracked/Session**     | 3      | AVG(behavior_count) per session |
| **Avg Goals Evaluated/Session**       | 12     | AVG(goal_count) per session     |

---

## 5. BUDGET & TIMELINE

### 5.1 Development Budget (Year 1)

| Category                         | Cost (VND)     | Notes                       |
| -------------------------------- | -------------- | --------------------------- |
| **Personnel**                    |                |                             |
| - Product Manager (1 FTE)        | 240M           | 20M/month × 12 months       |
| - UI/UX Designer (0.5 FTE)       | 120M           | 10M/month × 12 months       |
| - Mobile Developers (2 FTE)      | 720M           | 30M/month × 2 × 12 months   |
| - Backend Developer (1 FTE)      | 360M           | 30M/month × 12 months       |
| - QA Engineer (1 FTE)            | 240M           | 20M/month × 12 months       |
| **Infrastructure**               |                |                             |
| - Cloud Hosting (Supabase)       | 36M            | 3M/month × 12 months        |
| - CDN (Cloudflare)               | 12M            | 1M/month × 12 months        |
| - AI Processing (OpenAI API)     | 24M            | 2M/month × 12 months        |
| - Monitoring (DataDog)           | 12M            | 1M/month × 12 months        |
| **Marketing**                    |                |                             |
| - Digital Ads (Facebook, Google) | 120M           | 10M/month × 12 months       |
| - Content Marketing              | 36M            | 3M/month × 12 months        |
| - Events & Conferences           | 48M            | 4 events × 12M              |
| **Software & Tools**             |                |                             |
| - Development Tools              | 24M            | Figma, GitHub, Jira, etc.   |
| - Analytics Tools                | 12M            | Mixpanel, Firebase          |
| **Contingency (10%)**            | 200M           | Buffer for unexpected costs |
| **TOTAL BUDGET**                 | **2,204M VND** | (~$90,000 USD)              |

---

### 5.2 Timeline (12 months)

```
┌─────────────────────────────────────────────────────────────────────┐
│                         PROJECT TIMELINE                            │
└─────────────────────────────────────────────────────────────────────┘

PHASE 1: PLANNING & DESIGN (Month 1-2)
├─ Week 1-2: Market Research & User Interviews
├─ Week 3-4: Wireframing & Prototyping
├─ Week 5-6: Design System & UI/UX Finalization
└─ Week 7-8: Technical Architecture & Database Design

PHASE 2: ALPHA DEVELOPMENT (Month 3-5)
├─ Month 3: Core Features
│   ├─ Authentication & User Management
│   ├─ Student Management
│   └─ Session Creation (Manual)
├─ Month 4: Logging Features
│   ├─ Session Logging (4-step flow)
│   ├─ ABC Behavior Tracking
│   └─ Goal Evaluation
└─ Month 5: Analytics & Dictionary
    ├─ Behavior Dictionary (127+ behaviors)
    ├─ Analytics Dashboard
    └─ Reports Export (PDF/Excel)

PHASE 3: BETA DEVELOPMENT (Month 6-7)
├─ Month 6: AI Features
│   ├─ AI Session Creation (OCR + NLP)
│   ├─ Smart Suggestions
│   └─ Content Library
└─ Month 7: Polish & Testing
    ├─ Bug Fixes
    ├─ Performance Optimization
    └─ Beta Testing with 50 teachers

PHASE 4: LAUNCH (Month 8)
├─ Week 1-2: App Store Submission
├─ Week 3: Marketing Campaign Launch
└─ Week 4: Public Launch Event

PHASE 5: POST-LAUNCH (Month 9-12)
├─ Month 9-10: User Feedback & Iteration
│   ├─ Bug fixes based on user reports
│   ├─ Feature improvements
│   └─ Onboarding optimization
├─ Month 11: Premium Features
│   ├─ Advanced Analytics
│   ├─ Team Collaboration
│   └─ Custom Reports
└─ Month 12: Expansion Planning
    ├─ iPad app development kickoff
    ├─ Web dashboard design
    └─ Partnership negotiations
```

---

### 5.3 Milestones

| Milestone                       | Target Date | Success Criteria                           |
| ------------------------------- | ----------- | ------------------------------------------ |
| **M1: Design Complete**         | Month 2     | All 32 wireframes approved by stakeholders |
| **M2: Alpha Launch (Internal)** | Month 5     | Core features working, 0 critical bugs     |
| **M3: Beta Launch (50 users)**  | Month 7     | Beta user satisfaction > 4.0/5.0           |
| **M4: App Store Approval**      | Month 8     | iOS + Android apps approved                |
| **M5: Public Launch**           | Month 8     | 100 users onboarded in first week          |
| **M6: 500 Users**               | Month 10    | Reach 500 active users                     |
| **M7: Revenue Positive**        | Month 11    | Monthly revenue > Monthly burn rate        |
| **M8: 1,000 Users**             | Month 12    | Reach 1,000 active users                   |

---

## 6. STAKEHOLDERS

### 6.1 Internal Stakeholders

#### 6.1.1 Executive Team

**Role:** Final decision makers, budget approval, strategic direction

**Interests:**

- ROI and revenue growth
- Market share and competitive advantage
- Risk mitigation
- Brand reputation

**Engagement:**

- Monthly executive briefings
- Quarterly board presentations
- Budget approval meetings

---

#### 6.1.2 Product Team

**Role:** Define product vision, prioritize features, user research

**Interests:**

- User satisfaction and engagement
- Feature adoption
- Product-market fit
- Competitive differentiation

**Engagement:**

- Daily standups
- Weekly sprint planning
- Bi-weekly user testing
- Monthly roadmap reviews

---

#### 6.1.3 Engineering Team

**Role:** Build and maintain the platform

**Interests:**

- Technical feasibility
- Code quality and maintainability
- Performance and scalability
- Developer experience

**Engagement:**

- Daily standups
- Sprint planning & retrospectives
- Technical architecture reviews
- Code reviews

---

#### 6.1.4 Marketing Team

**Role:** Drive user acquisition and retention

**Interests:**

- User growth metrics
- Brand awareness
- Content performance
- Campaign ROI

**Engagement:**

- Weekly marketing sync
- Monthly campaign reviews
- Launch planning meetings

---

### 6.2 External Stakeholders

#### 6.2.1 Special Education Teachers (Primary Users)

**Role:** End users of the platform

**Interests:**

- Ease of use and time savings
- Accuracy and reliability
- Evidence-based content
- Professional development

**Engagement:**

- Beta testing program
- User interviews (monthly)
- In-app feedback surveys
- Community forum

**Communication Channels:**

- In-app notifications
- Email newsletters
- Facebook Group
- Monthly webinars

---

#### 6.2.2 Special Education Centers & Schools

**Role:** Institutional customers (for team subscriptions)

**Interests:**

- Teacher productivity
- Data quality and compliance
- Cost efficiency
- Training and support

**Engagement:**

- Quarterly business reviews
- Annual contracts
- Dedicated account managers
- On-site training sessions

---

#### 6.2.3 Parents of Students

**Role:** Secondary beneficiaries, influence teacher adoption

**Interests:**

- Transparency in child's progress
- Clear communication with teachers
- Evidence of improvement
- Photo/video documentation

**Engagement:**

- Shared reports (via teachers)
- Parent portal (future)
- Educational content (blog/videos)

---

#### 6.2.4 Academic & Research Community

**Role:** Validate evidence-based approach, contribute content

**Interests:**

- Research data access
- Academic credibility
- Knowledge sharing
- Publications and citations

**Engagement:**

- Research partnership program
- Academic advisory board
- Conference presentations
- Co-authored publications

---

#### 6.2.5 Government & Regulatory Bodies

**Role:** Ensure compliance with education and data protection laws

**Interests:**

- Data privacy (GDPR, COPPA)
- Educational standards compliance
- Accessibility (WCAG)
- Ethical AI use

**Engagement:**

- Compliance reports
- Privacy policy updates
- Certification applications
- Regulatory consultations

---

#### 6.2.6 Investors (Future)

**Role:** Provide funding for growth and expansion

**Interests:**

- Revenue growth and profitability
- Market opportunity and TAM
- Competitive moat
- Exit potential

**Engagement:**

- Quarterly investor updates
- Pitch decks and due diligence
- Board meetings (if applicable)

---

## 7. MARKET ANALYSIS

### 7.1 Market Size (TAM, SAM, SOM)

#### Total Addressable Market (TAM)

- **Vietnam Special Education Market**:
  - ~50,000 special education teachers (public + private)
  - ~200,000 students with special needs (ages 3-18)
  - **TAM = 50,000 teachers × 1.2M VND/year = 60B VND/year** (~$2.5M USD)

#### Serviceable Addressable Market (SAM)

- **Tech-Savvy Teachers in Urban Areas** (TP.HCM, Hà Nội, Đà Nẵng):
  - ~15,000 teachers (30% of TAM)
  - **SAM = 15,000 teachers × 1.2M VND/year = 18B VND/year** (~$750K USD)

#### Serviceable Obtainable Market (SOM - Year 1)

- **Conservative Target**: 3% market share of SAM
- **SOM = 450 teachers × 1.2M VND/year = 540M VND/year** (~$22K USD)
- **Realistic Target**: 5% market share
- **SOM = 750 teachers × 1.2M VND/year = 900M VND/year** (~$37K USD)

---

### 7.2 Competitive Landscape

#### 7.2.1 Direct Competitors

**1. Bloomz (USA)**

- **Strengths**: Communication focus, parent portal, established brand
- **Weaknesses**: Not specialized for special education, no Vietnamese support
- **Price**: $5/teacher/month (~120K VND/month)
- **Market**: USA K-12

**2. Seesaw (USA)**

- **Strengths**: Student portfolio, parent engagement, popular in Asia
- **Weaknesses**: Generic tool, not SPED-focused, no behavior tracking
- **Price**: Free (basic), $10/teacher/month (premium)
- **Market**: Global K-5

**3. ClassDojo (USA)**

- **Strengths**: Behavior tracking, class communication, gamification
- **Weaknesses**: Not SPED-focused, no ABC tracking, limited analytics
- **Price**: Free (ads), $5/teacher/month (ad-free)
- **Market**: Global K-12

**Our Differentiation:**

- ✅ **Specialized for SPED**: Evidence-based behavior library
- ✅ **Vietnamese localization**: First in Vietnam
- ✅ **ABC tracking**: Industry-standard behavior analysis
- ✅ **AI-powered**: Auto-create sessions from lesson plans
- ✅ **Affordable**: 99K VND/month (~$4 USD)

---

#### 7.2.2 Indirect Competitors

**1. Excel/Google Sheets**

- **Strengths**: Free, flexible, familiar
- **Weaknesses**: Time-consuming, no analytics, no mobile optimization
- **Price**: Free
- **Market Share**: ~40% of teachers

**2. Paper Notebooks**

- **Strengths**: Simple, no learning curve
- **Weaknesses**: Not searchable, hard to share, risk of loss
- **Price**: Free
- **Market Share**: ~50% of teachers

**3. Custom School Systems**

- **Strengths**: Institutional support, integrated with school data
- **Weaknesses**: Slow development, not SPED-focused
- **Price**: Varies
- **Market Share**: ~5% (large schools only)

**Our Advantage:**

- 70% time savings vs. Excel/Paper
- Mobile-first for on-the-go logging
- Evidence-based content (not generic)
- Analytics and insights (vs. manual calculations)

---

### 7.3 Market Trends

#### Trend 1: Digital Transformation in Education (Post-COVID)

- **Impact**: 85% of teachers now use at least 1 digital tool
- **Opportunity**: High receptivity to new edtech solutions
- **Timeline**: 2020-2025 growth phase

#### Trend 2: Increased Awareness of Special Education Needs

- **Impact**: Vietnam government mandates inclusive education by 2030
- **Opportunity**: Growing demand for SPED teacher training and tools
- **Timeline**: 2025-2030 expansion

#### Trend 3: Evidence-Based Practice Movement

- **Impact**: Parents and schools demand scientifically-backed interventions
- **Opportunity**: Our 127+ evidence-based behaviors are unique selling point
- **Timeline**: 2023-2027 maturation

#### Trend 4: AI in Education

- **Impact**: AI tools (ChatGPT, etc.) raise expectations for smart features
- **Opportunity**: Our AI session creation is cutting-edge
- **Timeline**: 2023-2026 early adoption

---

## 8. RISK ASSESSMENT

### 8.1 Technical Risks

| Risk                          | Probability | Impact   | Mitigation Strategy                                                            |
| ----------------------------- | ----------- | -------- | ------------------------------------------------------------------------------ |
| **AI OCR accuracy < 80%**     | Medium      | High     | Use multiple OCR providers (Google Vision + Tesseract), manual review fallback |
| **Mobile performance issues** | Low         | High     | Performance testing on low-end devices, code optimization, lazy loading        |
| **Data loss or corruption**   | Low         | Critical | Daily backups, point-in-time recovery, redundant storage (Supabase)            |
| **Security breach**           | Low         | Critical | Encryption at rest & in transit, regular security audits, bug bounty program   |
| **Third-party API downtime**  | Medium      | Medium   | Fallback providers, offline mode, caching                                      |

---

### 8.2 Business Risks

| Risk                                    | Probability | Impact   | Mitigation Strategy                                                        |
| --------------------------------------- | ----------- | -------- | -------------------------------------------------------------------------- |
| **Low user adoption**                   | Medium      | High     | Beta testing with 50 users, iterate based on feedback, marketing campaigns |
| **High churn rate (> 10%/mo)**          | Medium      | High     | Onboarding improvements, customer success team, feature requests           |
| **Low free → premium conversion**       | High        | High     | Clear value prop for premium, free tier limitations, trial periods         |
| **Competitor launches similar product** | Low         | Medium   | Fast iteration, unique features (AI, Vietnamese content), brand loyalty    |
| **Funding shortfall**                   | Low         | Critical | Bootstrapping, angel investment, government grants (STEM innovation)       |

---

### 8.3 Regulatory Risks

| Risk                                      | Probability | Impact   | Mitigation Strategy                                                |
| ----------------------------------------- | ----------- | -------- | ------------------------------------------------------------------ |
| **Data privacy violations (GDPR, COPPA)** | Low         | Critical | Legal consultation, privacy policy compliance, user consent flows  |
| **Educational data restrictions**         | Low         | Medium   | No PII in analytics, anonymize all research data, parental consent |
| **Export restrictions (AI models)**       | Low         | Low      | Use compliant AI providers (OpenAI, Google), local hosting option  |

---

### 8.4 Market Risks

| Risk                           | Probability | Impact | Mitigation Strategy                                                     |
| ------------------------------ | ----------- | ------ | ----------------------------------------------------------------------- |
| **Market too small**           | Low         | High   | Expand to Thailand/Indonesia after Vietnam success, add parent features |
| **Price sensitivity**          | Medium      | Medium | Free tier with generous limits, flexible pricing, annual discounts      |
| **Slow sales cycle (schools)** | High        | Medium | Target individual teachers first, pilot programs with schools           |

---

## 9. ASSUMPTIONS & CONSTRAINTS

### 9.1 Key Assumptions

1. **User Behavior**:

   - Teachers log sessions at least 3x/week
   - Teachers have smartphone with iOS 13+ or Android 8+
   - Teachers have reliable internet connection (3G+)

2. **Market Assumptions**:

   - SPED market in Vietnam will grow 15% annually
   - Teachers are willing to pay 99K VND/month for premium features
   - Schools will reimburse teachers for subscriptions (30% of cases)

3. **Technical Assumptions**:
   - Supabase can handle 10,000 concurrent users
   - OpenAI API uptime > 99.5%
   - App Store approval process < 2 weeks

---

### 9.2 Constraints

#### Technical Constraints

- **Mobile-only**: No web app in Year 1 (resource constraint)
- **Single language**: Vietnamese only in Year 1 (English in Year 2)
- **Manual behavior entry**: No auto-detection via video/sensors (future)

#### Business Constraints

- **Budget**: 2.2B VND total for Year 1
- **Team size**: 5.5 FTE developers + 1 PM + 0.5 Designer
- **Timeline**: 8 months to launch (aggressive)

#### Regulatory Constraints

- **Data residency**: All data must be stored in Vietnam or compliant regions
- **COPPA compliance**: No direct data collection from children < 13
- **Accessibility**: Must meet WCAG 2.1 Level AA for government contracts

---

## 10. SUCCESS CRITERIA & GO/NO-GO DECISION

### 10.1 Launch Criteria (Month 8)

**Must-Have (Go/No-Go):**

- ✅ All 32 wireframe screens implemented and tested
- ✅ Crash-free rate > 98%
- ✅ Beta user satisfaction > 4.0/5.0
- ✅ 90% of features working as designed
- ✅ App Store and Play Store approval received

**Should-Have (Launch but note as known issues):**

- AI OCR accuracy > 80% (can improve post-launch)
- 100% feature parity iOS/Android (can differ slightly)

**Nice-to-Have (Post-launch):**

- Offline mode (can add in update)
- Multi-language support (Year 2)

---

### 10.2 Year 1 Success Definition

**Success = ALL of the following:**

1. ✅ **1,000+ active users** by Month 12
2. ✅ **200+ premium subscribers** (20% conversion)
3. ✅ **> 4.0 App Store rating** (both iOS & Android)
4. ✅ **60% D7 retention rate**
5. ✅ **Revenue positive** (Monthly revenue > Burn rate) by Month 12

**Partial Success = 3/5 criteria met**

- Re-evaluate pricing, features, or target market
- Adjust Year 2 roadmap

**Failure = < 3/5 criteria met**

- Pivot to different user segment (e.g., parents instead of teachers)
- Consider acquisition or shutdown

---

## APPENDIX

### A. Glossary

- **GDĐB**: Giáo dục đặc biệt (Special Education)
- **ABC Model**: Antecedent-Behavior-Consequence (behavior analysis framework)
- **Evidence-Based Practice**: Interventions backed by peer-reviewed research
- **ARR**: Annual Recurring Revenue
- **CLV**: Customer Lifetime Value
- **CAC**: Customer Acquisition Cost
- **NPS**: Net Promoter Score
- **DAU/MAU**: Daily Active Users / Monthly Active Users

---

### B. References

1. **Market Research**:

   - Vietnam Ministry of Education Special Education Statistics 2024
   - UNESCO Inclusive Education Report 2023

2. **Competitive Analysis**:

   - Bloomz pricing page (bloomz.com/pricing)
   - Seesaw feature comparison (seesaw.me)
   - ClassDojo usage statistics (classdojo.com)

3. **Academic Sources**:
   - Applied Behavior Analysis literature (for ABC model)
   - Vietnam Journal of Special Education Research

---

### C. Document History

| Version | Date         | Author       | Changes                           |
| ------- | ------------ | ------------ | --------------------------------- |
| 0.1     | Oct 15, 2025 | Product Team | Initial draft                     |
| 0.5     | Oct 25, 2025 | Product Team | Stakeholder feedback incorporated |
| 1.0     | Nov 4, 2025  | Product Team | Final approval from executives    |

---

**Approval Signatures:**

- **CEO**: ************\_************ Date: ****\_\_\_****
- **CTO**: ************\_************ Date: ****\_\_\_****
- **CFO**: ************\_************ Date: ****\_\_\_****
- **Product Owner**: ******\_\_\_\_****** Date: ****\_\_\_****

---

**Next Steps:**

1. ✅ BRD Approved → Proceed to PRD (Product Requirements Document)
2. ✅ Design System finalization
3. ✅ Development kick-off (Sprint 1)
