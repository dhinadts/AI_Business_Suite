class Customer {
  const Customer(
    this.name,
    this.company,
    this.phone,
    this.status,
    this.revenue,
  );
  final String name;
  final String company;
  final String phone;
  final String status;
  final double revenue;
}

class Product {
  const Product(this.name, this.sku, this.stock, this.price, this.status);
  final String name;
  final String sku;
  final int stock;
  final double price;
  final String status;

  Product copyWith({int? stock, double? price, String? status}) {
    return Product(
      name,
      sku,
      stock ?? this.stock,
      price ?? this.price,
      status ?? this.status,
    );
  }
}

class Invoice {
  const Invoice(
    this.number,
    this.customer,
    this.amount,
    this.status,
    this.date,
  );
  final String number;
  final String customer;
  final double amount;
  final String status;
  final String date;
}

class StockIntakeItem {
  const StockIntakeItem(
    this.product,
    this.invoice,
    this.quantity,
    this.unit,
    this.purchaseRate,
    this.salePrice,
    this.destination,
    this.status,
  );
  final String product;
  final String invoice;
  final double quantity;
  final String unit;
  final double purchaseRate;
  final double salePrice;
  final String destination;
  final String status;
}

class SaleDeductionRule {
  const SaleDeductionRule(
    this.invoiceType,
    this.stockSource,
    this.deduction,
    this.status,
  );
  final String invoiceType;
  final String stockSource;
  final String deduction;
  final String status;
}

class VoiceBillLine {
  const VoiceBillLine(this.product, this.quantity, this.unit, this.rate);

  final String product;
  final double quantity;
  final String unit;
  final double rate;

  double get total => quantity * rate;
}

class PrinterRecommendation {
  const PrinterRecommendation(
    this.name,
    this.range,
    this.connectivity,
    this.bestFor,
    this.note,
  );

  final String name;
  final String range;
  final String connectivity;
  final String bestFor;
  final String note;
}

class ReportMetric {
  const ReportMetric(this.label, this.value, this.delta, this.chartValues);
  final String label;
  final String value;
  final String delta;
  final List<double> chartValues;
}

class TeamMember {
  const TeamMember(this.name, this.role, this.email, this.status);
  final String name;
  final String role;
  final String email;
  final String status;
}

class GSTReturn {
  const GSTReturn(this.period, this.type, this.status, this.taxableValue);
  final String period;
  final String type;
  final String status;
  final double taxableValue;
}

class NotificationItem {
  const NotificationItem(this.title, this.body, this.time);
  final String title;
  final String body;
  final String time;
}

class ChatMessage {
  const ChatMessage(this.sender, this.message, {this.isAi = false});
  final String sender;
  final String message;
  final bool isAi;
}
