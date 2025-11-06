# Hướng Dẫn Chuyển Đổi Từ JavaScript Sang TypeScript

## 1. Tại Sao Nên Chuyển Sang TypeScript?

### 1.1. Lợi Ích Chính

**Static Typing - Kiểm Tra Kiểu Tĩnh**
TypeScript giúp bạn phát hiện lỗi ngay trong quá trình viết code, thay vì phải chạy ứng dụng mới phát hiện ra bug. Điều này đặc biệt quan trọng trong các dự án lớn với nhiều developer.

**Phát Hiện Lỗi Sớm**
Thay vì lỗi xuất hiện ở production, TypeScript compiler sẽ cảnh báo bạn ngay khi có vấn đề về kiểu dữ liệu, thuộc tính không tồn tại, hoặc tham số sai.

**Hỗ Trợ IDE Vượt Trội**
Với TypeScript, IDE của bạn (VS Code, WebStorm...) có thể cung cấp autocomplete thông minh, refactoring an toàn, và documentation ngay trong code. Điều này giúp tăng tốc độ coding đáng kể.

**Code Dễ Bảo Trì**
Khi dự án phát triển, TypeScript giúp code tự document chính nó. Bạn không cần đoán kiểu dữ liệu của một hàm nào đó - TypeScript nói rõ cho bạn.

**Refactoring An Toàn**
Khi thay đổi cấu trúc code, TypeScript sẽ chỉ ra tất cả những nơi bị ảnh hưởng, giúp bạn không bỏ sót gì.

### 1.2. TypeScript Là Gì?

TypeScript là một superset của JavaScript - nghĩa là mọi code JavaScript hợp lệ đều là code TypeScript hợp lệ. TypeScript chỉ thêm vào các tính năng kiểm tra kiểu và biên dịch về JavaScript thuần để chạy trên browser/Node.js.

## 2. Các Kiểu Dữ Liệu Cơ Bản

### 2.1. Kiểu Nguyên Thủy

**String, Number, Boolean**

```typescript
// JavaScript - không có kiểm tra kiểu
let username = "John";
let age = 25;
let isActive = true;

username = 123; // Không có lỗi trong JS

// TypeScript - có kiểm tra kiểu
let username: string = "John";
let age: number = 25;
let isActive: boolean = true;

username = 123; // ❌ Lỗi: Type 'number' is not assignable to type 'string'
```

**Array**

```typescript
// JavaScript
let numbers = [1, 2, 3];
let names = ["Alice", "Bob"];

// TypeScript - Cách 1: Sử dụng []
let numbers: number[] = [1, 2, 3];
let names: string[] = ["Alice", "Bob"];

// TypeScript - Cách 2: Sử dụng Array<T>
let scores: Array<number> = [90, 85, 88];

// Array hỗn hợp
let mixed: (string | number)[] = [1, "two", 3];
```

### 2.2. Any vs Unknown

**Any - "Tắt" Type Checking**

```typescript
let data: any = "hello";
data = 123;           // ✅ OK
data = { x: 10 };     // ✅ OK
data.toUpperCase();   // ✅ OK (nhưng có thể crash runtime nếu data không phải string)

// Tránh sử dụng any trừ khi thực sự cần thiết
```

**Unknown - Type-Safe "Any"**

```typescript
let data: unknown = "hello";

// ❌ Không thể sử dụng trực tiếp
console.log(data.toUpperCase()); // Lỗi

// ✅ Phải kiểm tra kiểu trước
if (typeof data === "string") {
  console.log(data.toUpperCase()); // OK
}

// Unknown an toàn hơn any vì bắt buộc phải type-check
```

**Khi Nào Dùng Any/Unknown?**
- `any`: Khi làm việc với thư viện legacy không có types, hoặc khi migrate từ JS sang TS từng phần
- `unknown`: Khi không biết trước kiểu dữ liệu (ví dụ: response từ API), nhưng muốn type-safe

### 2.3. Null và Undefined

```typescript
let x: string | null = null;
let y: string | undefined = undefined;

// strictNullChecks (nên bật trong tsconfig.json)
let name: string = null; // ❌ Lỗi với strictNullChecks
let name: string | null = null; // ✅ OK
```

## 3. Interfaces và Types - Sự Khác Biệt Quan Trọng

### 3.1. Interface - Định Nghĩa Cấu Trúc Object

**JavaScript Trước Khi Có TypeScript**

```javascript
// JavaScript - không có contract rõ ràng
function createUser(name, email, age) {
  return {
    name: name,
    email: email,
    age: age,
    greet() {
      return `Hello, I'm ${this.name}`;
    }
  };
}

const user = createUser("Alice", "alice@email.com", 25);
console.log(user.greet());
```

**TypeScript Với Interface**

```typescript
// TypeScript - định nghĩa rõ ràng cấu trúc
interface User {
  name: string;
  email: string;
  age: number;
  greet(): string;
}

function createUser(name: string, email: string, age: number): User {
  return {
    name,
    email,
    age,
    greet() {
      return `Hello, I'm ${this.name}`;
    }
  };
}

const user: User = createUser("Alice", "alice@email.com", 25);
console.log(user.greet());
```

**Optional Properties và Readonly**

```typescript
interface Product {
  id: number;
  name: string;
  price: number;
  description?: string;  // Optional - có thể có hoặc không
  readonly createdAt: Date;  // Không thể thay đổi sau khi tạo
}

const product: Product = {
  id: 1,
  name: "Laptop",
  price: 1000,
  createdAt: new Date()
};

product.price = 900; // ✅ OK
product.createdAt = new Date(); // ❌ Lỗi: Cannot assign to 'createdAt'
```

**Extending Interfaces**

```typescript
interface Animal {
  name: string;
  age: number;
}

interface Dog extends Animal {
  breed: string;
  bark(): void;
}

const myDog: Dog = {
  name: "Buddy",
  age: 3,
  breed: "Golden Retriever",
  bark() {
    console.log("Woof!");
  }
};
```

### 3.2. Type Aliases - Định Nghĩa Kiểu Tùy Chỉnh

**Type cho Objects (giống Interface)**

```typescript
type User = {
  name: string;
  email: string;
  age: number;
};

const user: User = {
  name: "Bob",
  email: "bob@email.com",
  age: 30
};
```

**Type cho Union Types**

```typescript
// Type có thể làm được điều mà Interface không thể
type Status = "pending" | "approved" | "rejected";
type ID = string | number;

let orderStatus: Status = "pending"; // ✅ OK
orderStatus = "shipped"; // ❌ Lỗi

function getUserById(id: ID): void {
  // id có thể là string hoặc number
}
```

**Type cho Primitive Unions**

```typescript
type Theme = "light" | "dark";
type Size = "sm" | "md" | "lg" | "xl";

function setTheme(theme: Theme): void {
  console.log(`Setting theme to ${theme}`);
}

setTheme("light"); // ✅ OK
setTheme("blue");  // ❌ Lỗi
```

### 3.3. Interface vs Type - Khi Nào Dùng Cái Nào?

**Dùng Interface Khi:**
- Định nghĩa shape của objects/classes
- Cần extends hoặc implements
- Làm việc với OOP
- Muốn declaration merging (hợp nhất nhiều khai báo)

```typescript
// Declaration Merging - chỉ Interface có thể
interface Window {
  customProperty: string;
}

interface Window {
  anotherProperty: number;
}

// Window giờ có cả customProperty và anotherProperty
```

**Dùng Type Khi:**
- Tạo union types hoặc intersection types
- Làm việc với primitives, tuples
- Cần conditional types hoặc mapped types (nâng cao)
- Muốn alias cho một kiểu phức tạp

```typescript
// Intersection Types
type Admin = {
  adminLevel: number;
};

type UserWithAdmin = User & Admin;

const admin: UserWithAdmin = {
  name: "Admin",
  email: "admin@email.com",
  age: 35,
  adminLevel: 5
};
```

**Quy Tắc Đơn Giản:**
- Interface cho objects và classes
- Type cho mọi thứ khác (unions, primitives, complex types)

## 4. Generics - Code Linh Hoạt và Tái Sử Dụng

### 4.1. Vấn Đề Khi Không Dùng Generics

**JavaScript/TypeScript Không Dùng Generics**

```typescript
// Phải tạo nhiều hàm giống nhau cho các kiểu khác nhau
function getFirstString(arr: string[]): string {
  return arr[0];
}

function getFirstNumber(arr: number[]): number {
  return arr[0];
}

// Hoặc mất type safety
function getFirst(arr: any[]): any {
  return arr[0]; // Mất thông tin về kiểu trả về
}
```

### 4.2. Giải Pháp Với Generics

**Generic Function**

```typescript
// <T> là type parameter - một "biến" cho kiểu dữ liệu
function getFirst<T>(arr: T[]): T {
  return arr[0];
}

// TypeScript tự động infer kiểu
const firstString = getFirst(["a", "b", "c"]); // firstString: string
const firstNumber = getFirst([1, 2, 3]);       // firstNumber: number

// Hoặc chỉ định rõ kiểu
const firstItem = getFirst<string>(["x", "y"]); // firstItem: string
```

**Generic Interface**

```typescript
// JavaScript - không có type checking
function wrapInArray(value) {
  return [value];
}

// TypeScript với Generics
interface Box<T> {
  value: T;
}

const stringBox: Box<string> = { value: "hello" };
const numberBox: Box<number> = { value: 42 };

// Generic với nhiều type parameters
interface Pair<K, V> {
  key: K;
  value: V;
}

const userAge: Pair<string, number> = {
  key: "Alice",
  value: 25
};
```

### 4.3. Generics Thực Tế - API Response

**Trước: Không Dùng Generics**

```typescript
interface UserResponse {
  data: User;
  status: number;
  message: string;
}

interface ProductResponse {
  data: Product;
  status: number;
  message: string;
}

// Phải tạo nhiều interfaces tương tự
```

**Sau: Dùng Generics**

```typescript
interface ApiResponse<T> {
  data: T;
  status: number;
  message: string;
}

// Tái sử dụng cho mọi loại data
type UserResponse = ApiResponse<User>;
type ProductResponse = ApiResponse<Product>;
type ProductListResponse = ApiResponse<Product[]>;

async function fetchUser(id: number): Promise<ApiResponse<User>> {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
}

// TypeScript biết chính xác user.data là User
const user = await fetchUser(1);
console.log(user.data.name); // ✅ Autocomplete hoạt động!
```

### 4.4. Generic Constraints

```typescript
// Giới hạn T phải có thuộc tính length
function logLength<T extends { length: number }>(item: T): void {
  console.log(item.length);
}

logLength("hello");      // ✅ OK - string có length
logLength([1, 2, 3]);    // ✅ OK - array có length
logLength({ length: 5 }); // ✅ OK - object có length
logLength(123);          // ❌ Lỗi - number không có length
```

## 5. Enums và Union Types

### 5.1. Enums - Tập Hợp Các Giá Trị Có Tên

**JavaScript - Sử Dụng Objects**

```javascript
// JavaScript
const OrderStatus = {
  PENDING: "PENDING",
  PROCESSING: "PROCESSING",
  SHIPPED: "SHIPPED",
  DELIVERED: "DELIVERED"
};

function updateOrderStatus(orderId, status) {
  // Không có kiểm tra - có thể truyền bất kỳ string nào
  console.log(`Order ${orderId} is now ${status}`);
}

updateOrderStatus(123, "WRONG_STATUS"); // Không có lỗi!
```

**TypeScript - Numeric Enum**

```typescript
enum OrderStatus {
  Pending,      // 0
  Processing,   // 1
  Shipped,      // 2
  Delivered     // 3
}

function updateOrderStatus(orderId: number, status: OrderStatus): void {
  console.log(`Order ${orderId} is now ${status}`);
}

updateOrderStatus(123, OrderStatus.Shipped); // ✅ OK
updateOrderStatus(123, "Shipped");           // ❌ Lỗi
```

**String Enum (Khuyến Nghị)**

```typescript
enum OrderStatus {
  Pending = "PENDING",
  Processing = "PROCESSING",
  Shipped = "SHIPPED",
  Delivered = "DELIVERED"
}

// Dễ debug hơn vì giá trị là string có nghĩa
console.log(OrderStatus.Shipped); // "SHIPPED"
```

### 5.2. Union Types - Lựa Chọn Linh Hoạt Hơn

**Union Types với Literals**

```typescript
// Union type - thường được ưa chuộng hơn enum trong TypeScript hiện đại
type OrderStatus = "pending" | "processing" | "shipped" | "delivered";

function updateOrderStatus(orderId: number, status: OrderStatus): void {
  console.log(`Order ${orderId} is now ${status}`);
}

updateOrderStatus(123, "shipped"); // ✅ OK
updateOrderStatus(123, "cancelled"); // ❌ Lỗi - không nằm trong union
```

**Union Types Phức Tạp**

```typescript
type SuccessResponse = {
  success: true;
  data: User;
};

type ErrorResponse = {
  success: false;
  error: string;
};

type ApiResponse = SuccessResponse | ErrorResponse;

function handleResponse(response: ApiResponse): void {
  if (response.success) {
    // TypeScript biết đây là SuccessResponse
    console.log(response.data.name); // ✅ OK
  } else {
    // TypeScript biết đây là ErrorResponse
    console.log(response.error); // ✅ OK
  }
}
```

### 5.3. Enum vs Union Types - Nên Dùng Cái Nào?

**Dùng Enum Khi:**
- Cần một namespace cho các giá trị liên quan
- Làm việc với code cũ hoặc API cần numeric values
- Muốn reverse mapping (từ value về key)

**Dùng Union Types Khi:**
- Muốn code đơn giản, nhẹ hơn
- Làm việc với TypeScript hiện đại
- Cần tree-shaking tốt hơn (bundle size nhỏ hơn)
- **Khuyến nghị cho hầu hết trường hợp**

```typescript
// Modern TypeScript style - Union Types
type Theme = "light" | "dark" | "auto";
type Size = "sm" | "md" | "lg";

// Traditional style - Enums
enum Theme {
  Light = "light",
  Dark = "dark",
  Auto = "auto"
}
```

## 6. Thiết Lập TypeScript

### 6.1. Cài Đặt TypeScript

**Cài Đặt Global**

```bash
# NPM
npm install -g typescript

# Yarn
yarn global add typescript

# Kiểm tra cài đặt
tsc --version
```

**Cài Đặt Cho Dự Án (Khuyến Nghị)**

```bash
# NPM
npm install --save-dev typescript

# Yarn
yarn add --dev typescript

# Khởi tạo tsconfig.json
npx tsc --init
```

### 6.2. File tsconfig.json - Cấu Hình Cơ Bản

```json
{
  "compilerOptions": {
    /* Basic Options */
    "target": "ES2020",                    // Version JS sau khi compile
    "module": "commonjs",                  // System module (commonjs cho Node, es6 cho browser)
    "lib": ["ES2020"],                     // Thư viện JS có sẵn
    "outDir": "./dist",                    // Thư mục output
    "rootDir": "./src",                    // Thư mục source
    
    /* Strict Type-Checking Options - QUAN TRỌNG */
    "strict": true,                        // Bật tất cả strict checks
    "noImplicitAny": true,                 // Không cho phép any ngầm định
    "strictNullChecks": true,              // null/undefined phải khai báo rõ
    "strictFunctionTypes": true,           // Kiểm tra function types chặt chẽ
    
    /* Additional Checks */
    "noUnusedLocals": true,                // Cảnh báo biến không dùng
    "noUnusedParameters": true,            // Cảnh báo tham số không dùng
    "noImplicitReturns": true,             // Hàm phải return ở mọi đường đi
    
    /* Module Resolution Options */
    "esModuleInterop": true,               // Tương thích import ES6
    "skipLibCheck": true,                  // Bỏ qua check thư viện bên ngoài
    "forceConsistentCasingInFileNames": true,
    
    /* Advanced Options */
    "resolveJsonModule": true,             // Cho phép import JSON
    "moduleResolution": "node"             // Cách resolve modules như Node.js
  },
  "include": ["src/**/*"],                 // Files cần compile
  "exclude": ["node_modules", "**/*.test.ts"] // Files bỏ qua
}
```

### 6.3. Cấu Hình Cho Các Môi Trường Khác Nhau

**Cho Node.js**

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "types": ["node"]
  }
}
```

**Cho React**

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "jsx": "react-jsx",
    "module": "esnext",
    "moduleResolution": "node",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

### 6.4. Scripts Package.json

```json
{
  "scripts": {
    "build": "tsc",
    "watch": "tsc --watch",
    "start": "node dist/index.js",
    "dev": "ts-node src/index.ts"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "ts-node": "^10.9.0",
    "@types/node": "^20.0.0"
  }
}
```

## 7. So Sánh Trước/Sau - Ví Dụ Thực Tế

### 7.1. Định Nghĩa Hàm

**JavaScript - Trước**

```javascript
// JavaScript - không rõ kiểu input/output
function calculateTotal(items, tax) {
  const subtotal = items.reduce((sum, item) => sum + item.price * item.quantity, 0);
  return subtotal * (1 + tax);
}

const total = calculateTotal([
  { price: 10, quantity: 2 },
  { price: 15, quantity: 1 }
], 0.1);
```

**TypeScript - Sau**

```typescript
// TypeScript - rõ ràng và an toàn
interface CartItem {
  price: number;
  quantity: number;
}

function calculateTotal(items: CartItem[], tax: number): number {
  const subtotal = items.reduce((sum, item) => sum + item.price * item.quantity, 0);
  return subtotal * (1 + tax);
}

const total = calculateTotal([
  { price: 10, quantity: 2 },
  { price: 15, quantity: 1 }
], 0.1);

// ❌ Lỗi nếu truyền sai kiểu
calculateTotal("wrong", 0.1); // Lỗi compile-time
```

### 7.2. Tạo Object và Class

**JavaScript - Trước**

```javascript
// JavaScript - Factory function
function createProduct(id, name, price) {
  return {
    id: id,
    name: name,
    price: price,
    getDiscountedPrice(discount) {
      return this.price * (1 - discount);
    }
  };
}

const product = createProduct(1, "Laptop", 1000);
```

**TypeScript - Sau (Cách 1: Interface + Function)**

```typescript
interface Product {
  id: number;
  name: string;
  price: number;
  getDiscountedPrice(discount: number): number;
}

function createProduct(id: number, name: string, price: number): Product {
  return {
    id,
    name,
    price,
    getDiscountedPrice(discount: number): number {
      return this.price * (1 - discount);
    }
  };
}

const product = createProduct(1, "Laptop", 1000);
console.log(product.getDiscountedPrice(0.1)); // ✅ Autocomplete hoạt động
```

**TypeScript - Sau (Cách 2: Class)**

```typescript
class Product {
  constructor(
    public id: number,
    public name: string,
    public price: number
  ) {}

  getDiscountedPrice(discount: number): number {
    return this.price * (1 - discount);
  }
}

const product = new Product(1, "Laptop", 1000);
console.log(product.getDiscountedPrice(0.1));
```

### 7.3. Async/Await và Promises

**JavaScript - Trước**

```javascript
// JavaScript
async function fetchUser(userId) {
  const response = await fetch(`/api/users/${userId}`);
  const data = await response.json();
  return data;
}

fetchUser(1).then(user => {
  console.log(user.name); // Không biết user có thuộc tính gì
});
```

**TypeScript - Sau**

```typescript
interface User {
  id: number;
  name: string;
  email: string;
}

async function fetchUser(userId: number): Promise<User> {
  const response = await fetch(`/api/users/${userId}`);
  const data: User = await response.json();
  return data;
}

// TypeScript biết chính xác kiểu của user
fetchUser(1).then((user: User) => {
  console.log(user.name);  // ✅ Autocomplete
  console.log(user.age);   // ❌ Lỗi - property không tồn tại
});
```

### 7.4. Xử Lý Mảng và Higher-Order Functions

**JavaScript - Trước**

```javascript
// JavaScript
const users = [
  { name: "Alice", age: 25 },
  { name: "Bob", age: 30 },
  { name: "Charlie", age: 35 }
];

const names = users.map(user => user.name);
const adults = users.filter(user => user.age >= 18);
```

**TypeScript - Sau**

```typescript
interface User {
  name: string;
  age: number;
}

const users: User[] = [
  { name: "Alice", age: 25 },
  { name: "Bob", age: 30 },
  { name: "Charlie", age: 35 }
];

// TypeScript infer kiểu tự động
const names: string[] = users.map(user => user.name);
const adults: User[] = users.filter(user => user.age >= 18);

// ❌ Lỗi nếu truy cập property không tồn tại
const ids = users.map(user => user.id); // Lỗi: property 'id' không tồn tại
```

## 8. Các Tình Huống Thực Tế

### 8.1. Form Handling

**JavaScript - Trước**

```javascript
function handleSubmit(formData) {
  const errors = {};
  
  if (!formData.email) {
    errors.email = "Email is required";
  }
  
  if (formData.age < 18) {
    errors.age = "Must be 18 or older";
  }
  
  return errors;
}
```

**TypeScript - Sau**

```typescript
interface FormData {
  email: string;
  password: string;
  age: number;
}

interface FormErrors {
  email?: string;
  password?: string;
  age?: string;
}

function handleSubmit(formData: FormData): FormErrors {
  const errors: FormErrors = {};
  
  if (!formData.email) {
    errors.email = "Email is required";
  }
  
  if (formData.age < 18) {
    errors.age = "Must be 18 or older";
  }
  
  return errors;
}

// ❌ Lỗi nếu thiếu field bắt buộc
handleSubmit({ email: "test@test.com" }); // Lỗi: thiếu 'age' và 'password'
```

### 8.2. State Management (React)

**JavaScript - Trước**

```javascript
import { useState } from 'react';

function UserProfile() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);
  
  // Không rõ structure của user
  return <div>{user?.name}</div>;
}
```

**TypeScript - Sau**

```typescript
import { useState } from 'react';

interface User {
  id: number;
  name: string;
  email: string;
}

function UserProfile() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  
  // TypeScript biết user có thể null hoặc User
  return (
    <div>
      {user?.name} {/* ✅ Autocomplete */}
      {user?.invalidProp} {/* ❌ Lỗi */}
    </div>
  );
}
```

## 9. Tips và Best Practices

### 9.1. Khi Migration Từ JavaScript

1. **Bật TypeScript Dần Dần**: Đổi từng file `.js` thành `.ts`, không cần làm hết cùng lúc
2. **Bắt Đầu Với `strict: false`**: Sau đó từ từ bật các strict options
3. **Sử Dụng `any` Tạm Thời**: Khi migration, dùng `any` cho phần chưa rõ kiểu, sau đó fix dần
4. **Cài Types Cho Libraries**: `npm install --save-dev @types/[library-name]`

### 9.2. Best Practices

```typescript
// ✅ DO: Sử dụng type inference khi có thể
const name = "Alice"; // TypeScript biết đây là string

// ❌ DON'T: Khai báo kiểu thừa
const name: string = "Alice"; // Không cần thiết

// ✅ DO: Sử dụng const assertions cho objects không đổi
const config = {
  apiUrl: "https://api.example.com",
  timeout: 5000
} as const;

// ✅ DO: Ưu tiên interface cho objects public
export interface User {
  name: string;
  age: number;
}

// ✅ DO: Ưu tiên type cho unions và aliases
export type Status = "idle" | "loading" | "success" | "error";

// ❌ DON'T: Tránh any khi có thể
function process(data: any) { } // Tránh điều này

// ✅ DO: Sử dụng unknown thay thế
function process(data: unknown) {
  if (typeof data === "string") {
    // Xử lý string
  }
}
```

### 9.3. Utility Types Hữu Ích

```typescript
```typescript
interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

// Partial - Tất cả properties trở thành optional
type PartialUser = Partial<User>;
// { id?: number; name?: string; email?: string; age?: number }

function updateUser(id: number, updates: Partial<User>): void {
  // Chỉ cần truyền các field muốn update
}
updateUser(1, { name: "Alice" }); // ✅ OK

// Required - Tất cả properties bắt buộc
type RequiredUser = Required<PartialUser>;

// Pick - Chọn một số properties
type UserPreview = Pick<User, "id" | "name">;
// { id: number; name: string }

// Omit - Loại bỏ một số properties
type UserWithoutId = Omit<User, "id">;
// { name: string; email: string; age: number }

// Record - Tạo object với keys và value type cụ thể
type UserRoles = Record<string, string[]>;
const roles: UserRoles = {
  admin: ["read", "write", "delete"],
  user: ["read"]
};

// Readonly - Tất cả properties không thể thay đổi
type ReadonlyUser = Readonly<User>;
const user: ReadonlyUser = { id: 1, name: "Alice", email: "alice@test.com", age: 25 };
user.name = "Bob"; // ❌ Lỗi
```

## 10. Xử Lý Lỗi Phổ Biến

### 10.1. Type Assertions

**Khi TypeScript Không Hiểu Đúng Kiểu**

```typescript
// Trường hợp: DOM elements
const input = document.getElementById("username"); // HTMLElement | null
input.value = "Alice"; // ❌ Lỗi: Property 'value' does not exist on type 'HTMLElement'

// Giải pháp 1: Type assertion
const input = document.getElementById("username") as HTMLInputElement;
input.value = "Alice"; // ✅ OK

// Giải pháp 2: Type guard
const input = document.getElementById("username");
if (input instanceof HTMLInputElement) {
  input.value = "Alice"; // ✅ OK
}
```

**Non-null Assertion (!)**

```typescript
// Khi bạn chắc chắn giá trị không null/undefined
const user = users.find(u => u.id === 1);
console.log(user.name); // ❌ Lỗi: Object is possibly 'undefined'

// Sử dụng ! (chỉ khi chắc chắn)
console.log(user!.name); // ✅ OK, nhưng nguy hiểm nếu user undefined

// An toàn hơn: Optional chaining
console.log(user?.name); // ✅ OK và an toàn
```

### 10.2. Working With External Libraries

**Khi Library Không Có Types**

```bash
# Tìm types từ DefinitelyTyped
npm install --save-dev @types/lodash
npm install --save-dev @types/express
npm install --save-dev @types/node
```

**Khi Library Không Có Types Available**

```typescript
// Tạo file declarations.d.ts
declare module 'my-untyped-library' {
  export function doSomething(param: string): number;
}

// Hoặc dùng any tạm thời
declare module 'my-untyped-library';
```

### 10.3. Discriminated Unions - Pattern Mạnh Mẽ

```typescript
// Thay vì dùng optional properties không rõ ràng
interface Response {
  success: boolean;
  data?: User;
  error?: string;
}

// ✅ Dùng Discriminated Union tốt hơn
type SuccessResponse = {
  success: true;
  data: User;
};

type ErrorResponse = {
  success: false;
  error: string;
};

type Response = SuccessResponse | ErrorResponse;

function handleResponse(response: Response) {
  if (response.success) {
    // TypeScript biết đây là SuccessResponse
    console.log(response.data.name); // ✅ OK
    // console.log(response.error); // ❌ Lỗi - không có error property
  } else {
    // TypeScript biết đây là ErrorResponse
    console.log(response.error); // ✅ OK
    // console.log(response.data); // ❌ Lỗi - không có data property
  }
}
```

## 11. Advanced Patterns

### 11.1. Function Overloading

```typescript
// JavaScript - một hàm nhiều cách dùng
function createElement(tag) {
  return document.createElement(tag);
}

// TypeScript - Function overloading
function createElement(tag: "div"): HTMLDivElement;
function createElement(tag: "input"): HTMLInputElement;
function createElement(tag: "button"): HTMLButtonElement;
function createElement(tag: string): HTMLElement;
function createElement(tag: string): HTMLElement {
  return document.createElement(tag);
}

// TypeScript biết chính xác return type
const div = createElement("div");     // HTMLDivElement
const input = createElement("input"); // HTMLInputElement
const button = createElement("button"); // HTMLButtonElement
```

### 11.2. Mapped Types

```typescript
interface User {
  id: number;
  name: string;
  email: string;
}

// Tạo type với tất cả properties là optional và nullable
type NullableUser = {
  [K in keyof User]?: User[K] | null;
};

// Kết quả:
// {
//   id?: number | null;
//   name?: string | null;
//   email?: string | null;
// }

// Ví dụ thực tế: Form errors
type FormErrors<T> = {
  [K in keyof T]?: string;
};

interface LoginForm {
  username: string;
  password: string;
}

const errors: FormErrors<LoginForm> = {
  username: "Username is required",
  // password optional
};
```

### 11.3. Conditional Types

```typescript
// Type thay đổi dựa trên condition
type IsString<T> = T extends string ? true : false;

type A = IsString<string>; // true
type B = IsString<number>; // false

// Ví dụ thực tế: API Response type
type ApiResponse<T> = T extends { id: number }
  ? { success: true; data: T }
  : { success: false; error: string };

interface User {
  id: number;
  name: string;
}

type UserResponse = ApiResponse<User>;
// { success: true; data: User }

type InvalidResponse = ApiResponse<string>;
// { success: false; error: string }
```

## 12. Testing Với TypeScript

### 12.1. Jest với TypeScript

**Cài Đặt**

```bash
npm install --save-dev jest @types/jest ts-jest
npx ts-jest config:init
```

**Test File**

```typescript
// sum.ts
export function sum(a: number, b: number): number {
  return a + b;
}

// sum.test.ts
import { sum } from './sum';

describe('sum function', () => {
  it('should add two numbers correctly', () => {
    expect(sum(2, 3)).toBe(5);
  });

  it('should handle negative numbers', () => {
    expect(sum(-1, -2)).toBe(-3);
  });
});
```

**Mock Với Types**

```typescript
interface User {
  id: number;
  name: string;
}

interface UserService {
  getUser(id: number): Promise<User>;
}

// Mock với proper typing
const mockUserService: jest.Mocked<UserService> = {
  getUser: jest.fn()
};

// Test
it('should fetch user', async () => {
  mockUserService.getUser.mockResolvedValue({
    id: 1,
    name: "Alice"
  });

  const user = await mockUserService.getUser(1);
  expect(user.name).toBe("Alice");
});
```

## 13. TypeScript Với Các Frameworks

### 13.1. React + TypeScript

**Functional Component**

```typescript
import React, { useState } from 'react';

interface ButtonProps {
  label: string;
  onClick: () => void;
  disabled?: boolean;
  variant?: "primary" | "secondary";
}

// Cách 1: Function Declaration
function Button({ label, onClick, disabled = false, variant = "primary" }: ButtonProps) {
  return (
    <button onClick={onClick} disabled={disabled} className={variant}>
      {label}
    </button>
  );
}

// Cách 2: Arrow Function với React.FC
const Button: React.FC<ButtonProps> = ({ label, onClick, disabled = false, variant = "primary" }) => {
  return (
    <button onClick={onClick} disabled={disabled} className={variant}>
      {label}
    </button>
  );
};

// Sử dụng
function App() {
  const handleClick = () => {
    console.log("Clicked!");
  };

  return (
    <div>
      <Button label="Click me" onClick={handleClick} variant="primary" />
    </div>
  );
}
```

**Hooks Với TypeScript**

```typescript
import { useState, useEffect, useRef } from 'react';

interface User {
  id: number;
  name: string;
  email: string;
}

function UserProfile({ userId }: { userId: number }) {
  // useState với explicit type
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  
  // useRef với HTMLElement
  const inputRef = useRef<HTMLInputElement>(null);
  
  useEffect(() => {
    const fetchUser = async () => {
      setLoading(true);
      try {
        const response = await fetch(`/api/users/${userId}`);
        const data: User = await response.json();
        setUser(data);
      } catch (error) {
        console.error(error);
      } finally {
        setLoading(false);
      }
    };
    
    fetchUser();
  }, [userId]);
  
  const focusInput = () => {
    inputRef.current?.focus(); // Optional chaining vì có thể null
  };
  
  if (loading) return <div>Loading...</div>;
  if (!user) return <div>No user found</div>;
  
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
      <input ref={inputRef} type="text" />
      <button onClick={focusInput}>Focus Input</button>
    </div>
  );
}
```

**Custom Hooks**

```typescript
import { useState, useEffect } from 'react';

// Custom hook với generic type
function useFetch<T>(url: string): {
  data: T | null;
  loading: boolean;
  error: Error | null;
} {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<Error | null>(null);
  
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(url);
        const json: T = await response.json();
        setData(json);
      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    };
    
    fetchData();
  }, [url]);
  
  return { data, loading, error };
}

// Sử dụng
interface Post {
  id: number;
  title: string;
  body: string;
}

function PostList() {
  const { data, loading, error } = useFetch<Post[]>('/api/posts');
  
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  
  return (
    <ul>
      {data?.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}
```

### 13.2. Express + TypeScript

```typescript
import express, { Request, Response, NextFunction } from 'express';

const app = express();
app.use(express.json());

// Định nghĩa types cho request body
interface CreateUserBody {
  name: string;
  email: string;
  age: number;
}

interface UserParams {
  id: string;
}

// Route với typed request/response
app.post('/users', (
  req: Request<{}, {}, CreateUserBody>,
  res: Response
) => {
  const { name, email, age } = req.body;
  
  // Validation
  if (!name || !email || age < 18) {
    return res.status(400).json({ error: "Invalid data" });
  }
  
  // Create user logic
  const user = { id: 1, name, email, age };
  res.status(201).json(user);
});

// Route với params
app.get('/users/:id', (
  req: Request<UserParams>,
  res: Response
) => {
  const userId = parseInt(req.params.id);
  
  // Fetch user logic
  const user = { id: userId, name: "Alice", email: "alice@test.com" };
  res.json(user);
});

// Middleware với types
const authMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  const token = req.headers.authorization;
  
  if (!token) {
    res.status(401).json({ error: "Unauthorized" });
    return;
  }
  
  next();
};

app.use('/protected', authMiddleware);

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
```

## 14. Debugging và Troubleshooting

### 14.1. VS Code Tips

**Cấu Hình .vscode/settings.json**

```json
{
  "typescript.preferences.importModuleSpecifier": "relative",
  "typescript.updateImportsOnFileMove.enabled": "always",
  "typescript.suggest.autoImports": true,
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": true
  }
}
```

### 14.2. Compiler Errors Phổ Biến

**Error: Type 'X' is not assignable to type 'Y'**

```typescript
// ❌ Lỗi
interface User {
  name: string;
  age: number;
}

const user: User = {
  name: "Alice"
  // Thiếu age
};

// ✅ Fix
const user: User = {
  name: "Alice",
  age: 25
};
```

**Error: Object is possibly 'null' or 'undefined'**

```typescript
// ❌ Lỗi
const user = users.find(u => u.id === 1);
console.log(user.name); // user có thể undefined

// ✅ Fix 1: Optional chaining
console.log(user?.name);

// ✅ Fix 2: Guard clause
if (user) {
  console.log(user.name);
}

// ✅ Fix 3: Nullish coalescing
const name = user?.name ?? "Unknown";
```

**Error: Property 'X' does not exist on type 'Y'**

```typescript
// ❌ Lỗi
interface User {
  name: string;
}

const user: User = { name: "Alice" };
console.log(user.age); // age không tồn tại

// ✅ Fix: Thêm property vào interface
interface User {
  name: string;
  age?: number; // Optional nếu không bắt buộc
}
```

## 15. Kết Luận và Bước Tiếp Theo

### 15.1. Checklist Học TypeScript

- ✅ Hiểu lợi ích của TypeScript (static typing, early error detection)
- ✅ Nắm vững các kiểu cơ bản (string, number, boolean, array)
- ✅ Phân biệt Interface vs Type và biết khi nào dùng cái nào
- ✅ Sử dụng Generics để tạo code linh hoạt
- ✅ Hiểu Enums và Union Types
- ✅ Thiết lập tsconfig.json đúng cách
- ✅ Thực hành với các ví dụ thực tế

### 15.2. Tài Nguyên Học Thêm

**Official Documentation**
- TypeScript Handbook: https://www.typescriptlang.org/docs/handbook/
- TypeScript Playground: https://www.typescriptlang.org/play

**Courses và Tutorials**
- Matt Pocock's TypeScript course
- Execute Program - TypeScript track
- Frontend Masters - TypeScript courses

**Practice**
- Type Challenges: https://github.com/type-challenges/type-challenges
- Exercism TypeScript track

### 15.3. Migration Strategy

**Bước 1: Chuẩn Bị**
- Cài đặt TypeScript và @types packages
- Tạo tsconfig.json với strict: false
- Đổi một file test từ .js sang .ts

**Bước 2: Migration Dần Dần**
- Bắt đầu với utility functions và helpers
- Tiếp theo là models và interfaces
- Sau đó là business logic
- Cuối cùng là UI components

**Bước 3: Tăng Strictness**
- Bật noImplicitAny
- Bật strictNullChecks
- Bật tất cả strict options

**Bước 4: Refactor và Optimize**
- Loại bỏ any không cần thiết
- Sử dụng Utility Types
- Tối ưu type inference

### 15.4. Lời Khuyên Cuối

1. **Đừng Sợ Lỗi Compiler**: Lỗi TypeScript là bạn của bạn, giúp bạn tìm bug sớm
2. **Bắt Đầu Nhỏ**: Không cần convert toàn bộ codebase cùng lúc
3. **Đọc Error Messages**: TypeScript error messages rất chi tiết và hữu ích
4. **Sử Dụng IDE**: VS Code với TypeScript là combo hoàn hảo
5. **Thực Hành Thường Xuyên**: TypeScript có learning curve, nhưng sẽ trở nên tự nhiên sau một thời gian

---

**Chúc bạn thành công trong hành trình chuyển đổi từ JavaScript sang TypeScript! 🚀**
