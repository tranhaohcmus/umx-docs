#!/bin/bash

# Duyệt qua tất cả file .md trong thư mục hiện tại
for file in *.md; do
    # Kiểm tra nếu file tồn tại (tránh lỗi khi không có file .md nào)
    [ -f "$file" ] || continue

    # Kiểm tra nếu file rỗng hoặc chỉ có khoảng trắng
    if [ ! -s "$file" ] || [ -z "$(grep -v '^[[:space:]]*$' "$file")" ]; then
        echo "Xóa file rỗng: $file"
        rm -f "$file"
    fi
done

echo "Hoàn tất!"
