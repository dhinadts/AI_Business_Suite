import mongoose from 'mongoose';

const productSchema = new mongoose.Schema(
  {
    name: { type: String, required: true, trim: true },
    barcode: { type: String, trim: true, index: true },
    sku: { type: String, trim: true, index: true },
    unit: {
      type: String,
      enum: ['kg', 'gram', 'litre', 'ml', 'packet', 'piece', 'box', 'bag'],
      default: 'piece',
    },
    stockQuantity: { type: Number, default: 0, min: 0 },
    reorderLevel: { type: Number, default: 5, min: 0 },
    purchasePrice: { type: Number, default: 0, min: 0 },
    salePrice: { type: Number, required: true, min: 0 },
    languageAliases: {
      hindi: { type: String, trim: true },
      tamil: { type: String, trim: true },
      telugu: { type: String, trim: true },
      kannada: { type: String, trim: true },
      malayalam: { type: String, trim: true },
      marathi: { type: String, trim: true },
      bengali: { type: String, trim: true },
      gujarati: { type: String, trim: true },
    },
    isActive: { type: Boolean, default: true },
  },
  { timestamps: true },
);

productSchema.virtual('isLowStock').get(function isLowStock() {
  return this.stockQuantity <= this.reorderLevel;
});

productSchema.set('toJSON', { virtuals: true });
productSchema.set('toObject', { virtuals: true });

export const Product = mongoose.model('Product', productSchema);
