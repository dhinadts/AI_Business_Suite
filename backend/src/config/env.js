import dotenv from 'dotenv';

dotenv.config();

function parseOrigins(value) {
  if (!value) return true;
  return value
    .split(',')
    .map((origin) => origin.trim())
    .filter(Boolean);
}

export const env = {
  port: Number(process.env.PORT || 4000),
  nodeEnv: process.env.NODE_ENV || 'development',
  mongodbUri: process.env.MONGODB_URI || 'mongodb://127.0.0.1:27017/ai_business_suite',
  mongoServerSelectionTimeoutMs: Number(process.env.MONGO_SERVER_SELECTION_TIMEOUT_MS || 5000),
  corsOrigins: parseOrigins(process.env.CORS_ORIGIN),
};
