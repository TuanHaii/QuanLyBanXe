# Mobile API Endpoints

Tai lieu nay mo ta contract API hien tai de team mobile tich hop nhanh va dung schema.

## 1) Base URL

- Local: `http://localhost:3000/api`
- Port co the thay doi qua bien moi truong `APP_PORT`.

## 2) Headers

- `Content-Type: application/json`
- Endpoint can auth them:
  - `Authorization: Bearer <JWT_TOKEN>`

## 3) Response Format

### Success response

Tat ca API thanh cong hien tai deu tra HTTP `200`.

```json
{
  "success": true,
  "message": "Success message",
  "data": {}
}
```

### Error response

```json
{
  "success": false,
  "message": "Error message",
  "errors": null
}
```

Ma loi thuong gap:

- `400`: Invalid input / missing field
- `401`: Unauthorized / token invalid
- `404`: Not found
- `409`: Conflict (vi du email da ton tai)
- `500`: Internal server error

## 4) Endpoint Summary

| Module | Method | Path | Auth | Muc dich |
|---|---|---|---|---|
| Health | GET | `/health` | No | Kiem tra service |
| Example | GET | `/example` | No | Du lieu mau |
| Auth | POST | `/auth/register` | No | Dang ky |
| Auth | POST | `/auth/login` | No | Dang nhap |
| Auth | POST | `/auth/logout` | Yes | Dang xuat |
| Auth | POST | `/auth/forgot-password` | No | Tao reset token |
| Auth | POST | `/auth/reset-password` | No | Dat lai mat khau |
| Auth | GET | `/auth/profile` | Yes | Lay profile |
| Auth | PUT | `/auth/profile` | Yes | Cap nhat profile |
| Cars | GET | `/cars` | No | Danh sach xe |
| Cars | GET | `/cars/:id` | No | Chi tiet xe |
| Cars | POST | `/cars` | Yes | Tao xe moi |
| Cars | PUT | `/cars/:id` | Yes | Cap nhat xe |
| Cars | DELETE | `/cars/:id` | Yes | Xoa xe |
| Mall | GET | `/mall` | No | Danh sach san pham cho mobile |
| Sales | GET | `/sales` | No | Danh sach sale |
| Sales | GET | `/sales/:id` | No | Chi tiet sale |
| Sales | POST | `/sales` | Yes | Tao sale |
| Sales | PUT | `/sales/:id` | Yes | Cap nhat sale |
| Sales | DELETE | `/sales/:id` | Yes | Xoa sale |

## 5) Endpoint Details

### 5.1 Health

#### GET `/health`

- Auth: No
- Request body: none

Sample response:

```json
{
  "success": true,
  "message": "Service is healthy",
  "data": {
    "status": "healthy",
    "uptime": 123.456,
    "timestamp": "2026-04-21T12:34:56.000Z"
  }
}
```

### 5.2 Example

#### GET `/example`

- Auth: No
- Request body: none

Sample response:

```json
{
  "success": true,
  "message": "Example data loaded",
  "data": {
    "example": true,
    "name": "BE_QLBX Example",
    "config": {
      "id": "string",
      "name": "string",
      "createdAt": "string"
    }
  }
}
```

### 5.3 Auth

#### POST `/auth/register`

- Auth: No

Request body:

```json
{
  "name": "Nguyen Van A",
  "email": "a@example.com",
  "password": "Password123!",
  "phone": "0901234567"
}
```

Required fields: `name`, `email`, `password`, `phone`.

Success data:

```json
{
  "token": "<jwt_token>",
  "user": {
    "id": "uuid",
    "name": "Nguyen Van A",
    "email": "a@example.com",
    "phone": "0901234567",
    "role": "user",
    "createdAt": "2026-04-21T12:34:56.000Z",
    "updatedAt": "2026-04-21T12:34:56.000Z"
  }
}
```

Possible errors:

- `400`: Missing required registration fields
- `409`: Email is already registered

#### POST `/auth/login`

- Auth: No

Request body:

```json
{
  "email": "a@example.com",
  "password": "Password123!"
}
```

Required fields: `email`, `password`.

Success data: giong `register` (`token` + `user`).

Possible errors:

- `400`: Email and password are required
- `401`: Invalid email or password

#### POST `/auth/logout`

- Auth: Yes
- Request body: none

Success data:

```json
{
  "message": "Logout successful"
}
```

Possible errors:

- `401`: Missing/invalid bearer token

#### POST `/auth/forgot-password`

- Auth: No

Request body:

```json
{
  "email": "a@example.com"
}
```

Required fields: `email`.

Success data (hien tai co tra `resetToken` de test):

```json
{
  "message": "If the email is registered, a reset link has been sent",
  "resetToken": "optional_token_for_testing"
}
```

Possible errors:

- `400`: Email is required

#### POST `/auth/reset-password`

- Auth: No

Request body:

```json
{
  "token": "reset_token",
  "password": "NewPassword123!"
}
```

Required fields: `token`, `password`.

Success data:

```json
{
  "message": "Password has been reset successfully"
}
```

Possible errors:

- `400`: Token and password are required
- `400`: Reset token is invalid or expired

#### GET `/auth/profile`

- Auth: Yes
- Request body: none

Success data:

```json
{
  "id": "uuid",
  "name": "Nguyen Van A",
  "email": "a@example.com",
  "phone": "0901234567",
  "role": "user",
  "createdAt": "2026-04-21T12:34:56.000Z",
  "updatedAt": "2026-04-21T12:34:56.000Z"
}
```

Possible errors:

- `401`: Missing/invalid bearer token
- `404`: User not found

#### PUT `/auth/profile`

- Auth: Yes

Request body (chi update cac field hop le):

```json
{
  "name": "Nguyen Van B",
  "phone": "0911222333",
  "email": "b@example.com"
}
```

Allowed fields: `name`, `phone`, `email`.

Possible errors:

- `400`: No valid fields provided for profile update
- `409`: Email is already in use
- `401`: Missing/invalid bearer token

### 5.4 Cars

#### Car object

```json
{
  "id": "uuid",
  "brand": "Toyota",
  "model": "Camry",
  "category": "Sedan",
  "year": 2024,
  "price": 1200000000,
  "status": "available",
  "stock": 5,
  "rating": 4.7,
  "imageUrl": "https://...",
  "badgeLabel": "Hot",
  "badgeColor": "#FF4D4F",
  "description": "...",
  "createdBy": "user_uuid",
  "createdAt": "2026-04-21T12:34:56.000Z",
  "updatedAt": "2026-04-21T12:34:56.000Z"
}
```

#### GET `/cars`

- Auth: No
- Query params: none (API nay chua loc theo query/category)
- Success data: `Car[]`

#### GET `/cars/:id`

- Auth: No
- Success data: `Car`
- Errors:
  - `404`: Car not found

#### POST `/cars`

- Auth: Yes

Request body:

```json
{
  "brand": "Toyota",
  "model": "Camry",
  "category": "Sedan",
  "year": 2024,
  "price": 1200000000,
  "status": "available",
  "stock": 5,
  "rating": 4.7,
  "imageUrl": "https://...",
  "badgeLabel": "New",
  "badgeColor": "#1677FF",
  "description": "Mau moi"
}
```

Required fields: `brand`, `model`.
Default values neu bo trong:

- `category`: `Sedan`
- `status`: `available`
- `stock`: `0`
- `rating`: `0`

Errors:

- `400`: Brand and model are required
- `401`: Missing/invalid bearer token

#### PUT `/cars/:id`

- Auth: Yes

Allowed update fields:

- `brand`, `model`, `category`, `year`, `price`, `status`, `stock`, `rating`, `imageUrl`, `badgeLabel`, `badgeColor`, `description`

Errors:

- `400`: No valid fields provided for car update
- `404`: Car not found
- `401`: Missing/invalid bearer token

#### DELETE `/cars/:id`

- Auth: Yes
- Success data:

```json
{
  "message": "Car deleted successfully"
}
```

Errors:

- `404`: Car not found
- `401`: Missing/invalid bearer token

### 5.5 Mall

#### GET `/mall`

- Auth: No
- Query params:
  - `category` (optional): loc chinh xac theo category
  - `query` (optional): tim kiem theo `brand`/`model`/`description` (khong phan biet hoa thuong)
- Success data: `Car[]`

Vi du:

- `/mall?category=Sedan`
- `/mall?query=toyota`
- `/mall?category=SUV&query=hyundai`

### 5.6 Sales

#### Sale object

```json
{
  "id": "uuid",
  "carName": "Toyota Camry",
  "carId": "car_uuid",
  "customerName": "Tran Van C",
  "customerId": "KH001",
  "customerPhone": "0909000000",
  "customerEmail": "c@example.com",
  "salePrice": 1200000000,
  "discount": 10000000,
  "deposit": 50000000,
  "saleDate": "2026-04-21T10:00:00.000Z",
  "notes": "Thanh toan dot 1",
  "status": "pending",
  "createdAt": "2026-04-21T12:34:56.000Z",
  "updatedAt": "2026-04-21T12:34:56.000Z"
}
```

#### GET `/sales`

- Auth: No
- Query params:
  - `status` (optional): loc theo status
  - `query` (optional): tim theo `car_name`, `customer_name`, `customer_phone`, `customer_email`
- Success data: `Sale[]`

#### GET `/sales/:id`

- Auth: No
- Success data: `Sale`
- Errors:
  - `404`: Sale not found

#### POST `/sales`

- Auth: Yes

Request body:

```json
{
  "carName": "Toyota Camry",
  "carId": "car_uuid",
  "customerName": "Tran Van C",
  "customerId": "KH001",
  "customerPhone": "0909000000",
  "customerEmail": "c@example.com",
  "salePrice": 1200000000,
  "discount": 10000000,
  "deposit": 50000000,
  "saleDate": "2026-04-21T10:00:00.000Z",
  "notes": "Thanh toan dot 1",
  "status": "pending"
}
```

Required fields: `carName`, `customerName`, `salePrice`, `saleDate`.
Default value:

- `status`: `pending`

Errors:

- `400`: carName, customerName, salePrice and saleDate are required
- `401`: Missing/invalid bearer token

#### PUT `/sales/:id`

- Auth: Yes

Allowed update fields:

- `carName`, `carId`, `customerName`, `customerId`, `customerPhone`, `customerEmail`, `salePrice`, `discount`, `deposit`, `saleDate`, `notes`, `status`

Errors:

- `400`: No valid fields provided for sale update
- `404`: Sale not found
- `401`: Missing/invalid bearer token

#### DELETE `/sales/:id`

- Auth: Yes
- Success data:

```json
{
  "message": "Sale deleted successfully"
}
```

Errors:

- `404`: Sale not found
- `401`: Missing/invalid bearer token

## 6) Integration Notes For Mobile

- Luu `token` sau `login/register` va gui qua header `Authorization` cho endpoint can auth.
- Khi token het han hoac sai, backend tra `401` voi `success: false`.
- Cac endpoint tao/sua/xoa dang tra `200` (khong dung `201`/`204`). Mobile nen rely vao `success` + `message` + `data`.
- `forgot-password` dang tra `resetToken` de test nhanh. Neu deploy production, nen gui token qua email thay vi tra truc tiep.
