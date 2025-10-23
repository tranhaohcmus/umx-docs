# 12. Popup: Form A-B-C

```
┌─────────────────────────────────┐
│  Ghi nhận Hành vi A-B-C    ✕   │
├─────────────────────────────────┤
│                                 │
│  🅰️ Tiền đề (Antecedent)       │
│  ┌─────────────────────────┐   │
│  │ Yêu cầu làm việc khó ▼ │   │
│  └─────────────────────────┘   │
│                                 │
│  🅱️ Hành vi (Behavior)         │
│  ┌─────────────────────────┐   │
│  │ 🔍 Tìm hoặc chọn...     │   │
│  │ • Ném đồ vật            │   │
│  │ • Tự ý rời khỏi chỗ    │   │
│  │ • La hét                │   │
│  └─────────────────────────┘   │
│                                 │
│  🔤 Mô tả chi tiết (tùy chọn)  │
│  ┌─────────────────────────┐   │
│  │ Con ném bút chì xuống   │   │
│  │ sàn sau khi được yêu    │   │
│  │ cầu làm bài tập viết... │   │
│  └─────────────────────────┘   │
│                                 │
│  ©️ Hệ quả (Consequence)        │
│  ┌─────────────────────────┐   │
│  │ Được nghỉ ngơi 5 phút ▼│   │
│  └─────────────────────────┘   │
│                                 │
│  📊 Cường độ                   │
│  ○ Nhẹ  ◉ Trung bình  ○ Cao   │
│                                 │
│  🕐 Thời điểm                  │
│  ┌─────────────────────────┐   │
│  │ 10:15                  🕐│   │
│  └─────────────────────────┘   │
│                                 │
│  [Hủy]          [Lưu hành vi]  │
└─────────────────────────────────┘
```

## Mục đích

- Ghi nhận hành vi theo phương pháp ABC
- Thu thập thông tin tiền đề, hành vi, hệ quả
- Hỗ trợ phân tích hành vi sau này

## Components

- **Antecedent Dropdown**: Chọn tiền đề
- **Behavior Search/Select**: Tìm hoặc chọn hành vi từ dictionary
- **Description Textarea**: Mô tả chi tiết (optional)
- **Consequence Dropdown**: Chọn hệ quả
- **Intensity Radio**: Nhẹ / Trung bình / Cao
- **Time Picker**: Thời điểm xảy ra
- **Action Buttons**: Hủy, Lưu hành vi

## Interactions

- Select antecedent → Choose from dropdown
- Search/select behavior → Link to behavior dictionary
- Type description → Add details
- Select consequence → Choose from dropdown
- Select intensity → Rate severity
- Pick time → Set timestamp
- Tap "Lưu hành vi" → Save ABC record
