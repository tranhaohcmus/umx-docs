# Ghi nhật ký - Ghi chú giáo viên

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 3/4: Ghi chú Giáo viên   │
│  ████████████████████░░░ 75%  │
│                                 │
│  📝 Quan sát chung              │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Hôm nay con đã thể hiện   │ │ Text area
│  │ sự tiến bộ rõ rệt trong   │ │
│  │ việc nhận diện màu sắc.   │ │
│  │ Con có thể gọi đúng tên   │ │
│  │ màu đỏ và xanh. Tuy nhiên │ │
│  │ vẫn còn nhầm lẫn khi phân │ │
│  │ biệt giữa xanh lá và xanh │ │
│  │ dương...                  │ │
│  │                           │ │
│  │ [250/1000 ký tự]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🎤 GHI ÂM                │ │ Voice input button
│  └───────────────────────────┘ │
│                                 │
│  🎤 Ghi chú bằng giọng nói     │
│  ┌───────────────────────────┐ │
│  │  ⏺️ 00:00 / 05:00          │ │ Recording state
│  │  [⏸️ Tạm dừng] [⏹️ Dừng]  │ │
│  │                           │ │
│  │  Đang ghi âm...           │ │
│  │  ████████░░ 80%           │ │
│  └───────────────────────────┘ │
│                                 │
│  Hoặc:                         │
│  ┌───────────────────────────┐ │
│  │  🔊 Ghi chú giọng nói (1) │ │ Recorded audio
│  │  📝 02:34                 │ │
│  │  [▶️ Phát] [🗑️ Xóa]       │ │
│  └───────────────────────────┘ │
│                                 │
│  📸 Đính kèm ảnh/video         │
│  ┌───────────────────────────┐ │
│  │ [📷] [🖼️] [🎥]            │ │
│  │                           │ │
│  │ Đã thêm: 2 ảnh            │ │
│  │ ┌──┐ ┌──┐                │ │
│  │ │📷│ │📷│ [+ Thêm]       │ │
│  │ └──┘ └──┘                │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Gợi ý mẫu câu:             │
│  • "Con đã thể hiện..."        │
│  • "Cần cải thiện..."          │
│  • "Điểm nổi bật..."           │
│                                 │
│  ┌───────────────────────────┐ │
│  │   TIẾP TỤC (3/4) →        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]     [Lưu nháp]   │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Step 3/4 - Ghi chú quan sát của giáo viên với nhiều định dạng.

## Components

### Text Notes

- Multi-line textarea
- Character counter (1000 max)
- Template suggestions

### Voice Recording

- Record button
- Duration counter
- Play/Pause/Delete

### Media Attachments

- Camera button
- Gallery button
- Video button
- Thumbnail preview
- Add more option

### Template Suggestions

- Quick phrases to help teacher

### Actions

- Continue to Step 4
- Back to Step 2
- Save draft

## Interactions

- **Type text** = Add written notes
- **Tap microphone** = Start/stop recording
- **Tap camera** = Take photo
- **Tap gallery** = Choose from device
- **Tap video** = Record video
- **Tap thumbnail** = View/delete media

## Validation

- At least one of: text, voice, or media
- Max 5 media files
- Max 5 minutes voice recording

## Related Screens

- **Previous**: 14-log-attitude.md
- **Next**: 16-log-behavior.md
