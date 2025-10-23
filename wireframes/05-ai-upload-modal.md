# 5. Modal: AI Upload

```
┌─────────────────────────────────┐
│  Tạo buổi học với AI       ✕   │
├─────────────────────────────────┤
│                                 │
│  📂 Chọn File hoặc Dán nội dung│
│                                 │
│  ┌─────────────────────────┐   │
│  │  [📄 Chọn file từ thiết │   │
│  │       bị]                │   │
│  │                         │   │
│  │  Hỗ trợ: PDF, DOCX,    │   │
│  │  TXT, JPG, PNG          │   │
│  └─────────────────────────┘   │
│                                 │
│  hoặc                           │
│                                 │
│  📝 Dán nội dung bài giảng     │
│  ┌─────────────────────────┐   │
│  │ Thứ 2:                  │   │
│  │ - Hoạt động 1: Ai đây?  │   │
│  │ - Hoạt động 2: Vận động │   │
│  │ ...                     │   │
│  └─────────────────────────┘   │
│                                 │
│  [Hủy]    [📤 Upload và Phân tích]│
└─────────────────────────────────┘
```

## Mục đích

- Upload file bài giảng hoặc dán text
- Phù hợp với mobile (không có drag & drop)

## Components

- **File Picker Button**: Chọn file từ thiết bị
- **Supported Formats**: PDF, DOCX, TXT, JPG, PNG
- **Text Input**: Dán nội dung văn bản
- **Action Buttons**: Hủy, Upload và Phân tích

## Interactions

- Tap "📄 Chọn file từ thiết bị" → Open native file picker
- Paste text in textarea → Text input
- Tap "📤 Upload và Phân tích" → Start AI processing
- Tap "Hủy" → Close modal
