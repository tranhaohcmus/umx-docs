# Đặc tả Yêu cầu Chức năng (FRS)

## Functional Requirements Specification - Educare Connect

---

**Phiên bản Tài liệu**: 1.0  
**Ngày**: 23/10/2025  
**Tên Dự án**: Educare Connect  
**Chủ sở hữu Tài liệu**: Nhóm Phát triển Sản phẩm  
**Trạng thái**: Đang Xem xét

---

## Mục lục

1. [Giới thiệu](#1-giới-thiệu)
2. [Yêu cầu Chức năng](#2-yêu-cầu-chức-năng)
3. [Yêu cầu Phi chức năng](#3-yêu-cầu-phi-chức-năng)
4. [Yêu cầu Hiệu suất](#4-yêu-cầu-hiệu-suất)
5. [Yêu cầu Bảo mật](#5-yêu-cầu-bảo-mật)
6. [Yêu cầu Tuân thủ](#6-yêu-cầu-tuân-thủ)
7. [Ma trận Theo dõi](#7-ma-trận-theo-dõi)

---

## 1. Giới thiệu

### 1.1 Mục đích

Tài liệu này mô tả chi tiết các yêu cầu chức năng và phi chức năng cho ứng dụng Educare Connect - nền tảng quản lý giảng dạy dành cho giáo viên giáo dục đặc biệt.

### 1.2 Phạm vi

FRS này bao gồm tất cả các tính năng và yêu cầu kỹ thuật cho MVP (Minimum Viable Product) của Educare Connect, bao gồm:

- Quản lý học sinh và buổi học
- Ghi nhật ký buổi học
- Tạo buổi học với AI
- Theo dõi hành vi ABC
- Phân tích và báo cáo
- Quản lý người dùng

### 1.3 Tài liệu Tham khảo

- Business Requirements Document (BRD.md)
- Wireframes (`/wireframes-final/`)
- System Architecture Document
- Database Design Document

### 1.4 Thuật ngữ và Viết tắt

| Thuật ngữ | Định nghĩa                                                     |
| --------- | -------------------------------------------------------------- |
| ABC       | Antecedent-Behavior-Consequence (Phương pháp theo dõi hành vi) |
| GDĐB      | Giáo dục Đặc biệt                                              |
| OCR       | Optical Character Recognition (Nhận dạng ký tự quang học)      |
| AI        | Artificial Intelligence (Trí tuệ nhân tạo)                     |
| MVP       | Minimum Viable Product (Sản phẩm khả thi tối thiểu)            |

---

## 2. Yêu cầu Chức năng

### 2.1 Module Xác thực và Người dùng

#### FR-001: Đăng ký Tài khoản

**Mô tả**: Giáo viên có thể tạo tài khoản mới

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép đăng ký bằng email và mật khẩu
- Hệ thống phải xác thực email trước khi kích hoạt tài khoản
- Hệ thống phải yêu cầu mật khẩu tối thiểu 8 ký tự, bao gồm chữ hoa, chữ thường và số
- Hệ thống phải lưu trữ thông tin cơ bản: họ tên, email, số điện thoại

**Tiêu chí Chấp nhận**:

- Giáo viên có thể hoàn thành đăng ký trong 3 phút
- Email xác thực được gửi trong vòng 30 giây
- Mật khẩu được mã hóa trước khi lưu trữ

**Màn hình liên quan**: 29-onboarding.md

---

#### FR-002: Đăng nhập Hệ thống

**Mô tả**: Giáo viên có thể đăng nhập vào ứng dụng

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hỗ trợ đăng nhập bằng email/mật khẩu
- Hệ thống phải hỗ trợ đăng nhập bằng sinh trắc học (vân tay, Face ID)
- Hệ thống phải cho phép "Ghi nhớ đăng nhập" trong 30 ngày
- Hệ thống phải khóa tài khoản sau 5 lần đăng nhập sai

**Tiêu chí Chấp nhận**:

- Đăng nhập thành công trong < 2 giây
- Session token có thời hạn 7 ngày
- Hiển thị thông báo lỗi rõ ràng khi đăng nhập thất bại

**Màn hình liên quan**: N/A (Login screen)

---

#### FR-003: Quản lý Profile

**Mô tả**: Giáo viên có thể xem và chỉnh sửa thông tin cá nhân

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép cập nhật: họ tên, ảnh đại diện, số điện thoại, email
- Hệ thống phải xác thực lại khi thay đổi email
- Hệ thống phải cho phép đổi mật khẩu với xác thực mật khẩu cũ
- Hệ thống phải lưu lịch sử thay đổi thông tin

**Tiêu chí Chấp nhận**:

- Thay đổi được lưu và đồng bộ trong < 3 giây
- Ảnh đại diện hỗ trợ định dạng JPG, PNG, tối đa 5MB
- Validation real-time cho email và số điện thoại

**Màn hình liên quan**: 23-profile.md

---

### 2.2 Module Quản lý Học sinh

#### FR-004: Thêm Học sinh Mới

**Mô tả**: Giáo viên có thể thêm học sinh vào danh sách quản lý

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép nhập: họ tên, tuổi, ảnh đại diện, ghi chú
- Hệ thống phải tự động tạo mã học sinh duy nhất
- Hệ thống phải cho phép thêm thông tin phụ huynh (optional)
- Hệ thống phải hỗ trợ upload ảnh từ camera hoặc thư viện

**Tiêu chí Chấp nhận**:

- Thêm học sinh mới trong < 1 phút
- Hỗ trợ tối đa 100 học sinh/giáo viên
- Ảnh học sinh được resize và tối ưu tự động

**Màn hình liên quan**: 01-dashboard.md

---

#### FR-005: Xem Danh sách Học sinh

**Mô tả**: Giáo viên có thể xem tất cả học sinh đang quản lý

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị danh sách học sinh với avatar, tên, tuổi
- Hệ thống phải cho phép tìm kiếm học sinh theo tên
- Hệ thống phải cho phép lọc theo: tuổi, ngày thêm
- Hệ thống phải hiển thị số buổi học đã hoàn thành

**Tiêu chí Chấp nhận**:

- Load danh sách < 1 giây
- Tìm kiếm real-time (debounce 300ms)
- Hiển thị 20 học sinh/trang với infinite scroll

**Màn hình liên quan**: 01-dashboard.md

---

#### FR-006: Xem Chi tiết Học sinh

**Mô tả**: Giáo viên có thể xem thông tin chi tiết và lịch sử của học sinh

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị: thông tin cơ bản, lịch buổi học, thống kê tiến độ
- Hệ thống phải hiển thị lịch tuần với các buổi học
- Hệ thống phải hiển thị top 5 hành vi thường gặp
- Hệ thống phải cho phép truy cập nhanh vào các buổi học

**Tiêu chí Chấp nhận**:

- Load dữ liệu chi tiết < 2 giây
- Lịch hiển thị 7 ngày với khả năng scroll
- Thống kê cập nhật real-time

**Màn hình liên quan**: 02-student-detail.md

---

#### FR-007: Chỉnh sửa/Xóa Học sinh

**Mô tả**: Giáo viên có thể cập nhật hoặc xóa thông tin học sinh

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép chỉnh sửa tất cả thông tin học sinh
- Hệ thống phải yêu cầu xác nhận trước khi xóa
- Hệ thống phải soft delete (đánh dấu xóa, không xóa vĩnh viễn ngay)
- Hệ thống phải cảnh báo nếu xóa học sinh có buổi học đang diễn ra

**Tiêu chí Chấp nhận**:

- Cập nhật được lưu và đồng bộ < 2 giây
- Dialog xác nhận rõ ràng với số buổi học sẽ bị ảnh hưởng
- Khôi phục được học sinh đã xóa trong 30 ngày

**Màn hình liên quan**: 02-student-detail.md, 30-confirmations.md

---

### 2.3 Module Quản lý Buổi học

#### FR-008: Chọn Phương thức Tạo Buổi học

**Mô tả**: Giáo viên có thể chọn tạo buổi học thủ công hoặc bằng AI

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị 2 tùy chọn: "Tạo thủ công" và "Tạo với AI"
- Hệ thống phải hiển thị mô tả ngắn cho mỗi phương thức
- Hệ thống phải cho phép chọn nhanh bằng gesture
- Hệ thống phải hiển thị số lần đã sử dụng AI còn lại (nếu có giới hạn)

**Tiêu chí Chấp nhận**:

- Bottom sheet xuất hiện mượt mà với animation 300ms
- Các button có touch target tối thiểu 44x44pt
- Thông báo rõ ràng nếu hết quota AI

**Màn hình liên quan**: 03-create-method-sheet.md

---

#### FR-009: Tạo Buổi học Thủ công - Bước 1

**Mô tả**: Giáo viên nhập thông tin cơ bản cho buổi học

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép chọn: ngày, giờ bắt đầu, giờ kết thúc
- Hệ thống phải cho phép chọn loại buổi học (Sáng/Chiều/Tối)
- Hệ thống phải validate thời gian hợp lệ
- Hệ thống phải cảnh báo nếu trùng lịch

**Tiêu chí Chấp nhận**:

- Date picker hỗ trợ tiếng Việt
- Validation real-time với message rõ ràng
- Auto-fill giờ dựa trên loại buổi (Sáng: 8-11h)

**Màn hình liên quan**: 04-manual-step1.md

---

#### FR-010: Tạo Buổi học Thủ công - Bước 2

**Mô tả**: Giáo viên thêm nội dung dạy học và mục tiêu

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép thêm nhiều nội dung dạy học
- Hệ thống phải cho phép thêm nhiều mục tiêu cho mỗi nội dung
- Hệ thống phải hỗ trợ drag-to-reorder để sắp xếp thứ tự
- Hệ thống phải cho phép xóa/sửa nội dung và mục tiêu

**Tiêu chí Chấp nhận**:

- Thêm tối thiểu 1 nội dung với 1 mục tiêu
- Drag-to-reorder mượt mà với haptic feedback
- Numbered list tự động cập nhật khi reorder

**Màn hình liên quan**: 05-manual-step2.md, 06-modal-add-content.md

---

#### FR-011: Tạo Buổi học Thủ công - Bước 3

**Mô tả**: Giáo viên xem lại và xác nhận tạo buổi học

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị tóm tắt đầy đủ: thời gian, nội dung, mục tiêu
- Hệ thống phải cho phép quay lại chỉnh sửa
- Hệ thống phải cho phép lưu nháp
- Hệ thống phải tạo buổi học khi xác nhận

**Tiêu chí Chấp nhận**:

- Hiển thị đầy đủ thông tin đã nhập
- Tạo buổi học thành công trong < 2 giây
- Hiển thị success state sau khi tạo

**Màn hình liên quan**: 07-manual-step3.md, 28-success-states.md

---

#### FR-012: Tạo Buổi học với AI - Upload File

**Mô tả**: Giáo viên upload giáo án để AI phân tích

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải hỗ trợ upload: PDF, DOCX, TXT, JPG, PNG
- Hệ thống phải cho phép paste text trực tiếp
- Hệ thống phải giới hạn kích thước file: 10MB
- Hệ thống phải hiển thị progress khi upload

**Tiêu chí Chấp nhận**:

- Upload thành công < 5 giây (file 5MB)
- Hiển thị preview file trước khi xử lý
- Validate định dạng file trước khi upload

**Màn hình liên quan**: 08-ai-upload.md

---

#### FR-013: Tạo Buổi học với AI - Xử lý

**Mô tả**: AI phân tích giáo án và trích xuất cấu trúc

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải sử dụng OCR để extract text từ ảnh/PDF
- Hệ thống phải sử dụng OpenAI để phân tích cấu trúc
- Hệ thống phải hiển thị progress với các bước: Upload → OCR → AI → Tạo template
- Hệ thống phải cho phép hủy quá trình

**Tiêu chí Chấp nhận**:

- Xử lý hoàn tất trong < 30 giây
- Hiển thị progress bar với % hoàn thành
- Xử lý được giáo án tiếng Việt

**Màn hình liên quan**: 09-ai-processing.md

---

#### FR-014: Tạo Buổi học với AI - Preview & Edit

**Mô tả**: Giáo viên xem và chỉnh sửa kết quả AI

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải hiển thị danh sách buổi học AI đề xuất
- Hệ thống phải cho phép chọn/bỏ chọn từng buổi
- Hệ thống phải cho phép chỉnh sửa nội dung và mục tiêu
- Hệ thống phải cho phép tạo hàng loạt buổi học đã chọn

**Tiêu chí Chấp nhận**:

- Hiển thị tối thiểu 1 buổi học được đề xuất
- Có thể chỉnh sửa inline với auto-save
- Tạo hàng loạt thành công trong < 5 giây

**Màn hình liên quan**: 10-ai-preview.md

---

### 2.4 Module Ghi Nhật ký

#### FR-015: Chọn Phiên để Ghi

**Mô tả**: Giáo viên chọn buổi học để bắt đầu ghi nhật ký

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị các buổi học hôm nay
- Hệ thống phải ưu tiên buổi đang diễn ra hoặc đang ghi dở
- Hệ thống phải hiển thị trạng thái: Chưa bắt đầu, Đang ghi, Đã hoàn thành
- Hệ thống phải cho phép xem buổi học ngày khác

**Tiêu chí Chấp nhận**:

- Load danh sách phiên < 1 giây
- Nếu có 1 phiên đang ghi dở, hiển thị dialog resume
- Smart filter: pre-filter theo học sinh nếu từ Student Detail

**Màn hình liên quan**: 11-session-selector.md

---

#### FR-016: Ghi Nhật ký - Overview

**Mô tả**: Giáo viên xem tổng quan tiến độ ghi nhật ký

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị progress bar (X/Y nội dung hoàn thành)
- Hệ thống phải hiển thị danh sách nội dung với trạng thái
- Hệ thống phải cho phép tap vào nội dung để bắt đầu ghi
- Hệ thống phải disable nút "Hoàn tất" cho đến khi 100%

**Tiêu chí Chấp nhận**:

- Progress cập nhật real-time khi hoàn thành nội dung
- Phân biệt rõ nội dung đã ghi và chưa ghi
- Auto-save mỗi 2 phút

**Màn hình liên quan**: 12-log-overview.md

---

#### FR-017: Ghi Nhật ký - Chi tiết Mục tiêu

**Mô tả**: Giáo viên đánh giá từng mục tiêu của nội dung

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị danh sách mục tiêu
- Hệ thống phải cho phép đánh giá: Đạt / Đang học / Chưa
- Hệ thống phải cho phép thêm ghi chú cho từng mục tiêu
- Hệ thống phải lưu tự động khi thay đổi

**Tiêu chí Chấp nhận**:

- Chọn đánh giá bằng 1 tap
- Ghi chú hỗ trợ tối đa 500 ký tự
- Auto-save debounce 1 giây

**Màn hình liên quan**: 13-log-detail.md

---

#### FR-018: Ghi Nhật ký - Thái độ Học tập

**Mô tả**: Giáo viên đánh giá thái độ của học sinh

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép chọn mood emoji (5 lựa chọn)
- Hệ thống phải hiển thị 3 slider: Hợp tác, Tập trung, Độc lập (0-100%)
- Hệ thống phải cho phép thêm ghi chú thái độ
- Hệ thống phải lưu tự động

**Tiêu chí Chấp nhận**:

- Emoji tap to select với animation
- Slider mượt mà với haptic feedback
- Auto-save khi thay đổi

**Màn hình liên quan**: 14-log-attitude.md

---

#### FR-019: Ghi Nhật ký - Ghi chú

**Mô tả**: Giáo viên thêm ghi chú cho buổi học

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải cho phép nhập text ghi chú (tối đa 2000 ký tự)
- Hệ thống phải cho phép ghi âm (tối đa 5 phút)
- Hệ thống phải cho phép đính kèm ảnh/video (tối đa 5 files, 10MB/file)
- Hệ thống phải auto-save ghi chú

**Tiêu chí Chấp nhận**:

- Text auto-save debounce 2 giây
- Audio recording với pause/resume
- Media files được upload với progress indicator

**Màn hình liên quan**: 15-log-notes.md

---

#### FR-020: Ghi Nhật ký - Hành vi ABC

**Mô tả**: Giáo viên ghi nhận hành vi theo phương pháp ABC

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị danh sách hành vi đã ghi
- Hệ thống phải cho phép thêm hành vi mới
- Hệ thống phải hiển thị: Thời gian, Hành vi, Mức độ, A-B-C
- Hệ thống phải cho phép edit/delete hành vi

**Tiêu chí Chấp nhận**:

- Thêm hành vi bằng FAB button
- Swipe to delete với confirmation
- Hiển thị badge số lượng hành vi đã ghi

**Màn hình liên quan**: 16-log-behavior.md

---

#### FR-021: Bottom Sheet Thêm Hành vi ABC

**Mô tả**: Giáo viên nhập chi tiết hành vi ABC

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải có 3 bước: A (Antecedent) → B (Behavior) → C (Consequence)
- Hệ thống phải cho phép chọn từ behavior dictionary hoặc nhập tự do
- Hệ thống phải cho phép chọn mức độ: Nhẹ / Trung bình / Nặng
- Hệ thống phải validate đầy đủ A-B-C trước khi lưu

**Tiêu chí Chấp nhận**:

- Stepper navigation mượt mà
- Autocomplete từ dictionary
- Validation rõ ràng cho từng bước

**Màn hình liên quan**: 17-abc-sheet.md

---

### 2.5 Module Từ điển Hành vi

#### FR-022: Xem Từ điển Hành vi

**Mô tả**: Giáo viên xem danh sách hành vi có sẵn

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị 127+ hành vi phổ biến
- Hệ thống phải nhóm theo danh mục: Tấn công, Tự kỷ, Giao tiếp, v.v.
- Hệ thống phải cho phép tìm kiếm hành vi
- Hệ thống phải hiển thị số lần ghi nhận cho mỗi hành vi

**Tiêu chí Chấp nhận**:

- Load dictionary < 1 giây
- Tìm kiếm real-time với fuzzy matching
- Hiển thị trending behaviors

**Màn hình liên quan**: 18-dictionary-home.md

---

#### FR-023: Xem Chi tiết Hành vi

**Mô tả**: Giáo viên xem thông tin chi tiết về hành vi

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải hiển thị: Định nghĩa, nguyên nhân, can thiệp đề xuất
- Hệ thống phải hiển thị thống kê: Số lần ghi nhận, xu hướng
- Hệ thống phải cho phép thêm vào favorites
- Hệ thống phải liên kết đến analytics của hành vi đó

**Tiêu chí Chấp nhận**:

- Load chi tiết < 1 giây
- Favorite sync across devices
- Deep link đến analytics

**Màn hình liên quan**: 19-dictionary-detail.md

---

### 2.6 Module Phân tích và Báo cáo

#### FR-024: Tổng quan Phân tích

**Mô tả**: Giáo viên xem tổng quan analytics

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị tổng quan tháng: Số buổi học, giờ giảng dạy, học sinh active
- Hệ thống phải hiển thị top 5 hành vi trong tháng
- Hệ thống phải hiển thị xu hướng (tăng/giảm so với tháng trước)
- Hệ thống phải cho phép chọn khoảng thời gian

**Tiêu chí Chấp nhận**:

- Load analytics < 2 giây
- Charts render mượt mà
- Data cache để offline viewing

**Màn hình liên quan**: 20-analytics-overview.md

---

#### FR-025: Phân tích Chi tiết Hành vi

**Mô tả**: Giáo viên xem phân tích sâu về 1 hành vi

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị line chart xu hướng theo thời gian
- Hệ thống phải phân tích A-B-C: Nguyên nhân phổ biến, kết quả thường gặp
- Hệ thống phải hiển thị phân bố mức độ (Nhẹ/TB/Nặng)
- Hệ thống phải hiển thị thời điểm hay xảy ra (Sáng/Chiều/Tối)

**Tiêu chí Chấp nhận**:

- Charts tương tác với zoom/pan
- Data export thành PDF/Excel
- Smart insights: "Hành vi này tăng 50% khi..."

**Màn hình liên quan**: 21-analytics-detail.md

---

#### FR-026: So sánh Nhiều Hành vi

**Mô tả**: Giáo viên so sánh xu hướng của nhiều hành vi

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải cho phép chọn 2-5 hành vi để so sánh
- Hệ thống phải hiển thị multi-line chart
- Hệ thống phải highlight điểm giao nhau
- Hệ thống phải cho phép export comparison

**Tiêu chí Chấp nhận**:

- Chart render < 2 giây
- Màu sắc phân biệt rõ ràng
- Legend interactive (tap to hide/show)

**Màn hình liên quan**: 22-analytics-compare.md

---

### 2.7 Module Cài đặt

#### FR-027: Cài đặt Thông báo

**Mô tả**: Giáo viên quản lý thông báo

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải cho phép bật/tắt push notifications
- Hệ thống phải cho phép cài đặt thông báo: Reminder buổi học, Hoàn thành ghi nhật ký
- Hệ thống phải cho phép chọn thời gian nhắc nhở
- Hệ thống phải cho phép tùy chỉnh âm thanh thông báo

**Tiêu chí Chấp nhận**:

- Settings sync across devices
- Notification sent đúng thời gian
- In-app notification badge

**Màn hình liên quan**: 24-settings.md

---

#### FR-028: Cài đặt Ngôn ngữ và Hiển thị

**Mô tả**: Giáo viên tùy chỉnh giao diện

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải hỗ trợ ngôn ngữ: Tiếng Việt, English
- Hệ thống phải cho phép chọn theme: Light / Dark / Auto
- Hệ thống phải cho phép điều chỉnh font size
- Hệ thống phải restart gracefully khi đổi ngôn ngữ

**Tiêu chí Chấp nhận**:

- Language switch không mất dữ liệu
- Dark mode support toàn bộ screens
- Font size responsive

**Màn hình liên quan**: 24-settings.md

---

### 2.8 Module UI States

#### FR-029: Empty States

**Mô tả**: Hiển thị trạng thái khi không có dữ liệu

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị empty state cho: No students, No sessions, No favorites
- Hệ thống phải có illustration và message hướng dẫn
- Hệ thống phải có CTA button: "Thêm học sinh", "Tạo buổi học"
- Hệ thống phải friendly và khuyến khích action

**Tiêu chí Chấp nhận**:

- Empty state hiển thị ngay lập tức
- Illustration loading mượt mà
- CTA button rõ ràng

**Màn hình liên quan**: 25-empty-states.md

---

#### FR-030: Error States

**Mô tả**: Hiển thị trạng thái lỗi

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị error state cho: Network error, Server 500, 404, AI error
- Hệ thống phải có message lỗi dễ hiểu
- Hệ thống phải có action: Retry, Go back, Contact support
- Hệ thống phải log error để debug

**Tiêu chí Chấp nhận**:

- Error message user-friendly (không tech jargon)
- Retry button functional
- Error logged to monitoring service

**Màn hình liên quan**: 26-error-states.md

---

#### FR-031: Loading States

**Mô tả**: Hiển thị trạng thái đang tải

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải có loading state cho: Skeleton, Pull-to-refresh, Full-screen, Inline, Progress
- Hệ thống phải hiển thị loading ngay lập tức (<100ms)
- Hệ thống phải có timeout (30 giây) nếu load quá lâu
- Hệ thống phải mượt mà không làm giật UI

**Tiêu chí Chấp nhận**:

- Skeleton màu nhạt, shimmer effect
- Pull-to-refresh với haptic feedback
- Progress bar accurate (nếu có %)

**Màn hình liên quan**: 27-loading-states.md

---

#### FR-032: Success States

**Mô tả**: Hiển thị trạng thái thành công

**Ưu tiên**: Should-have

**Chi tiết**:

- Hệ thống phải hiển thị success state cho: Create, Save, Complete, Export
- Hệ thống phải có animation celebration (confetti, checkmark)
- Hệ thống phải có message khích lệ
- Hệ thống phải tự động dismiss sau 2-3 giây

**Tiêu chí Chấp nhận**:

- Success animation mượt mà
- Message positive và cụ thể
- Auto-dismiss hoặc swipe to dismiss

**Màn hình liên quan**: 28-success-states.md

---

### 2.9 Module Onboarding & Help

#### FR-033: Onboarding Flow

**Mô tả**: Hướng dẫn người dùng mới

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải có 3 màn hình giới thiệu: Welcome, Features 1, Features 2
- Hệ thống phải cho phép swipe để next/prev
- Hệ thống phải cho phép skip
- Hệ thống phải chỉ hiển thị 1 lần cho first-time users

**Tiêu chí Chấp nhận**:

- Onboarding screens với illustrations
- Swipe gesture mượt mà
- Skip button rõ ràng

**Màn hình liên quan**: 29-onboarding.md

---

#### FR-034: Confirmation Dialogs

**Mô tả**: Xác nhận các hành động quan trọng

**Ưu tiên**: Must-have

**Chi tiết**:

- Hệ thống phải hiển thị confirmation cho: Delete, Complete, Discard, Logout
- Hệ thống phải mô tả rõ hậu quả của action
- Hệ thống phải có 2 buttons: Cancel và Confirm (màu nguy hiểm)
- Hệ thống phải prevent accidental taps

**Tiêu chí Chấp nhận**:

- Dialog modal với backdrop
- Confirm button màu đỏ cho destructive actions
- ESC key để cancel (trên Android back button)

**Màn hình liên quan**: 30-confirmations.md

---

#### FR-035: Gesture Guide

**Mô tả**: Hướng dẫn các gesture tương tác

**Ưu tiên**: Nice-to-have

**Chi tiết**:

- Hệ thống phải có guide cho: Swipe, Tap, Drag-drop, Pinch-zoom
- Hệ thống phải hiển thị animation demo
- Hệ thống phải cho phép practice gesture
- Hệ thống phải accessible từ Settings

**Tiêu chí Chấp nhận**:

- Animation loop mượt mà
- Guide hiển thị contextual (first time use feature)
- Có thể skip hoặc "Don't show again"

**Màn hình liên quan**: 31-gesture-guide.md

---

## 3. Yêu cầu Phi chức năng

### 3.1 Usability (Khả năng Sử dụng)

#### NFR-001: Mobile-First Design

**Mô tả**: Ứng dụng phải được thiết kế tối ưu cho mobile

**Chi tiết**:

- Touch targets tối thiểu 44x44pt (iOS) / 48x48dp (Android)
- Bottom navigation để dễ tiếp cận bằng ngón tay cái
- Gesture-based interactions (swipe, pinch, long-press)
- Single-hand friendly layout

**Đo lường**:

- 90% users có thể hoàn thành tasks bằng 1 tay
- Touch target compliance: 100%

---

#### NFR-002: Accessibility

**Mô tả**: Ứng dụng phải accessible cho người khuyết tật

**Chi tiết**:

- VoiceOver/TalkBack support
- Dynamic Type support (font scaling)
- Color contrast ratio tối thiểu 4.5:1 (WCAG AA)
- Alternative text cho images

**Đo lường**:

- WCAG AA compliance: 100%
- VoiceOver navigation: All screens
- Contrast ratio: Pass all checks

---

#### NFR-003: Internationalization

**Mô tả**: Ứng dụng phải hỗ trợ đa ngôn ngữ

**Chi tiết**:

- Hỗ trợ tiếng Việt và English
- Right-to-Left (RTL) ready (future)
- Date/time format theo locale
- Number format theo locale

**Đo lường**:

- 100% strings localized
- Zero hardcoded strings
- RTL layout tested

---

### 3.2 Reliability (Độ Tin cậy)

#### NFR-004: Offline-First

**Mô tả**: Ứng dụng phải hoạt động offline

**Chi tiết**:

- Local database với SQLite
- Sync khi có internet
- Conflict resolution strategy
- Cache images và static assets

**Đo lường**:

- 95% features hoạt động offline
- Sync success rate: >98%
- Conflict rate: <1%

---

#### NFR-005: Data Integrity

**Mô tả**: Dữ liệu phải được bảo toàn và nhất quán

**Chi tiết**:

- Auto-save mỗi 2 phút
- Versioning cho sync conflicts
- Backup tự động hàng ngày
- Transaction rollback khi error

**Đo lường**:

- Data loss incidents: 0
- Auto-save success rate: 99.9%
- Backup completion: 100%

---

#### NFR-006: Error Handling

**Mô tả**: Ứng dụng phải xử lý lỗi gracefully

**Chi tiết**:

- Try-catch cho tất cả operations
- User-friendly error messages
- Error logging và reporting
- Graceful degradation

**Đo lường**:

- Unhandled exceptions: 0
- Error recovery rate: >95%
- User-reported errors: <1%

---

### 3.3 Maintainability (Khả năng Bảo trì)

#### NFR-007: Code Quality

**Mô tả**: Code phải clean và maintainable

**Chi tiết**:

- TypeScript với strict mode
- ESLint và Prettier configured
- Component documentation
- Unit test coverage >80%

**Đo lường**:

- Code coverage: >80%
- ESLint errors: 0
- Code duplication: <5%

---

#### NFR-008: Logging & Monitoring

**Mô tả**: Ứng dụng phải có logging và monitoring

**Chi tiết**:

- Firebase Crashlytics integration
- Analytics tracking (Firebase Analytics)
- Performance monitoring
- Custom event logging

**Đo lường**:

- Crash-free users: >99%
- Event tracking: 100% critical events
- Performance monitoring: All screens

---

---

## 4. Yêu cầu Hiệu suất

### 4.1 Response Time

#### PERF-001: App Launch Time

**Yêu cầu**: App phải khởi động nhanh

**Target**:

- Cold start: <3 giây
- Warm start: <1.5 giây
- Hot start: <0.5 giây

**Đo lường**: Time to Interactive (TTI)

---

#### PERF-002: Screen Load Time

**Yêu cầu**: Màn hình phải load nhanh

**Target**:

- Dashboard: <1 giây
- Student detail: <2 giây
- Analytics: <2 giây
- AI processing: <30 giây

**Đo lường**: First Contentful Paint (FCP)

---

#### PERF-003: API Response Time

**Yêu cầu**: API calls phải nhanh

**Target**:

- Read operations: <500ms (p95)
- Write operations: <1s (p95)
- AI operations: <30s (p95)
- Sync operations: <3s (p95)

**Đo lường**: API latency (p50, p95, p99)

---

### 4.2 Throughput

#### PERF-004: Concurrent Users

**Yêu cầu**: Hệ thống phải xử lý nhiều users đồng thời

**Target**:

- Support 10,000 concurrent users
- Peak load: 20,000 concurrent users
- No degradation <5,000 users

**Đo lường**: Concurrent sessions, Request rate

---

#### PERF-005: Data Processing

**Yêu cầu**: Xử lý dữ liệu hiệu quả

**Target**:

- Load 100 students: <1 giây
- Load 1000 sessions: <3 giây
- Generate analytics report: <5 giây
- AI process 10-page document: <30 giây

**Đo lường**: Processing time, Memory usage

---

### 4.3 Resource Usage

#### PERF-006: Memory Usage

**Yêu cầu**: Sử dụng memory hiệu quả

**Target**:

- Idle: <100MB
- Active usage: <250MB
- Peak: <500MB
- No memory leaks

**Đo lường**: RAM usage, Heap size

---

#### PERF-007: Battery Usage

**Yêu cầu**: Tiết kiệm pin

**Target**:

- Background: <1% battery/hour
- Active usage: <5% battery/hour
- No battery drain issues

**Đo lường**: Battery impact, CPU usage

---

#### PERF-008: Storage Usage

**Yêu cầu**: Sử dụng storage hiệu quả

**Target**:

- App size: <50MB
- Database: <100MB for 1000 sessions
- Cache: <200MB
- Total: <500MB

**Đo lường**: Disk usage, Cache size

---

#### PERF-009: Network Usage

**Yêu cầu**: Tối ưu network traffic

**Target**:

- Initial load: <5MB
- Daily usage: <20MB
- Sync: <2MB/session
- Images optimized: <500KB each

**Đo lường**: Data transferred, Request count

---

### 4.4 Scalability

#### PERF-010: Horizontal Scalability

**Yêu cầu**: Hệ thống phải scale được

**Target**:

- Auto-scale Firebase functions
- CDN cho static assets
- Load balancer ready
- Microservices architecture

**Đo lường**: Scale-up time, Throughput increase

---

#### PERF-011: Database Scalability

**Yêu cầu**: Database phải scale được

**Target**:

- Support 100K users
- 10M sessions
- 100M behavior records
- Query performance stable

**Đo lường**: Query time, Index effectiveness

---

---

## 5. Yêu cầu Bảo mật

### 5.1 Authentication & Authorization

#### SEC-001: User Authentication

**Yêu cầu**: Xác thực người dùng an toàn

**Chi tiết**:

- Firebase Authentication
- Email/password với bcrypt hashing
- Biometric authentication (optional)
- Session management với JWT
- Token refresh mechanism

**Tiêu chuẩn**: OWASP Top 10 compliance

---

#### SEC-002: Authorization

**Yêu cầu**: Kiểm soát truy cập

**Chi tiết**:

- Role-based access control (RBAC)
- Teacher chỉ truy cập data của mình
- Firestore security rules
- API endpoint protection

**Tiêu chuẩn**: Principle of Least Privilege

---

### 5.2 Data Security

#### SEC-003: Data Encryption

**Yêu cầu**: Mã hóa dữ liệu

**Chi tiết**:

- Data at rest: AES-256 encryption
- Data in transit: TLS 1.3
- SQLite encryption (optional)
- Sensitive fields encrypted

**Tiêu chuẩn**: AES-256, TLS 1.3

---

#### SEC-004: Data Privacy

**Yêu cầu**: Bảo vệ privacy

**Chi tiết**:

- Personal data minimization
- User consent cho data collection
- Right to deletion
- Data retention policy (3 years)

**Tiêu chuẩn**: GDPR compliance

---

#### SEC-005: Secure Storage

**Yêu cầu**: Lưu trữ an toàn

**Chi tiết**:

- Keychain/Keystore cho sensitive data
- No plain text passwords
- Secure credentials storage
- Clear cache on logout

**Tiêu chuẩn**: Platform best practices

---

### 5.3 Application Security

#### SEC-006: Code Security

**Yêu cầu**: Code an toàn

**Chi tiết**:

- No hardcoded secrets
- Environment variables cho config
- Obfuscation cho production build
- Regular dependency updates

**Tiêu chuẩn**: OWASP Mobile Security

---

#### SEC-007: Input Validation

**Yêu cầu**: Validate input

**Chi tiết**:

- Client-side validation
- Server-side validation
- Sanitize user input
- SQL injection prevention

**Tiêu chuẩn**: OWASP Input Validation

---

#### SEC-008: API Security

**Yêu cầu**: API an toàn

**Chi tiết**:

- Rate limiting (100 req/min)
- API key authentication
- CORS configuration
- Request signing

**Tiêu chuẩn**: API Security Best Practices

---

### 5.4 Monitoring & Response

#### SEC-009: Security Monitoring

**Yêu cầu**: Giám sát bảo mật

**Chi tiết**:

- Failed login tracking
- Suspicious activity detection
- Security event logging
- Alerting mechanism

**Tiêu chuẩn**: Security Operations Center (SOC)

---

#### SEC-010: Incident Response

**Yêu cầu**: Phản hồi sự cố

**Chi tiết**:

- Incident response plan
- Data breach notification (72h)
- User notification
- Post-mortem analysis

**Tiêu chuẩn**: NIST Incident Response

---

---

## 6. Yêu cầu Tuân thủ

### 6.1 Legal Compliance

#### COMP-001: GDPR Compliance

**Yêu cầu**: Tuân thủ GDPR

**Chi tiết**:

- Privacy policy rõ ràng
- User consent cho data processing
- Right to access, rectify, delete
- Data portability
- Data breach notification

**Tiêu chuẩn**: EU GDPR

---

#### COMP-002: Vietnam Data Protection

**Yêu cầu**: Tuân thủ luật Việt Nam

**Chi tiết**:

- Tuân thủ Nghị định 13/2023/NĐ-CP
- Data localization (nếu yêu cầu)
- Cross-border data transfer compliance
- User consent tiếng Việt

**Tiêu chuẩn**: Vietnamese Data Protection Law

---

#### COMP-003: Children's Privacy

**Yêu cầu**: Bảo vệ trẻ em

**Chi tiết**:

- Không thu thập data trẻ <13 tuổi trực tiếp
- Parental consent (nếu cần)
- Minimal data collection cho học sinh
- Clear data usage explanation

**Tiêu chuẩn**: COPPA (US), Article 8 GDPR

---

### 6.2 Platform Compliance

#### COMP-004: App Store Guidelines

**Yêu cầu**: Tuân thủ App Store

**Chi tiết**:

- Follow Apple HIG (Human Interface Guidelines)
- In-app purchase rules (nếu có)
- Content policy compliance
- Privacy nutrition label accurate

**Tiêu chuẩn**: Apple App Store Review Guidelines

---

#### COMP-005: Google Play Policy

**Yêu cầu**: Tuân thủ Google Play

**Chi tiết**:

- Follow Material Design (khuyến nghị)
- Data safety section accurate
- Permissions declaration
- Content rating appropriate

**Tiêu chuẩn**: Google Play Policy Center

---

### 6.3 Industry Standards

#### COMP-006: Accessibility Standards

**Yêu cầu**: Tuân thủ accessibility

**Chi tiết**:

- WCAG 2.1 Level AA
- Section 508 compliance (US)
- EN 301 549 (EU)
- Mobile accessibility

**Tiêu chuẩn**: WCAG 2.1 AA

---

#### COMP-007: Education Standards

**Yêu cầu**: Tuân thủ chuẩn giáo dục

**Chi tiết**:

- Phương pháp ABC evidence-based
- Special education best practices
- IEP (Individualized Education Program) compatible
- Data-driven instruction principles

**Tiêu chuẩn**: Special Education Standards

---

---

## 7. Ma trận Theo dõi

### 7.1 Functional Requirements Traceability

| Req ID | Tên                  | Ưu tiên | Màn hình                  | Use Case | Test Case |
| ------ | -------------------- | ------- | ------------------------- | -------- | --------- |
| FR-001 | Đăng ký Tài khoản    | Must    | 29-onboarding.md          | UC-001   | TC-001    |
| FR-002 | Đăng nhập Hệ thống   | Must    | Login                     | UC-002   | TC-002    |
| FR-004 | Thêm Học sinh        | Must    | 01-dashboard.md           | UC-003   | TC-004    |
| FR-008 | Chọn Phương thức Tạo | Must    | 03-create-method-sheet.md | UC-004   | TC-008    |
| FR-012 | AI Upload File       | Should  | 08-ai-upload.md           | UC-005   | TC-012    |
| FR-015 | Chọn Phiên Ghi       | Must    | 11-session-selector.md    | UC-006   | TC-015    |
| FR-020 | Hành vi ABC          | Must    | 16-log-behavior.md        | UC-007   | TC-020    |
| FR-024 | Analytics Overview   | Must    | 20-analytics-overview.md  | UC-008   | TC-024    |

### 7.2 Non-Functional Requirements Traceability

| Req ID   | Tên            | Loại        | Target         | Test Method        |
| -------- | -------------- | ----------- | -------------- | ------------------ |
| NFR-001  | Mobile-First   | Usability   | 44x44pt        | Manual Testing     |
| NFR-002  | Accessibility  | Usability   | WCAG AA        | Automated + Manual |
| NFR-004  | Offline-First  | Reliability | 95% features   | Integration Test   |
| PERF-001 | App Launch     | Performance | <3s            | Performance Test   |
| PERF-002 | Screen Load    | Performance | <2s            | Performance Test   |
| SEC-001  | Authentication | Security    | JWT + Firebase | Security Audit     |
| SEC-003  | Encryption     | Security    | AES-256        | Security Scan      |
| COMP-001 | GDPR           | Compliance  | Full           | Legal Review       |

### 7.3 Feature Coverage Matrix

| Module              | FR Count | Implemented | Tested | Coverage |
| ------------------- | -------- | ----------- | ------ | -------- |
| Authentication      | 3        | 0           | 0      | 0%       |
| Student Management  | 4        | 0           | 0      | 0%       |
| Session Management  | 7        | 0           | 0      | 0%       |
| Logging             | 7        | 0           | 0      | 0%       |
| Behavior Dictionary | 2        | 0           | 0      | 0%       |
| Analytics           | 3        | 0           | 0      | 0%       |
| Settings            | 2        | 0           | 0      | 0%       |
| UI States           | 4        | 0           | 0      | 0%       |
| Onboarding          | 3        | 0           | 0      | 0%       |
| **Total**           | **35**   | **0**       | **0**  | **0%**   |

---

## Phụ Lục

### Phụ Lục A: Tham chiếu Wireframes

Tất cả wireframes được lưu tại: `/docs-project/wireframes-final/`

**Core Flows**:

- 01-10: Session Creation (Manual + AI)
- 11-17: Session Logging + ABC
- 18-19: Behavior Dictionary
- 20-22: Analytics & Reports

**Supporting**:

- 23-24: Profile & Settings
- 25-28: UI States
- 29-31: Onboarding & Help

### Phụ Lục B: Tham chiếu Use Cases

Chi tiết use cases được mô tả trong Product Requirements Document (PRD.md)

### Phụ Lục C: Lịch sử Thay đổi

| Phiên bản | Ngày       | Tác giả       | Thay đổi             |
| --------- | ---------- | ------------- | -------------------- |
| 1.0       | 23/10/2025 | Nhóm Sản phẩm | Tạo tài liệu ban đầu |

---

**Kết thúc Tài liệu Đặc tả Yêu cầu Chức năng**
