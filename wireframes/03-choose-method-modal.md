# 3. Modal: Chọn Phương thức Tạo Buổi học

```
┌─────────────────────────────────┐
│  Tạo buổi học mới          ✕   │
├─────────────────────────────────┤
│                                 │
│  Chọn cách tạo buổi học:       │
│                                 │
│  ┌─────────────────────────┐   │
│  │  ✍️ Tạo thủ công        │   │
│  │  Nhập thông tin từng bước│   │
│  │  [Chọn →]               │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │  🤖 Tạo với AI         │   │
│  │  Upload file bài giảng  │   │
│  │  AI tự động phân tích   │   │
│  │  [Chọn →]               │   │
│  └─────────────────────────┘   │
│                                 │
│  [Hủy]                         │
└─────────────────────────────────┘
```

## Mục đích

- Cho phép giáo viên chọn phương thức tạo buổi học
- 2 options: Thủ công hoặc AI

## Components

- **Option Card 1**: Tạo thủ công
- **Option Card 2**: Tạo với AI
- **Cancel Button**

## Interactions

- Tap "✍️ Tạo thủ công" → Open manual creation modal
- Tap "🤖 Tạo với AI" → Open AI upload modal
- Tap "Hủy" → Close modal
