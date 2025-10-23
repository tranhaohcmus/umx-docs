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
│   │ ┌─────────────────────┐ │   │
│   │ │ 🔍 Tìm nội dung...  │ │   │ Search
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ [🏃] [🧠] [💬] [🤝] [🍴] [Tất cả] │   │ Quick filters
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

- Search để tìm kiếm nội dung có sẵn
- Quick filter theo domain tags để lọc nhanh
- Tạo nội dung mới với tên, lĩnh vực, mô tả
- Danh sách mục tiêu

## Components

### Fields

1. **Search bar**: "🔍 Tìm nội dung..." - Search existing content library
2. **Domain tag filters**: Quick filter buttons
   - [🏃] = Vận động (Motor Skills)
   - [🧠] = Nhận thức (Cognitive)
   - [💬] = Ngôn ngữ (Language)
   - [🤝] = Xã hội (Social)
   - [🍴] = Tự phục vụ (Self-care)
   - [Tất cả] = Clear filter
3. **Lĩnh vực** (Required, Dropdown)
   - 🏃 Vận động (Motor Skills)
   - 🧠 Nhận thức (Cognitive)
   - 💬 Ngôn ngữ (Language)
   - 🤝 Xã hội (Social)
   - 🍴 Tự phục vụ (Self-care)
4. **Tên nội dung** (Required)
5. **Mô tả** (Optional)
6. **Mục tiêu** (Dynamic list)

### Actions

- Add goal button
- Cancel/Save buttons

## Interactions

- **Swipe down** = Close modal
- **Tap outside** = Close (with confirmation)
- **Tap search** = Focus search, show keyboard
- **Tap domain tag filter** = Filter content by that domain (toggle on/off)
- **Type in search** = Real-time search results from content library
- **Select from search results** = Auto-fill form with selected content
- **Add goal** = Add new goal input
- **Remove goal** = Delete goal ([✕] button)

## Validation

- Tên nội dung: Required, min 3 characters
- Lĩnh vực: Required (must select one)
- Mục tiêu: At least 1 goal required
- Search optimization: Fuzzy search supports Vietnamese without diacritics

- Domain/Lĩnh vực is required (default: 🧠 Nhận thức)
- Name is required
- Must have at least 1 goal
- Max 10 goals per content

## Related Screens

- **Parent**: 05-manual-step2.md
