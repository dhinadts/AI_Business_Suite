import { Router } from 'express';

import { getMongoStatus } from '../config/db.js';

const router = Router();

router.get('/', (req, res) => {
  res.json({
    status: 'ok',
    uptime: process.uptime(),
    mongo: getMongoStatus(),
    timestamp: new Date().toISOString(),
  });
});

router.get('/ready', (req, res) => {
  const mongo = getMongoStatus();
  res.status(mongo.state === 'connected' ? 200 : 503).json({
    ready: mongo.state === 'connected',
    mongo,
  });
});

export default router;
