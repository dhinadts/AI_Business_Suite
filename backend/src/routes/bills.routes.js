import { Router } from 'express';
import mongoose from 'mongoose';

import { Bill } from '../models/bill.model.js';
import { Product } from '../models/product.model.js';

const router = Router();

router.get('/', async (req, res, next) => {
  try {
    const bills = await Bill.find().sort({ createdAt: -1 }).limit(100);
    res.json({ data: bills });
  } catch (error) {
    next(error);
  }
});

router.post('/', async (req, res, next) => {
  const session = await mongoose.startSession();

  try {
    const createdBill = await session.withTransaction(async () => {
      const items = await Promise.all(
        req.body.items.map(async (item) => {
          const product = await Product.findById(item.product).session(session);
          if (!product) {
            const error = new Error(`Product not found: ${item.product}`);
            error.status = 404;
            throw error;
          }

          if (product.stockQuantity < item.quantity) {
            const error = new Error(`Insufficient stock for ${product.name}`);
            error.status = 409;
            throw error;
          }

          product.stockQuantity -= Number(item.quantity);
          await product.save({ session });

          const rate = Number(item.rate ?? product.salePrice);
          const quantity = Number(item.quantity);

          return {
            product: product._id,
            name: product.name,
            quantity,
            unit: item.unit || product.unit,
            rate,
            total: Number((quantity * rate).toFixed(2)),
          };
        }),
      );

      const subtotal = items.reduce((sum, item) => sum + item.total, 0);
      const discount = Number(req.body.discount || 0);
      const grandTotal = Math.max(subtotal - discount, 0);

      const [bill] = await Bill.create(
        [
          {
            billNumber: req.body.billNumber || `BILL-${Date.now()}`,
            customerName: req.body.customerName,
            customerPhone: req.body.customerPhone,
            paymentMode: req.body.paymentMode,
            source: req.body.source,
            status: req.body.status,
            items,
            subtotal,
            discount,
            grandTotal,
          },
        ],
        { session },
      );

      return bill;
    });

    res.status(201).json({ data: createdBill });
  } catch (error) {
    next(error);
  } finally {
    await session.endSession();
  }
});

export default router;
