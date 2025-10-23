# 15. Màn hình Báo cáo Phân tích

```
┌─────────────────────────────────────────┐
│  ← Báo cáo Phân tích            📤 💾   │
├─────────────────────────────────────────┤
│                                         │
│  ┌────┐                                │
│  │ BA │ Bé An (Nguyễn Văn An)         │
│  └────┘                                │
│  ⚠️ Hành vi: Ném đồ vật                │
│  📅 Dữ liệu: 01/10 - 22/10/2025        │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ [7 ngày] [30 ngày] [Tùy chỉnh]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  📊 Biểu đồ Tần suất                   │
│  ┌─────────────────────────────────┐   │
│  │     ╷                           │   │
│  │  5  ┼   ●                       │   │
│  │  4  ┼   │   ●                   │   │
│  │  3  ┼ ● │   │ ●   ●             │   │
│  │  2  ┼ │ │ ● │ │   │   ●         │   │
│  │  1  ┼ │ │ │ │ │ ● │ ● │         │   │
│  │  0  ┼─┴─┴─┴─┴─┴─┴─┴─┴─┴──       │   │
│  │     1 2 3 4 5 6 7 8 9 10 (ngày) │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📊 Phân tích Tiền đề (A)              │
│  ┌─────────────────────────────────┐   │
│  │ Yêu cầu làm việc khó    ███ 45% │   │
│  │ Không được chú ý        ██  30%  │   │
│  │ Cảm giác khó chịu       █   15%  │   │
│  │ Khác                    █   10%  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📊 Phân tích Hệ quả (C)               │
│  ┌─────────────────────────────────┐   │
│  │ Được nghỉ ngơi          ███ 50% │   │
│  │ Được chú ý              ██  35%  │   │
│  │ Bị nhắc nhở             █   15%  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  🤖 Kết luận & Gợi ý AI                │
│  ┌─────────────────────────────────┐   │
│  │ • Hành vi tăng 15% tuần này     │   │
│  │ • Chủ yếu xảy ra khi được yêu   │   │
│  │   cầu làm việc khó (45%)        │   │
│  │ • Hệ quả chính: Được nghỉ (50%) │   │
│  │                                 │   │
│  │ 💡 Gợi ý:                       │   │
│  │ 1. Giảm độ khó nhiệm vụ         │   │
│  │ 2. Dạy con cách xin nghỉ        │   │
│  │ 3. Khen thưởng khi hoàn thành   │   │
│  └─────────────────────────────────┘   │
│                                         │
│  [📤 Xuất báo cáo PDF]                 │
│                                         │
└─────────────────────────────────────────┘
```

## Mục đích

- Phân tích hành vi của học sinh theo thời gian
- Hiển thị biểu đồ tần suất, tiền đề, hệ quả
- Cung cấp kết luận và gợi ý từ AI

## Components

- **Student Header**: Avatar, tên, hành vi đang phân tích
- **Date Range Selector**: 7 ngày / 30 ngày / Tùy chỉnh
- **Frequency Chart**: Line chart showing behavior frequency
- **Antecedent Analysis**: Bar chart showing A distribution
- **Consequence Analysis**: Bar chart showing C distribution
- **AI Insights**: Summary and recommendations
- **Export Button**: Xuất PDF

## Interactions

- Tap date range → Change time period
- Tap chart → View details
- Scroll → View more analytics
- Tap "📤 Xuất báo cáo PDF" → Generate and share PDF
- Tap "💾" → Save report
