# Confirmation Dialogs

## 1. Delete Session Confirmation

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│                                 │
│   ┌─────────────────────────┐   │
│   │                         │   │
│   │  ⚠️ Xóa buổi học?       │   │
│   │                         │   │
│   │  Bạn có chắc chắn muốn  │   │
│   │  xóa buổi học này không?│   │
│   │                         │   │
│   │  ┌─────────────────┐    │   │
│   │  │ T3, 22/10/2025  │    │   │
│   │  │ Buổi sáng       │    │   │
│   │  │ 5 nội dung      │    │   │
│   │  └─────────────────┘    │   │
│   │                         │   │
│   │  Hành động này không thể│   │
│   │  hoàn tác.              │   │
│   │                         │   │
│   │  ───────────────────────│   │
│   │                         │   │
│   │  [HỦY]      [❌ XÓA]   │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## 2. Complete Session Confirmation

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│                                 │
│   ┌─────────────────────────┐   │
│   │                         │   │
│   │  ✅ Hoàn tất buổi học?  │   │
│   │                         │   │
│   │  Bạn đã ghi đủ thông tin│   │
│   │  và sẵn sàng hoàn tất?  │   │
│   │                         │   │
│   │  📊 Kiểm tra lại:       │   │
│   │  ┌─────────────────┐    │   │
│   │  │ ✅ 5/5 nội dung │    │   │
│   │  │ ✅ Thái độ      │    │   │
│   │  │ ✅ Ghi chú      │    │   │
│   │  │ ✅ Hành vi (1)  │    │   │
│   │  └─────────────────┘    │   │
│   │                         │   │
│   │  Sau khi hoàn tất, bạn  │   │
│   │  vẫn có thể xem lại và  │   │
│   │  chỉnh sửa.             │   │
│   │                         │   │
│   │  ───────────────────────│   │
│   │                         │   │
│   │  [HỦY]  [✅ HOÀN TẤT]  │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## 3. Discard Changes Confirmation

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│                                 │
│   ┌─────────────────────────┐   │
│   │                         │   │
│   │  ⚠️ Hủy thay đổi?       │   │
│   │                         │   │
│   │  Bạn có các thay đổi    │   │
│   │  chưa lưu.              │   │
│   │                         │   │
│   │  Nếu thoát, mọi thay đổi│   │
│   │  sẽ bị mất.             │   │
│   │                         │   │
│   │  ───────────────────────│   │
│   │                         │   │
│   │  [Ở LẠI]  [THOÁT]      │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## 4. Logout Confirmation

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│                                 │
│   ┌─────────────────────────┐   │
│   │                         │   │
│   │  🚪 Đăng xuất?          │   │
│   │                         │   │
│   │  Bạn có chắc chắn muốn  │   │
│   │  đăng xuất?             │   │
│   │                         │   │
│   │  💡 Lưu ý:              │   │
│   │  • Dữ liệu đã được lưu  │   │
│   │  • Bạn có thể đăng nhập │   │
│   │    lại bất kỳ lúc nào   │   │
│   │                         │   │
│   │  ───────────────────────│   │
│   │                         │   │
│   │  [HỦY]  [ĐĂNG XUẤT]    │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## 5. Delete Student Confirmation

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│                                 │
│   ┌─────────────────────────┐   │
│   │                         │   │
│   │  ⚠️ Xóa học sinh?       │   │
│   │                         │   │
│   │  Xóa "Bé An" sẽ xóa:    │   │
│   │  • Tất cả buổi học (12) │   │
│   │  • Tất cả nhật ký (45)  │   │
│   │  • Tất cả hành vi (8)   │   │
│   │  • Tất cả báo cáo       │   │
│   │                         │   │
│   │  ⚠️ HÀNH ĐỘNG NÀY KHÔNG │   │
│   │     THỂ HOÀN TÁC!       │   │
│   │                         │   │
│   │  Gợi ý: Sao lưu dữ liệu │   │
│   │  trước khi xóa.         │   │
│   │                         │   │
│   │  ───────────────────────│   │
│   │                         │   │
│   │  [HỦY]  [❌ XÓA VĨNH VIỄN]│   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## Purpose

Confirmation dialogs ngăn chặn hành động không mong muốn.

## Types

### 1. Delete Session

- **Icon**: ⚠️ Warning
- **Info**: Session details
- **Warning**: Cannot undo
- **Actions**: Cancel (gray), Delete (red)

### 2. Complete Session

- **Icon**: ✅ Checkmark
- **Info**: Summary checklist
- **Reassurance**: Can edit later
- **Actions**: Cancel (gray), Complete (green)

### 3. Discard Changes

- **Icon**: ⚠️ Warning
- **Info**: Unsaved changes notice
- **Warning**: Changes will be lost
- **Actions**: Stay (primary), Exit (secondary)

### 4. Logout

- **Icon**: 🚪 Door
- **Info**: Logout confirmation
- **Notes**: Data saved, can login anytime
- **Actions**: Cancel (gray), Logout (blue)

### 5. Delete Student (High Risk)

- **Icon**: ⚠️ Warning (red)
- **Info**: Detailed list of what will be deleted
- **Warning**: CANNOT UNDO (emphasized)
- **Suggestion**: Backup first
- **Actions**: Cancel (gray), Delete (red, emphasized)

## Design Principles

### Visual Hierarchy

1. Icon (top, large)
2. Title (bold, 20pt)
3. Description
4. Details (if needed)
5. Warning (if destructive)
6. Actions (bottom)

### Button Styles

- **Destructive**: Red background ([❌ XÓA])
- **Primary**: Blue/Green ([✅ HOÀN TẤT])
- **Secondary**: Gray outline ([HỦY])
- **Order**: Safe action left, risky action right

### Tone

- **Destructive actions**: Strong warning language
- **Completion**: Reassuring, positive
- **General**: Clear, concise
- **High-risk**: Detailed consequences + suggestion

### Layout

- **Modal**: Centered on screen
- **Background**: 60% dim overlay
- **Width**: 85% of screen width
- **Padding**: 24px
- **Border radius**: 16px
- **Shadow**: Deep shadow

## Interaction

### Gestures

- **Tap outside** = Dismiss (Cancel)
- **Swipe down** = Dismiss (Cancel)
- **Tap Cancel** = Dismiss
- **Tap Confirm** = Execute action

### Keyboard

- **Escape** = Cancel
- **Enter** = Confirm (non-destructive only)

### Animation

- **Open**: Fade + scale (300ms)
- **Close**: Fade out (200ms)
- **Background**: Fade in/out (250ms)

## Accessibility

- VoiceOver announces dialog
- Focus trapped within dialog
- Required buttons clearly labeled
- Warning text announced
- High contrast for destructive actions

## Best Practices

1. **Only for important actions**: Don't overuse
2. **Clear consequences**: Explain what will happen
3. **Escape hatch**: Always provide Cancel
4. **Destructive actions**: Require explicit confirmation
5. **Informative**: Show what's at stake
6. **Reassuring**: For non-destructive (can edit later)

## Related Screens

- Can appear over any screen
- Context-specific content
