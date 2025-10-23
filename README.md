# Educare Connect - App Demo Can Thiệp Sớm

## Tổng quan Dự án

**Educare Connect** là ứng dụng hỗ trợ giáo viên can thiệp sớm trong việc:

- Ghi nhận và theo dõi nhật ký dạy học hàng ngày
- Phân tích hành vi học sinh theo phương pháp A-B-C
- Tra cứu thông tin về các hành vi thách thức
- Tạo báo cáo trực quan để đánh giá tiến trình

## Cấu trúc Tài liệu

1. [Tổng quan Chức năng](./FEATURES_OVERVIEW.md) - Mô tả tổng quan các module
2. [Luồng Người dùng (User Flow)](./USER_FLOW.md) - Sơ đồ chi tiết hành trình người dùng
3. [Thiết kế Màn hình](./SCREEN_DESIGN.md) - Chi tiết từng màn hình
4. [Cấu trúc Dữ liệu](./DATA_STRUCTURE.md) - Schema và mô hình dữ liệu
5. [Tích hợp Module](./MODULE_INTEGRATION.md) - Cách các module liên kết với nhau

## Công nghệ Sử dụng

- **Framework**: React Native
- **Quản lý State**: Redux / Context API
- **Database**: SQLite (local) / Firebase (cloud)
- **Biểu đồ**: React Native Chart Kit / Victory Native
- **Navigation**: React Navigation

## Mục tiêu Sản phẩm

Tạo ra công cụ đơn giản, trực quan giúp giáo viên can thiệp sớm:

- Tiết kiệm thời gian ghi chép
- Có cái nhìn khách quan về hành vi học sinh
- Đưa ra quyết định can thiệp dựa trên dữ liệu
- Giao tiếp hiệu quả với phụ huynh

## Demo Workflow

```
Giáo viên mở app → Chọn học sinh → Ghi nhật ký buổi học →
Đánh giá mục tiêu → Ghi nhận hành vi (A-B-C) → Lưu dữ liệu →
Xem phân tích từ điển → Đọc báo cáo trực quan → Xuất báo cáo
```

---

Xem chi tiết trong các file documentation bên dưới.
