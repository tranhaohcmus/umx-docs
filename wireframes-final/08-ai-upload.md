# AI Upload - Step 1

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo với AI     [✕]    │
├─────────────────────────────────┤
│                                 │
│  📂 Upload giáo án              │
│                                 │
│  ┌───────────────────────────┐ │
│  │         📄                │ │
│  │                           │ │
│  │   [📱 Chọn file từ thiết bị]│ │
│  │                           │ │
│  │   ✓ PDF, DOCX, TXT, JPG   │ │
│  │   ⚠️ Tối đa 10MB          │ │
│  │                           │ │
│  └───────────────────────────┘ │
│                                 │
│  ──────── hoặc ────────        │
│                                 │
│  📝 Dán nội dung văn bản       │
│  ┌───────────────────────────┐ │
│  │ Thứ 2:                    │ │
│  │ - Hoạt động 1: Ai đây?     │ │
│  │ - Hoạt động 2: Vận động   │ │
│  │ Thứ 3:                    │ │
│  │ - Hoạt động 1: Màu sắc... │ │
│  │                           │ │
│  │ [0/5000 ký tự]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ✨ AI sẽ giúp bạn:            │
│  • Phân tích cấu trúc giáo án  │
│  • Tự động tạo buổi học        │
│  • Trích xuất mục tiêu         │
│  • Sắp xếp theo ngày/buổi      │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🚀 PHÂN TÍCH NGAY        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Upload giáo án qua file hoặc text để AI phân tích và tạo buổi học tự động.

## Components

### File Upload

- File picker button
- Supported formats: PDF, DOCX, TXT, JPG
- Max size: 10MB

### Text Input

- Multi-line textarea
- Max 5000 characters
- Character counter

### Benefits List

- AI capabilities preview

### CTA

- Analyze button (disabled until file/text provided)

## Interactions

- **Tap file picker** = Open device file picker
- **Paste text** = Enable analyze button
- **Tap PHÂN TÍCH** = Upload and process

## Validation

- Must have either file OR text (not both required)
- File must be supported format
- File must be under 10MB
- Text must be 10-5000 characters

## Related Screens

- **Next**: 09-ai-processing.md
