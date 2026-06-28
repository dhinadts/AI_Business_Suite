import '../../app/app_language.dart';
import '../../core/mock_data/models.dart';

class GroceryVoiceBillingService {
  List<VoiceBillLine> parse(String text, AppLanguage language) {
    final normalized = _normalize(text);
    final lines = <VoiceBillLine>[];
    for (final item in _catalog) {
      if (!item.matches.any(normalized.contains)) continue;
      final quantity = _quantityBefore(normalized, item.matches) ?? 1;
      lines.add(VoiceBillLine(item.product, quantity, item.unit, item.rate));
    }
    return lines;
  }

  String localeFor(AppLanguage language) {
    return switch (language) {
      AppLanguage.english => 'en_IN',
      AppLanguage.hindi => 'hi_IN',
      AppLanguage.tamil => 'ta_IN',
      AppLanguage.malayalam => 'ml_IN',
      AppLanguage.telugu => 'te_IN',
      AppLanguage.kannada => 'kn_IN',
    };
  }

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[,.;:\n]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  double? _quantityBefore(String text, List<String> matches) {
    final match = matches.firstWhere(text.contains, orElse: () => '');
    if (match.isEmpty) return null;
    final index = text.indexOf(match);
    final prefix = text
        .substring(0, index)
        .split(' ')
        .reversed
        .take(4)
        .toList();
    for (final token in prefix) {
      final direct = double.tryParse(token);
      if (direct != null) return direct;
      final mapped = _numberWords[token];
      if (mapped != null) return mapped;
    }
    return null;
  }
}

class _GroceryVoiceItem {
  const _GroceryVoiceItem(this.product, this.unit, this.rate, this.matches);

  final String product;
  final String unit;
  final double rate;
  final List<String> matches;
}

const _catalog = [
  _GroceryVoiceItem('Rice Sona Masoori 5kg', 'bag', 360, [
    'rice',
    'chawal',
    'arisi',
    'akki',
    'biyyam',
    'ari',
  ]),
  _GroceryVoiceItem('Toor Dal 1kg', 'packet', 165, [
    'dal',
    'pappu',
    'paruppu',
    'bele',
    'പരിപ്പ്',
  ]),
  _GroceryVoiceItem('Sunflower Oil 1L', 'bottle', 142, [
    'oil',
    'tel',
    'ennai',
    'enne',
    'నూనె',
    'എണ്ണ',
  ]),
  _GroceryVoiceItem('Milk 500ml', 'packet', 32, [
    'milk',
    'doodh',
    'paal',
    'haalu',
    'పాలు',
    'പാല്',
  ]),
  _GroceryVoiceItem('Sugar 1kg', 'packet', 48, [
    'sugar',
    'cheeni',
    'sakkarai',
    'sakkare',
    'పంచదార',
    'panchasara',
  ]),
];

const _numberWords = {
  'one': 1.0,
  'two': 2.0,
  'three': 3.0,
  'four': 4.0,
  'five': 5.0,
  'ek': 1.0,
  'do': 2.0,
  'teen': 3.0,
  'char': 4.0,
  'paanch': 5.0,
  'oru': 1.0,
  'rendu': 2.0,
  'moonru': 3.0,
  'ondu': 1.0,
  'eradu': 2.0,
  'mooru': 3.0,
  'oka': 1.0,
};
