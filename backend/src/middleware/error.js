export function notFoundHandler(req, res) {
  res.status(404).json({
    error: 'Not Found',
    message: `Route ${req.method} ${req.originalUrl} does not exist`,
  });
}

export function errorHandler(error, req, res, next) {
  if (res.headersSent) {
    return next(error);
  }

  const status = error.statusCode || error.status || 500;
  const payload = {
    error: status >= 500 ? 'Internal Server Error' : 'Request Error',
    message: error.message || 'Something went wrong',
  };

  if (process.env.NODE_ENV !== 'production') {
    payload.stack = error.stack;
  }

  return res.status(status).json(payload);
}
