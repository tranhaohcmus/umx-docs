# Modal - Thêm nội dung

## Wireframe

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│   ┌─────────────────────────┐   │
│   │ ──                      │   │
│   │                         │   │
│   │ Thêm nội dung mới       │   │
│   │                         │   │
│   │ 🏷️ Lĩnh vực *          │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🧠 Nhận thức     ▼  │ │   │ Dropdown
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ 📝 Tên nội dung *       │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ VD: Nhận diện màu   │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ 📄 Mô tả               │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ Học nhận biết và... │ │   │
│   │ │                     │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ 🎯 Mục tiêu học tập    │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 1. Gọi tên màu [✕] │ │   │
│   │ │ 2. Nhận diện màu[✕]│ │   │
│   │ │ 3. Phân biệt màu[✕]│ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ [➕ Thêm mục tiêu]      │   │
│   │                         │   │
│   │ ───────────────────────  │   │
│   │                         │   │
│   │ [Hủy]    [✅ Thêm]     │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## Purpose

Modal để thêm nội dung dạy học mới với:

- Tên nội dung
- Mô tả (optional)
- Danh sách mục tiêu

## Components

### Fields

1. **Lĩnh vực** (Required, Dropdown)
   - 🏃 Vận động (Motor Skills)
   - 🧠 Nhận thức (Cognitive)
   - 💬 Ngôn ngữ (Language)
   - 🤝 Xã hội (Social)
   - 🍴 Tự phục vụ (Self-care)
2. **Tên nội dung** (Required)
3. **Mô tả** (Optional)
4. **Mục tiêu** (Dynamic list)

### Actions

- Add goal button
- Cancel/Save buttons

## Interactions

- **Swipe down** = Close modal
- **Tap outside** = Close (with confirmation)
- **Add goal** = Add new goal input
- **Remove goal** = Delete goal ([✕] button)

## Validation

- Domain/Lĩnh vực is required (default: 🧠 Nhận thức)
- Name is required
- Must have at least 1 goal
- Max 10 goals per content

## Related Screens

- **Parent**: 05-manual-step2.md
