import mongoose from 'mongoose';

import { env } from './env.js';

export async function connectMongo() {
  mongoose.set('strictQuery', true);

  await mongoose.connect(env.mongodbUri, {
    serverSelectionTimeoutMS: env.mongoServerSelectionTimeoutMs,
  });
  console.log(`MongoDB connected: ${mongoose.connection.name}`);
}

export async function disconnectMongo() {
  await mongoose.disconnect();
  console.log('MongoDB disconnected');
}

export function getMongoStatus() {
  const states = ['disconnected', 'connected', 'connecting', 'disconnecting'];
  return {
    state: states[mongoose.connection.readyState] || 'unknown',
    database: mongoose.connection.name || null,
    host: mongoose.connection.host || null,
  };
}
