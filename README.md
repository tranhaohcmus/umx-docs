# Day 03 — Auth: Review Checklist + Giải thích `components/ui`

> Ghi chú để đọc lại. Gồm: (1) `src/components/ui/` từ đâu ra, (2) checklist review code Day 3, (3) context còn treo, (4) câu hỏi mở.

---

## Phần 1 — `src/components/ui/` từ đâu ra?

### Mô hình "copy-paste / own-your-code" (giống shadcn/ui)
Gluestack **v3 KHÔNG** cài component kiểu `import { Button } from "@gluestack-ui/themed"` (đó là v1). Thay vào đó, CLI **copy source code component vào repo của bạn**. Bạn *sở hữu* file `.tsx` đó → sửa thoải mái, không bị khóa version.

### Các lệnh đã tạo ra chúng
1. **Khởi tạo** (chạy 1 lần):
   ```bash
   npx gluestack-ui@latest init --use-npm --path src/components/ui
   ```
   - Tạo `src/components/ui/gluestack-ui-provider/` (provider + theme).
   - Cài deps lõi vào `node_modules`: `@gluestack-ui/core`, `@gluestack-ui/utils`, `@legendapp/motion`, `nativewind`, `tailwind-variants`…
   - **Tự sửa** `babel.config.js` (alias `@`, `nativewind/babel`), `metro.config.js` (`withNativeWind`), `tailwind.config.js` (color tokens), `tsconfig.json`, `global.css`. (Đây là lý do các config tự dưng "phình ra" — log lúc đó in `Cloning repository…` rồi `Project configuration generated`.)

2. **Thêm từng component**:
   ```bash
   npx gluestack-ui@latest add box text button heading center vstack hstack spinner
   npx gluestack-ui@latest add input
   ```
   Mỗi component → 1 thư mục `src/components/ui/<name>/index.tsx` (log in `Pulling latest changes… / Git pull successful / Added components`).

### CLI lấy code ở đâu?
Nó **clone/pull template repo của gluestack** (registry trên GitHub) rồi **ghi file `.tsx`** vào đúng `--path` bạn chỉ định. Không phải code "tự sinh", mà là **bản sao** từ template chính thức.

### Bên trong 1 component (vd `button/index.tsx`)
```ts
import { createButton } from '@gluestack-ui/core/button/creator';      // primitive (logic, a11y) từ package
import { tva, withStyleContext } from '@gluestack-ui/utils/nativewind-utils'; // helper styling
import { cssInterop } from 'nativewind';                                // cho phép className trên RN component
```
- **Logic/accessibility** đến từ package `@gluestack-ui/core` (trong `node_modules`).
- **Style** = chuỗi Tailwind class (qua `tva`) nằm **trong file bạn sở hữu** → muốn đổi màu/size cứ sửa trực tiếp.
- Đó là lý do hết lỗi Hermes của v1: v3 style bằng NativeWind (không còn `@gluestack-style/react` với `#private` fields).

### Thư mục `gluestack-ui-provider/`
| File | Vai trò |
|------|---------|
| `config.ts` | Bảng **CSS variables màu** light/dark (qua `vars()` của nativewind) |
| `index.tsx` | `GluestackUIProvider` (bản RN) — set colorScheme + bọc `OverlayProvider`/`ToastProvider` |
| `index.web.tsx`, `index.next15.tsx` | Biến thể web/Next.js — **RN không dùng**, CLI scaffold sẵn cho đa nền tảng, để kệ |

### Về sau
- Thêm component: `npx gluestack-ui@latest add <name>` → import `@/components/ui/<name>`.
- Gỡ: xóa thư mục đó.
- **Không** sửa logic trong `node_modules/@gluestack-ui/*` (đó là primitive dùng chung).

---

## Phần 2 — Checklist review code Day 3

### A. Backend — `addons/classpulse_base/controllers/auth_controller.py`
- [ ] Nhận `db, login, password` qua **kwargs hàm** (KHÔNG `request.get_json_data()`) — vì dispatcher json gọi `endpoint(**params)`.
- [ ] Sai creds → `raise AccessDenied(...)` (để Odoo wrap thành JSON-RPC error), KHÔNG `return {"status":"error"}`.
- [ ] Có `root.session_store.rotate(request.session, request.env)` **trước khi** trả `session_id` (fix sid rotate).
- [ ] `/me`, `/logout`: `auth="user"`, `type="json"`, `csrf=False`.
- [ ] Không leak recordset thô — trả dict đã normalize.

### B. Core — `src/core/api/odooClient.ts`
- [ ] Request interceptor wrap envelope `{jsonrpc, method:"call", params: config.data ?? {}}` cho **mọi** request.
- [ ] Inject `Cookie: session_id=…` khi có `_sessionId`.
- [ ] Header `ngrok-skip-browser-warning` (đang dùng ngrok).
- [ ] Response interceptor: unwrap `body.result`; nếu `body.error` → bắt **session-expired** (`code===100` / `SessionExpiredException`) gọi `_onSessionExpired()` rồi `throw`.
- [ ] **KHÔNG `import authStore`** trong file này (Hard Rule #10 + #7) — chỉ dùng callback `setOnSessionExpired`.
- [ ] `setSessionId` / `setOnSessionExpired` export ra ngoài.

### C. Core — `src/core/api/endpoints.ts`
- [ ] BaseURL đọc `EXPO_PUBLIC_ODOO_URL` (đổi URL không sửa code).
- [ ] Không hardcode URL rải rác nơi khác.

### D. Core — `src/core/stores/authStore.ts` (Zustand slice #11)
- [ ] `login()`: gọi `authApi.login` → `SecureStore.setItemAsync` → **`setSessionId(sid)`** → `set({user, isAuthenticated:true})`.
- [ ] `logout()`: `authApi.logout` (bọc try/catch) → xóa SecureStore → `setSessionId(null)` → reset state.
- [ ] `restore()`: đọc SecureStore → `setSessionId` → `getMe()` → set user; lỗi thì clear sạch + `isRestoring:false`.
- [ ] `isRestoring` khởi tạo `true` và **luôn** về `false` ở mọi nhánh (không kẹt splash).
- [ ] Store gọi `authApi` (tầng api), **không** gọi `odooClient` trực tiếp.

### E. Feature auth — tầng data
- [ ] `types/auth.types.ts`: `User`, `LoginRequest`, `LoginResponse`, `MeResponse` khớp response controller.
- [ ] `api/authMapper.ts`: normalize (snake_case → camelCase, vd `avatar_url`→`avatarUrl`). **Không** gọi network. (Hard Rule #9: không skip mapper.)
- [ ] `api/authApi.ts`: gọi `odooClient`, trả DTO sạch; **không** import store; **không** chứa business logic.
- [ ] `keys/authKeys.ts`: query key factory (tên file đúng `authKeys.ts`).
- [ ] `schemas/auth.schema.ts`: zod validate (thư mục `schemas/` số nhiều).

### F. Feature auth — tầng UI/hook
- [ ] `hooks/useLogin.ts`: `useMutation` gọi `authStore.login`; **không** import `odooClient` (Hard Rule #2).
- [ ] `screens/LoginScreen.tsx`: react-hook-form + `Controller` + zodResolver; **không** import `odooClient` (Hard Rule #1); **không** business logic (Hard Rule #3) — chỉ render + gọi hook.
- [ ] Validate trống/sai → lỗi inline, **không** gọi API (zodResolver chặn submit).
- [ ] Lỗi server → toast/Alert, không crash.
- [ ] Import UI từ `@/components/ui/*` (v3), không còn `@gluestack-ui/themed` (v1).

### G. Navigators + App.tsx
- [ ] `AppNavigator`: chọn **cả navigator** theo `user.role` (Role-Based #10), không `if` từng screen; có splash khi `isRestoring`.
- [ ] `AuthNavigator` / `TeacherNavigator` / `StudentNavigator` tách biệt.
- [ ] `App.tsx`: thứ tự provider cố định (Gesture→SafeArea→Query→Theme→AppNavigator) + `setOnSessionExpired(() => logout())` + `restore()` lúc boot (Callback Registration #7).

### H. Data flow & Hard Rules (xuyên suốt)
- [ ] Luồng đúng 1 chiều: `Screen → Hook → React Query → API → Mapper → odooClient`.
- [ ] Không tầng nào nhảy cóc; không `odooClient` trong Screen/Hook; không `authStore` trong api/odooClient.
- [ ] Mỗi file mới viết → cuối có ghi **Patterns used** (rule §11 của CLAUDE.md).

### I. Acceptance criteria Day 3 (chạy thật)
- [ ] Login đúng → đúng navigator theo role.
- [ ] Reload/kill app → vẫn đăng nhập (restore).
- [ ] Session expired → auto logout về Login.
- [ ] Form trống/sai → lỗi inline, không gọi API.
- [ ] Sai pass → toast, không crash.
- [ ] `npx tsc --noEmit` sạch.

---

## Phần 3 — Context còn treo (không chặn Day 3)
1. **Test luồng Student**: chưa có user `student` biết password. Cần thì set SQL `role='student'` + reset pass cho 1 user.
2. **Role bị reset khi `-u classpulse_base`**: muốn bền vững, bật lại `views/res_users_views.xml` trong manifest để set role qua UI (kiểm tra file view không lỗi trước).
3. **`avatar_url` trỏ `localhost`**: ảnh đại diện không load qua điện thoại (login không ảnh hưởng) — Day sau set `web.base.url`/proxy.
4. **`docs/api_contract.md`** vẫn ghi `GET /api/v1/me` (LOCKED) — nên sửa thành `POST` cho khớp code.

---

## Phần 4 — Câu hỏi mở (trả lời khi quay lại)
1. Muốn mình **tự chạy audit** theo checklist (đọc từng file, báo pass/fail + chỗ cần sửa), hay tự tick?
2. Có cần mình tạo **user student test** (set role + password) để nghiệm thu criteria "đúng navigator theo role" cho cả 2 vai?
3. Đi tiếp **Day 4 (Class & Enrollment full-stack)** luôn không?

---

## Nhắc nhanh cách chạy lại mai (kết nối mobile ↔ Odoo qua ngrok)
1. Terminal A: `ngrok http 8069` (giữ mở) → copy URL `https://XXXX.ngrok-free.dev`.
2. `EduManagement/.env`: `EXPO_PUBLIC_ODOO_URL=https://XXXX.ngrok-free.dev` (không `/` cuối).
3. Terminal B: `cd EduManagement && npx expo start -c`.
4. Login `teacher@test.com` / `123` (uid 19, role đã set `teacher`).
> Mẹo khỏi đổi URL: dùng static domain — `ngrok http --url=https://<ten>.ngrok-free.app 8069`.
