import { createApp } from './app.js';
import { connectMongo, disconnectMongo } from './config/db.js';
import { env } from './config/env.js';

const app = createApp();

let server;

async function start() {
  await connectMongo();

  server = app.listen(env.port, () => {
    console.log(`API listening on http://localhost:${env.port}`);
  });
}

async function shutdown(signal) {
  console.log(`${signal} received. Closing API server...`);
  if (server) {
    server.close(async () => {
      await disconnectMongo();
      process.exit(0);
    });
    return;
  }
  await disconnectMongo();
  process.exit(0);
}

process.on('SIGINT', () => shutdown('SIGINT'));
process.on('SIGTERM', () => shutdown('SIGTERM'));

start().catch((error) => {
  console.error('Failed to start API server:', error);
  process.exit(1);
});
