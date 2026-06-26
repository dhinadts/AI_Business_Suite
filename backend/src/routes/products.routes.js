import { Router } from 'express';

import { Product } from '../models/product.model.js';

const router = Router();

router.get('/', async (req, res, next) => {
  try {
    const search = req.query.search?.toString().trim();
    const filter = search
      ? {
          $or: [
            { name: new RegExp(search, 'i') },
            { barcode: new RegExp(search, 'i') },
            { sku: new RegExp(search, 'i') },
          ],
        }
      : {};

    const products = await Product.find(filter).sort({ name: 1 }).limit(100);
    res.json({ data: products });
  } catch (error) {
    next(error);
  }
});

router.post('/', async (req, res, next) => {
  try {
    const product = await Product.create(req.body);
    res.status(201).json({ data: product });
  } catch (error) {
    next(error);
  }
});

router.patch('/:id', async (req, res, next) => {
  try {
    const product = await Product.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });

    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }

    return res.json({ data: product });
  } catch (error) {
    return next(error);
  }
});

router.post('/:id/stock-adjustments', async (req, res, next) => {
  try {
    const quantity = Number(req.body.quantity || 0);
    const mode = req.body.mode === 'decrease' ? -1 : 1;

    const product = await Product.findByIdAndUpdate(
      req.params.id,
      { $inc: { stockQuantity: quantity * mode } },
      { new: true, runValidators: true },
    );

    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }

    return res.json({ data: product });
  } catch (error) {
    return next(error);
  }
});

export default router;
