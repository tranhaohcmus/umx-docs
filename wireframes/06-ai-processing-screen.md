# 6. Screen: AI Processing

```
┌─────────────────────────────────┐
│  AI đang phân tích...      ✕   │
├─────────────────────────────────┤
│                                 │
│         🤖                      │
│                                 │
│  AI đang phân tích bài giảng... │
│                                 │
│  ┌─────────────────────────┐   │
│  │ ████████░░░░░░░░░  60%  │   │
│  └─────────────────────────┘   │
│                                 │
│  ✅ Đọc file thành công         │
│  ✅ Trích xuất cấu trúc         │
│  🔄 Phân tích nội dung...       │
│  ⏳ Tạo danh sách buổi học      │
│                                 │
│  Ước tính: ~30 giây             │
│                                 │
│  Vui lòng đợi...                │
│                                 │
└─────────────────────────────────┘
```

## Mục đích

- Hiển thị tiến trình AI đang xử lý
- Thông báo từng bước đang thực hiện

## Components

- **AI Icon**: 🤖
- **Progress Bar**: Hiển thị % hoàn thành
- **Step Indicators**: ✅ (done), 🔄 (processing), ⏳ (pending)
- **Estimated Time**: ~30 giây
- **Close Button**: Cho phép hủy

## Interactions

- Auto-update progress bar
- Auto-navigate to preview when done
- Tap "✕" → Hủy xử lý (confirm dialog)
