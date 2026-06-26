import 'models.dart';

const customers = [
  Customer(
    'Walk-in Customer',
    'Daily counter',
    '+91 90000 00000',
    'Active',
    84200,
  ),
  Customer(
    'Ramesh Kumar',
    'Monthly grocery account',
    '+91 97844 20310',
    'High value',
    124000,
  ),
  Customer(
    'Meena Stores',
    'Nearby tea stall',
    '+91 96635 79120',
    'Follow up',
    32650,
  ),
  Customer('Anita Devi', 'Family account', '+91 98440 76543', 'Active', 61230),
];

const products = [
  Product('Rice Sona Masoori 5kg', 'GRC-RICE-5KG', 42, 360, 'In stock'),
  Product('Toor Dal 1kg', 'GRC-DAL-1KG', 18, 165, 'Low stock'),
  Product('Sunflower Oil 1L', 'GRC-OIL-1L', 24, 142, 'In stock'),
  Product('Milk 500ml', 'GRC-MILK-500', 7, 32, 'Low stock'),
];

const invoices = [
  Invoice('BILL-1048', 'Walk-in Customer', 842, 'Paid', '26 Jun 2026'),
  Invoice('BILL-1047', 'Ramesh Kumar', 1280, 'Pending', '25 Jun 2026'),
  Invoice('BILL-1046', 'Meena Stores', 1845, 'Paid', '22 Jun 2026'),
  Invoice('BILL-1045', 'Anita Devi', 946, 'Draft', '21 Jun 2026'),
];

const reportMetrics = [
  ReportMetric('Monthly Revenue', '₹18.4L', '+12.5%', [
    8.5,
    9.2,
    10.6,
    12.8,
    14.4,
    18.4,
  ]),
  ReportMetric('Outstanding', '₹3.2L', '-4.1%', [5.6, 5.0, 4.8, 4.2, 3.7, 3.2]),
  ReportMetric('Inventory Value', '₹9.8L', '+8.2%', [
    6.4,
    7.1,
    7.9,
    8.5,
    9.1,
    9.8,
  ]),
  ReportMetric('GST Ready Docs', '94%', '+6 docs', [68, 74, 79, 84, 88, 94]),
];

const teamMembers = [
  TeamMember('Nisha Menon', 'Owner', 'nisha@dhinadts.com', 'Active'),
  TeamMember('Rahul Verma', 'Billing Manager', 'rahul@dhinadts.com', 'Active'),
  TeamMember('Sara Khan', 'Inventory Staff', 'sara@dhinadts.com', 'Invited'),
];

const gstReturns = [
  GSTReturn('June 2026', 'GSTR-1', 'Ready for review', 1845000),
  GSTReturn('June 2026', 'GSTR-3B', 'Draft', 1682000),
  GSTReturn('May 2026', 'GSTR-1', 'Filed', 1733000),
];

const notifications = [
  NotificationItem('Invoice paid', 'Rao Textiles cleared INV-1048.', '5 min'),
  NotificationItem(
    'GST review pending',
    'GSTR-1 has 3 invoices to verify.',
    '1 hr',
  ),
  NotificationItem(
    'Low stock',
    'Thermal Printer is below reorder point.',
    'Today',
  ),
];

const aiMessages = [
  ChatMessage(
    'AI',
    'Good morning. Revenue is up 12.5% and two invoices need attention.',
    isAi: true,
  ),
  ChatMessage('You', 'Show billing risks for this week.'),
  ChatMessage(
    'AI',
    'I found one overdue invoice and three low-margin product lines to review.',
    isAi: true,
  ),
];
