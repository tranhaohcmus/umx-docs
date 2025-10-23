# 14. Màn hình Chi tiết Hành vi

```
┌─────────────────────────────────────────┐
│  ← Ném đồ vật                   ⭐ 📤   │
├─────────────────────────────────────────┤
│                                         │
│  ⚠️                                     │
│  Ném đồ vật                             │
│                                         │
│  📊 Đã ghi nhận 127 lần trong hệ thống │
│  📈 Xu hướng: Tăng 15% tuần này        │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  📄 Mô tả Hành vi                       │
│  ┌─────────────────────────────────┐   │
│  │ Hành vi ném các vật dụng, đồ   │   │
│  │ chơi trong lớp học hoặc tại nhà.│   │
│  │ Có thể ném về phía người khác   │   │
│  │ hoặc ném bừa bãi...             │   │
│  └─────────────────────────────────┘   │
│                                         │
│  🔍 Nguyên nhân Phổ biến               │
│  • Yêu cầu làm việc khó               │
│  • Không được chú ý                    │
│  • Cảm thấy khó chịu                   │
│  • Môi trường quá kích thích           │
│                                         │
│  🎯 Chức năng Hành vi                  │
│  • Attention (Thu hút chú ý)          │
│  • Escape (Thoát khỏi nhiệm vụ)       │
│  • Sensory (Kích thích cảm giác)      │
│  • Tangible (Có được đồ vật)          │
│                                         │
│  💡 Gợi ý Can thiệp                    │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 1. Dạy kỹ năng giao tiếp thay  │   │
│  │    thế                          │   │
│  │    [Xem chi tiết →]             │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 2. Cung cấp kích thích cảm giác│   │
│  │    [Xem chi tiết →]             │   │
│  └─────────────────────────────────┘   │
│                                         │
│  📊 Phân tích cho Học sinh của bạn     │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  ┌────┐                         │   │
│  │  │ BA │ Bé An                  │   │
│  │  └────┘                         │   │
│  │  12 lần ghi nhận               │   │
│  │  [Xem Biểu đồ Phân tích →]    │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

## Mục đích

- Hiển thị thông tin chi tiết về hành vi
- Thống kê số lần ghi nhận và xu hướng
- Cung cấp gợi ý can thiệp
- Liên kết với phân tích của từng học sinh

## Components

- **Behavior Header**: Icon, tên, star (favorite), share
- **Statistics**: Số lần ghi nhận, xu hướng
- **Description**: Mô tả chi tiết hành vi
- **Common Causes**: Danh sách nguyên nhân phổ biến
- **Behavior Functions**: Các chức năng hành vi (AEST)
- **Intervention Suggestions**: Cards với gợi ý can thiệp
- **Student Analysis**: Cards học sinh có hành vi này

## Interactions

- Tap "⭐" → Toggle favorite
- Tap "📤" → Share behavior info
- Tap intervention card → View intervention details
- Tap student card → View student-specific analytics
- Scroll → View more content
