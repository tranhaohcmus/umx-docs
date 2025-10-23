# UX Guidelines & Best Practices

## Core UX Principles

### 1. Mobile-First Design

**Philosophy**: Design for the smallest screen first, then scale up.

**Implementation**:

- Touch targets minimum 44x44pt
- Thumb-friendly navigation at bottom
- Single-column layouts (mobile)
- Progressive disclosure of information
- Swipe gestures for common actions
- Vertical scrolling preferred

**Why**: Teachers use app while teaching, need one-handed operation.

---

### 2. Progressive Disclosure

**Philosophy**: Show only what's necessary, reveal details on demand.

**Implementation**:

- Collapsible sections (session content)
- Step-by-step forms (manual creation)
- "View more" expandable lists
- Tooltips for advanced features
- Contextual help

**Why**: Reduces cognitive load, prevents overwhelm.

---

### 3. Feedback & Affordance

**Philosophy**: Every action should have immediate, clear feedback.

**Implementation**:

- Loading states (spinners, skeletons)
- Success confirmations (toasts, checkmarks)
- Error messages (specific, actionable)
- Haptic feedback (button press, long press)
- Visual state changes (hover, active, disabled)
- Progress indicators (AI processing, uploads)

**Why**: Builds confidence, prevents confusion.

---

### 4. Gesture-Based Interactions

**Philosophy**: Leverage native mobile gestures for efficiency.

**Implementation**:

- Swipe left: Delete/Quick actions
- Pull down: Refresh data
- Long press: Select multiple
- Swipe calendar: Navigate weeks
- Pinch zoom: Charts, images
- Swipe down on sheet: Dismiss

**Why**: Faster than button taps, feels natural.

---

### 5. Offline-First Approach

**Philosophy**: App should work without internet connection.

**Implementation**:

- Cache all viewed data
- Allow offline logging
- Queue sync when online
- Show offline indicator
- Graceful degradation (disable AI features)
- Conflict resolution on sync

**Why**: Teachers may work in areas with poor connectivity.

---

### 6. Accessibility

**Philosophy**: App should be usable by everyone.

**Implementation**:

- VoiceOver/TalkBack support
- Dynamic type (font scaling)
- Color contrast (WCAG AA)
- Focus indicators
- Descriptive labels
- Alternative text for images
- Keyboard navigation (iPad)

**Why**: Inclusive design, legal compliance.

---

### 7. Performance

**Philosophy**: App should feel fast and responsive.

**Implementation**:

- Optimize images (WebP, lazy load)
- Virtualized lists (100+ items)
- Skeleton screens (perceived performance)
- Debounce search inputs
- Cache frequently accessed data
- Background sync
- Native animations (60fps)

**Why**: Poor performance = abandonment.

---

### 8. Error Prevention

**Philosophy**: Prevent errors before they happen.

**Implementation**:

- Confirmation dialogs (delete, logout)
- Form validation (real-time)
- Auto-save drafts
- Undo actions (toast with undo)
- Smart defaults (date = today)
- Clear constraints (file size, format)

**Why**: Better than error recovery.

---

## Information Architecture

### Navigation Hierarchy

```
Bottom Navigation (Level 1)
├── 🏠 Nhà (Dashboard)
│   ├── Student List
│   └── Quick Stats
│
├── 📝 Ghi (Logging)
│   ├── Create Session (Manual/AI)
│   └── Log Session
│
├── 📊 Báo (Reports)
│   ├── Analytics Overview
│   ├── Behavior Detail
│   └── Behavior Comparison
│
└── 👤 Tôi (Profile)
    ├── Profile Info
    └── Settings
```

### Content Priority

1. **Primary**: Quick access to logging (main job-to-be-done)
2. **Secondary**: View student progress, create sessions
3. **Tertiary**: Analytics, settings, help

---

## Interaction Patterns

### 1. List Patterns

**Infinite Scroll**:

- Load more on scroll (20 items per page)
- Show loading indicator
- For: Student list (if 100+), session history

**Pull-to-Refresh**:

- Standard gesture on all lists
- Show spinner + "Đang tải..."
- Haptic feedback on trigger

**Swipe Actions**:

- Swipe left: Reveal actions
- Color code: Red (delete), Blue (edit), Green (complete)
- Partial swipe: Show icons
- Full swipe: Execute primary action

**Multi-Select**:

- Long press first item
- Tap others to select
- Show count in header
- Batch actions at top

---

### 2. Form Patterns

**Step-by-Step (Wizards)**:

- Progress indicator at top
- One concept per step
- Next/Back navigation
- Save draft option
- Used for: Manual session creation, logging

**Inline Editing**:

- Tap to edit
- Show save/cancel inline
- Auto-save on blur (with confirmation)
- Used for: Profile info, student info

**Smart Defaults**:

- Date: Today
- Time: Based on session type (Sáng/Chiều)
- Pre-fill from last entry

**Validation**:

- Real-time (on blur)
- Clear error messages
- Scroll to first error
- Prevent submission until valid

---

### 3. Search Patterns

**Instant Search**:

- Search as you type (debounced 300ms)
- Highlight matches
- Show count
- Clear button (✕)
- Recent searches (optional)

**Filters & Sort**:

- Bottom sheet for filters
- Chips for active filters
- Clear all option
- Sort: Dropdown or segmented control

---

### 4. Empty States

**Friendly & Actionable**:

- Large icon (60x60pt)
- Clear explanation
- Primary CTA
- Optional help link
- Examples: No students, No sessions, No favorites

**When to Show**:

- First-time users
- After deletion
- After filtering (no results)
- Network errors (with retry)

---

### 5. Loading States

**Skeleton Screens** (Preferred):

- Show content structure
- Shimmer animation
- Better perceived performance
- For: Lists, cards, detailed views

**Spinners**:

- Button loading states
- Small inline loaders
- Full-screen initial load

**Progress Bars**:

- Long operations (AI processing)
- File uploads
- Show percentage + estimated time

---

### 6. Success States

**Celebrations**:

- Icon + message
- Auto-dismiss (3s) or manual close
- Next action buttons
- For: Create session, Complete logging, Export report

**Toasts**:

- Non-blocking
- 2-3 seconds
- Action button (Undo, View)
- For: Save, Delete, Export

---

## Data Entry Optimization

### 1. Minimize Typing

- Smart defaults
- Dropdowns with search
- Recent selections
- Templates/Presets
- Voice input (notes)

### 2. Behavior Library

- Pre-defined 127+ behaviors
- Search + quick select
- Frequently used at top
- Save as template
- Auto-suggest from history

### 3. Auto-Complete

- Student names
- Behavior antecedents
- Behavior consequences
- Goal templates

### 4. Bulk Actions

- Multi-select sessions
- Bulk delete
- Bulk export
- AI create multiple sessions

---

## Onboarding & Help

### First-Time Experience

**Onboarding Screens** (3 screens):

1. Welcome + value prop
2. Key feature 1: Easy logging
3. Key feature 2: Analytics

- Swipeable, skippable
- Show once only

**Empty States as Guides**:

- No students → "Add your first student"
- No sessions → "Create with manual or AI"
- Contextual help where needed

**Tooltips**:

- Show on first use
- Dismissible
- "Don't show again" option
- For: Complex features (ABC entry, AI upload)

### Ongoing Help

- Help icon in navigation bar
- Searchable FAQ
- Video tutorials (embedded)
- Contact support
- In-app chat (optional)

---

## Content Strategy

### Voice & Tone

**Friendly, Professional, Supportive**:

- Use "you" and "your"
- Positive language
- Avoid jargon
- Clear, concise
- Encouraging (not patronizing)

**Examples**:

- ❌ "Error: Invalid input"
- ✅ "Vui lòng nhập tên học sinh"

- ❌ "Task completed successfully"
- ✅ "Tuyệt vời! Bạn đã hoàn thành buổi học"

### Microcopy

**Button Labels**:

- Action-oriented: "Tạo buổi học", "Bắt đầu ghi"
- Not: "OK", "Submit", "Click here"

**Error Messages**:

- Explain what happened
- Why it happened
- How to fix it
- Example: "Không thể tải file. File quá lớn (>10MB). Vui lòng chọn file nhỏ hơn."

**Success Messages**:

- Confirm action
- Next steps
- Example: "Đã lưu nhật ký! [Xem báo cáo →]"

---

## Platform-Specific Considerations

### iOS

- Use SF Symbols for icons
- Bottom sheet = half modal
- Navigation bar = 44pt
- Tab bar = 49pt + safe area
- Haptic feedback: UIImpactFeedback
- Action sheets for destructive actions
- Use native date/time pickers

### Android

- Use Material Icons
- Bottom sheet = BottomSheetDialogFragment
- App bar = 56dp
- Bottom nav = 56dp
- Ripple effects on tap
- Floating Action Button (FAB)
- Snackbar for toasts
- Use native Material pickers

---

## Performance Optimization

### Perceived Performance

- Skeleton screens
- Optimistic UI updates
- Instant feedback
- Background sync
- Cache aggressively

### Real Performance

- Lazy load images
- Virtualized lists (FlatList)
- Debounce search (300ms)
- Throttle scroll events
- Code splitting (if web)
- Reduce bundle size
- Native animations (Reanimated)

---

## Internationalization (i18n)

### Text

- Externalize all strings
- Support Vietnamese (primary)
- English (secondary)
- RTL support (future)

### Numbers & Dates

- Vietnamese format: DD/MM/YYYY
- 24-hour time (or 12-hour with AM/PM)
- Locale-aware number formatting

### Cultural Considerations

- Formal pronouns (Cô, Em, Bé)
- Respectful language for children
- Color meanings (cultural)

---

## Analytics & Metrics

### Track User Behavior

- Screen views
- Button taps
- Feature usage (Manual vs AI)
- Completion rates (logging steps)
- Error rates
- Session duration

### KPIs

- Daily Active Users (DAU)
- Logging completion rate
- Time to create session
- AI usage rate
- Retention (D1, D7, D30)

### A/B Testing

- Onboarding variations
- Button copy
- Feature placement
- AI prompts

---

## Security & Privacy

### Data Protection

- Encrypt sensitive data
- Secure API communication (HTTPS)
- Token-based auth (JWT)
- Biometric login (Face ID, Fingerprint)
- Auto-logout after inactivity

### Privacy

- GDPR/COPPA compliance
- Clear privacy policy
- User consent for data collection
- Data export/delete options
- Anonymize analytics data

### Permissions

- Request only when needed
- Explain why needed
- Handle denials gracefully
- Camera: For photos
- Storage: For file upload
- Notifications: For reminders

---

## Future Enhancements

### Collaboration

- Share reports with parents
- Teacher collaboration
- Comment threads

### AI Improvements

- Voice-to-text logging
- AI-suggested interventions
- Predictive behavior analysis

### Advanced Analytics

- Longitudinal studies
- Cross-student comparisons
- Trend predictions

### Platform Expansion

- iPad optimization
- Desktop web app
- Apple Watch companion

---

## Resources

### Design Tools

- Figma (design system)
- Sketch (wireframes)
- Principle (prototypes)
- LottieFiles (animations)

### Accessibility

- WCAG 2.1 Guidelines
- Apple Human Interface Guidelines
- Material Design Accessibility

### Research

- Nielsen Norman Group (UX research)
- Laws of UX (principles)
- Baymard Institute (usability)

---

**Remember**: The goal is to make teachers' lives easier. Every design decision should reduce friction, save time, and provide value. When in doubt, test with real teachers and iterate based on feedback.
