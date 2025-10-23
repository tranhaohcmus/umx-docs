# AI Processing

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41   ← AI đang xử lý  [✕]    │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   🤖    │             │ Animation
│         └─────────┘             │
│                                 │
│  AI đang phân tích giáo án...  │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ████████████░░░░░░  65%   │ │ Progress bar
│  └───────────────────────────┘ │
│                                 │
│  ✅ Đọc file thành công         │
│  ✅ Trích xuất cấu trúc         │
│  🔄 Phân tích nội dung...       │
│  ⏳ Tạo danh sách buổi học      │
│  ⏳ Gợi ý mục tiêu học tập      │
│                                 │
│  ⏱️ Ước tính: ~20 giây          │
│                                 │
│                                 │
│  💡 Mẹo: AI có thể phân tích    │
│  nhiều tuần giáo án cùng lúc   │
│                                 │
│                                 │
│  [Hủy phân tích]               │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Hiển thị tiến trình AI phân tích giáo án.

## Components

### Animation

- Animated robot icon
- Pulsing or rotating effect

### Progress Bar

- 0-100% completion
- Smooth transitions

### Step Checklist

- ✅ Completed steps
- 🔄 Current step
- ⏳ Pending steps

### Time Estimate

- Dynamic countdown

### Tip

- Helpful information

### Cancel Button

- Allow cancellation

## Interactions

- **Auto-advance**: Moves to preview when complete
- **Tap Hủy**: Confirm cancellation
- **Error**: Show error state with retry option

## States

- Processing (current)
- Success → Navigate to preview
- Error → Show error message + retry

## Related Screens

- **Previous**: 08-ai-upload.md
- **Next**: 10-ai-preview.md
- **Error**: 25-error-states.md
