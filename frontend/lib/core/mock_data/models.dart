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
