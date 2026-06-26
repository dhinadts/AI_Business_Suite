import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import morgan from 'morgan';

import { env } from './config/env.js';
import { errorHandler, notFoundHandler } from './middleware/error.js';
import billsRouter from './routes/bills.routes.js';
import healthRouter from './routes/health.routes.js';
import productsRouter from './routes/products.routes.js';

export function createApp() {
  const app = express();

  app.use(helmet());
  app.use(cors({ origin: env.corsOrigins, credentials: true }));
  app.use(express.json({ limit: '1mb' }));
  app.use(morgan(env.nodeEnv === 'production' ? 'combined' : 'dev'));

  app.get('/', (req, res) => {
    res.json({
      name: 'AI Business Suite API',
      status: 'ok',
      routes: ['/api/health', '/api/products', '/api/bills'],
    });
  });

  app.use('/api/health', healthRouter);
  app.use('/api/products', productsRouter);
  app.use('/api/bills', billsRouter);

  app.use(notFoundHandler);
  app.use(errorHandler);

  return app;
}
