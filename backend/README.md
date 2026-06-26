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

## Auth Flow

- Signup -> Company Registration -> Auto Classification -> Personalized Dashboard
- Login -> Load Company Profile -> Load UI Config -> Personalized Dashboard

## Demo Users

```text
grocery@demo.com / Password@123
small@demo.com / Password@123
medium@demo.com / Password@123
large@demo.com / Password@123
```

Each demo account maps to a different dashboard preset.

## Routes

- `POST /auth/signup`
- `POST /auth/login`
- `GET /auth/me`
- `GET /companies/me`
- `PATCH /companies/me`

## Prisma Notes

This project uses MongoDB through Prisma. MongoDB projects use:

```bash
npx prisma db push
```

instead of SQL-style migration files.
