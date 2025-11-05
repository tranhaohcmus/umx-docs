# Giải Thích: Indexes vs Stored Fields trong Database

**Ngày:** 2025-11-04  
**Mục đích:** Làm rõ sự khác biệt giữa Indexes (không cần lưu) và Computed Fields (cần lưu)

---

## 📌 CÂU HỎI: "Indexes có cần lưu vào database không?"

### ✅ **TRẢ LỜI NGẮN GỌN:**

- **Indexes thông thường:** ❌ **KHÔNG** cần field mới
- **Full-text search với JSON:** ✅ **CẦN** field mới (`keywords_tsvector`)
- **Search ranking:** ✅ **CẦN** field mới (`search_rank`)

---

## 🔍 PHẦN 1: INDEXES THÔNG THƯỜNG - KHÔNG CẦN FIELD MỚI

### **Indexes là gì?**

**Index** là cấu trúc dữ liệu **metadata** do database engine quản lý, giống như "mục lục sách":

- Sách có nội dung (data)
- Mục lục ở cuối sách (index) giúp tìm nhanh
- Mục lục **KHÔNG phải** phần nội dung sách

### **Ví dụ cụ thể:**

```sql
-- TABLE: BEHAVIOR_LIBRARY
CREATE TABLE BEHAVIOR_LIBRARY (
  id UUID PRIMARY KEY,
  behavior_code VARCHAR(20),
  name_vn VARCHAR(255),
  keywords_vn JSON,
  usage_count INTEGER
);

-- Tạo index (KHÔNG cần field mới)
CREATE INDEX idx_behavior_usage
ON BEHAVIOR_LIBRARY(usage_count DESC);
```

**Sau khi tạo index:**

- ❌ Table **KHÔNG** thêm column nào
- ✅ PostgreSQL tạo B-tree structure riêng
- ✅ Index tự động update khi data thay đổi
- ✅ Query sử dụng index để tìm nhanh

### **Cách index hoạt động:**

```
BEHAVIOR_LIBRARY table:
┌──────┬───────┬─────────┬──────────┐
│ id   │ code  │ name_vn │ usage_ct │
├──────┼───────┼─────────┼──────────┤
│ uuid1│ BH_01 │ Ăn vạ   │ 45       │
│ uuid2│ BH_02 │ Từ chối │ 32       │
│ uuid3│ BH_03 │ Đánh bạn│ 28       │
└──────┴───────┴─────────┴──────────┘

Index idx_behavior_usage (riêng biệt):
┌──────────┬────────────┐
│ usage_ct │ row pointer│
├──────────┼────────────┤
│ 45       │ → uuid1    │
│ 32       │ → uuid2    │
│ 28       │ → uuid3    │
└──────────┴────────────┘
```

**Query sử dụng index:**

```sql
-- Without index: Full table scan O(n)
-- With index: Binary search O(log n)
SELECT * FROM BEHAVIOR_LIBRARY
ORDER BY usage_count DESC;
```

### **Các loại indexes thông thường (KHÔNG cần field mới):**

```sql
-- 1. Single column index
CREATE INDEX idx_name ON BEHAVIOR_LIBRARY(name_vn);

-- 2. Composite index
CREATE INDEX idx_group_usage
ON BEHAVIOR_LIBRARY(behavior_group_id, usage_count DESC);

-- 3. Partial index
CREATE INDEX idx_active_behaviors
ON BEHAVIOR_LIBRARY(behavior_code)
WHERE is_active = TRUE;

-- 4. Unique index
CREATE UNIQUE INDEX idx_unique_code
ON BEHAVIOR_LIBRARY(behavior_code);
```

**Tất cả đều KHÔNG tạo field mới trong table!**

---

## 🎯 PHẦN 2: KHI NÀO CẦN FIELD MỚI?

### **Case 1: Full-text Search với JSON Array**

**Vấn đề:**

```sql
BEHAVIOR_LIBRARY {
    keywords_vn JSON  -- Value: ["ăn vạ", "la hét", "nằm lăn", ...]
}
```

**Để search full-text:**

1. Extract JSON array → string
2. Convert string → tsvector format
3. Index tsvector

**❌ Nếu KHÔNG có field mới:**

```sql
-- Phải convert MỖI LẦN query (chậm!)
SELECT * FROM BEHAVIOR_LIBRARY
WHERE to_tsvector('vietnamese',
  (SELECT string_agg(value::text, ' ')
   FROM jsonb_array_elements_text(keywords_vn::jsonb))
) @@ to_tsquery('vietnamese', 'ăn & vạ');
```

**✅ Với field mới (tối ưu):**

```sql
-- 1. Thêm column để cache kết quả
ALTER TABLE BEHAVIOR_LIBRARY
ADD COLUMN keywords_tsvector TSVECTOR;

-- 2. Trigger tự động update
CREATE TRIGGER trigger_update_keywords_tsvector
BEFORE INSERT OR UPDATE OF keywords_vn
ON BEHAVIOR_LIBRARY
FOR EACH ROW
EXECUTE FUNCTION update_behavior_keywords_tsvector();

-- 3. Index trên column mới
CREATE INDEX idx_keywords_fts
ON BEHAVIOR_LIBRARY USING GIN(keywords_tsvector);

-- 4. Query nhanh hơn 10-100x
SELECT * FROM BEHAVIOR_LIBRARY
WHERE keywords_tsvector @@ to_tsquery('vietnamese', 'ăn & vạ');
```

**Lợi ích:**

- ✅ Convert 1 lần (khi INSERT/UPDATE)
- ✅ Search nhanh (GIN index)
- ✅ Không tốn CPU mỗi query

---

### **Case 2: Computed Ranking Score**

**Vấn đề:**

```sql
-- Calculate ranking mỗi lần search (chậm!)
SELECT
  *,
  (usage_count * 10 +
   CASE WHEN last_used_at > NOW() - INTERVAL '7 days' THEN 50 ELSE 0 END
  ) as search_rank
FROM BEHAVIOR_LIBRARY
ORDER BY search_rank DESC;
```

**✅ Với field mới:**

```sql
-- 1. Thêm column để cache ranking
ALTER TABLE BEHAVIOR_LIBRARY
ADD COLUMN search_rank INTEGER;

-- 2. Trigger auto-update khi usage thay đổi
CREATE TRIGGER trigger_update_search_rank
BEFORE INSERT OR UPDATE OF usage_count, last_used_at
ON BEHAVIOR_LIBRARY
FOR EACH ROW
EXECUTE FUNCTION update_behavior_search_rank();

-- 3. Index để sort nhanh
CREATE INDEX idx_search_rank
ON BEHAVIOR_LIBRARY(search_rank DESC);

-- 4. Query đơn giản hơn
SELECT * FROM BEHAVIOR_LIBRARY
ORDER BY search_rank DESC;
```

**Lợi ích:**

- ✅ Ranking được cache
- ✅ Sort nhanh (index on integer)
- ✅ Không compute lại mỗi query

---

## 📊 SO SÁNH: Index vs Stored Field

| Tiêu chí             | Index thông thường        | Stored Field (Computed)              |
| -------------------- | ------------------------- | ------------------------------------ |
| **Tạo column mới?**  | ❌ Không                  | ✅ Có                                |
| **Tự động update?**  | ✅ Có (bởi DB)            | ✅ Có (bởi trigger)                  |
| **Tốn storage?**     | Ít (chỉ metadata)         | Nhiều hơn (duplicate data)           |
| **Performance gain** | 10-100x                   | 10-1000x (với complex computation)   |
| **Use case**         | Simple filtering, sorting | Complex computation, JSON extraction |

---

## 🛠️ MIGRATION CHO BEHAVIOR_LIBRARY

### **Fields cần thêm:**

```sql
ALTER TABLE BEHAVIOR_LIBRARY
ADD COLUMN keywords_tsvector TSVECTOR,  -- Full-text search
ADD COLUMN search_rank INTEGER;          -- Ranking score
```

### **Triggers tự động:**

```sql
-- Trigger 1: Update keywords_tsvector khi keywords_vn thay đổi
CREATE TRIGGER trigger_update_keywords_tsvector
BEFORE INSERT OR UPDATE OF keywords_vn
ON BEHAVIOR_LIBRARY
FOR EACH ROW
EXECUTE FUNCTION update_behavior_keywords_tsvector();

-- Trigger 2: Update search_rank khi usage thay đổi
CREATE TRIGGER trigger_update_search_rank
BEFORE INSERT OR UPDATE OF usage_count, last_used_at
ON BEHAVIOR_LIBRARY
FOR EACH ROW
EXECUTE FUNCTION update_behavior_search_rank();
```

### **Indexes:**

```sql
-- GIN index cho full-text search
CREATE INDEX idx_behavior_keywords_fts
ON BEHAVIOR_LIBRARY USING GIN(keywords_tsvector);

-- B-tree index cho ranking sort
CREATE INDEX idx_behavior_search_rank
ON BEHAVIOR_LIBRARY(search_rank DESC);
```

---

## 📈 PERFORMANCE IMPACT

### **Before (without computed fields):**

```sql
-- Search "ăn vạ" - SLOW (100ms)
SELECT * FROM BEHAVIOR_LIBRARY
WHERE to_tsvector('vietnamese',
  (SELECT string_agg(value::text, ' ')
   FROM jsonb_array_elements_text(keywords_vn::jsonb))
) @@ to_tsquery('vietnamese', 'ăn & vạ')
ORDER BY
  usage_count * 10 +
  CASE WHEN last_used_at > NOW() - INTERVAL '7 days' THEN 50 ELSE 0 END DESC;
```

**Problems:**

- ❌ JSON extraction mỗi row
- ❌ tsvector conversion mỗi row
- ❌ Ranking calculation mỗi row
- ❌ Không thể dùng index

### **After (with computed fields):**

```sql
-- Search "ăn vạ" - FAST (5-10ms)
SELECT * FROM BEHAVIOR_LIBRARY
WHERE keywords_tsvector @@ to_tsquery('vietnamese', 'ăn & vạ')
ORDER BY search_rank DESC;
```

**Benefits:**

- ✅ GIN index scan (very fast)
- ✅ Pre-computed tsvector
- ✅ Pre-computed ranking
- ✅ 10-20x faster

---

## 🎓 GIẢI THÍCH JSONB DATA STRUCTURE

Bạn hỏi về 3 loại JSONB trong examples:

### **1. Explanation - ❌ WRONG FORMAT**

**Ví dụ bạn đưa (KHÔNG đúng):**

```json
{
  "manifestation": "Trẻ nói 'không', lắc đầu...",
  "why_happens": "Trẻ muốn tránh nhiệm vụ khó/chán...",
  "function": "Escape/Avoidance"
}
```

**Format ĐÚNG (theo data.md và wireframe 19):**

```json
{
  "explanation": [
    {
      "title": "Nhu cầu Giao tiếp",
      "description": "Với trẻ nhỏ, đặc biệt là trẻ chưa biết nói..."
    },
    {
      "title": "Nhu cầu Tự chủ & Độc lập",
      "description": "Từ 18 tháng đến 3 tuổi..."
    }
  ]
}
```

**Tại sao phải là ARRAY?**

- ✅ Một hành vi có **nhiều** lý thuyết giải thích (2-4 frameworks)
- ✅ Mỗi framework có title + description riêng
- ✅ UI hiển thị dạng expandable sections (1️⃣, 2️⃣, 3️⃣...)

---

### **2. Solutions - ❌ WRONG FORMAT**

**Ví dụ bạn đưa (KHÔNG đúng):**

```json
{
  "prevention": ["Strategy 1", "Strategy 2"],
  "intervention": ["Strategy 3", "Strategy 4"],
  "reinforcement": ["Strategy 5"]
}
```

**Format ĐÚNG (theo data.md):**

```json
{
  "solutions": [
    {
      "title": "Giữ bình tĩnh & Đảm bảo an toàn",
      "description": "Phản ứng của người lớn có thể khuếch đại hoặc làm dịu..."
    },
    {
      "title": "Không 'thỏa hiệp' với cơn ăn vạ",
      "description": "Nếu ăn vạ để đòi bánh, mà bạn cho bánh..."
    }
  ]
}
```

**Tại sao format này tốt hơn?**

- ✅ **Ordered list** - thứ tự quan trọng (step 1, 2, 3...)
- ✅ **Title + Description** - summary và chi tiết
- ✅ **Expandable UI** - wireframe 19 hiển thị title, click để xem description
- ✅ **Simpler** - không cần phân loại phức tạp (prevention/intervention/reinforcement)

**UI rendering:**

```
💡 Can thiệp Evidence-based 🎓

┌───────────────────────────┐
│ 1️⃣ Giữ bình tĩnh & Đảm bảo │
│    an toàn                │
│ ──────────────────────    │
│ Phản ứng của người lớn... │ ← Expandable
│ [Đọc thêm ↓]              │
└───────────────────────────┘

┌───────────────────────────┐
│ 2️⃣ Không "thỏa hiệp" với   │
│    cơn ăn vạ              │
│ ──────────────────────    │
│ Nếu ăn vạ để đòi bánh...  │
│ [Đọc thêm ↓]              │
└───────────────────────────┘
```

---

### **3. Sources - ❌ OVER-COMPLICATED**

**Ví dụ bạn đưa (phức tạp không cần thiết):**

```json
[
  {
    "title": "Cooper et al. (2020) - Applied Behavior Analysis",
    "type": "textbook",
    "citation": "Cooper, J. O., Heron, T. E., & Heward, W. L. (2020)..."
  }
]
```

**Format ĐƠN GIẢN HƠN (theo data.md):**

```json
{
  "sources": [
    "Potegal, M., & Davidson, R. J. (2003). Temper tantrums in young children: 1. Behavioral composition. Journal of Developmental & Behavioral Pediatrics, 24(3), 140-147.",
    "Sroufe, L. A. (2000). Emotional Development: The Organization of Emotional Life in the Early Years. Cambridge University Press."
  ]
}
```

**Tại sao simple array tốt hơn?**

- ✅ **Đơn giản** - chỉ cần citation string
- ✅ **APA format** - đã include đầy đủ thông tin (author, year, title, journal/publisher)
- ✅ **UI rendering** - bullet list đơn giản
- ✅ **Ít khi query** - không cần filter by type

**Nếu sau này cần structure phức tạp:**

```json
[
  {
    "citation": "Full APA citation string",
    "doi": "10.1097/00004703-200306000-00002",
    "url": "https://...",
    "pdf_url": "https://..."
  }
]
```

---

## ✅ KẾT LUẬN

### **Indexes thông thường:**

- ❌ KHÔNG cần field mới
- ✅ Database tự quản lý
- ✅ Tự động update
- 👉 **Chỉ cần chạy** `CREATE INDEX ...`

### **Full-text search & Ranking:**

- ✅ CẦN fields mới (`keywords_tsvector`, `search_rank`)
- ✅ Triggers tự động update
- ✅ Performance gain rất lớn (10-100x)
- 👉 **Chạy migration script:** `DB_MIGRATION_ADD_SEARCH_FIELDS.sql`

### **JSONB formats:**

- `explanation`: Array of {title, description}
- `solutions`: Array of {title, description}
- `sources`: Array of strings (APA citations)

---

**File migration:** `/docs/DB_MIGRATION_ADD_SEARCH_FIELDS.sql`  
**File ERD updated:** `/docs/ERD_MERMAID.md`
