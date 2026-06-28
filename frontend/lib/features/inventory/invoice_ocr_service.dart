import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../core/mock_data/models.dart';

class InvoiceOcrResult {
  const InvoiceOcrResult({required this.rawText, required this.items});

  final String rawText;
  final List<StockIntakeItem> items;
}

class InvoiceOcrService {
  Future<InvoiceOcrResult> scanImage(String imagePath) async {
    if (kIsWeb) {
      throw UnsupportedError('Live OCR scanning is supported on Android/iOS.');
    }
    final inputImage = InputImage.fromFilePath(imagePath);
    final latin = TextRecognizer();
    final devanagiri = TextRecognizer(script: TextRecognitionScript.devanagiri);
    try {
      final latinResult = await latin.processImage(inputImage);
      final devanagiriResult = await devanagiri.processImage(inputImage);
      final rawText = [
        latinResult.text,
        if (devanagiriResult.text.trim().isNotEmpty) devanagiriResult.text,
      ].where((text) => text.trim().isNotEmpty).join('\n');
      return InvoiceOcrResult(rawText: rawText, items: parseInvoiceText(rawText));
    } finally {
      await latin.close();
      await devanagiri.close();
    }
  }

  List<StockIntakeItem> parseInvoiceText(String rawText) {
    final lines = rawText
        .split(RegExp(r'[\r\n]+'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    final invoice = _invoiceNumber(rawText);
    final items = <StockIntakeItem>[];
    for (final line in lines) {
      final parsed = _parseLine(line, invoice);
      if (parsed != null) items.add(parsed);
    }
    return _dedupe(items);
  }

  StockIntakeItem? _parseLine(String line, String invoice) {
    final lower = line.toLowerCase();
    if (lower.contains('invoice') ||
        lower.contains('date') ||
        lower.contains('total') ||
        lower.contains('item qty')) {
      return null;
    }
    final numbers = RegExp(
      r'(?<![a-zA-Z])\d+(?:\.\d+)?(?![a-zA-Z])',
    ).allMatches(line).map((m) => double.tryParse(m.group(0)!)).nonNulls.toList();
    if (numbers.length < 2) return null;

    final product = _productName(line);
    if (product == null) return null;
    final quantity = numbers.first;
    final purchaseRate = numbers.length >= 3 ? numbers[numbers.length - 2] : 0.0;
    final salePrice = numbers.last;
    return StockIntakeItem(
      product,
      invoice,
      quantity,
      _unit(line),
      purchaseRate,
      salePrice,
      'Store room',
      'Scanned',
    );
  }

  String? _productName(String line) {
    final lower = line.toLowerCase();
    const knownItems = {
      'rice': 'Rice Sona Masoori 5kg',
      'sona': 'Rice Sona Masoori 5kg',
      'dal': 'Toor Dal 1kg',
      'toor': 'Toor Dal 1kg',
      'oil': 'Sunflower Oil 1L',
      'sunflower': 'Sunflower Oil 1L',
      'milk': 'Milk 500ml',
      'paper': 'A4 copier paper',
      'tape': 'Packing tape',
      'ink': 'Printer ink black',
    };
    for (final entry in knownItems.entries) {
      if (lower.contains(entry.key)) return entry.value;
    }
    final cleaned = line
        .replaceAll(RegExp(r'\d+(?:\.\d+)?'), ' ')
        .replaceAll(RegExp(r'\b(rs|mrp|qty|pcs|pkt|kg|ltr|l|ml)\b', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (cleaned.length < 3) return null;
    return cleaned.split(' ').take(5).join(' ');
  }

  String _unit(String line) {
    final lower = line.toLowerCase();
    const units = {
      'bags': 'bags',
      'bag': 'bags',
      'bottles': 'bottles',
      'bottle': 'bottles',
      'packets': 'packets',
      'packet': 'packets',
      'pkt': 'packets',
      'pcs': 'pieces',
      'pieces': 'pieces',
      'kg': 'kg',
      'ml': 'ml',
      'ltr': 'litre',
    };
    for (final entry in units.entries) {
      if (lower.contains(entry.key)) return entry.value;
    }
    return 'pieces';
  }

  String _invoiceNumber(String rawText) {
    final match = RegExp(
      r'(?:invoice|bill|inv)[\s#:.-]*([A-Z0-9-]+)',
      caseSensitive: false,
    ).firstMatch(rawText);
    return match?.group(1) ?? 'SCANNED-${DateTime.now().millisecondsSinceEpoch}';
  }

  List<StockIntakeItem> _dedupe(List<StockIntakeItem> items) {
    final seen = <String>{};
    return [
      for (final item in items)
        if (seen.add('${item.product}-${item.quantity}-${item.purchaseRate}'))
          item,
    ];
  }
}
