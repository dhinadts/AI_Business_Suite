import mongoose from 'mongoose';

const billItemSchema = new mongoose.Schema(
  {
    product: { type: mongoose.Schema.Types.ObjectId, ref: 'Product', required: true },
    name: { type: String, required: true, trim: true },
    quantity: { type: Number, required: true, min: 0.001 },
    unit: { type: String, required: true, trim: true },
    rate: { type: Number, required: true, min: 0 },
    total: { type: Number, required: true, min: 0 },
  },
  { _id: false },
);

const billSchema = new mongoose.Schema(
  {
    billNumber: { type: String, required: true, unique: true, index: true },
    customerName: { type: String, default: 'Walk-in Customer', trim: true },
    customerPhone: { type: String, trim: true },
    paymentMode: {
      type: String,
      enum: ['cash', 'upi', 'card', 'credit'],
      default: 'cash',
    },
    source: {
      type: String,
      enum: ['manual', 'voice', 'barcode', 'web'],
      default: 'manual',
    },
    items: { type: [billItemSchema], validate: (items) => items.length > 0 },
    subtotal: { type: Number, required: true, min: 0 },
    discount: { type: Number, default: 0, min: 0 },
    grandTotal: { type: Number, required: true, min: 0 },
    status: {
      type: String,
      enum: ['draft', 'paid', 'credit'],
      default: 'paid',
    },
  },
  { timestamps: true },
);

export const Bill = mongoose.model('Bill', billSchema);
