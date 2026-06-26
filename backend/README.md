# AI Business Suite Backend

Basic Express + MongoDB API for grocery billing and inventory.

## Setup

```bash
cd backend
npm install
copy .env.example .env
npm run dev
```

Default API URL:

```text
http://localhost:4000
```

## Environment

Set these values in `.env`:

```text
PORT=4000
MONGODB_URI=mongodb://127.0.0.1:27017/ai_business_suite
CORS_ORIGIN=http://127.0.0.1:5173,http://127.0.0.1:5175,http://localhost:5173,http://localhost:5175
```

## Routes

- `GET /api/health` - app and MongoDB status
- `GET /api/health/ready` - readiness check
- `GET /api/products` - list products
- `POST /api/products` - create a product
- `PATCH /api/products/:id` - update product
- `POST /api/products/:id/stock-adjustments` - increase/decrease stock
- `GET /api/bills` - list bills
- `POST /api/bills` - create bill and reduce stock

## Example Product

```json
{
  "name": "Rice Sona Masoori 5kg",
  "sku": "GRC-RICE-5KG",
  "unit": "bag",
  "stockQuantity": 42,
  "reorderLevel": 5,
  "purchasePrice": 310,
  "salePrice": 360,
  "languageAliases": {
    "hindi": "chawal",
    "tamil": "arisi"
  }
}
```
