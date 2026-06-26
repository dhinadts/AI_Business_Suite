# AI Business Suite Backend

NestJS + Prisma + MongoDB backend for authentication, company registration, business classification, and UI personalization.

## Setup

```bash
cd backend
npm install
copy .env.example .env
npx prisma generate
npx prisma db push
npm run seed
npm run start:dev
```

For production/live MongoDB, keep the database name in the connection string:

```text
mongodb+srv://USER:PASSWORD@HOST/ai_business_suite?retryWrites=true&w=majority
```

API:

```text
http://localhost:4000
```

Swagger:

```text
http://localhost:4000/docs
```

## Environment

```text
PORT=4000
DATABASE_URL=mongodb://127.0.0.1:27017/ai_business_suite
JWT_SECRET=change-this-secret-in-production
JWT_EXPIRES_IN=7d
CORS_ORIGIN=http://127.0.0.1:5173,http://127.0.0.1:5175,http://localhost:5173,http://localhost:5175
```

## Render Deployment

Use these settings for the backend service:

```text
Root Directory: backend
Build Command: npm install && npm run render:build
Start Command: npm run start
```

Set these Render environment variables:

```text
DATABASE_URL=<your live MongoDB connection string with /ai_business_suite>
JWT_SECRET=<strong production secret>
JWT_EXPIRES_IN=7d
CORS_ORIGIN=<your Flutter web/PWA URL>
PORT=4000
```

`npm run render:build` performs all backend deployment preparation:

- normalizes an Atlas URL that is missing `/ai_business_suite`
- runs `prisma generate`
- runs `prisma db push --skip-generate`
- builds NestJS

If the `ai_business_suite` database or required collections do not exist, Prisma `db push` creates them from `prisma/schema.prisma`.

After changing the live database schema manually, you can also run from this folder:

```bash
npx prisma db push --skip-generate
npm run seed
```

MongoDB Atlas must allow Render to connect. In Atlas, open `Network Access` and allow Render outbound access. For the simplest Render setup, add:

```text
0.0.0.0/0
```

## Live Verification Commands

Backend health:

```bash
curl https://ai-business-suite.onrender.com/health
```

Live MongoDB connection:

```bash
curl https://ai-business-suite.onrender.com/health/db
```

Expected database result:

```json
{"ok":true,"database":"connected","hasDatabaseUrl":true,"hasDatabaseName":true}
```

Demo login test:

```bash
curl -X POST https://ai-business-suite.onrender.com/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"grocery@demo.com\",\"password\":\"Password@123\"}"
```

Flutter web build using the live backend:

```bash
cd ../frontend
flutter build web --release
```

Flutter local Chrome run using the live backend:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=https://ai-business-suite.onrender.com
```

Flutter local Chrome run using a local backend:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:4000
```

## Auth Flow

- Signup -> Company Registration -> Auto Classification -> Personalized Dashboard
- Login -> Load Company Profile -> Load UI Config -> Personalized Dashboard

## Demo Users And Credentials

| Business preset | Email | Password | Notes |
| --- | --- | --- | --- |
| Grocery store | `grocery@demo.com` | `Password@123` | Association head demo account |
| Small business | `small@demo.com` | `Password@123` | MSME basic dashboard |
| Medium business | `medium@demo.com` | `Password@123` | Growth dashboard |
| Large business | `large@demo.com` | `Password@123` | Enterprise dashboard |

Each demo account maps to a different dashboard preset.

## Routes

- `POST /auth/signup`
- `POST /auth/login`
- `GET /auth/me`
- `GET /companies/me`
- `PATCH /companies/me`
- `GET /associations/me`
- `GET /associations/notifications`
- `POST /associations/device-token`
- `POST /associations/:associationId/notifications`

## Prisma Notes

This project uses MongoDB through Prisma. MongoDB projects use:

```bash
npx prisma db push
```

instead of SQL-style migration files.
