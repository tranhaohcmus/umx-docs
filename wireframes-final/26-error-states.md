# Error States

## 1. Network Error

```
┌─────────────────────────────────┐
│ 9:41          Educare   👤 ⚙️  │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   📡    │             │ Offline icon
│         └─────────┘             │
│                                 │
│  Không có kết nối mạng          │
│                                 │
│  Vui lòng kiểm tra kết nối      │
│  internet và thử lại.           │
│                                 │
│  💡 Bạn vẫn có thể:             │
│  • Xem dữ liệu đã tải           │
│  • Ghi nhật ký (lưu offline)    │
│  • Tạo buổi học mới             │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🔄 THỬ LẠI               │ │
│  └───────────────────────────┘ │
│                                 │
│  [Xem dữ liệu offline]         │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## 2. AI Upload Failed

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo với AI     [✕]    │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   ⚠️    │             │ Error icon
│         └─────────┘             │
│                                 │
│  Upload thất bại                │
│                                 │
│  Không thể phân tích file của   │
│  bạn. Vui lòng thử lại hoặc     │
│  kiểm tra định dạng file.       │
│                                 │
│  ❌ Nguyên nhân có thể:         │
│  • File quá lớn (>10MB)         │
│  • Định dạng không hỗ trợ       │
│  • Nội dung không rõ ràng       │
│  • Lỗi kết nối mạng             │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🔄 THỬ LẠI               │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │  ✍️ TẠO THỦ CÔNG          │ │
│  └───────────────────────────┘ │
│                                 │
│  [💬 Liên hệ hỗ trợ]           │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## 3. Server Error (500)

```
┌─────────────────────────────────┐
│ 9:41          Educare   👤 ⚙️  │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   ⚠️    │             │
│         └─────────┘             │
│                                 │
│  Đã có lỗi xảy ra               │
│                                 │
│  Hệ thống đang gặp sự cố. Chúng │
│  tôi đang khắc phục. Vui lòng   │
│  thử lại sau ít phút.           │
│                                 │
│  Mã lỗi: 500                    │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🔄 THỬ LẠI               │ │
│  └───────────────────────────┘ │
│                                 │
│  [💬 Báo lỗi]                  │
│  [🏠 Về trang chủ]             │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## 4. Session Not Found (404)

```
┌─────────────────────────────────┐
│ 9:41   ← Buổi học       [✕]    │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   🔍    │             │
│         └─────────┘             │
│                                 │
│  Không tìm thấy                 │
│                                 │
│  Buổi học này không tồn tại hoặc│
│  đã bị xóa.                     │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🏠 VỀ TRANG CHỦ          │ │
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]                  │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## Purpose

Error states giúp người dùng hiểu lỗi và hành động tiếp theo.

## Components

### Common Elements

- **Icon**: Error/Warning icon (60x60)
- **Title**: Short error message
- **Description**: Detailed explanation
- **Possible causes**: List of reasons (for complex errors)
- **Primary CTA**: Retry or alternative action
- **Secondary action**: Help or navigate away

### Error Types

1. **Network Error**

   - Icon: 📡 (Offline)
   - Offline capabilities listed
   - Retry button
   - Offline mode link

2. **AI Upload Failed**

   - Icon: ⚠️
   - Specific reasons
   - Retry option
   - Fallback: Manual creation
   - Support contact

3. **Server Error (500)**

   - Icon: ⚠️
   - Reassuring message
   - Error code
   - Retry button
   - Report/Home options

4. **Not Found (404)**
   - Icon: 🔍
   - Simple explanation
   - Navigate home
   - Back button

## Design Principles

- **Friendly tone**: Avoid technical jargon
- **Actionable**: Always provide next steps
- **Informative**: Explain what happened
- **Reassuring**: Build confidence to retry
- **Escape hatch**: Always offer way out

## Related Screens

- Any screen can show errors
- Context-specific error handling
